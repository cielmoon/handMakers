package kh.hand.makers.order.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.order.model.vo.Delivery;

public interface OrderService {
	
	int insertOrderEnroll(Map<String,Object> map);
	List<Map<String,String>> selectDeliveryList(String memberNo);
	Delivery selectDelivery(Delivery delivery);
}
