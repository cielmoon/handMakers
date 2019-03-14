package kh.hand.makers.order.model.dao;

import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;

public interface OrderDao {

	int insertDeliveryEnroll(Delivery del);
	int insertOrderEnroll(Order order);
}
