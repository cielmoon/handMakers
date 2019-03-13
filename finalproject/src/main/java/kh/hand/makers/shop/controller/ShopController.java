package kh.hand.makers.shop.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.service.ShopService;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

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
		List<Brand> list = service.selectBrandList(memberNo);
		mv.addObject("list", list);
		mv.setViewName("shop/shopEnroll");
		return mv;
	}
	
	// 브랜드 등록 페이지
	@RequestMapping("/shop/brandEnroll.do")
	public ModelAndView brandEnroll(String brandNo)
	{
		ModelAndView mv = new ModelAndView();

		if(brandNo != null) //반려된 브랜드 재등록 요청일 경우
		{
			Brand brand = service.selectBrand(brandNo);
			mv.addObject("brand", brand);
		}
		
		mv.setViewName("shop/brandEnroll");
		return mv;
	}
	
	@RequestMapping("/shop/brandEnrollEnd.do")
	public ModelAndView brandEnrollEnd(String memberNo, Brand b)
	{
		String brandNo = b.getBrandNo();
		
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		map.put("brandTitle", b.getBrandTitle());
		map.put("brandLicense", b.getBrandLicense());
		map.put("brandType", b.getBrandType());
		map.put("brandAddr", b.getBrandAddr());
		map.put("brandDetailAddr", b.getBrandDetailAddr());
		map.put("memberNo", memberNo);

		int result = -1;
		String msg="";
		String loc="/shop/shopEnroll.do";
		
		if(brandNo.trim().isEmpty()) // 신규 브랜드 등록
		{
			result = service.insertBrand(map);
			if(result>0)
			{
				msg="브랜드 등록이 정상적으로 접수되었습니다.";
			}
			else {
				msg="브랜드 등록 접수에 실패하였습니다.";
			}
		}else { // 반려된 브랜드 재등록 요청
			map.put("brandNo", brandNo);
			result = service.updateBrand(map);
			if(result>0)
			{
				msg="브랜드 재등록 요청이 정상적으로 접수되었습니다.";
			}
			else {
				msg="브랜드 재등록 요청에 실패하였습니다.";
			}
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}

	// 상품 제안 페이지
	@RequestMapping("/shop/productEnroll.do")
	public ModelAndView productEnroll(String brandNo)
	{
		ModelAndView mv = new ModelAndView();
		Brand brand = service.selectBrand(brandNo);	
		List<BigCategory> bcList = service.selectBcList();
		List<SmallCategory> scList = service.selectScList("B_C_NO_1");
		mv.addObject("brand", brand);
		mv.addObject("bcList", bcList);
		mv.addObject("scList", scList);
		mv.setViewName("shop/productEnroll");
		return mv;
	}
	
	@RequestMapping("/shop/productEnrollEnd.do")
	public ModelAndView productEnrollEnd(PreProduct p)
	{
		ModelAndView mv = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		map.put("preProductTitle", p.getPreProductTitle());
		map.put("preProductDiscript", p.getPreProductDiscript());
		map.put("brandNo", p.getBrandNo());
		map.put("bcNo", p.getBcNo());
		map.put("scNo", p.getScNo());

		int result = service.insertPreProduct(map);
		
		String msg="";
		String loc="/shop/shopEnroll.do";
		if(result>0)
		{
			msg="상품 제안이 정상적으로 접수되었습니다.";
		}
		else {
			msg="상품 제안 접수에 실패하였습니다.";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
		
	}
	
	@RequestMapping("/shop/productEnrollScSet.do")
	public ModelAndView productEnrollScSet(String bcNo)
	{
		ModelAndView mv = new ModelAndView();

		List<SmallCategory> scList = service.selectScList(bcNo);
		mv.addObject("scList", scList);
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping("/shop/brandHome.do")
	public ModelAndView brandHome(String brandNo)
	{
		ModelAndView mv = new ModelAndView();

		Brand brand = service.selectBrand(brandNo);	
		mv.addObject("brand", brand);
		mv.setViewName("shop/brandHome");
		return mv;
	}
}
