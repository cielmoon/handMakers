package kh.hand.makers.product.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.product.model.vo.DefaultProduct;
import kh.hand.makers.product.model.vo.ProductImg;
import kh.hand.makers.product.model.vo.Wish;

public interface ProductService {
	
	List<Map<String, Object>> selectCategoryTemp(String category);
	//List<Map<String, String>> productList(String category);
	List<Map<String, String>> productList(String category, int cPage, int numPerPage);
	List<Map<String, String>> productList(Map<String, String> map, int cPage, int numPerPage);
	int selectProductCount(String category);
	int selectProductCount(Map<String, String> map);
	Map<String,String> selectProduct(String productNo);
	List<Map<String,String>> selectCategory(String productNo);
	String selectBcTitle(String bcNo);
	List<ProductImg> selectProductImg(String productNo);
	Map<String,String> selectProductDetail(String productNo);
	int selectWishCount(Wish wish);
	int insertWish(Wish wish);
	int deleteWish(Wish wish);
	int selectCommentCount(Map<String,String> mapComment);
	List<Map<String,String>> selectComment(Map<String,String> map, int cPage, int numPerPage);
	List<Map<String,String>> selectProductOption(String productNo);
	List<Map<String, String>> getMenuList();
	List<Map<String, String>> sCategoryList(String bCategory);
	List<Map<String,String>> selectOrderList(Map<String,String> map);
	Map<String,String> selectBrand(String productNo);
	int insertCommentReview(Map<String,String> map);
	int insertTotalScoreReview(Map<String,String> map);
	List<Map<String, String>> selectReviewCommentSeconds();
	int selectWishYewon(Map<String, String> map);
	int insertCommentQuestion(Map<String,String> map);
	int updateComment(Map<String,String> map);
	int insertCommentLevel2(Map<String,String> map);
	int deleteComment(Map<String,String> map);
	Map<String,String> selectTotalScore(String productNo);
	int updateProductMinus(Map<String,Object> productMap);
	Map<String,String> selectProductCheck(Map<String,String> map);
	
	DefaultProduct selectDefaltProduct(String productNo);

	int updatePMinus(Map<String,Object> productMap);

}
