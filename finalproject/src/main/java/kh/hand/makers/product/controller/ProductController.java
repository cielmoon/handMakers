package kh.hand.makers.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ModelAndView productView(String productNo, HttpSession session) {
		
		ModelAndView mv = new ModelAndView();
		
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		
		Wish wish = new Wish();
		
		wish.setMemberNo(memberNo);
		wish.setProductNo(productNo);
		
		logger.debug(productNo);
		
		Map<String,String> product = service.selectProduct(productNo);
		List<SmallCategory> scList = shopService.selectScList(product.get("BC_NO"));
		String bcTitle = service.selectBcTitle(product.get("BC_NO"));
		List<ProductImg> productImg = service.selectProductImg(productNo);
		Map<String,String> productDetail = service.selectProductDetail(productNo);
		
		int count = service.selectWishCount(wish);
		
		if(count==0) {
			mv.addObject("wishCount",0);
		}else {
			mv.addObject("wishCount",1);
		}
		
		mv.addObject("productDetail",productDetail);
		mv.addObject("productImg", productImg);
		mv.addObject("bcTitle", bcTitle);
		mv.addObject("scList",scList);
		mv.addObject("product",product);
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
	public ModelAndView productCategory(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, @RequestParam(value="numPerPage", required=false, defaultValue="9") int numPerPage, String category)
	{
		
		if(category != null ) { categoryNo = category;	}
		Map<String, String> map = new HashMap();
		map.put("category", categoryNo);
		//logger.debug(numPerPages+"pages");
		//logger.debug(numPerPage+"nomal");
		//int contentCount = service.selectProductCount(categoryNo);
		int contentCount = service.selectProductCount(map);
		ModelAndView mv = new ModelAndView();
		//logger.debug("ProductController In -");logger.debug("+_+_+_+query : "+category);
		List<Map<String, String>> list = service.productList(map, cPage, numPerPage);
		
		mv.addObject("productList", list);
		//mv.addObject("pageBar", PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/product/category.do"));
		//페이징 다른 버전 url+=cpage
		mv.addObject("pageBar", PageFactory.getConditionPageBar(contentCount, cPage, numPerPage, "/makers/product/category.do?category="+categoryNo+"&numPerPage="+numPerPage));
		mv.addObject("cPage", cPage);
		mv.addObject("numPerPage", numPerPage);
		mv.addObject("contentCount", contentCount);
		
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
	public ModelAndView selectComment(@RequestParam(value="cPage", required=false, defaultValue="0") int cPage,
			String productNo, String commentType, HttpSession session) {
		
		int numPerPage = 3;
		
		ModelAndView mv = new ModelAndView();
		
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		
		System.out.println("커멘트 작업장이야 "+productNo+" " + commentType);
		
		Map<String,String> map = new HashMap();
		
		map.put("commentType", commentType);
		map.put("productNo", productNo);
		map.put("memberNo", memberNo);
		
		int commentCount = service.selectCommentCount(commentType);
		
		List<Map<String,String>> list = service.selectComment(map,cPage, numPerPage);
		
		mv.addObject("pageBar",PageFactoryComment.getPageBar(commentCount, cPage, numPerPage, "/makers/product/selectComment.do?productNo="+map.get("productNo")+"&commentType="+map.get("commentType")));
		mv.addObject("commentList",list);
		mv.setViewName("jsonView");
		
		return mv;
	}
}