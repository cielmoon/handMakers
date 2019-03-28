package kh.hand.makers.order.model.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kh.hand.makers.order.model.dao.OrderDao;
import kh.hand.makers.order.model.dao.OrderDaoImpl;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.dao.ProductDao;
import kh.hand.makers.product.model.dao.ProductDaoImpl;

@Service
public class OrderServiceImpl implements OrderService {

	private Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);
	
	@Autowired
	OrderDao dao = new OrderDaoImpl();
	@Autowired
	ProductDao productDao = new ProductDaoImpl();
	
	@Override
	@Transactional
	public int insertOrderEnroll(Order order) {
		int result = dao.insertOrderEnroll(order);
		
//		Map<String,String> map = new HashMap();
		Map<String,Object> map = new HashMap();
		
		if(result>0) {
			int r = dao.selectProductCheck(order); //갯수 다샀나 체크
			if(r > 0) {
				
				map.put("productNo", order.getProductNo());
				map.put("productOptionQty", order.getProductOptionQty());
				dao.updateProductSell(map);//yewon add.//기록하기전에 프로덕트에 지금 주문업데이트 해야지 이사람아!ㅡ ㅡ
				result = 0;					
				result = dao.insertProductSalesRecord(order.getProductNo());// 아카이브기록 (판매이력)
				if(result>0) {
					result = 0;
					//result = dao.updateProductState(order.getProductNo());//판매종료로 업데이트
					result = dao.updateProductStateYewon(order.getProductNo());
					//+그 후에 프로덕트에 초기화 + 누적++ 작업없음
				}
			}
		}

		return result;
	}

	@Override
	public List<Map<String, String>> selectDeliveryList(String memberNo) {
		
		return dao.selectDeliveryList(memberNo);
	}

	@Override
	public Delivery selectDelivery(Delivery delivery) {
		
		return dao.selectDelivery(delivery);
	}

	@Override
	public int updateProductSell(Map<String,Object> insertMap) {
		
		return dao.updateProductSell(insertMap);
	}

	@Override
	public Map<String, String> selectProductOption(String productOptionNo) {
		
		return dao.selectProductOption(productOptionNo);
	}

	@Override
	public Map<String, String> selectCategoryMap(String productNo) {
		
		return dao.selectCategoryMap(productNo);
	}

	@Override
	public int updateOrderState(Map<String, String> map) {
		
		return dao.updateOrderState(map);
	}

	@Override
	public int updateOrder(Map<String, Object> map) {
		
		return dao.updateOrder(map);
	}

	@Override
	public int updateResetOrder(Map<String, String> map) {
		
		return dao.updateResetOrder(map);
	}

	@Override
	public int updateResetProduct(Map<String, Object> map) {
		
		return dao.updateResetProduct(map);
	}

	@Override
	public int deleteOrder(String orderNo) {
		
		return dao.deleteOrder(orderNo);
	}
	
	
	

}
