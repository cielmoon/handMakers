package kh.hand.makers.order.model.service;

import java.util.List;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	@Override
	public int insertOrderEnroll(Order order) {
		
		return dao.insertOrderEnroll(order);
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
	
	

}
