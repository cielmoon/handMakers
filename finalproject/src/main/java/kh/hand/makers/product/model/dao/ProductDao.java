package kh.hand.makers.product.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.product.model.vo.Wish;

public interface ProductDao {
	
	List<Map<String, Object>> selectCategoryTemp(String category);
	//List<Map<String, String>> productList(String category);
	List<Map<String, String>> productList(String category, int cPage, int numPerPage);
	int selectProductCount();
	Map<String,String> selectProduct(String productNo);
	List<Map<String,String>> selectCategory(String productNo);
	Wish selectWish(Wish wish);
	int insertWish(Wish wish);
	String selectBcTitle(String bcNo);
}
