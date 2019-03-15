package kh.hand.makers.product.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.common.PageFactory;
import kh.hand.makers.product.model.service.ProductService;
import kh.hand.makers.product.model.vo.Product;

@Controller
public class ProductController {
	
	@Autowired
	ProductService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	//상품 상세화면 보여주는 서블릿
	// 3월 14일 상세상품 보여주기 위함
	@RequestMapping("/product/productView.do")
	public ModelAndView productView(String productNo) {
		
		ModelAndView mv = new ModelAndView();
		
		logger.debug(productNo);
		
		Map<String,String> map = service.selectProduct(productNo);

		System.out.println("찍나?");
		
		System.out.println(map);
		
		mv.addObject("product",map);
		mv.setViewName("/product/productView");

		return mv;
	}
	
	@RequestMapping("/product/bestList.do")
	public String productBestList()
	{
		return "product/bestList";
	}
	
	@RequestMapping("/product/newList.do")
	public String productNewList()
	{
		return "product/newList";
	}
	
	@RequestMapping("/product/preList.do")
	public String productPreList()
	{
		return "product/preList";
	}
	
	/*@RequestMapping("/product/category.do")
	public String productCategory()
	{
		return "product/category";
	}*/
	@RequestMapping("/product/category.do")
	public ModelAndView productCategory(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, String category)
	{
	
		int numPerPage=8;
		int contentCount = service.selectProductCount();
		
		ModelAndView mv = new ModelAndView();
		//ModelAndView mv = new ModelAndView("product/category");
		logger.debug("ProductController In -");
		logger.debug("+_+_+_+query : "+category);
		
		//List<Map<String, Object>> list = service.selectCategoryTemp(category);
		//mv.addObject("productList", list);
		//System.out.println(list);
		
//		List<Map<String, String>> list = service.productList(category);
		List<Map<String, String>> list = service.productList(category, cPage, numPerPage);
		
		
		mv.addObject("productList", list);
		/*mv.addObject("pageBar", PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/product/category.do"+category));*/
		mv.addObject("pageBar", PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/product/category.do"));
		System.out.println(list);
		mv.addObject("cPage", cPage);
		mv.addObject("contentCount", contentCount);
		
		return mv;
	}
	
	@RequestMapping("/product/productTest.do")
	public String productTest()
	{
		return "/product/productView";
	}

}





