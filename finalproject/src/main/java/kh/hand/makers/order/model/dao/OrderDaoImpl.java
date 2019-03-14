package kh.hand.makers.order.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;

@Repository
public class OrderDaoImpl implements OrderDao {
	
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public int insertDeliveryEnroll(Delivery del) {
	
		return session.insert("order.insertDelivery",del);
	}

	//주문테이블 인서트
	@Override
	public int insertOrderEnroll(Order order) {
		
		return session.insert("order.insertOrder", order);
	}

}
