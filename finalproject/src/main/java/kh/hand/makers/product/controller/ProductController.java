package kh.hand.makers.product.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.product.model.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	ProductService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	//상품 상세화면 보여주는 서블릿
	@RequestMapping("/product/productView.do")
	public String productView() {
		
		return "/product/productView";
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
	public ModelAndView productCategory(String category)
	{
		ModelAndView mv = new ModelAndView("product/category");
		logger.debug("ProductController In -");
		logger.debug("+_+_+_+query : "+category);
		
		List<Map<String, Object>> list = service.selectCategoryTemp(category);
		mv.addObject("productList", list);
		System.out.println(list);
		return mv;
	}
	
	@RequestMapping("/product/productTest.do")
	public String productTest()
	{
		return "/product/productView";
	}

}
