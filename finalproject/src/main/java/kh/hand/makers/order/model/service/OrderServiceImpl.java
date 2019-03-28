package kh.hand.makers.order.model.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kh.hand.makers.order.model.dao.OrderDao;
import kh.hand.makers.order.model.dao.OrderDaoImpl;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.dao.ProductDao;
import kh.hand.makers.product.model.dao.ProductDaoImpl;
import kh.hand.makers.product.model.vo.DefaultProduct;

@Service
public class OrderServiceImpl implements OrderService {

	private Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);
	
	@Autowired
	OrderDao dao = new OrderDaoImpl();
	@Autowired
	ProductDao productDao = new ProductDaoImpl();
	
	@Override
	@Transactional
	public int insertOrderEnroll(Order order) {
		int result = dao.insertOrderEnroll(order);
		
		Map<String,String> map = new HashMap();
		
		if(result>0) {
			int r = dao.selectProductCheck(order);
			if(r > 0) {
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

	@Override
	public int updateOrder(Map<String, Object> map) {
		
		return dao.updateOrder(map);
	}

	@Override
	public int updateResetOrder(Map<String, String> map) {
		
		return dao.updateResetOrder(map);
	}

	@Override
	public int updateResetProduct(Map<String, Object> map) {
		
		return dao.updateResetProduct(map);
	}

	@Override
	public int deleteOrder(String orderNo) {
		
		return dao.deleteOrder(orderNo);
	}

	@Override
	public int orderInsert(Order order) {
		// TODO Auto-generated method stub
		return dao.orderInsert(order);
	}

	@Override
	public int updateProductQty(Map<String, Object> updateProduct) {
		// TODO Auto-generated method stub
		return dao.updateProductQty(updateProduct);
	}

	@Override
	public int salesInsert(DefaultProduct ds) {
		// TODO Auto-generated method stub
		return dao.salesInsert(ds);
	}

	@Override
	public int updateProductCS(String productNo) {
		// TODO Auto-generated method stub
		return dao.updateProductCS(productNo);
	}
	
	
	

}
