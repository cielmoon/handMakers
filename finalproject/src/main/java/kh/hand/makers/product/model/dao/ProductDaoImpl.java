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
import kh.hand.makers.product.model.vo.Wish;

@Repository
public class ProductDaoImpl implements ProductDao {
	
	@Autowired
	SqlSession session;


	
	
	@Override
	public int selectProductCount() {
		// TODO Auto-generated method stub
		return session.selectOne("product.selectProductCount");
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
	public List<Map<String,String>> selectProduct(String productNo) {
		
		return session.selectList("product.selectProduct",productNo);
	}

	@Override
	public List<Map<String, String>> selectCategory(String productNo) {
		
		return session.selectList("product.selectCategory", productNo);
	}

	@Override
	public Map<String,String> selectWish(Map<String,String> wish) {
		
		return session.selectOne("product.selectWish",wish);
	}
	
	
	
	

}
