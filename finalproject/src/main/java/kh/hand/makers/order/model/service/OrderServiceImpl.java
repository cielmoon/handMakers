package kh.hand.makers.order.model.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.hand.makers.common.exception.OrderException;
import kh.hand.makers.order.model.dao.OrderDao;
import kh.hand.makers.order.model.dao.OrderDaoImpl;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;

@Service
public class OrderServiceImpl implements OrderService {

	private Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);
	
	@Autowired
	OrderDao dao = new OrderDaoImpl();
	
	@Transactional
	@Override
	public int insertOrderEnroll(Map<String, Object> map) {
		
		int result = 0;
		
		try {
					
			String memberNo = (String)map.get("member_no"); // 회원 번호
			String productNo = (String)map.get("product_no"); // 상품 번호
			String imp_uid = (String)map.get("imp_uid"); // 아임포트 고유 번호
			String merchant_uid = (String)map.get("merchant_uid"); // 아임포트 주문번호
			int orderTotalPrice = Integer.parseInt((String)map.get("order_total_price")); // 결제 총 금액
			String orderPayType = (String)map.get("order_payType"); // 상품 결제 타입	
			int productOptionQty = Integer.parseInt((String)map.get("productOptionQty")); // 상품 수량
			String productOptionSubject = (String)map.get("productOptionSubject"); // 상품 옵션
			
			String postCode = (String)map.get("postCode"); // 우편번호
			String deliveryAddr = (String)map.get("addr"); // 주소
			String deliveryDetailAddr = (String)map.get("detailAddr"); // 상세주소
			
			logger.debug(memberNo);
			logger.debug(productNo);
			logger.debug(imp_uid);
			logger.debug(merchant_uid);
			logger.debug(orderTotalPrice+"");
			logger.debug(orderPayType);
			logger.debug(productOptionQty+"");
			logger.debug(productOptionSubject);
			logger.debug(postCode);
			logger.debug(deliveryAddr);
			logger.debug(deliveryDetailAddr);
			
			Delivery del = new Delivery();
			
			del.setDeliveryPostCode(postCode);
			del.setDeliveryAddr(deliveryAddr);
			del.setDeliveryDetailAddr(deliveryDetailAddr);
			del.setMemberNo(memberNo);
			
			result = dao.insertDeliveryEnroll(del);
			
			logger.debug(del.getDeliveryNo());
			logger.debug("-------------------------");
			Order order = new Order();
			
			//배송지 번호 FK 이기 떄문에 가져 와서 넣어줌
			order.setDeliveryNo(del.getDeliveryNo());
			
			logger.debug(del.getDeliveryNo());
			logger.debug(order.getDeliveryNo());
			
			order.setOrderTotalPrice(orderTotalPrice);
			order.setOrderPayType(orderPayType);
			order.setProductNo(productNo);
			order.setMemberNo(memberNo);
			order.setImp_uid(imp_uid);
			order.setMerchant_uid(merchant_uid);
			order.setProductOptionSubject(productOptionSubject);
			order.setProductOptionQty(productOptionQty);
			
			if(result==0) {
				
				throw new OrderException("Delivery 주소 저장 실패");
			}	
			else {
				result = dao.insertOrderEnroll(order);
				
				if(result==0) throw new OrderException("주문테이블 저장 실패");
			}
		}
		catch(Exception e) {
			throw e;
		}
		
		return result;
	}

}
