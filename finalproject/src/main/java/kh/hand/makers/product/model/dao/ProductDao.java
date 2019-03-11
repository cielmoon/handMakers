package kh.hand.makers.product.model.dao;

import java.util.List;
import java.util.Map;

public interface ProductDao {
	
	List<Map<String, Object>> selectCategoryTemp(String category);

}
