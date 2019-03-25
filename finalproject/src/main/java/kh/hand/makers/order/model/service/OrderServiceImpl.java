package kh.hand.makers.order.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	public int insertOrderEnroll(Order order) {
		int result = dao.insertOrderEnroll(order);
		
		Map<String,String> map = new HashMap();
		
		if(result>0) {
			map = dao.selectProductCheck(order);
			if(map != null) {
				result = 0;
				result = dao.insertProductSalesRecord(order.getProductNo());
				if(result>0) {
					result = 0;
					result = dao.updateProductState(order.getProductNo());
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
	
	

}
