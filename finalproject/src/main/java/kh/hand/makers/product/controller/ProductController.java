package kh.hand.makers.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.common.PageFactory;
import kh.hand.makers.common.PageFactoryComment;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.product.model.service.ProductService;
import kh.hand.makers.product.model.vo.ProductImg;
import kh.hand.makers.product.model.vo.Wish;
import kh.hand.makers.shop.model.service.ShopService;
import kh.hand.makers.shop.model.vo.SmallCategory;

@Controller
public class ProductController {
	
	@Autowired
	ProductService service;
	@Autowired
	ShopService shopService;
	
	public static String categoryNo;
	public static String bestCategoryNo;
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	//상품 상세화면 보여주는 서블릿
	// 3월 14일 상세상품 보여주기 위함
	@RequestMapping("/product/productView.do")
	public ModelAndView productView(@RequestParam(value="rcPage", required=false, defaultValue="1") int rcPage,
			@RequestParam(value="qcPage", required=false, defaultValue="1") int qcPage,
			@RequestParam(value="commentType", required=false, defaultValue="none") String commentType,
			String productNo, HttpServletRequest request) {
		
		int numPerPage = 4;
		
		ModelAndView mv = new ModelAndView();
		
		List<Map<String,String>> orderList = null;
		
		Map<String,String> questionMap = new HashMap();
		
		Map<String,String> reviewMap = new HashMap();
		
		reviewMap.put("commentType", "R");
		reviewMap.put("productNo", productNo);
		questionMap.put("commentType", "Q");
		questionMap.put("productNo", productNo);
		
		logger.debug(reviewMap.get("productNo"));
		
		if(request.getSession().getAttribute("member")!=null) {
			
		String memberNo = ((Member)request.getSession().getAttribute("member")).getMemberNo();
		
		reviewMap.put("memberNo", memberNo);
		
		//주문번호 가지고 오기 위함(댓글 점수 때문에)
		orderList = service.selectOrderList(reviewMap);
		
		Wish wish = new Wish();
		
		wish.setMemberNo(memberNo);
		wish.setProductNo(productNo);
			
			//위시 카운트 해서 하트 표시 하기 위한 카운트
			int count = service.selectWishCount(wish);
			
			if(count==0) {
				mv.addObject("wishCount",0);
			}else {
				mv.addObject("wishCount",1);
			}
		
		}
		logger.debug(productNo);
		logger.debug(orderList+"");
		
		//상품 정보 
		Map<String,String> product = service.selectProduct(productNo);
		//소분류 리스트
		List<SmallCategory> scList = shopService.selectScList(product.get("BC_NO"));
		//대분류 제목
		String bcTitle = service.selectBcTitle(product.get("BC_NO"));
		//sub이미지 테이블
		List<ProductImg> productImg = service.selectProductImg(productNo);
		//상세 설명 테이블
		Map<String,String> productDetail = service.selectProductDetail(productNo);
		//상품 옵션 테이블
		List<Map<String,String>> productOption = service.selectProductOption(productNo);
		//업체 정보 select
		Map<String,String> brandMap = service.selectBrand(productNo);
		//후기 정보 select
		List<Map<String,String>> reviewCommentList = service.selectComment(reviewMap, rcPage, numPerPage);
		int reviewCommentCount = service.selectCommentCount(reviewMap.get("commentType"));
		//문의 정보 select
		List<Map<String,String>> questionCommentList = service.selectComment(questionMap, qcPage, numPerPage);
		int questionCommentCount = service.selectCommentCount(questionMap.get("commentType"));
		
		//후기 대댓글 리스트
		List<Map<String, String>> reviewSecondCommentList = service.selectReviewCommentSeconds();
		
		//누적점수 select
		/*Map<String,String> totalscore = service.selectTotalScore(productNo);*/
		
		mv.addObject("brand",brandMap);
		mv.addObject("rcPage", rcPage);
		mv.addObject("qcPage", qcPage);
		mv.addObject("productOption",productOption);
		mv.addObject("productDetail",productDetail);
		mv.addObject("productImg", productImg);
		mv.addObject("bcTitle", bcTitle);
		mv.addObject("scList",scList);
		mv.addObject("product",product);
		mv.addObject("orderList",orderList);
		mv.addObject("reviewCommentList",reviewCommentList);
		mv.addObject("questionCommentList",questionCommentList);
		mv.addObject("reviewCommentCount",reviewCommentCount);
		mv.addObject("questionCommentCount",questionCommentCount);
		mv.addObject("reviewSecondCommentList", reviewSecondCommentList);
		if(commentType.equals("R"))
		{
			mv.addObject("pageBar",PageFactory.getConditionProductPageBar(reviewCommentCount, rcPage, numPerPage, "/makers/product/productView.do?commentType=R&productNo="+productNo, "R"));
			mv.addObject("type", "R");
		}else if(commentType.equals("Q")){
			mv.addObject("pageBar",PageFactory.getConditionProductPageBar(questionCommentCount, qcPage, numPerPage, "/makers/product/productView.do?commentType=Q&productNo="+productNo, "Q"));
			mv.addObject("type", "Q");
		}
		mv.setViewName("/product/productView");
		
		return mv;
	}
	
