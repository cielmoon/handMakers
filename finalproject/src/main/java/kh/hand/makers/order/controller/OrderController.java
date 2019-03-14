package kh.hand.makers.order.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.order.model.service.OrderService;
import kh.hand.makers.order.model.service.OrderServiceImpl;

@Controller
public class OrderController {
	
	private Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	OrderService service = new OrderServiceImpl();
	
	@RequestMapping("/order/orderEnroll.do")
	public ModelAndView orderEnroll(@RequestParam Map<String,Object> map) {
		
		ModelAndView mv = new ModelAndView();
		
		System.out.println(map);
		
		mv.setViewName("order/orderEnroll");
		
		return mv;
	}
	
	@RequestMapping("/order/orderEnrollEnd.do")
	public String orderEnrollEnd(@RequestParam Map<String,Object> map) {
		
		ModelAndView mv = new ModelAndView();
		
		int result = service.insertOrderEnroll(map);
		
		return "redirect:/";
	}

}
