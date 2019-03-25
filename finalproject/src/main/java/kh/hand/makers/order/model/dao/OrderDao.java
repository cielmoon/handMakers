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
	Map<String,String> selectProductCheck(Order order);
	int insertProductSalesRecord(String productNo);
	int updateProductState(String productNo);
}
