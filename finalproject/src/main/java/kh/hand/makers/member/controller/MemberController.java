package kh.hand.makers.member.controller;

import java.io.UnsupportedEncodingException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.common.PageFactory;
import kh.hand.makers.member.model.service.MemberService;
import kh.hand.makers.member.model.vo.ManageOrder;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.product.model.service.ProductService;
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
	private JavaMailSender mailSender;
	private String emailCode;
	
	// mailSending 코드
	@RequestMapping("/member/mailSending.do")
	public ModelAndView mailSending(String memberEmail, ModelAndView mv) throws UnsupportedEncodingException {
		int ran = new Random().nextInt(100000) + 10000; // 인증 코드용 난수 발생 10000 ~ 99999
		System.out.println("왔다");
		System.out.println("이메일 : " + memberEmail);
		String setfrom = "admin";
		String title = "handmakers 인증 코드"; // 제목
		String content = "인증 코드는 " + Integer.toString(ran) + " 입니다. 인증 코드란에 입력해주세요."; // 인증 코드
		emailCode= Integer.toString(ran);
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,
					true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(memberEmail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
		
		mv.addObject("randomNumber",ran);
		mv.setViewName("jsonView");
		
		return mv;
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
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,
					true, "UTF-8");

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
	public ModelAndView mailSendingForPwd(String memberEmail, String memberEmailId, ModelAndView mv) throws UnsupportedEncodingException {
		System.out.println("찾으러왔다");
		int ran = new Random().nextInt(100000) + 10000; // 인증 코드용 난수 발생 10000 ~ 99999
		Map<String, String> findMember = new HashMap<String, String>();
		findMember.put("memberEmail", memberEmail);
		findMember.put("memberId", memberEmailId);
		String memberState = "F";
				
		Member member = service.memberFind(findMember);
		System.out.println("내가 찾은 멤버: "+ member);
		if(member.getMemberId().equals(memberEmailId) && member.getMemberEmail().equals(memberEmail)) {
			//존재한다
			
			String setfrom = "admin";
			String title = "handmakers 인증 코드"; // 제목
			String content = "인증 코드는 " + Integer.toString(ran) + " 입니다. 인증 코드란에 입력해주세요."; // 인증 코드
			emailCode= Integer.toString(ran);
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message,
						true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(memberEmail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}
			memberState = "T";	
			mv.addObject("randomNumber",emailCode);
			mv.addObject("memberState", memberState);
			mv.setViewName("jsonView");
			
			return mv;
		}else {
			
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

		System.out.println("checkId~~~~~~~~~~~");

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
	public ModelAndView wishList(@RequestParam(value="cPage", required=false, defaultValue="0") int cPage, HttpSession session) {
		
		int numPerPage = 4;
		
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		
		ModelAndView mv = new ModelAndView();
		
		int wishContentCount = service.selectWishCount(memberNo);
		
		List<Map<String,String>> wishList = service.selectWishList(memberNo, cPage, numPerPage);
		
		mv.addObject("wishContentCount",wishContentCount);
		mv.addObject("pageBar",PageFactory.getPageBar(wishContentCount, cPage, numPerPage, "/member/wishList.do"));
		mv.addObject("wishList",wishList);
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
			loc="/member/memberUpdate.do";

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
	public ModelAndView manageOrder(@RequestParam(value="cPage", required=false, defaultValue="0") int cPage, Member m)
	{
		int numPerPage=5;
		logger.debug("주문/배송 조회");
		ModelAndView mv=new ModelAndView();
		int contentCount=service.selectOrderCount();
		List<ManageOrder> oList=service.selectOrderList(m,cPage,numPerPage);
		mv.addObject("pageBar",PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/member/manageOrder.do"));
		mv.addObject("oList",oList);
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
		
		String memberNo = ((Member)request.getSession().getAttribute("member")).getMemberNo();
		
		wish.setMemberNo(memberNo);
		wish.setProductNo(productNo);
		
		int result = productService.deleteWish(wish);
		
		String msg = "";
		String loc = "/member/wishList.do";
		
		if(result>0) {
			msg = "찜 목록에서 해당 상품 삭제 하였습니다.";
		}else {
			msg = "찜 목록에서 해당 상품 삭제 실패 하였습니다.";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
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
}
