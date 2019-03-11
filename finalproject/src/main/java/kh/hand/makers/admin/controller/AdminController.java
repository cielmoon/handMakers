package kh.hand.makers.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	@RequestMapping("/admin/adminPage.do")
	public String adminMyPage()
	{
		return "admin/adminPage";
	}
	
	@RequestMapping("/admin/manageProduct.do")
	public String manageProduct()
	{
		return "admin/manageProduct";
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
