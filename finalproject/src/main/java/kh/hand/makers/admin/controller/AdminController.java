package kh.hand.makers.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.admin.model.service.AdminService;
import kh.hand.makers.admin.model.service.MailService;
import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.NewProduct;
import kh.hand.makers.admin.model.vo.Products;
import kh.hand.makers.admin.model.vo.SellerRequest;
import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.common.PageFactory;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

@Controller
public class AdminController {
	private Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Autowired
	AdminService service;
	private String sReqState = "B";
	
    private MailService mailService;
 
 
 
    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }
 
    // 회원가입 이메일 인증
    @RequestMapping(value = "/admin/authenticationEmail.do", method = RequestMethod.POST, produces = "application/json")
    public void mailSender(HttpServletRequest request) throws AddressException, MessagingException{
        
        String subject = (String) request.getParameter("subject"); // 메일 제목
        String message = (String) request.getParameter("message"); // 메일 내용
         
        // SMTP 서버 설정
        final String host = "smtp.gmail.com"; // 사용할 smtp host, naver라면 smtp.naver.com
        final String accountId = "#사용자 아이디#";
        final String accountPwd = "#사용자 비밀번호#";
        final int port = 465; // SMTP 포트
         
        String receiver = "#받는사람 이메일#"; // 받는사람 이메일
        String sender = "#보내는사람 이메일#"; // 보내는사람 이메일
         
        // Property 정보 생성
        Properties props = System.getProperties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", host);
         
        // 사용자 인증
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication(){
                return new javax.mail.PasswordAuthentication(accountId, accountPwd);
            }
        });
        session.setDebug(true);
         
        Message mimeMessage = new MimeMessage(session); //MimeMesage 생성
        mimeMessage.setFrom(new InternetAddress(sender)); // 보내는 EMAIL (정확히 적어야 SMTP 서버에서 인증 실패되지 않음)
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(receiver)); 
         
        // Message Setting
        mimeMessage.setSubject(subject);
        mimeMessage.setText(message);
        Transport.send(mimeMessage); // Transfer
    }
    
    /*@ResponseBody
    public boolean sendMailAuth(HttpSession session, @RequestParam String memberEmail) {
    	System.out.println("가져온값:" + memberEmail);
        int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
        session.setAttribute("joinCode", joinCode);
 
        String subject = "회원가입 인증 코드 발급 안내 입니다.";
        StringBuilder sb = new StringBuilder();
        sb.append("귀하의 인증 코드는 " + joinCode + " 입니다.");
        System.out.println("subject :"+subject);
        System.out.println("sb :"+sb.toString());
        System.out.println("memberEmail :"+memberEmail);
    
        return mailService.send(subject, sb.toString(), "babooyea@gmail.com", memberEmail, null);
    }*/
 
/*    // 아이디 찾기
    @RequestMapping(value = "/sendMail/id", method = RequestMethod.POST)
    public String sendMailId(HttpSession session, @RequestParam String email, @RequestParam String captcha, RedirectAttributes ra) {
        String captchaValue = (String) session.getAttribute("captcha");
        if (captchaValue == null || !captchaValue.equals(captcha)) {
            ra.addFlashAttribute("resultMsg", "자동 방지 코드가 일치하지 않습니다.");
            return "redirect:/find/id";
        }
 
        User user = userService.findAccount(email);
        if (user != null) {
            String subject = "아이디 찾기 안내 입니다.";
            StringBuilder sb = new StringBuilder();
            sb.append("귀하의 아이디는 " + user.getId() + " 입니다.");
            mailService.send(subject, sb.toString(), "아이디@gmail.com", email, null);
            ra.addFlashAttribute("resultMsg", "귀하의 이메일 주소로 해당 이메일로 가입된 아이디를 발송 하였습니다.");
        } else {
            ra.addFlashAttribute("resultMsg", "귀하의 이메일로 가입된 아이디가 존재하지 않습니다.");
        }
        return "redirect:/find/id";
    }*/
 
