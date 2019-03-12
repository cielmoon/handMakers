package kh.hand.makers.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OrderController {
	
	@RequestMapping("/order/orderEnroll.do")
	public String orderEnroll() {
		return "/order/orderEnroll";
	}

}
