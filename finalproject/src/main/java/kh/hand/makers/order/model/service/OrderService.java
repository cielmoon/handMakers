package kh.hand.makers.order.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.vo.DefaultProduct;

public interface OrderService {
	
	int insertOrderEnroll(Order order);
	List<Map<String,String>> selectDeliveryList(String memberNo);
	Delivery selectDelivery(Delivery delivery);
	int updateProductSell(Map<String,Object> insertMap);
	Map<String,String> selectProductOption(String productOptionNo);
	Map<String,String> selectCategoryMap(String productNo);
	int updateOrderState(Map<String,String> map); 
	int updateOrder(Map<String,Object> map);
	int updateResetOrder(Map<String,String> map);
	int updateResetProduct(Map<String,Object> map);
	int deleteOrder(String orderNo);

	
	
	int orderInsert(Order order);
	int updateProductQty(Map<String,Object> updateProduct);
	int salesInsert(DefaultProduct ds);
	int updateProductCS(String productNo);
	

}
