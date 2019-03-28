package kh.hand.makers.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kh.hand.makers.common.PageFactory;
import kh.hand.makers.member.model.service.MemberService;
import kh.hand.makers.member.model.vo.ManageOrder;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.service.OrderService;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.product.model.service.ProductService;
import kh.hand.makers.product.model.vo.DefaultProduct;
import kh.hand.makers.product.model.vo.Wish;
import kh.hand.makers.shop.model.service.ShopService;
import kh.hand.makers.shop.model.vo.Brand;

@SessionAttributes("member")
@Controller
public class MemberController {

	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	MemberService service;
	@Autowired
	BCryptPasswordEncoder pwEncoder;
	@Autowired
	ShopService shopService;
	@Autowired
	ProductService productService;
	@Autowired
	OrderService orderService;
	@Autowired
	private JavaMailSender mailSender;
	private String emailCode;

	@RequestMapping(value = "/member/changeProfile.do", method = RequestMethod.POST)
	public ModelAndView changeProfile(Member m, MultipartFile newProfileImg, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		String saveDir = "";

		if (m.getMemberAuthority().equals("A")) {
			saveDir = request.getSession().getServletContext().getRealPath("/resources/image/adminProfile");
		} else {
			saveDir = request.getSession().getServletContext().getRealPath("/resources/image/memberProfile");
		}

		String msg = "";
		String loc = "";

		if (!newProfileImg.isEmpty()) {
			// 파일명을 생성(rename)
			String orifileName = newProfileImg.getOriginalFilename();
			System.out.println("현재파일:" + orifileName);
			String ext = orifileName.substring(orifileName.lastIndexOf("."));
			// rename 규칙설정
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			int rdv = (int) (Math.random() * 1000);
			String reName = sdf.format(System.currentTimeMillis()) + "_" + rdv + ext;
			// 파일을 저장해보자
			try {
				newProfileImg.transferTo(new File(saveDir + "/" + reName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			m.setMemberProfile(reName);
			System.out.println("바뀐파일:" + reName);
		}

		int result = service.changeProfile(m);

		if (result > 0) {
			msg = "프로필사진 변경 완료";
			if (m.getMemberAuthority().equals("A")) {
				loc = "/admin/adminPage.do";
			} else {
				loc = "/member/myPage.do";
			}
		} else {
			msg = "프로필사진 변경 실패";
			if (m.getMemberAuthority().equals("A")) {
				loc = "/admin/adminPage.do";
			} else {
				loc = "/member/myPage.do";
			}
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	// mailSending 코드
	@RequestMapping("/member/mailSending.do")
	public ModelAndView mailSending(String memberEmail, ModelAndView mv) throws UnsupportedEncodingException {
		int ran = new Random().nextInt(100000) + 10000; // 인증 코드용 난수 발생 10000 ~ 99999
		System.out.println("왔다");
		System.out.println("이메일 : " + memberEmail);
		String setfrom = "admin";
		String title = "handmakers 인증 코드"; // 제목
		String content = "인증 코드는 " + Integer.toString(ran) + " 입니다. 인증 코드란에 입력해주세요."; // 인증 코드
		emailCode = Integer.toString(ran);
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(memberEmail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		mv.addObject("randomNumber", ran);
		mv.setViewName("jsonView");

		return mv;
	}

	@RequestMapping("/member/mailCheck.do")
	public ModelAndView mailCheck(String memberEmail, ModelAndView mv) throws UnsupportedEncodingException {
		System.out.println("왔다@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		int ran = new Random().nextInt(100000) + 10000; // 인증 코드용 난수 발생 10000 ~ 99999
		Member m = service.memberEmailFind(memberEmail);
		String emailState = "F";

		System.out.println("이메일 : " + memberEmail);

		if (m != null) {
			String setfrom = "admin";
			String title = "handmakers 인증 코드"; // 제목
			String content = "인증 코드는 " + Integer.toString(ran) + " 입니다. 인증 코드란에 입력해주세요."; // 인증 코드
			emailCode = Integer.toString(ran);

			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(memberEmail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}

			emailState = "T";
			mv.addObject("randomNumber", emailCode);
			mv.addObject("emailState", emailState);
			mv.setViewName("jsonView");

			return mv;
		} else {
			mv.addObject("emailState", emailState);
			mv.setViewName("jsonView");

			return mv;
		}
	}

	@RequestMapping("/member/memberIdFind.do")
	public ModelAndView memberIdFind(String memberEmail, ModelAndView mv) throws UnsupportedEncodingException {

		String memberId = service.memberIdFind(memberEmail);
		String setfrom = "admin";
		String title = "handmakers 아이디 찾기 이메일입니다."; // 제목
		String content = "귀하의 ID는  " + memberId + " 입니다."; // 인증 코드

		logger.debug("내 아이디 왔니?" + content);

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(memberEmail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		mv.setViewName("jsonView");

		return mv;
	}

	@RequestMapping("/member/mailSendingForPwd.do")
	public ModelAndView mailSendingForPwd(String memberEmail, String memberEmailId, ModelAndView mv)
			throws UnsupportedEncodingException {
		System.out.println("찾으러왔다");
		int ran = new Random().nextInt(100000) + 10000; // 인증 코드용 난수 발생 10000 ~ 99999
		Map<String, String> findMember = new HashMap<String, String>();
		findMember.put("memberEmail", memberEmail);
		findMember.put("memberId", memberEmailId);
		String memberState = "F";

		Member member = service.memberFind(findMember);
		System.out.println("내가 찾은 멤버: " + member);
		/*
		 * if(member.getMemberId().equals(memberEmailId) &&
		 * member.getMemberEmail().equals(memberEmail))
		 */
		if (member != null) {
			// 존재한다

			String setfrom = "admin";
			String title = "handmakers 인증 코드"; // 제목
			String content = "인증 코드는 " + Integer.toString(ran) + " 입니다. 인증 코드란에 입력해주세요."; // 인증 코드
			emailCode = Integer.toString(ran);
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(memberEmail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}
			memberState = "T";
			mv.addObject("randomNumber", emailCode);
			mv.addObject("memberState", memberState);
			mv.setViewName("jsonView");

			return mv;
		} else {

			mv.addObject("memberState", memberState);
			mv.setViewName("jsonView");

			return mv;
		}

	}

	@RequestMapping("/member/checkId.do")
	/*
	 * public void checkId(String userId,HttpServletResponse response) throws
	 * IOException { logger.debug("중복체크"); boolean
	 * isId=service.checkId(userId)==0?false:true; response.getWriter().print(isId);
	 * }
	 */
	public ModelAndView checkId(String memberId, ModelAndView mv) throws UnsupportedEncodingException {
		Map map = new HashMap();
		boolean isId = service.checkId(memberId) == 0 ? false : true;
		map.put("isId", isId);

		mv.addAllObjects(map);
		mv.setViewName("jsonView");

		return mv;
	}

	@RequestMapping("/member/checkEmail.do")
	public ModelAndView checkEmail(String memberEmail, ModelAndView mv) throws UnsupportedEncodingException {
		Map map = new HashMap();
		boolean isEmail = service.checkEmail(memberEmail) == 0 ? false : true;
		map.put("isEmail", isEmail);

		mv.addAllObjects(map);
		mv.setViewName("jsonView");

		return mv;
	}

	@RequestMapping("/member/memberEnroll.do")
	public String memberEnroll() {
		return "member/memberEnroll";
	}

	@RequestMapping("/member/memberEnrollEnd.do")
	public String memberEnrollEnd(Member m, Model model) {

		System.out.println("m이다" + m);
		String rawPw = m.getMemberPwd();
		System.out.println("암호화전 " + rawPw);
		// System.out.println("암호화후 "+pwEncoder.encode(rawPw));
		m.setMemberPwd(pwEncoder.encode(rawPw));
		int result = service.memberEnroll(m);
		String msg = "";
		String loc = "/";
		if (result > 0) {
			msg = "회원가입을 성공하였습니다.";
		} else {
			msg = "회원가입 실패하였습니다.";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		return "common/msg";

	}

	@RequestMapping("/member/memberLogin.do")
	public String memberLogin() {
		return "member/memberLogin";
	}

	@RequestMapping("/member/memberLoginEnd.do")
	// public String login(String userId, String password, Model model)
	public ModelAndView memberLoginEnd(Member m) {
		ModelAndView mv = new ModelAndView();
		System.out.println("m : " + m);
		logger.debug("로그인 제대로 들어옴!");
		logger.debug("파라미터확인 memberId : " + m.getMemberId() + " memberPwd : " + m.getMemberPwd());

		Member result = service.memberLogin(m.getMemberId());
		logger.debug("로그인결과 : " + result);
		String msg = "";
		String loc = "/";
		if (result != null && result.getMemberState().equals("1")) {
			if (pwEncoder.matches(m.getMemberPwd(), result.getMemberPwd())) {
				msg = "로그인성공";

				mv.addObject("member", result);
			} else {
				msg = "패스워드가 일치하지 않습니다.";
				loc = "/member/memberLogin.do";
			}
		} else {
			msg = "아이디가 존재하지 않습니다.";
			loc = "/member/memberLogin.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@RequestMapping("/member/memberLogout.do")
	public String memberLogout(SessionStatus status) {
		// SessionAttributes등록 로그인이면 : sessionStatus객체의
		// setComplete()매소드 이용로그아웃 처리
		// HttpSession이용 로그인이면 : HttpSession.invalide();
		if (!status.isComplete()) {
			status.setComplete();
		}
		return "redirect:/index.jsp";
	}

	@RequestMapping("/member/myPage.do")
	public ModelAndView memberMyPage(HttpSession session) {
		// 판매회원일 경우 등록된 브랜드 목록 가져옴
		String memberNo = ((Member) session.getAttribute("member")).getMemberNo();
		ModelAndView mv = new ModelAndView();
		List<Brand> list = shopService.selectBrandList(memberNo);
		mv.addObject("brandList", list);

		mv.addObject("listSize", list.size());

		mv.setViewName("member/myPage");
		return mv;
	}

	@RequestMapping("/member/adminPage.do")
	public String adminMyPage() {
		return "member/adminPage";
	}

	@RequestMapping("/member/wishList.do")
	public ModelAndView wishList(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			HttpSession session) {

		int numPerPage = 4;

		String memberNo = ((Member) session.getAttribute("member")).getMemberNo();

		ModelAndView mv = new ModelAndView();

		int wishContentCount = service.selectWishCount(memberNo);

		List<Map<String, String>> wishList = service.selectWishList(memberNo, cPage, numPerPage);

		mv.addObject("wishContentCount", wishContentCount);
		mv.addObject("pageBar",
				PageFactory.getPageBar(wishContentCount, cPage, numPerPage, "/makers/member/wishList.do"));
		mv.addObject("wishList", wishList);
		mv.setViewName("/member/wishList");

		return mv;
	}

	// member/memberUpdateEnd.do
	@RequestMapping("/member/memberUpdate.do")
	public String memberUpdate() {
		return "member/memberInfo";
	}

	@RequestMapping("/member/memberUpdateEnd.do")
	public ModelAndView memberUpdateEnd(Member m) {
		ModelAndView mv = new ModelAndView();
		System.out.println("m : " + m);
		logger.debug("회원정보 수정");

		int result = service.memberUpdate(m);

		String msg = "";
		String loc = "/";
		if (result > 0) {
			msg = "회원정보 수정이 완료되었습니다.";
			loc = "/member/memberUpdate.do";

		} else {
			msg = "회원정보 수정에 실패하였습니다.";
			loc = "/member/memberUpdate.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@RequestMapping("/member/manageOrder.do")
	public ModelAndView manageOrder(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			Member m) {
		int numPerPage = 5;
		logger.debug("주문/배송 조회");
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectOrderCount(m.getMemberNo());
		List<ManageOrder> oList = service.selectOrderList(m, cPage, numPerPage);
		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/member/manageOrder.do"));
		mv.addObject("oList", oList);
		mv.setViewName("member/manageOrder");
		return mv;
	}

	@RequestMapping("/member/memberWithdrawal.do")
	public String memberWithdrawal() {
		return "member/memberWithdrawal";
	}

	@RequestMapping("/member/checkPasswordEnd.do")
	public ModelAndView checkPasswordEnd(int checkNo, Member m) {
		logger.debug("회원탈퇴로 들어옴");
		ModelAndView mv = new ModelAndView();
		Member result = service.memberLogin(m.getMemberId());
		String memberId = m.getMemberId();
		String msg = "";
		String loc = "/";
		if (result != null) {
			if (pwEncoder.matches(m.getMemberPwd(), result.getMemberPwd())) {
				msg = "패스워드가 일치합니다.";
				if (checkNo == 0) {
					loc = "/member/memberWithdrawalEnd.do";
				} else if (checkNo == 1) {
					loc = "/member/changePassword.do";
				} else if (checkNo == 2) {
					loc = "/member/memberUpdate.do";
				} else if (checkNo == 3) {
					loc = "/member/enrollLocationView.do";
				}

			} else {
				msg = "패스워드가 일치하지 않습니다.";
				loc = "/member/checkPassword.do?checkNo=" + checkNo;
			}
		} else {
			msg = "패스워드가 일치하지 않습니다.";
			loc = "/member/checkPassword.do?checkNo=" + checkNo;
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@RequestMapping("/member/memberWithdrawalEnd.do")
	public String memberWithdrawalEnd() {
		return "member/memberWithdrawalEnd";
	}

	@RequestMapping("/member/memberWithdrawalEnds.do")
	public ModelAndView memberWithdrawalEnds(String memberNo, SessionStatus status) {
		logger.debug("회원탈퇴 대상 : " + memberNo);
		ModelAndView mv = new ModelAndView();

		int result = service.memberWithdrawal(memberNo);
		String msg = "";
		String loc = "/";

		if (result > 0) {
			// 찾은 브랜드들 상품들 전부 판매종료
			List<Brand> brandList = service.selectBrand(memberNo);
			if (brandList.size() > 0) {
				for (Brand brand : brandList) {
					int updateProduct = service.updateProductWithdrawl(brand.getBrandNo());
				}
			}
			// 찾은 브랜드 폐점신고
			if (brandList.size() > 0) {
				for (Brand brand : brandList) {
					int updateBrand = service.updateBrandWithdrawl(brand.getBrandNo());
				}
			}

			msg = "회원탈퇴가 완료되었습니다.";
			if (!status.isComplete()) {
				status.setComplete();
			}

		} else {
			msg = "회원탈퇴에 실패하였습니다.";
			loc = "/member/myPage.do";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@RequestMapping("/member/checkPassword.do")
	public ModelAndView checkPassword(int checkNo) {
		ModelAndView mv = new ModelAndView();
		logger.debug("체크NO: " + checkNo);
		mv.addObject("checkNo", checkNo);
		mv.setViewName("/member/checkPassword");

		return mv;
	}

	@RequestMapping("/member/changePassword.do")
	public String changePassword() {
		return "member/changePassword";
	}

	@RequestMapping("/member/newPwdChange.do")
	public ModelAndView newPwdChange(String newPwd, String memberId) {
		ModelAndView mv = new ModelAndView();
		logger.debug("패스워드 변경");
		logger.debug("memberId: " + memberId);
		logger.debug("newPwd: " + newPwd);
		String newChangedPwd = pwEncoder.encode(newPwd);
		String memberState = "F";
		Map<String, String> cP = new HashMap<String, String>();
		cP.put("memberId", memberId);
		cP.put("newChangedPwd", newChangedPwd);

		int result = service.memberNewPwdUpdate(cP);

		if (result > 0) {
			memberState = "T";
			mv.addObject("memberState", memberState);
			mv.setViewName("jsonView");
			return mv;
		} else {

			mv.addObject("memberState", memberState);
			mv.setViewName("jsonView");
			return mv;
		}

	}

	@RequestMapping("/member/changePasswordEnd.do")
	public ModelAndView changePasswordEnd(Member m) {
		ModelAndView mv = new ModelAndView();
		logger.debug("패스워드 변경");
		logger.debug("Member: " + m);
		m.setMemberPwd(pwEncoder.encode(m.getMemberPwd()));
		int result = service.memberPwdUpdate(m);

		String msg = "";
		String loc = "/";
		if (result > 0) {
			msg = "비밀번호 변경이 완료되었습니다.";
			loc = "/member/myPage.do";
		} else {
			msg = "비밀번호 변경에 실패했습니다.";
			loc = "/member/changePassword.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@RequestMapping("/member/enrollLocationView.do")
	public ModelAndView enrollLocationView(Member m) {
		ModelAndView mv = new ModelAndView();
		List<Delivery> deliveryList = service.selectDeliveryList(m.getMemberNo());
		mv.addObject("deliveryList", deliveryList);
		mv.setViewName("member/enrollLocationView");
		return mv;
	}

	@RequestMapping("/member/enrollLocation.do")
	public String enrollLocation() {

		return "/member/enrollLocation";
	}

	@RequestMapping("/member/enrollLocationEnd.do")
	public ModelAndView enrollLocationEnd(Member m, Delivery delivery) {
		ModelAndView mv = new ModelAndView();
		delivery.setMemberNo(m.getMemberNo());
		// System.out.println("암호화후 "+pwEncoder.encode(rawPw));
		int result = service.enrollLocation(delivery);
		String msg = "";
		String loc = "/";
		if (result > 0) {
			msg = "배송지 등록에 성공했습니다.";
			loc = "/member/enrollLocationView.do";
		} else {
			msg = "배송지 등록에 실패했습니다.";
			loc = "/member/enrollLocation.do";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@RequestMapping("/member/searchId.do")
	public String searchId() {
		return "member/findMemberId";
	}

	@RequestMapping("/member/searchPassword.do")
	public String searchPassword() {
		return "member/searchPassword";
	}

	@RequestMapping("/member/deleteWish.do")
	public ModelAndView deleteWish(String productNo, HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();

		Wish wish = new Wish();

		String memberNo = ((Member) request.getSession().getAttribute("member")).getMemberNo();

		wish.setMemberNo(memberNo);
		wish.setProductNo(productNo);

		int result = productService.deleteWish(wish);

		String msg = "";
		String loc = "/member/wishList.do";

		if (result > 0) {
			msg = "찜 목록에서 해당 상품 삭제 하였습니다.";
		} else {
			msg = "찜 목록에서 해당 상품 삭제 실패 하였습니다.";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("/common/msg");

		return mv;
	}

	@RequestMapping("/member/deleteLocation.do")
	public ModelAndView deleteLocation(String deliveryNo) {
		ModelAndView mv = new ModelAndView();
		int result = service.deleteLocation(deliveryNo);
		String msg = "";
		String loc = "/";
		if (result > 0) {
			msg = "배송지 삭제에 성공했습니다.";
			loc = "/member/enrollLocationView.do";
		} else {
			msg = "배송지 삭제에 실패했습니다.";
			loc = "/member/enrollLocationView.do";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@RequestMapping("/member/changeOrderState.do")
	public ModelAndView changeOrderState(String orderNo, HttpServletRequest request) {

		IamportClient client;

		String accessToken = null;

		ModelAndView mv = new ModelAndView();
		// max == 현재판매량 + 내 수량 -> 상품:판매종료

		String test_api_key = "0709424890638444";
		String test_api_secret = "AblFnSFrDGn4XNWRNAdC4E4dgOosLqbmCx1ZpHr3oP8mC5dqFq3K57YmWmOIN04px6pXOR1cH9zkfMKV";
		client = new IamportClient(test_api_key, test_api_secret);

		try {
			IamportResponse<AccessToken> auth_response = client.getAuth();
			accessToken = auth_response.getResponse().getToken();

		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());

			switch (e.getHttpStatusCode()) {
			case 401:
				// TODO
				break;
			case 500:
				// TODO
				break;
			}
		} catch (IOException e) {
			// 서버 연결 실패
			e.printStackTrace();
		}

		String[] s = orderNo.split(",");

		String oNo = s[0]; // 배송번호
		String oState = s[1]; // 상태값
		String uid = s[2]; // 배송취소에 필요한 고유 번호
		String productNo = s[3];// 상품 번호
		String productOptionQty = s[4];// 상품 수량

		logger.debug(uid);
		logger.debug(oNo);

		Map<String, String> map = new HashMap();
		Map<String, Object> productMap = new HashMap();
		Map<String, Object> psMap = new HashMap();
		String memberNo = ((Member) request.getSession().getAttribute("member")).getMemberNo();

		map.put("orderNo", oNo.trim());
		map.put("orderState", oState.trim());
		map.put("imp_uid", uid);
		map.put("memberNo", memberNo);
		map.put("productNo", productNo.trim());
		productMap.put("productOptionQty", Integer.parseInt(productOptionQty));
		productMap.put("productNo", productNo);

		psMap.put("orderNo", oNo.trim());
		psMap.put("orderState", oState.trim());
		psMap.put("imp_uid", uid);
		psMap.put("memberNo", memberNo);
		psMap.put("productNo", productNo.trim());

		int result = 0;

		try {
			// 주문 상태 바꾸는 로직
			DefaultProduct ds = productService.selectDefaltProduct(productNo);
			int saleCount = shopService.selectSaleEmpty(ds.getProductNo());

			if (saleCount > 0) {
				// 신규 자기 회차 넣어서
				psMap.put("saleCount", saleCount);
				result = orderService.updateOrderStateSecond(psMap);
				if(ds.getProductState() == 3) {
					int results = productService.updatePMinus(productMap);	
				}else {
					int results = productService.updateProductMinus(productMap);	
				}
						

			} else {
				// 입점예정
				result = orderService.updateOrderState(map);
				if(ds.getProductState() == 3) {
					int results = productService.updatePMinus(productMap);	
				}else {
					int results = productService.updateProductMinus(productMap);	
				}
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		String imp_uid = uid;
		CancelData cancel_data = new CancelData(imp_uid, true); // imp_uid를 통한 전액취소

		try {
			IamportResponse<Payment> payment_response = client.cancelPaymentByImpUid(cancel_data);
			logger.debug(payment_response.getMessage());

		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());

			switch (e.getHttpStatusCode()) {
			case 401:
				// TODO
				break;
			case 500:
				// TODO
				break;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		logger.debug("result" + result);
		// response.getWriter().print(result);

		String msg = "";
		String loc = "/member/manageOrder.do";

		if (result > 0) {
			msg = "결제 취소에 성공했습니다.";
		} else {
			msg = "결제 취소에 실패했습니다.";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@RequestMapping("/member/updateOrderState.do")
	public ModelAndView updateOrderState(String orderNo) {
		ModelAndView mv = new ModelAndView();

		int result = service.updateOrderState(orderNo);

		String msg = "";
		String loc = "";

		if (result > 0) {
			msg = "구매확정에 성공했습니다.";
			loc = "/member/manageOrder.do";
		} else {
			msg = "구매확정에 실패했습니다.";
			loc = "/member/manageOrder.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}
}
