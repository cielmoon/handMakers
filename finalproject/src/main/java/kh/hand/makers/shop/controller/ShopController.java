package kh.hand.makers.shop.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.service.ShopService;
import kh.hand.makers.shop.model.vo.Shop;

@Controller
public class ShopController {
	private Logger logger=LoggerFactory.getLogger(ShopController.class);
	
	@Autowired
	ShopService service;
	
	@RequestMapping("/shop/shopCart.do")
	public String shopCart()
	{
		return "shop/shopCart";
	}
	
	// 입점 신청 페이지
	@RequestMapping("/shop/shopEnroll.do")
	public ModelAndView shopEnroll(HttpSession session)
	{	
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		
		ModelAndView mv = new ModelAndView();
		List<Shop> list = service.selectBrandList(memberNo);
		mv.addObject("list", list);
		mv.setViewName("shop/shopEnroll");
		return mv;
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
