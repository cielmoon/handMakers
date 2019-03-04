package kh.hand.makers.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.hand.makers.HomeController;

@Controller
public class HeaderController {
	
	private static final Logger logger = LoggerFactory.getLogger(HeaderController.class);
	
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
	
	@RequestMapping("/product/category.do")
	public String productCategory()
	{
		return "product/category";
	}

}
