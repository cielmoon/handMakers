package kh.hand.makers.order.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.vo.DefaultProduct;

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

	@Override
	public int updateOrderState(Map<String, String> map) {
		
		return session.update("order.updateOrderState",map);
	}

	@Override
	public int updateOrderStateSecond(Map<String, Object> psMap) {
		// TODO Auto-generated method stub
		return session.update("order.updateOrderStateSecond",psMap);
	}

	@Override
	public int selectProductCheck(Order order) {
		
		return session.selectOne("product.selectProductCheck",order);
	}

	@Override
	public int insertProductSalesRecord(Order order) {
		
		return session.insert("product.insertProductSalesRecord",order);
	}

	@Override
	public int updateProductState(String productNo) {
		
		return session.update("product.updateProductState",productNo);
	}

	@Override
	public int updateOrder(Map<String, Object> map) {
		
		return session.update("product.updateOrder",map);
	}

	@Override
	public int updateResetOrder(Map<String, String> map) {
		
		return session.update("product.updateResetOrder",map);
	}

	@Override
	public int updateResetProduct(Map<String, Object> map) {
		
		return session.update("product.updateResetProduct",map);
	}

	@Override
	public int deleteOrder(String orderNo) {
		
		return session.delete("order.deleteOrder",orderNo);
	}

	@Override
	public int orderInsert(Order order) {
		// TODO Auto-generated method stub
		return session.insert("order.orderInsert",order);
	}

	@Override
	public int updateProductQty(Map<String, Object> updateProduct) {
		// TODO Auto-generated method stub
		return session.update("order.updateProductQty",updateProduct);
	}

	@Override
	public int salesInsert(DefaultProduct ds) {
		// TODO Auto-generated method stub
		return session.insert("order.salesInsert",ds);
	}

	@Override
	public int updateProductCS(String productNo) {
		// TODO Auto-generated method stub
		return session.update("order.updateProductCS",productNo);

	}

	@Override
	public int salesInsertFirst(DefaultProduct ds) {
		// TODO Auto-generated method stub
		return session.insert("order.salesInsertFirst",ds);
	}

	@Override
	public int updatePStateEnd(String productNo) {
		// TODO Auto-generated method stub
		return session.update("order.updatePStateEnd",productNo);
	}

	@Override
	public int orderInsertSecond(Order order) {
		// TODO Auto-generated method stub
		return session.insert("order.orderInsertSecond",order);
	}

	@Override
	public int updateProductCSS(String productNo) {
		// TODO Auto-generated method stub
		return session.update("order.updateProductCSS",productNo);
	}
	
	

}
