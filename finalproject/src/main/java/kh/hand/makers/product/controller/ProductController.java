package kh.hand.makers.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kh.hand.makers.product.model.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	ProductService service;
	
	//상품 상세화면 보여주는 서블릿
	@RequestMapping("/product/productView.do")
	public String productView() {
		
		return "/product/productView";
	}

}
