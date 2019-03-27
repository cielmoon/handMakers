package kh.hand.makers.product.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kh.hand.makers.product.model.vo.DefaultProduct;
import kh.hand.makers.product.model.vo.Product2;
import kh.hand.makers.product.model.vo.ProductImg;
import kh.hand.makers.product.model.vo.Wish;

@Repository
public class ProductDaoImpl implements ProductDao {
		
	@Autowired
	SqlSession session;
	
	private static final Logger logger = LoggerFactory.getLogger(ProductDaoImpl.class);
	
	@Override
	public int selectWishYewon(Map<String, String> map) {
		// TODO Auto-generated method stub
		logger.debug("들어옴 : selectWishYewon");
		int result;
		if(session.selectOne("product.selectWishYewon", map) != null)
		{
			result = session.delete("product.deleteWishYewon", map);
			logger.debug("있을때 : "+ result);
			return 0;
		}
		else
		{
			result = session.delete("product.insertWishYewon", map);
			logger.debug("없을때 : "+ result);
			return 1;
		}
		/*int result = session.selectOne("product.selectWishYewon", map);
		logger.debug("1차 : "+ result);
		if(result > 0)//있음
		{
			result = session.delete("product.deleteWishYewon", map);
			logger.debug("있을때 : "+ result);
			return 0;
		}
		else
		{
			result = session.delete("product.insertWishYewon", map);
			logger.debug("없을때 : "+ result);
			return 1;
		}*/
	}

	@Override
	public int selectProductCount(String category) {
		// TODO Auto-generated method stub
		return session.selectOne("product.selectProductCount", category);
	}

	@Override
	public List<Map<String, String>> productList(String category, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rb = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return session.selectList("product.selectProductList", category, rb);
	}

	@Override
	public List<Map<String, Object>> selectCategoryTemp(String category) {
		// TODO Auto-generated method stub
		
		List<Map<String, Object>> list = new ArrayList();
		Product2 product = new Product2("01", "testTitle", new Date(), new Date(), new Date(), "detail", "comment", "nomal", "step", 12345, 369, 1212, "bigCategory", "smallCategory", "brandNo", "adminNo", "memberNo", 2, 9, 4.5);
		Map<String, Object> map = new HashMap();
		map.put("product", product);
		System.out.println(map);
		list.add(map);
		
		return list;
	}

	// 3월 14일 상세상품 보여주기 위함
	@Override
	public Map<String,String> selectProduct(String productNo) {
		
		return session.selectOne("product.selectProduct",productNo);
	}

	@Override
	public List<Map<String, String>> selectCategory(String productNo) {
		
		return session.selectList("product.selectCategory", productNo);
	}

	@Override
	public int selectWishCount(Wish wish) {
		
		return session.selectOne("product.selectWish",wish);
	}

	@Override
	public int insertWish(Wish wish) {
		
		return session.insert("product.insertWish",wish);
	}

	@Override
	public String selectBcTitle(String bcNo) {
		
		return session.selectOne("product.selectBcTitle", bcNo);
	}

	@Override
	public List<ProductImg> selectProductImg(String productNo) {
		
		return session.selectList("product.selectProductImg",productNo);
	}

	@Override
	public Map<String, String> selectProductDetail(String productNo) {
		
		return session.selectOne("product.selectProductDetail",productNo);
	}

	@Override
	public int deleteWish(Wish wish) {
		
		return session.delete("product.deleteWish", wish);
	}

	@Override
	public int selectCommentCount(Map<String,String> mapComment) {
		
		return session.selectOne("product.selectCommentCount",mapComment);
	}

	@Override
	public List<Map<String, String>> selectComment(Map<String, String> map, int cPage, int numPerPage) {
		
		RowBounds rb = new RowBounds((cPage-1)*numPerPage, numPerPage);
		
		if(map.get("commentType").equals("R"))
		{
			return session.selectList("product.selectCommentR", map, rb);
		}else 
		{
			return session.selectList("product.selectCommentQ", map, rb);
		}

	
	}

	@Override
	public List<Map<String, String>> selectProductOption(String productNo) {
		
		return session.selectList("product.selectProductOption", productNo);
	}
	
	@Override
	public int selectProductCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return session.selectOne("product.selectProductCount", map);
	}
	
	
	@Override
	public List<Map<String, String>> productList(Map<String, String> map, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rb = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return session.selectList("product.selectProductList", map, rb);
	}

	@Override
	public List<Map<String, String>> getMenuList() {
		// TODO Auto-generated method stub
		return session.selectList("product.selectMenuList");
	}

	@Override
	public List<Map<String, String>> sCategoryList(String bCategory) {
		// TODO Auto-generated method stub
		return session.selectList("product.sCategoryList", bCategory);
	}

	@Override
	public List<Map<String, String>> selectOrderList(Map<String, String> map) {
		
		return session.selectList("product.selectOrderList",map);
	}

	@Override
	public Map<String, String> selectBrand(String productNo) {
		
		return session.selectOne("product.selectBrand",productNo);
	}

	@Override
	public int insertCommentReview(Map<String, String> map) {
		
		return session.insert("product.insertCommentReview",map);
	}

	@Override
	public int insertTotalScoreReview(Map<String, String> map) {
		System.out.println(map);
		return session.insert("product.insertTotalScoreReview",map);
	}

	@Override
	public List<Map<String, String>> selectReviewCommentSeconds() {
		return session.selectList("product.selectReviewCommentSeconds");
	}

	@Override
	public int insertCommentQuestion(Map<String, String> map) {
		logger.debug("문의 등록 전 확인"+map+"");
		return session.insert("product.insertCommentQuestion",map);
	}

	@Override
	public int updateComment(Map<String, String> map) {
		
		return session.update("product.updateComment",map);
	}

	@Override
	public int insertCommentLevel2(Map<String, String> map) {
		
		return session.insert("product.insertCommentLevel2",map);
	}

	@Override
	public int deleteComment(Map<String, String> map) {
		
		return session.delete("product.deleteComment",map);
	}

	@Override
	public Map<String, String> selectTotalScore(String productNo) {
		
		return session.selectOne("product.selectTotalScore",productNo);
	}

	@Override
	public int updateProductMinus(Map<String, Object> productMap) {
		
		return session.update("product.updateProductMinus",productMap);
	}

	@Override
	public Map<String,String> selectProductCheck(Map<String,String> map) {
		
		return session.selectOne("product.selectProductCheck",map);
	}

	@Override
	public DefaultProduct selectDefaltProduct(String productNo) {
		// TODO Auto-generated method stub
		return session.selectOne("product.selectDefaltProduct",productNo);
	}

	

	

}
