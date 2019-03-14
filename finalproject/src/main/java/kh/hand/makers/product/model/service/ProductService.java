package kh.hand.makers.product.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.product.model.vo.Product;

public interface ProductService {
	
	List<Map<String, Object>> selectCategoryTemp(String category);
	//List<Map<String, String>> productList(String category);
	List<Map<String, String>> productList(String category, int cPage, int numPerPage);
	int selectProductCount();
	Map<String,String> selectProduct(String productNo);

}