	@RequestMapping("/product/bestList.do")
	public ModelAndView productBestList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, @RequestParam(value="numPerPage", required=false, defaultValue="9") int numPerPage, String category, String sc, HttpSession session)
	{
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap();
		map.put("productStep", "2");//2= 베스트
		logger.debug("BestList in category : "+category);
		if(category != null ) {
			bestCategoryNo = category;	
			map.put("category", bestCategoryNo);
		String bcTitle = service.selectBcTitle(bestCategoryNo);
		mv.addObject("bcTitle", bcTitle);
		mv.addObject("category", bestCategoryNo);
		List<Map<String, String>> sCategoryList = service.sCategoryList(bestCategoryNo);
		mv.addObject("sCategoryList", sCategoryList);
		logger.debug("bestCategory if in -- "+map);
		
		}
		
		if( sc != null)	{ map.put("sc", sc); }
		

		if(session.getAttribute("member") != null) {
			String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
			map.put("memberNo", memberNo); 
			//logger.debug(memberNo+" : PC_category_mem");
			}
		
		
		int contentCount = service.selectProductCount(map);
		List<Map<String, String>> productList = service.productList(map, cPage, numPerPage);
		
		logger.debug("리스트는 ? : "+productList+"  ----- count ?? : "+contentCount);				
		if(category != null ) {
		mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/bestList.do?category="+bestCategoryNo+"&numPerPage="+numPerPage));
		}else
		{
			mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/bestList.do?numPerPage="+numPerPage));
		}
		mv.addObject("productList", productList);
		
		mv.addObject("cPage", cPage);
		mv.addObject("numPerPage", numPerPage);
		mv.addObject("contentCount", contentCount);
		
		logger.debug("****bestList Map : "+map);
		
		return mv;

	}
	
	@RequestMapping("/product/newList.do")
	public ModelAndView productNewList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, @RequestParam(value="numPerPage", required=false, defaultValue="8") int numPerPage)
	{
		
		Map<String, String> map = new HashMap();
		map.put("productStep", "1");//1= 신규
		int contentCount = service.selectProductCount(map);
		logger.debug(contentCount+"ㄳ");
		
		
		ModelAndView mv = new ModelAndView();
		List<Map<String, String>> list = service.productList(map, cPage, numPerPage);
		
		mv.addObject("productList", list);
		mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/newList.do?numPerPage="+numPerPage));
		mv.addObject("cPage", cPage);
		mv.addObject("numPerPage", numPerPage);
		mv.addObject("contentCount", contentCount);
		
		return mv;
	}
	
	@RequestMapping("/product/preList.do")
	public ModelAndView productPreList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, @RequestParam(value="numPerPage", required=false, defaultValue="8") int numPerPage)
	{
		Map<String, String> map = new HashMap();
		map.put("productStep", "0");//입점예정
		int contentCount = service.selectProductCount(map);
		logger.debug(contentCount+"ㄳ");
		
		
		ModelAndView mv = new ModelAndView();
		List<Map<String, String>> list = service.productList(map, cPage, numPerPage);
		
		mv.addObject("productList", list);
		mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/preList.do?numPerPage="+numPerPage));
		mv.addObject("cPage", cPage);
		mv.addObject("numPerPage", numPerPage);
		mv.addObject("contentCount", contentCount);
		
		return mv;	
		}
	
	@RequestMapping("/product/category.do")
	public ModelAndView productCategory(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, @RequestParam(value="numPerPage", required=false, defaultValue="9") int numPerPage, String category, String sc, HttpSession session)
	{
		if(category != null ) { categoryNo = category;	}
		
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap();
		map.put("category", categoryNo);
		if( sc != null)	{ map.put("sc", sc); }

		if(session.getAttribute("member") != null) {
			String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
			map.put("memberNo", memberNo); 
			//logger.debug(memberNo+" : PC_category_mem");
			}
		String bcTitle = service.selectBcTitle(categoryNo);
		List<Map<String, String>> sCategoryList = service.sCategoryList(categoryNo);
		int contentCount = service.selectProductCount(map);
		List<Map<String, String>> productList = service.productList(map, cPage, numPerPage);
		
		logger.debug("리스트는 ? : "+productList);
		logger.debug("리스트갯수는 ? : "+productList.size());
		logger.debug("  ----- count ?? : "+contentCount);
		
		mv.addObject("productList", productList);
		mv.addObject("sCategoryList", sCategoryList);
		
		if(sc != null ) {
			mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/category.do?category="+categoryNo+"&sc="+sc+"&numPerPage="+numPerPage));
			}else
			{
				mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/category.do?category="+categoryNo+"&numPerPage="+numPerPage));
			}
		
		
		
		
		mv.addObject("cPage", cPage);
		mv.addObject("numPerPage", numPerPage);
		mv.addObject("contentCount", contentCount);
		mv.addObject("bcTitle", bcTitle);
		mv.addObject("category", categoryNo);
		
		return mv;
	}
	
	@RequestMapping("/product/productTest.do")
	public String productTest()
	{
		return "/product/productView";
	}
	
	@RequestMapping("/product/selectWish.do")
	public ModelAndView selectWish(HttpSession session, String productNo, int wishCount) {
		
		ModelAndView mv = new ModelAndView();
		
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		
		System.out.println("변화전 : "+wishCount);
		
		Wish wish = new Wish();
		
		wish.setMemberNo(memberNo);
		wish.setProductNo(productNo);
		
		int result = 0;
		
		if(wishCount==0) {
			logger.debug("위시 등록!!!");
			result = service.insertWish(wish);
		}else if(wishCount!=0){
			logger.debug("위시 해제!!!");
			result = service.deleteWish(wish);
			result = result -1;
		}
		System.out.println("변화 후 :"+result);
		
		mv.addObject("wishCount",result);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	@RequestMapping("/product/productDetail.do")
	public ModelAndView productDetail(String productNo){
		ModelAndView mv = new ModelAndView();
		
		System.out.println("여기 들어 오니?");
		
		Map<String,String> productDetail = service.selectProductDetail(productNo);
		
		logger.debug(productDetail+"");
		
		mv.addObject("productDetail",productDetail);
		mv.setViewName("jsonView");
		
		return mv;
	}

	@RequestMapping("/product/selectComment.do")
	@ResponseBody
	public ModelAndView selectComment(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			String productNo, String commentType, HttpServletRequest request) {
		
		int numPerPage = 3;
		
		ModelAndView mv = new ModelAndView();
		
		Map<String,String> map = new HashMap();
		
		map.put("commentType", commentType);
		map.put("productNo", productNo);

		int commentCount = service.selectCommentCount(commentType);
		
		List<Map<String,String>> commentList = service.selectComment(map,cPage, numPerPage);
		
		logger.debug(commentList+"");
		
		mv.addObject("cPage",cPage);
		mv.addObject("pageBar",PageFactoryComment.getPageBar(commentCount, cPage, numPerPage, "/makers/product/selectComment.do?productNo="+productNo+"&commentType="+commentType, productNo, commentType));
		mv.addObject("commentList",commentList);
		
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	@RequestMapping("/product/insertCommentReview.do")
	public ModelAndView insertCommentReview(@RequestParam Map<String,String> map, HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView();
		
		logger.debug(map+"");
		
		int result = service.insertCommentReview(map);
		
		String msg = "";
		String loc = "/product/productView.do?productNo="+map.get("reviewCommentProductNo");
		
		if(result>0) {
			System.out.println("이건 되니????");
			logger.debug(map+"");
			result = service.insertTotalScoreReview(map);
			if(result>0) {				
				msg = "후기 댓글 등록 성공~!";
			}
		}else {
			msg = "후기 댓글 등록 실패하였습니다..";
		}
		
		mv.addObject("loc",loc);
		mv.addObject("msg",msg);
		mv.setViewName("/common/msg");
		
		return mv;
	}
	
	/*@RequestMapping("/product/selectReviewCommentSeconds.do")
	public ModelAndView selectReviewCommentSeconds(String commentNo)
	{
		ModelAndView mv = new ModelAndView();
		List<Map<String, String>> list = service.selectReviewCommentSeconds(commentNo);
		mv.addObject("list",list);
		mv.setViewName("jsonView");
		
		return mv;
	}*/
	
	@RequestMapping("/product/selectWishYewon.do")
	@ResponseBody
	public int selectWishYewon(HttpSession session, String productNo) {
		String memberNo=null;
		 
		
		if(session.getAttribute("member") != null) {
			memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		}
		Map<String, String> map = new HashMap();
		map.put("productNo", productNo);
		map.put("memberNo", memberNo);
		
		int result = service.selectWishYewon(map);
		
		return result;
	}
	
	@RequestMapping("/product/insertCommentQuestion.do")
	public ModelAndView insertCommentQuestion(@RequestParam Map<String,String> map, HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView();
		
		logger.debug(map+"");
		
		int result = service.insertCommentQuestion(map);
		
		String msg = "";
		String loc = "/product/productView.do?productNo="+map.get("questionCommentProductNo");
		
		if(result>0) {
			System.out.println("이건 되니????");
			logger.debug(map+"");
		
			msg = "문의 댓글 등록 성공~!";
			
		}else {
			msg = "문의 댓글 등록 실패하였습니다..";
		}
		
		mv.addObject("loc",loc);
		mv.addObject("msg",msg);
		mv.setViewName("/common/msg");
		
		return mv;
	}
	
	@RequestMapping("/product/updateReviewComment.do")
	public ModelAndView updateReviewComment(@RequestParam Map<String,String> map) {
		
		ModelAndView mv = new ModelAndView();
		
		logger.debug(map+"");
		
		int result = service.updateComment(map);
		
		logger.debug(result+"");
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/product/insertReviewCommentLevel2.do")
	public ModelAndView insertCommentLevel2(@RequestParam Map<String,String> map) {
		
		ModelAndView mv = new ModelAndView();
		
		logger.debug(map+"");
		
		return mv;
	}
	
}