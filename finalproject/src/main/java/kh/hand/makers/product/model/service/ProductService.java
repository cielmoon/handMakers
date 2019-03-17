package kh.hand.makers.product.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.product.model.vo.ProductImg;
import kh.hand.makers.product.model.vo.Wish;

public interface ProductService {
	
	List<Map<String, Object>> selectCategoryTemp(String category);
	//List<Map<String, String>> productList(String category);
	List<Map<String, String>> productList(String category, int cPage, int numPerPage);
	int selectProductCount(String category);
	Map<String,String> selectProduct(String productNo);
	List<Map<String,String>> selectCategory(String productNo);
	String selectBcTitle(String bcNo);
	List<ProductImg> selectProductImg(String productNo);
	Map<String,String> selectProductDetail(String productNo);
	int selectWishCount(Wish wish);
	int insertWish(Wish wish);
	int deleteWish(Wish wish);
	int selectCommentCount(String commentType);
	List<Map<String,String>> selectComment(Map<String,String> map, int cPage, int numPerPage);
}
