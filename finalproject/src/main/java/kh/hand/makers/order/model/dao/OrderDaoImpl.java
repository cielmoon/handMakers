package kh.hand.makers.order.model.dao;

import java.util.List;
import java.util.Map;

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
		System.out.println("---------------------------------");
		System.out.println(order);
		return session.insert("order.insertOrder", order);
	}

	@Override
	public List<Map<String, String>> selectDeliveryList(String memberNo) {
		
		return session.selectList("order.selectDeliveryList",memberNo);
	}

	@Override
	public Delivery selectDelivery(Delivery delivery) {
		
		return session.selectOne("order.selectDelivery", delivery);
	}

	@Override
	public int updateProductSell(Map<String,Object> insertMap) {
		
		return session.update("order.updateProductSell",insertMap);
	}

	@Override
	public Map<String, String> selectProductOption(String productOptionNo) {
		
		return session.selectOne("order.selectProductOption",productOptionNo);
	}

	@Override
	public Map<String, String> selectCategoryMap(String productNo) {
		
		return session.selectOne("order.selectCategoryMap",productNo);
	}
	
	

}
