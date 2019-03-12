package kh.hand.makers.product.model.service;

import java.util.List;
import java.util.Map;

public interface ProductService {
	
	List<Map<String, Object>> selectCategoryTemp(String category);
	List<Map<String, String>> productList(String category);

}
