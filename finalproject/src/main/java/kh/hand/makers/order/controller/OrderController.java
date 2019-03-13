package kh.hand.makers.order.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OrderController {
	
	private Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@RequestMapping("/order/orderEnroll.do")
	public String orderEnroll() {
		return "/order/orderEnroll";
	}
	
	@RequestMapping("/order/orderEnrollEnd.do")
	public ModelAndView orderEnrollEnd(@RequestParam Map<String,Object> map) {
		
		ModelAndView mv = new ModelAndView();
		
		String memberNo = (String)map.get("member_no"); // 회원 번호
		String productNo = (String)map.get("product_no"); // 상품 번호
		String imp_uid = (String)map.get("imp_uid"); // 아임포트 고유 번호
		String merchant_uid = (String)map.get("merchant_uid"); // 아임포트 주문번호
		int orderTotalPrice = (int)map.get("order_total_price"); // 결제 총 금액
		String orderPayType = (String)map.get("order_payType"); // 상품 결제 타입
		String postCode = (String)map.get("postCode"); // 우편번호
		String deliveryAddr = (String)map.get("addr"); // 주소
		String deliveryDetailAddr = (String)map.get("detailAddr"); // 상세주소
		
		logger.debug(memberNo);
		logger.debug(productNo);
		logger.debug(imp_uid);
		logger.debug(merchant_uid);
		logger.debug(orderTotalPrice+"");
		logger.debug(orderPayType);
		logger.debug(postCode);
		logger.debug(deliveryAddr);
		logger.debug(deliveryDetailAddr);
		
		return mv;
	}

}
