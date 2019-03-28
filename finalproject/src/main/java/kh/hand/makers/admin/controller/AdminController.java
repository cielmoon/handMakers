package kh.hand.makers.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@RequestMapping("/admin/questionAndAnswer.do")
	public String questionAndAnswerPage() {
		return "admin/questionAndAnswer";
	}

	@RequestMapping("/admin/memberList.do")
	public ModelAndView manageMember(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();

		List<Member> memberList = service.selectMemberList(cPage, numPerPage);
		int contentCount = service.selectMemberCount(memberList);

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
	public ModelAndView manageBrand(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {
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

		ModelAndView mv = new ModelAndView();
		System.out.println("지금 받아온 값:" + brandNo);
		String[] bNoSplit = brandNo.split(",");
		String msg = "";
		String loc = "";
		Map<String, String> bs = new HashMap<String, String>();
		String bNo = bNoSplit[0].trim();

		bs.put("brandNo", bNo);
		bs.put("brandState", bNoSplit[1]);

		String memberNo = service.selectSellerNo(bNo);
		int result = service.brandStateUpdate(bs);
		if (result > 0 && bNoSplit[1].equals("b")) {
			int updateResult = service.memberStateUpdate(memberNo);
			int updateSellerProfile = service.sellerProfileUpdate(memberNo);
			if (updateResult > 0) {
				msg = "수정완료";
				loc = "/admin/manageBrand.do";
			} else {
				Map<String, String> bbs = new HashMap<String, String>();
				bbs.put("brandNo", bNo);
				bbs.put("brandState", "a");
				int results = service.brandStateUpdate(bbs);
				msg = "수정실패(판매자 등록 실패)";
				loc = "/admin/manageBrand.do";
			}
		} else if (result > 0 && bNoSplit[1].equals("c")) {
			msg = "수정완료";
			loc = "/admin/manageBrand.do";
		} else {
			msg = "수정실패";
			loc = "/admin/manageBrand.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;

	}

	// 입점 관리
	@RequestMapping("/admin/managePreProduct.do")
	public ModelAndView managePreProduct(
			@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();

		List<Brand> brandList = service.selectBrandList();
		List<BigCategory> bcList = service.selectBcList();
		List<SmallCategory> scList = service.selectScList("B_C_NO_1");

		Map<String, String> sortingProductList = new HashMap<String, String>();// state
		List<Brand> brandLists = service.selectBrandList();
		sortingProductList.put("brandNo", brandLists.get(0).getBrandNo());
		sortingProductList.put("bcNo", "B_C_NO_1");
		sortingProductList.put("scNo", "S_C_NO_1");

		/*
		 * List<AdminProduct> adminProductList =
		 * service.selectProductList(sortingProductList);
		 */
		List<managePreProduct> preProductList = service.selectPreProductList(cPage, numPerPage, sortingProductList);
		int contentCount = service.selectPreProductCount(sortingProductList);
		for (managePreProduct managePreProduct : preProductList) {
			managePreProduct.setPrePDate(managePreProduct.getPreProductDate().toString());
		}
		mv.addObject("bcList", bcList);
		mv.addObject("scList", scList);
		mv.addObject("brandList", brandList);

		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/managePreProduct.do"));
		mv.addObject("preProductList", preProductList);
		mv.setViewName("admin/managePreProduct");
		return mv;

	}

	@RequestMapping("/admin/selectPList.do")
	@ResponseBody
	public Map selectPList(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			String brandNo, String bcNo, String scNo) {
		int numPerPage = 5;
		/* ModelAndView mv = new ModelAndView(); */

		Map<String, String> sortingProductList = new HashMap<String, String>();// state

		sortingProductList.put("brandNo", brandNo);
		sortingProductList.put("bcNo", bcNo);
		sortingProductList.put("scNo", scNo);

		List<managePreProduct> preProductList = service.selectPreProductList(cPage, numPerPage, sortingProductList);
		for (managePreProduct managePreProduct : preProductList) {
			managePreProduct.setPrePDate(managePreProduct.getPreProductDate().toString());
		}
		int contentCount = service.selectPreProductCount(sortingProductList);
		logger.debug("현재 brandNo :" + brandNo);
		logger.debug("현재 Productsize :" + contentCount);

		Map map = new HashMap();
		map.put("proc", preProductList);
		map.put("page", PageFactory.getManageProductPageBar(contentCount, cPage, numPerPage, brandNo, bcNo, scNo,
				"/makers/admin/selectPList.do"));
		/*
		 * map.put("page",PageFactory.getManageProductPageBar(contentCount, cPage,
		 * numPerPage, brandNo, bcNo, scNo, "/makers/admin/selectBList.do"));
		 */
		/*
		 * mv.addObject("pageBar", PageFactory.getPageBar(contentCount, cPage,
		 * numPerPage, "/makers/admin/selectBrandProductList.do"));
		 * mv.addObject("adProductList", adProductList); mv.setViewName("jsonView");
		 */

		return map;
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
	public ModelAndView manageProduct(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();

		List<Brand> brandList = service.selectBrandList();
		List<BigCategory> bcList = service.selectBcList();
		List<SmallCategory> scList = service.selectScList("B_C_NO_1");

		Map<String, String> sortingProductList = new HashMap<String, String>();// state
		List<Brand> brandLists = service.selectBrandList();
		sortingProductList.put("brandNo", brandLists.get(0).getBrandNo());
		sortingProductList.put("bcNo", "B_C_NO_1");
		sortingProductList.put("scNo", "S_C_NO_1");

		/*
		 * List<AdminProduct> adminProductList =
		 * service.selectProductList(sortingProductList);
		 */
		List<AdminProduct> adminProductList = service.selectProductList(cPage, numPerPage, sortingProductList);
		int contentCount = service.selectProductCount(sortingProductList);
		for (AdminProduct adminProduct : adminProductList) {
			System.out.println("가져온 리스트: " + adminProductList);
		}
		mv.addObject("bcList", bcList);
		mv.addObject("scList", scList);
		mv.addObject("brandList", brandList);

		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageProduct.do"));
		mv.addObject("adminProductList", adminProductList);
		mv.setViewName("admin/manageProduct");
		return mv;
	}

	@RequestMapping("/admin/selectBList.do")
	@ResponseBody
	public Map selectBList(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			String brandNo, String bcNo, String scNo) {
		int numPerPage = 5;
		/* ModelAndView mv = new ModelAndView(); */

		Map<String, String> sortingProductList = new HashMap<String, String>();// state

		sortingProductList.put("brandNo", brandNo);
		sortingProductList.put("bcNo", bcNo);
		sortingProductList.put("scNo", scNo);

		/*
		 * List<AdminProduct> adProductList =
		 * service.selectProductList(sortingProductList);
		 */
		List<AdminProduct> adProductList = service.selectProductList(cPage, numPerPage, sortingProductList);
		for (AdminProduct adminProduct : adProductList) {
			System.out.println("ProductNo:" + adminProduct.getProductNo());
			System.out.println("업데이트날짜:" + adminProduct.getUpdateDate());
			System.out.println("마감날짜:" + adminProduct.getProductEndDate());
			adminProduct.setpUpdateDate(adminProduct.getUpdateDate().toString());
			adminProduct.setpEndDate(adminProduct.getProductEndDate().toString());
			adminProduct.setpEnrollDate(adminProduct.getProductEnrollDate().toString());
		}
		
		int contentCount = service.selectProductCount(sortingProductList);
		logger.debug("현재 brandNo :" + brandNo);
		logger.debug("현재 Productsize :" + contentCount);

		Map map = new HashMap();
		map.put("proc", adProductList);
		map.put("page", PageFactory.getManageProductPageBar(contentCount, cPage, numPerPage, brandNo, bcNo, scNo,
				"/makers/admin/selectBList.do"));
		/*
		 * map.put("page",PageFactory.getManageProductPageBar(contentCount, cPage,
		 * numPerPage, brandNo, bcNo, scNo, "/makers/admin/selectBList.do"));
		 */
		/*
		 * mv.addObject("pageBar", PageFactory.getPageBar(contentCount, cPage,
		 * numPerPage, "/makers/admin/selectBrandProductList.do"));
		 * mv.addObject("adProductList", adProductList); mv.setViewName("jsonView");
		 */

		return map;
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
			@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage) {
		int numPerPage = 5;
		ModelAndView mv = new ModelAndView();

		List<Brand> brandList = service.selectBrandList();
		List<BigCategory> bcList = service.selectBcList();
		List<SmallCategory> scList = service.selectScList("B_C_NO_1");

		Map<String, String> sortingProductList = new HashMap<String, String>();// state
		List<Brand> brandLists = service.selectBrandList();
		sortingProductList.put("brandNo", brandLists.get(0).getBrandNo());
		sortingProductList.put("bcNo", "B_C_NO_1");
		sortingProductList.put("scNo", "S_C_NO_1");

		/*
		 * List<AdminProduct> adminProductList =
		 * service.selectProductList(sortingProductList);
		 */
		List<AdminProduct> adminProductList = service.selectReProductList(cPage, numPerPage, sortingProductList);
		int contentCount = service.selectReProductCount(sortingProductList);

		mv.addObject("bcList", bcList);
		mv.addObject("scList", scList);
		mv.addObject("brandList", brandList);
		for (AdminProduct adminProduct : adminProductList) {
			adminProduct.setpUpdateDate(adminProduct.getUpdateDate().toString());
			adminProduct.setpEndDate(adminProduct.getProductEndDate().toString());
			adminProduct.setpEnrollDate(adminProduct.getProductEnrollDate().toString());
		}

		mv.addObject("pageBar",
				PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageReProduct.do"));
		mv.addObject("adminProductList", adminProductList);
		mv.setViewName("admin/manageReProduct");

		return mv;
	}

	@RequestMapping("/admin/selectRList.do")
	@ResponseBody
	public Map selectRList(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			String brandNo, String bcNo, String scNo) {
		int numPerPage = 5;
		/* ModelAndView mv = new ModelAndView(); */

		Map<String, String> sortingProductList = new HashMap<String, String>();// state

		sortingProductList.put("brandNo", brandNo);
		sortingProductList.put("bcNo", bcNo);
		sortingProductList.put("scNo", scNo);

		/*
		 * List<AdminProduct> adProductList =
		 * service.selectProductList(sortingProductList);
		 */
		List<AdminProduct> adProductList = service.selectReProductList(cPage, numPerPage, sortingProductList);
		for (AdminProduct adminProduct : adProductList) {
			adminProduct.setpEndDate(adminProduct.getProductEndDate().toString());
			adminProduct.setpEnrollDate(adminProduct.getProductEnrollDate().toString());
			adminProduct.setpUpdateDate(adminProduct.getUpdateDate().toString());
		}
		int contentCount = service.selectReProductCount(sortingProductList);

		Map map = new HashMap();
		map.put("proc", adProductList);
		map.put("page", PageFactory.getManageProductPageBar(contentCount, cPage, numPerPage, brandNo, bcNo, scNo, "/makers/admin/selectRList.do"));
		/*
		 * map.put("page",PageFactory.getManageProductPageBar(contentCount, cPage,
		 * numPerPage, brandNo, bcNo, scNo, "/makers/admin/selectBList.do"));
		 */
		/*
		 * mv.addObject("pageBar", PageFactory.getPageBar(contentCount, cPage,
		 * numPerPage, "/makers/admin/selectBrandProductList.do"));
		 * mv.addObject("adProductList", adProductList); mv.setViewName("jsonView");
		 */

		return map;
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
	public ModelAndView enrollProductEnd(Member m, String brandNo, String bcNo, String scNo, NewProduct n,
			String newProductDetail, MultipartFile newProductProfile, MultipartFile[] newProductDetailImg,
			String[] newProductOption, HttpServletRequest request) {
		logger.debug("enrollProductEnd");

		String sellerNo = service.selectSellerNo(brandNo);
		logger.debug("sadfasdfasdfasdfasdf :" + sellerNo);

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

		logger.debug("끝날짜: " + n.getNewProductSaleEnd());
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
		logger.debug("받아온 이미지 원래이름: " + oriFileName);
		logger.debug("받아온 이미지 새이름: " + reName);
		return ResponseEntity.ok().body(reName);
	}

	@RequestMapping("/admin/manageRequest.do")
	public ModelAndView manageRequest(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
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
			if (sellerRequest.getSellerReqType().equals("B")) {
				String reqBrandName = service.selectBrandName(sellerRequest.getSellerReqRef());
				sellerRequest.setRefName(reqBrandName);
			} else if (sellerRequest.getSellerReqType().equals("P")) {
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

	@RequestMapping("/admin/manageRequestBrand.do")
	@ResponseBody
	public Map manageRequestBrand(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			String state) {
		int numPerPage = 5;

		List<SellerRequest> selectRequestList = service.selectRequestStateList(cPage, numPerPage, state);
		int contentCount = service.selectRequestStateListCount(state);
		for (SellerRequest sellerRequest : selectRequestList) {
			String reqBrandName = service.selectBrandName(sellerRequest.getSellerReqRef());
			sellerRequest.setsReqDate(sellerRequest.getSellerReqDate().toString());
			sellerRequest.setRefName(reqBrandName);

		}
		Map map = new HashMap();
		map.put("proc", selectRequestList);
		map.put("page", PageFactory.getManageRequestBrandPageBar(contentCount, cPage, numPerPage, state,
				"/makers/admin/manageRequestBrand.do"));

		return map;
	}

	@RequestMapping("/admin/manageRequestProduct.do")
	@ResponseBody
	public Map manageRequestProduct(@RequestParam(value = "cPage", required = false, defaultValue = "1") int cPage,
			String state) {
		int numPerPage = 5;

		List<SellerRequest> selectRequestList = service.selectRequestStateList(cPage, numPerPage, state);
		int contentCount = service.selectRequestStateListCount(state);
		for (SellerRequest sellerRequest : selectRequestList) {
			String reqProductName = service.selectProductName(sellerRequest.getSellerReqRef());
			sellerRequest.setsReqDate(sellerRequest.getSellerReqDate().toString());
			sellerRequest.setRefName(reqProductName);

		}
		Map map = new HashMap();
		map.put("proc", selectRequestList);
		map.put("page", PageFactory.getManageRequestProductPageBar(contentCount, cPage, numPerPage, state,
				"/makers/admin/manageRequestProduct.do"));

		return map;
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
			String memberNo = service.selectSellerNo(reqRef);
			int count = service.selectBrandStateCount(memberNo);
			if (rNoSplit[2].equals("e") && count == 1) {
				// 멤버 권한을 S -> M
				int updateResult = service.memberAuthorityChange(memberNo);
			}
			if (rNoSplit[2].equals("e")) {
				int updateProductStateResult = service.updateProductState(reqRef);
				if (updateProductStateResult > 0) {
					logger.debug("해당 브랜드의 모든 상품 판매중지 완료(상태는:판매완료)");
				} else {
					logger.debug("해당 브랜드의 모든 상품 상태 변경 실패");
				}
			}
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

	@RequestMapping("/admin/updateProductInfo.do")
	public ModelAndView updateProductInfo(String productNo) {
		logger.debug("재등록 상세 productNo: "+productNo);
		Map<String, String> product = service.selectProduct(productNo);

		ModelAndView mv = new ModelAndView();
		mv.addObject("product", product);
		mv.setViewName("admin/updateProductInfo");

		return mv;
	}

	@RequestMapping("/admin/updateProductInfoEnd.do")
	public ModelAndView updateProductInfoEnd(String productNo, String productNewPrice, String productNewMin,
			String productNewMax, String productNewEndDate) {

		Map<String, String> product = service.selectProduct(productNo);
		String msg = "";
		String loc = "";

		product.put("productNo", productNo);
		product.put("productPrice", productNewPrice);
		product.put("productMin", productNewMin);
		product.put("productMax", productNewMax);
		product.put("productEndDate", productNewEndDate);

		int result = service.updateProduct(product);
		ModelAndView mv = new ModelAndView();
		if (result > 0) {
			msg = "재등록 완료";
			loc = "/admin/manageProduct.do";
		} else {
			msg = "재등록 실패";
			loc = "/admin/updateProductInfo.do";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}
	@RequestMapping("/admin/checkReq.do")
	public ModelAndView checkReq(String sellerReqNo) {	
		ModelAndView mv = new ModelAndView();
		SellerRequest sellerReq =  service.selectSellerRequest(sellerReqNo);
		if (sellerReq.getSellerReqType().equals("B")) {
			String reqBrandName = service.selectBrandName(sellerReq.getSellerReqRef());
			sellerReq.setRefName(reqBrandName);
		} else if (sellerReq.getSellerReqType().equals("P")) {
			String reqProductName = service.selectProductName(sellerReq.getSellerReqRef());
			sellerReq.setRefName(reqProductName);
		}
		System.out.println(sellerReq);
		mv.addObject("sellerReq", sellerReq);
		mv.setViewName("admin/sellerReqInfo");

		return mv;
	}
	
	@RequestMapping("/admin/updatePState.do")
	public ModelAndView updatePState(String productNo) {	

		int result=  service.updatePState(productNo);		

		ModelAndView mv = new ModelAndView();
		String msg = "";
		String loc = "";
		if (result > 0) {
			msg = "판매중지 완료";
			loc = "/admin/manageProduct.do";
		} else {
			msg = "판매중지 실패";
			loc = "/admin/manageProduct.do";
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
