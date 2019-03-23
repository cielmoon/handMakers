package kh.hand.makers.product.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.product.model.vo.Product2;
import kh.hand.makers.product.model.vo.ProductImg;
import kh.hand.makers.product.model.vo.Wish;

@Repository
public class ProductDaoImpl implements ProductDao {
	
	@Autowired
	SqlSession session;
	
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
	public int selectCommentCount(String commentType) {
		
		return session.selectOne("product.selectCommentCount",commentType);
	}

	@Override
	public List<Map<String, String>> selectComment(Map<String, String> map, int cPage, int numPerPage) {
		
		RowBounds rb = new RowBounds((cPage-1)*numPerPage, numPerPage);
		
		
		System.out.println("=============================================");
		
		System.out.println("이거 보자~~");
		System.out.println(map);
		
		return session.selectList("product.selectComment", map, rb);
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


	

}
