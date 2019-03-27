package kh.hand.makers.order.controller;

import java.util.HashMap;
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
import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.service.ProductService;
import kh.hand.makers.shop.model.service.ShopService;
import kh.hand.makers.shop.model.vo.SmallCategory;

@Controller
public class OrderController {
	
	private Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	OrderService service = new OrderServiceImpl();
	@Autowired
	ProductService productService;
	@Autowired
	ShopService shopService;
	
	@RequestMapping("/order/orderEnroll.do")
	public ModelAndView orderEnroll(@RequestParam Map<String,Object> map, HttpSession session) {
		
		String memberNo = ((Member)session.getAttribute("member")).getMemberNo();
		
		ModelAndView mv = new ModelAndView();
		
		logger.debug(map+"");
		
		//장바구니 비슷한 구매전에 업데이트 우선 함!!! 나중에 결제 안되면 롤백!!!
		int updateOrder = service.updateOrder(map);
		
		logger.debug(updateOrder+"");
		
		String productOptionNo = (String)map.get("productOption"); 
				
		Map<String,String> productOption = service.selectProductOption(productOptionNo);
		
		String productNo = (String)map.get("productNo");
		
		Map<String,String> product = productService.selectProduct(productNo);
		
		Map<String,String> categoryMap = service.selectCategoryMap(productNo); 
		
		String bcTitle = productService.selectBcTitle(categoryMap.get("BC_NO"));
		
		List<SmallCategory> scList = shopService.selectScList(categoryMap.get("BC_NO"));
		
		logger.debug(productOption+"");
		
		List<Map<String,String>> deliveryList = service.selectDeliveryList(memberNo);
		
		mv.addObject("product",product);
		mv.addObject("bcTitle",bcTitle);
		mv.addObject("scList",scList);
		mv.addObject("deliveryList", deliveryList);
		mv.addObject("orderList", map);
		mv.addObject("productOption",productOption);
		mv.setViewName("order/orderEnroll");
		
		return mv;
	}
	
	@RequestMapping("/order/orderEnrollEnd.do")
	public ModelAndView orderEnrollEnd(@RequestParam Map<String,Object> map) {
		
		ModelAndView mv = new ModelAndView();
		
		String memberNo = (String)map.get("member_no"); // 회원 번호
		String productNo = (String)map.get("product_no"); // 상품 번호
		String imp_uid = (String)map.get("imp_uid"); // 아임포트 고유 번호
		String merchant_uid = (String)map.get("merchant_uid"); // 아임포트 주문번호
		int orderTotalPrice = Integer.parseInt((String)map.get("order_total_price")); // 결제 총 금액
		String orderPayType = (String)map.get("order_payType"); // 상품 결제 타입	
		int productOptionQty = Integer.parseInt((String)map.get("productOptionQty")); // 상품 수량
		String productOption = (String)map.get("productOption"); // 상품 옵션
		String orderPayStatus = (String)map.get("order_payStatus");
		String postCode = (String)map.get("postCode"); // 우편번호
		String deliveryAddr = (String)map.get("addr"); // 주소
		String deliveryDetailAddr = (String)map.get("detailAddr"); // 상세주소
		
		logger.debug(orderPayStatus);
		logger.debug(memberNo);
		logger.debug(productNo);
		logger.debug(imp_uid);
		logger.debug(merchant_uid);
		logger.debug(orderTotalPrice+"");
		logger.debug(orderPayType);
		logger.debug(productOptionQty+"");
		logger.debug(productOption);
		logger.debug(postCode);
		logger.debug(deliveryAddr);
		logger.debug(deliveryDetailAddr);
		
		Order order = new Order();
		
		order.setOrderTotalPrice(orderTotalPrice);
		order.setOrderPayType(orderPayType);
		order.setOrderPayStatus(orderPayStatus);
		order.setProductNo(productNo);
		order.setMemberNo(memberNo);
		order.setImp_uid(imp_uid);
		order.setMerchant_uid(merchant_uid);
		order.setProductOption(productOption);
		order.setProductOptionQty(productOptionQty);
		
		order.setDeliveryPostCode(postCode);
		order.setDeliveryAddr(deliveryAddr);
		order.setDeliveryDetailAddr(deliveryDetailAddr);
		
		int result = service.insertOrderEnroll(order);
		
		Map<String,Object> insertMap = new HashMap();
		
		insertMap.put("productNo", productNo);
		insertMap.put("productOptionQty", productOptionQty);
		
		String msg="";
		String loc ="";
		
		if(result>0) {
			result = service.updateProductSell(insertMap);
			if(result>0) {
				msg = "결재 완료되었습니다 이용해주셔서 감사합니다.";
				loc = "/";
			}else {
				msg = "결재 실패하였습니다.";
				loc = "/order/orderEnroll.do";
			}
			
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
	
	@RequestMapping("/order/updateResetOrder.do")
	public ModelAndView updateResetOrder(@RequestParam Map<String,String> map) {
		
		ModelAndView mv = new ModelAndView();
		
		logger.debug(map+"");
		
		int result = service.updateResetOrder(map);
		
		String msg = "결제 실패 하셨습니다.";
		String loc = "/product/productView.do?productNo="+map.get("productNo");
		
		mv.addObject("loc",loc);
		mv.addObject("msg",msg);
		mv.setViewName("/common/msg");
		
		return mv;
	}

}
