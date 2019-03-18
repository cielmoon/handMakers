package kh.hand.makers.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.hand.makers.product.model.service.ProductService;

@Controller
public class HeaderController {
	
	@Autowired
	ProductService service;
	
	private static final Logger logger = LoggerFactory.getLogger(HeaderController.class);
	
	@RequestMapping("/common/menuList.do")
	@ResponseBody
	public List<Map<String, String>> getMenuList()
	{	
		List<Map<String, String>> list = service.getMenuList();
		logger.debug("가져온거?"+list);
		return list;
	}
	/*
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
	
	@RequestMapping("/product/productTest.do")
	public String productTest()
	{
		return "/product/productView";
	}*/

}
