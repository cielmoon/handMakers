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
	/*public static String numPerPage;*/
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	//상품 상세화면 보여주는 서블릿
	// 3월 14일 상세상품 보여주기 위함
	@RequestMapping("/product/productView.do")
	public ModelAndView productView(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			String productNo, HttpServletRequest request) {
		
		int numPerPage = 3;
		
		ModelAndView mv = new ModelAndView();
		
		List<Map<String,String>> orderList = null;
		
		Map<String,String> questionMap = new HashMap();
		
		Map<String,String> reviewMap = new HashMap();
		
		if(request.getSession().getAttribute("member")!=null) {
			
		String memberNo = ((Member)request.getSession().getAttribute("member")).getMemberNo();
		
		reviewMap.put("reviewCommentType", "R");
		reviewMap.put("productNo", productNo);
		reviewMap.put("memberNo", memberNo);
		questionMap.put("questionCommentType", "Q");
		questionMap.put("productNo", productNo);
		questionMap.put("memberNo", memberNo);
		
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
		List<Map<String,String>> reviewCommentList = service.selectComment(reviewMap, cPage, numPerPage);
		int reviewCommentCount = service.selectCommentCount(reviewMap.get("reviewCommentType"));
		//문의 정보 select
		List<Map<String,String>> questionCommentList = service.selectComment(questionMap, cPage, numPerPage);
		int questionCommentCount = service.selectCommentCount(questionMap.get("questionCommentType"));
		
		mv.addObject("brand",brandMap);
		mv.addObject("cPage", cPage);
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
		mv.addObject("reviewPageBar",PageFactory.getConditionPageBar(reviewCommentCount, cPage, numPerPage, "/product/productView.do?productNo="+productNo+"&commentType="+reviewMap.get("reviewCommentType")));
		mv.addObject("questionPageBar",PageFactory.getConditionPageBar(questionCommentCount, cPage, numPerPage, "/product/productView.do?productNo="+productNo+"&commentType="+questionMap.get("questionCommentType")));
		mv.setViewName("/product/productView");

		return mv;
	}
	
	@RequestMapping("/product/bestList.do")
	public String productBestList()
	{
		return "product/bestList";
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
		mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/newList.do?numPerPage="+numPerPage));
		mv.addObject("cPage", cPage);
		mv.addObject("numPerPage", numPerPage);
		mv.addObject("contentCount", contentCount);
		
		return mv;	
		}
	
	@RequestMapping("/product/category.do")
	public ModelAndView productCategory(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, @RequestParam(value="numPerPage", required=false, defaultValue="9") int numPerPage, String category, String sc)
	{
		
		if(category != null ) { categoryNo = category;	}
		
		//logger.debug(numPerPages+"pages");
		//logger.debug(numPerPage+"nomal");
		//int contentCount = service.selectProductCount(categoryNo);
		ModelAndView mv = new ModelAndView();
		//logger.debug("ProductController In -");logger.debug("+_+_+_+query : "+category);
		Map<String, String> map = new HashMap();
		map.put("category", categoryNo);
		if( sc != null)	{ map.put("sc", sc); }
		logger.debug("가져온 sc 있니? : "+sc);
		String bcTitle = service.selectBcTitle(categoryNo);
		List<Map<String, String>> sCategoryList = service.sCategoryList(categoryNo);
		int contentCount = service.selectProductCount(map);
		List<Map<String, String>> productList = service.productList(map, cPage, numPerPage);
		logger.debug("P.C- sCategoryList : "+sCategoryList);
		
		
		mv.addObject("productList", productList);
		mv.addObject("sCategoryList", sCategoryList);
		//mv.addObject("pageBar", PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/product/category.do"));
		//페이징 다른 버전 url+=cpage
		mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/category.do?category="+categoryNo+"&numPerPage="+numPerPage));
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
	
}