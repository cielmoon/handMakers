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
	int updateProductSell(Map<String,Object> insertMap);
	Map<String,String> selectProductOption(String productOptionNo);
	Map<String,String> selectCategoryMap(String productNo);
	int updateOrderState(Map<String,String> map);
	int selectProductCheck(Order order);
	int insertProductSalesRecord(Order order);
	int updateProductState(String productNo);
	int updateOrder(Map<String,Object> map);
	int updateResetOrder(Map<String,String> map);
	int updateResetProduct(Map<String,Object> map);
	int deleteOrder(String orderNo);
	int updateProductStateYewon(Order order);
}
