package kh.hand.makers.shop.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ShopController {
	private Logger logger=LoggerFactory.getLogger(ShopController.class);
	
	
	@RequestMapping("/shop/shopCart.do")
	public String shopCart()
	{
		return "shop/shopCart";
	}
	
	// 입점 신청 페이지
	@RequestMapping("/shop/shopEnroll.do")
	public String shopEnroll()
	{
		return "shop/shopEnroll";
	}
	
	// 브랜드 등록 페이지
	@RequestMapping("/shop/brandEnroll.do")
	public String brandEnroll()
	{
		return "shop/brandEnroll";
	}

	// 상품 제안 페이지
	@RequestMapping("/shop/productEnroll.do")
	public String productEnroll()
	{
		return "shop/productEnroll";
	}
	
	
}
