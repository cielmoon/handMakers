package kh.hand.makers.order.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.service.OrderService;
import kh.hand.makers.order.model.service.OrderServiceImpl;
import kh.hand.makers.order.model.vo.Delivery;

@Controller
public class OrderController {
	
	private Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	OrderService service = new OrderServiceImpl();
	
	@RequestMapping("/order/orderEnroll.do")
	public ModelAndView orderEnroll(@RequestParam Map<String,Object> map, HttpSession session) {
		
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		
		ModelAndView mv = new ModelAndView();
		
		logger.debug(map+"");
		
		List<Map<String,String>> deliveryList = service.selectDeliveryList(memberNo);
		
		mv.addObject("deliveryList", deliveryList);
		mv.addObject("orderList", map);
		mv.setViewName("order/orderEnroll");
		
		return mv;
	}
	
	@RequestMapping("/order/orderEnrollEnd.do")
	public ModelAndView orderEnrollEnd(@RequestParam Map<String,Object> map) {
		
		ModelAndView mv = new ModelAndView();
		
		String msg="";
		String loc ="";
		
		int result = service.insertOrderEnroll(map);
		
		if(result>0) {
			msg = "결재 완료되었습니다 이용해주셔서 감사합니다.";
			loc = "/";
		}else {
			msg = "결재 실패하였습니다.";
			loc = "/order/orderEnroll.do";
		}
		
		mv.addObject("loc",loc);
		mv.addObject("msg",msg);
		mv.setViewName("/common/msg");
		
		return mv;
	}
	
	@RequestMapping("/delivery/selectDelivery.do")
	public ModelAndView selectDelivery(String deliveryNo, HttpSession session){
		
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		
		ModelAndView mv = new ModelAndView();
		
		System.out.println(deliveryNo);
		
		Delivery delivery = new Delivery();
		
		delivery.setDeliveryNo(deliveryNo);
		delivery.setMemberNo(memberNo);
		
		delivery = service.selectDelivery(delivery);
		
		logger.debug(delivery+"");
		
		mv.addObject("delivery", delivery);
		mv.setViewName("jsonView");
		
		return mv;
	}

}
