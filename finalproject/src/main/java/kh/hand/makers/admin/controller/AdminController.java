package kh.hand.makers.admin.controller;


import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import java.io.*;


import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.admin.model.service.AdminService;
import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.NewProduct;
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
	public ModelAndView manageProduct(
			@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectProductCount();
		List<AdminProduct> adminProductList = service.selectProductList(cPage, numPerPage);
		
		List<BigCategory> bcList = service.selectBcList();
		List<SmallCategory> scList = service.selectScList("B_C_NO_1");
		
		mv.addObject("bcList", bcList);
		mv.addObject("scList", scList);
		
		
		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageProduct.do"));
		mv.addObject("adminProductList", adminProductList);
		mv.setViewName("admin/manageProduct");
		return mv;
	}
	@RequestMapping("/admin/productEnrollScSet.do")
	public ModelAndView productEnrollScSet(String bcNo)
	{
		ModelAndView mv = new ModelAndView();

		List<SmallCategory> scList = service.selectScList(bcNo);
		mv.addObject("scList", scList);
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/admin/productEnrollBrandSet.do")
	public ModelAndView productEnrollBrandSet(String scNo)
	{
		ModelAndView mv = new ModelAndView();

		/*List<Brand> brandList = service.selectBrandList(scNo);
		mv.addObject("brandList", brandList);*/
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 상품재등록 관리
	@RequestMapping("/admin/manageReProduct.do")
	public ModelAndView manageReProduct(@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
		int numPerPage = 5;
		
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectReProductCount();
		List<AdminProduct> adminProductList = service.selectReProductList(cPage, numPerPage);
		mv.addObject("pageBar",	PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageReProduct.do"));
		mv.addObject("adminProductList", adminProductList);
		mv.setViewName("admin/manageReProduct");
		return mv;
	}

	@RequestMapping("/admin/enrollProduct.do")
	public String enrollProduct() {
		return "admin/enrollProduct";
	}

	// 상품 등록에서 등록 날짜는 처음 등록할때만 추가하고 이후에는 업데이트로 감
	@RequestMapping("/admin/enrollProductEnd.do")
	public ModelAndView enrollProductEnd(Member m, NewProduct n, HttpServletRequest request) {
		logger.debug("enrollProductEnd");
		
		ModelAndView mv = new ModelAndView();
		
		n.setNewProductDetailImgList("김연아.jpg");
		n.setNewProductDetailImgList("김연아.jpg");
		n.setNewProductDetailImgList("김연아.jpg");
		
		n.setNewProductOptionList("옵션1");
		n.setNewProductOptionList("옵션2");
		n.setNewProductOptionList("옵션3");
		
		n.setNewProductBigCategory("B_C_NO_1");
		n.setNewProductSmallCategory("S_C_NO_2");
		n.setNewProductBrand("B_NO_21");
		n.setNewProductMemberId("M_NO_2");
		// 위의 setter들은 강제로 추가해준 값 (나중에 변경해줘야 함)
		
		n.setNewProductUpdateDate(n.getNewProductSaleStart());
		n.setNewProductAdminId("M_NO_1");
		
		/*String root = pageContext.request.contextPath;
		String saveDir = root + "assets"+"\\upload" + File.separator + "boardImage";

		// 파일에 대한 크기제한 설정
		int maxSize = 1024 * 1024 * 10;// 10Mb

		MultipartRequest mr = new MultipartRequest(request, saveDir, maxSize, "UTF-8", new DefaultFileRenamePolicy());

		
		Enumeration e = mr.getFileNames();
		while(e.hasMoreElements())
		{
			n.setNewProductDetailImgList(mr.getFilesystemName((String)e.nextElement()));
			
		}*/
		
		System.out.println("n : !@13" + n);
		System.out.println("날짜 : " + n.getNewProductSale());
		
		String msg = "";
		String loc = "";
	
		int result1 = service.enrollProduct(n);

		
		if (result1 > 0 ) {
			msg = "상품등룍 완료";
			System.out.println(n.getNewProductNo());
			
			loc = "/admin/enrollProduct.do";
		} else {
			msg = "상품등룍 실패";
			loc = "/admin/enrollProductEnd.do";
		}
	
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		
		return mv;
	}

	@RequestMapping("/admin/manageRequest.do")
	public ModelAndView manageRequest(@RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage, String sellerReqState) {		
		if(sellerReqState != null) {
			setsReqState(sellerReqState);
		}else {
			setsReqState("B");
		}
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();
		int contentCount = service.selectRequestCount(getsReqState());
		List<SellerRequest> requestList = service.selectRequestList(getsReqState(), cPage, numPerPage);
		for (SellerRequest sellerRequest : requestList) {
			if(sellerRequest.equals("B")) {
				String reqBrandName = service.selectBrandName(sellerRequest.getSellerReqRef());
				sellerRequest.setRefName(reqBrandName);
			}else if(sellerRequest.equals("P")){
				String reqProductName = service.selectProductName(sellerRequest.getSellerReqRef());
				sellerRequest.setRefName(reqProductName);
			}
			
		}
		mv.addObject("pageBar",	PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageRequest.do"));
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
		String reqType = rNoSplit[3].trim();//B or P
		String reqRef = rNoSplit[4].trim();//브랜드 or 상품 no
		Map<String, String> sr1 = new HashMap<String, String>();//process
		Map<String, String> sr2 = new HashMap<String, String>();//state
		sr1.put("sellerReqNo", rNoSplit[0].trim());
		sr1.put("sellerReqProcess", rNoSplit[1]);
		
		sr2.put("sellerReqNo", rNoSplit[0].trim());
		sr2.put("sellerReqState", rNoSplit[2]);		

		int result1 = service.reqProcessUpdate(sr1);
		int result2 = service.reqStateUpdate(sr2);
		int r = 0;
		Map<String, String> bs = new HashMap<String, String>();//brand상태 바꾸기
		Map<String, String> ps = new HashMap<String, String>();//product상태 바꾸기
		
		if(reqType.equals("B")) {
			bs.put("brandNo", reqRef);
			bs.put("brandState",rNoSplit[2] );
			r = service.brandStateUpdate(bs);
		}else if(reqType.equals("P")){
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