/*    // 비밀번호 찾기
    @RequestMapping(value = "/sendMail/password", method = RequestMethod.POST)
    public String sendMailPassword(HttpSession session, @RequestParam String id, @RequestParam String email, @RequestParam String captcha, RedirectAttributes ra) {
        String captchaValue = (String) session.getAttribute("captcha");
        if (captchaValue == null || !captchaValue.equals(captcha)) {
            ra.addFlashAttribute("resultMsg", "자동 방지 코드가 일치하지 않습니다.");
            return "redirect:/find/password";
        }
 
        User user = userService.findAccount(email);
        if (user != null) {
            if (!user.getId().equals(id)) {
                ra.addFlashAttribute("resultMsg", "입력하신 이메일의 회원정보와 가입된 아이디가 일치하지 않습니다.");
                return "redirect:/find/password";
            }
            int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
            String password = String.valueOf(ran);
            userService.updateInfo(user.getNo(), "password", password); // 해당 유저의 DB정보 변경
 
            String subject = "임시 비밀번호 발급 안내 입니다.";
            StringBuilder sb = new StringBuilder();
            sb.append("귀하의 임시 비밀번호는 " + password + " 입니다.");
            mailService.send(subject, sb.toString(), "아이디@gmail.com", email, null);
            ra.addFlashAttribute("resultMsg", "귀하의 이메일 주소로 새로운 임시 비밀번호를 발송 하였습니다.");
        } else {
            ra.addFlashAttribute("resultMsg", "귀하의 이메일로 가입된 아이디가 존재하지 않습니다.");
        }
        return "redirect:/find/password";
    }*/

    
    
    
	
	
	
	
	
	@RequestMapping("/admin/questionAndAnswer.do")
	public String questionAndAnswerPage() {
		return "admin/questionAndAnswer";
	}
	
	@RequestMapping("/admin/memberList.do")
	public ModelAndView manageMember(@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectMemberCount();
		List<Member> memberList = service.selectMemberList(cPage, numPerPage);
		mv.addObject("pageBar", PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/memberList.do"));
		mv.addObject("memberList", memberList);
		mv.setViewName("admin/memberList");
		return mv;
	}

	// 관리자페이지 홈
	@RequestMapping("/admin/adminPage.do")
	public String adminMyPage() {
		return "admin/adminPage";
	}

	// 브랜드 관리
	@RequestMapping("/admin/manageBrand.do")
	public ModelAndView manageBrand(@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectBrandCount();
		List<Brand> brandList = service.selectBrandList(cPage, numPerPage);
		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageBrand.do"));
		mv.addObject("brandList", brandList);
		mv.setViewName("admin/manageBrand");
		return mv;
	}

	@RequestMapping("/admin/changeBrandState.do")
	public ModelAndView changeBrandState(String brandNo) {

		System.out.println("지금 받아온 값:" + brandNo);
		String[] bNoSplit = brandNo.split(",");
		String msg = "";
		String loc = "";
		Map<String, String> bs = new HashMap<String, String>();

		bs.put("brandNo", bNoSplit[0].trim());
		bs.put("brandState", bNoSplit[1]);
		if (bNoSplit[1].equals("0") || bNoSplit[1].equals("2")) {
			// 입점제안 승인취소 또 반려 + 상품도 재등록으로 이동
			// 입점제안 상태와 상품의 상태를 조작해야함
			// int results=service.preProductStateUpdate(bs);
			// int results=service.productStateUpdate(bs);
		}
		int result = service.brandStateUpdate(bs);
		if (result > 0) {
			msg = "수정완료";
			loc = "/admin/manageBrand.do";
		} else {
			msg = "수정실패";
			loc = "/admin/manageBrand.do";
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}

	// 입점 관리
	@RequestMapping("/admin/managePreProduct.do")
	public ModelAndView managePreProduct(
			@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectPreProductCount();
		List<managePreProduct> preProductList = service.selectPreProductList(cPage, numPerPage);
		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/managePreProduct.do"));
		mv.addObject("preProductList", preProductList);
		mv.setViewName("admin/managePreProduct");
		return mv;
	}

	@RequestMapping("/admin/changePreProductState.do")
	public ModelAndView changePreProductState(String preProductNo) {

		String[] pNoSplit = preProductNo.split(",");
		String msg = "";
		String loc = "";
		Map<String, String> ps = new HashMap<String, String>();

		ps.put("preProductNo", pNoSplit[0].trim());
		ps.put("preProductState", pNoSplit[1]);
		if (pNoSplit[1].equals("0") || pNoSplit[1].equals("2")) {
			// 입점제안 승인취소 또 반려 + 상품도 재등록으로 이동
			// 입점제안 상태와 상품의 상태를 조작해야함
			// int results=service.preProductStateUpdate(bs);
			// int results=service.productStateUpdate(bs);
		}
		int result = service.preProductStateUpdate(ps);
		if (result > 0) {
			msg = "수정완료";
			loc = "/admin/managePreProduct.do";
		} else {
			msg = "수정실패";
			loc = "/admin/managePreProduct.do";
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}

	@RequestMapping("/admin/preProductView.do")
	public ModelAndView preProductView(String preProductNo) {
		ModelAndView mv = new ModelAndView();
		PreProduct pProduct = service.selectPreProduct(preProductNo);
		mv.addObject("preProduct", pProduct);
		mv.setViewName("admin/preProductView");
		return mv;
	}

	// 상품 관리
	@RequestMapping("/admin/manageProduct.do")
	public ModelAndView manageProduct(@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectProductCount();
		List<AdminProduct> adminProductList = service.selectProductList(cPage, numPerPage);
		
		List<Brand> brandList = service.selectBrandList();
		List<BigCategory> bcList = service.selectBcList();
		List<SmallCategory> scList = service.selectScList("B_C_NO_1");

		mv.addObject("bcList", bcList);
		mv.addObject("scList", scList);
		mv.addObject("brandList", brandList);

		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageProduct.do"));
		mv.addObject("adminProductList", adminProductList);
		mv.setViewName("admin/manageProduct");
		return mv;
	}

	@RequestMapping("/admin/productEnrollScSet.do")
	public ModelAndView productEnrollScSet(String bcNo) {
		ModelAndView mv = new ModelAndView();

		List<SmallCategory> scList = service.selectScList(bcNo);
		mv.addObject("scList", scList);

		mv.setViewName("jsonView");
		return mv;
	}

	@RequestMapping("/admin/productEnrollBrandSet.do")
	public ModelAndView productEnrollBrandSet(String scNo) {
		ModelAndView mv = new ModelAndView();

		/*
		 * List<Brand> brandList = service.selectBrandList(scNo);
		 * mv.addObject("brandList", brandList);
		 */

		mv.setViewName("jsonView");
		return mv;
	}

	// 상품재등록 관리
	@RequestMapping("/admin/manageReProduct.do")
	public ModelAndView manageReProduct(
			@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
		int numPerPage = 5;

		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectReProductCount();
		List<AdminProduct> adminProductList = service.selectReProductList(cPage, numPerPage);
		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageReProduct.do"));
		mv.addObject("adminProductList", adminProductList);
		mv.setViewName("admin/manageReProduct");
		return mv;
	}

	@RequestMapping("/admin/enrollProduct.do")
	public ModelAndView enrollProduct() {
		ModelAndView mv = new ModelAndView();
		
		List<Brand> brandList = service.selectBrandList();
		List<BigCategory> bcList = service.selectBcList();
		List<SmallCategory> scList = service.selectScList("B_C_NO_1");

		mv.addObject("bcList", bcList);
		mv.addObject("scList", scList);
		mv.addObject("brandList", brandList);
		

		mv.setViewName("admin/enrollProduct");
		return mv;
		
	}

	// 상품 등록에서 등록 날짜는 처음 등록할때만 추가하고 이후에는 업데이트로 감
	@RequestMapping(value = "/admin/enrollProductEnd.do", method = RequestMethod.POST)
	public ModelAndView enrollProductEnd(Member m, String brandNo, String bcNo, String scNo, NewProduct n, String newProductDetail, MultipartFile newProductProfile,
			MultipartFile[] newProductDetailImg, String[] newProductOption, HttpServletRequest request) {
		logger.debug("enrollProductEnd");

		String sellerNo = service.selectSellerNo(brandNo);
		logger.debug("sadfasdfasdfasdfasdf :"+sellerNo);
		
		ModelAndView mv = new ModelAndView();
		Products p = new Products();

		String savDir = request.getSession().getServletContext().getRealPath("/resources/image/product");

		if (!newProductProfile.isEmpty()) {
			// 파일명을 생성(rename)
			String orifileName = newProductProfile.getOriginalFilename();
			System.out.println("현재파일:" + orifileName);
			String ext = orifileName.substring(orifileName.lastIndexOf("."));
			// rename 규칙설정
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			int rdv = (int) (Math.random() * 1000);
			String reName = sdf.format(System.currentTimeMillis()) + "_" + rdv + ext;
			// 파일을 저장해보자
			try {
				newProductProfile.transferTo(new File(savDir + "/" + reName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			n.setNewProductProfileImg(reName);
			System.out.println("바뀐파일:" + reName);

		}

		for (MultipartFile f : newProductDetailImg) {
			if (!f.isEmpty()) {
				// 파일명을 생성(rename)
				String orifileName = f.getOriginalFilename();
				System.out.println("현재파일:" + orifileName);
				String ext = orifileName.substring(orifileName.lastIndexOf("."));
				// rename 규칙설정
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rdv = (int) (Math.random() * 1000);
				String reName = sdf.format(System.currentTimeMillis()) + "_" + rdv + ext;
				// 파일을 저장해보자
				try {
					f.transferTo(new File(savDir + "/" + reName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				n.setNewProductDetailImgList(reName);
				System.out.println("바뀐파일:" + reName);

			}
		}
		
		n.setNewProductBigCategory(bcNo);
		n.setNewProductSmallCategory(scNo);
		n.setNewProductBrand(brandNo);
		n.setNewProductMemberNo(sellerNo);

		for (String string : newProductOption) {
			n.setNewProductOptionList(string);
		}

		// 위의 setter들은 강제로 추가해준 값 (나중에 변경해줘야 함)

		n.setNewProductUpdateDate(n.getNewProductSaleStart());
		n.setNewProductAdminNo("M_NO_1");

		String msg = "";
		String loc = "";

		// p.setProductNo(productNo);//입력후 찾아서 가져옴
		p.setProductTitle(n.getNewProductName());
		p.setProductProfile(n.getNewProductProfileImg());
		p.setProductEnrollDate(n.getNewProductSaleStart());
		logger.debug("등록날짜: "+n.getNewProductSaleStart());
		logger.debug("끝날짜: "+n.getNewProductSaleEnd());
		p.setProductUpdate(n.getNewProductSaleStart());
		p.setProductEndDate(n.getNewProductSaleEnd());
		p.setProductComment(n.getNewProductComment());
		// p.setProductState(n.get);//default 0
		// p.setProductStep(productStep);//default 0
		p.setProductPrice(Integer.parseInt(n.getNewProductPrice()));
		p.setProductMax(Integer.parseInt(n.getNewProductMax()));
		p.setProductMin(Integer.parseInt(n.getNewProductMin()));
		p.setScNo(n.getNewProductSmallCategory());
		p.setBcNo(n.getNewProductBigCategory());
		p.setBrandNo(n.getNewProductBrand());
		p.setAdminNo(n.getNewProductAdminNo());
		p.setMemberNo(n.getNewProductMemberNo());
		// p.setProductCurSell(productCurSell);//default
		// p.setProductTotalSell(productTotalSell);//default
		p.setProductDiscount(Integer.parseInt(n.getNewProductSale()));

		int result1 = service.enrollProduct(p);
		n.setNewProductNo(p.getProductNo());
		Map<String, String> detail = new HashMap<String, String>();
		detail.put("productNo", p.getProductNo());
		detail.put("productDetail", newProductDetail);
		int result2 = service.enrollProductDetail(detail);
		int result3 = 0;
		int result4 = 0;
		Map<String, String> img = new HashMap<String, String>();
		img.put("productNo", n.getNewProductNo());
		Map<String, String> option = new HashMap<String, String>();
		option.put("productNo", n.getNewProductNo());

		for (String i : n.getNewProductDetailImgList()) {
			img.put("productImg", i);
			result3 = service.enrollProductImg(img);

		}
		for (String o : n.getNewProductOptionList()) {
			System.out.println("옵션값: " + o);
		}
		for (String o : n.getNewProductOptionList()) {
			option.put("productOption", o);
			result4 = service.enrollProductOption(option);
		}
		if (result1 > 0 && result2 > 0 && result3 > 0 && result4 > 0) {
			msg = "상품등록 완료";
			loc = "/admin/manageProduct.do";
		} else {
			msg = "상품등록 실패";
			loc = "/admin/enrollProductEnd.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");

		return mv;
	}

	@PostMapping("/admin/handleFileUpload.do")
    @ResponseBody
	public ResponseEntity<?> handleFileUpload(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/image/product");
		logger.debug("img핸들러 도착");
		// 파일명 생성(rename)
		String oriFileName = file.getOriginalFilename();
		String ext = oriFileName.substring(oriFileName.lastIndexOf(".")); // 파일 확장자

		// rename 규칙 설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int rdv = (int) (Math.random() * 1000); // 랜덤값 생성
		String reName = sdf.format(System.currentTimeMillis()) + "_" + rdv + ext;

		// 파일 저장
		try {
			file.transferTo(new File(saveDir + "/" + reName));
		} catch (IllegalStateException | IOException e) { // IllegalStateException : 파일 저장 경로를 못 찾을 경우
			e.printStackTrace();
		}
		logger.debug("받아온 이미지 원래이름: "+oriFileName);
		logger.debug("받아온 이미지 새이름: "+reName);
		return ResponseEntity.ok().body(reName);
	}

	@RequestMapping("/admin/manageRequest.do")
	public ModelAndView manageRequest(@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage,
			String sellerReqState) {
		if (sellerReqState != null) {
			setsReqState(sellerReqState);
		} else {
			setsReqState("B");
		}
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectRequestCount(getsReqState());
		List<SellerRequest> requestList = service.selectRequestList(getsReqState(), cPage, numPerPage);
		for (SellerRequest sellerRequest : requestList) {
			if (sellerRequest.equals("B")) {
				String reqBrandName = service.selectBrandName(sellerRequest.getSellerReqRef());
				sellerRequest.setRefName(reqBrandName);
			} else if (sellerRequest.equals("P")) {
				String reqProductName = service.selectProductName(sellerRequest.getSellerReqRef());
				sellerRequest.setRefName(reqProductName);
			}

		}
		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageRequest.do"));
		mv.addObject("requestList", requestList);
		mv.setViewName("admin/manageRequest");

		return mv;
	}

	@RequestMapping("/admin/changeReqProcess.do")
	public ModelAndView changeReqProcess(String sellerReqNo) {

		ModelAndView mv = new ModelAndView();
		logger.debug("지금 받아온 값:" + sellerReqNo);
		String[] rNoSplit = sellerReqNo.split(",");
		String msg = "";
		String loc = "";
		String reqType = rNoSplit[3].trim();// B or P
		String reqRef = rNoSplit[4].trim();// 브랜드 or 상품 no

		Map<String, String> sr1 = new HashMap<String, String>();// process
		Map<String, String> sr2 = new HashMap<String, String>();// state

		sr1.put("sellerReqNo", rNoSplit[0].trim());
		sr1.put("sellerReqProcess", rNoSplit[1]);

		sr2.put("sellerReqNo", rNoSplit[0].trim());
		sr2.put("sellerReqState", rNoSplit[2]);

		int result1 = service.reqProcessUpdate(sr1);
		int result2 = service.reqStateUpdate(sr2);
		int r = 0;
		Map<String, String> bs = new HashMap<String, String>();// brand상태 바꾸기
		Map<String, String> ps = new HashMap<String, String>();// product상태 바꾸기

		if (reqType.equals("B")) {
			bs.put("brandNo", reqRef);
			bs.put("brandState", rNoSplit[2]);
			r = service.brandStateUpdate(bs);
		} else if (reqType.equals("P")) {
			ps.put("productNo", reqRef);
			ps.put("productState", rNoSplit[2]);
			r = service.productStateUpdate(ps);
		}

		if (r > 0 && result1 > 0 && result2 > 0) {
			msg = "수정완료";
			loc = "/admin/manageRequest.do";
		} else {
			msg = "수정실패";
			loc = "/admin/manageRequest.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}

	public String getsReqState() {
		return sReqState;
	}

	public void setsReqState(String sReqState) {
		this.sReqState = sReqState;
	}

}
