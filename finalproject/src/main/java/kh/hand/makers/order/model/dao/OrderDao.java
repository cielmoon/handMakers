package kh.hand.makers.order.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;

public interface OrderDao {
	
	int insertDeliveryEnroll(Delivery del);
	int insertOrderEnroll(Order order);
	List<Map<String,String>> selectDeliveryList(String memberNo);
	Delivery selectDelivery(Delivery delivery);
}
