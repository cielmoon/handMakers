package kh.hand.makers.product.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.product.model.vo.ProductImg;
import kh.hand.makers.product.model.vo.Wish;

public interface ProductDao {
	
	List<Map<String, Object>> selectCategoryTemp(String category);
	//List<Map<String, String>> productList(String category);
	List<Map<String, String>> productList(String category, int cPage, int numPerPage);
	List<Map<String, String>> productList(Map<String, String> map, int cPage, int numPerPage);
	int selectProductCount(String category);
	int selectProductCount(Map<String, String> map);
	Map<String,String> selectProduct(String productNo);
	List<Map<String,String>> selectCategory(String productNo);
	int selectWishCount(Wish wish);
	int insertWish(Wish wish);
	String selectBcTitle(String bcNo);
	List<ProductImg> selectProductImg(String productNo);
	Map<String,String> selectProductDetail(String productNo);
	int deleteWish(Wish wish);
	int selectCommentCount(String commentType);
	List<Map<String,String>> selectComment(Map<String,String> map, int cPage, int numPerPage);
	List<Map<String,String>> selectProductOption(String productNo);
	List<Map<String, String>> getMenuList();
	List<Map<String, String>> sCategoryList(String bCategory);
	List<Map<String,String>> selectOrderList(Map<String,String> map);
	Map<String,String> selectBrand(String productNo);
}
