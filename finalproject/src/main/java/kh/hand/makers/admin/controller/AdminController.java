package kh.hand.makers.admin.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.admin.model.service.AdminService;
import kh.hand.makers.common.PageFactory;
import kh.hand.makers.shop.model.vo.Brand;

@Controller
public class AdminController {
	private Logger logger=LoggerFactory.getLogger(AdminController.class);
	@Autowired
	AdminService service;
	
	@RequestMapping("/admin/adminPage.do")
	public String adminMyPage()
	{
		return "admin/adminPage";
	}
	
	@RequestMapping("/admin/manageBrand.do")
/*	public String manageProduct() {
		return "admin/manageProduct";
	}*/
	public ModelAndView manageBrand(
			@RequestParam(value="cPage", 
			required=false, defaultValue="0") int cPage
			)
	{
		int numPerPage=5;
		ModelAndView mv=new ModelAndView();
		int contentCount=service.selectBrandCount();
		List<Brand> brandList=service.selectBrandList(cPage,numPerPage);
		mv.addObject("pageBar",PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageBrand"));
		mv.addObject("brandList",brandList);
		mv.setViewName("admin/manageBrand");
		return mv;
	}	
	
	@RequestMapping("/admin/manageProduct.do")
/*	public String manageProduct() {
		return "admin/manageProduct";
	}*/
	public ModelAndView manageProduct(
			@RequestParam(value="cPage", 
			required=false, defaultValue="0") int cPage
			)
	{
		int numPerPage=5;
		ModelAndView mv=new ModelAndView();
		int contentCount=service.selectProductCount();
		List<Map<String,String>> productList=service.selectProductList(cPage,numPerPage);
		mv.addObject("pageBar",PageFactory.getPageBar(contentCount, cPage, numPerPage, "/makers/admin/manageProduct"));
		mv.addObject("productList",productList);
		mv.setViewName("admin/manageProduct");
		return mv;
	}
	
	@RequestMapping("/admin/enrollProduct.do")
	public String enrollProduct()
	{
		return "admin/enrollProduct";
	}
	
	@RequestMapping("/admin/enrollProductEnd.do")
	public String enrollProductEnd()
	{
		return "admin/enrollProductEnd";
	}
	
	
	
	
}
