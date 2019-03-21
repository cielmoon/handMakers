package kh.hand.makers.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.product.model.dao.ProductDao;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.product.model.vo.ProductImg;
import kh.hand.makers.product.model.vo.Wish;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductDao dao;

	
	
	@Override
	public int selectProductCount(String category) {
		// TODO Auto-generated method stub
		return dao.selectProductCount(category);
	}

	@Override
	public List<Map<String, Object>> selectCategoryTemp(String category) {
		// TODO Auto-generated method stub
		return dao.selectCategoryTemp(category);
	}

	@Override
	public List<Map<String, String>> productList(String category, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.productList(category, cPage, numPerPage);
	}

	// 3월 14일 상세상품 보여주기 위함
	@Override
	public Map<String,String> selectProduct(String productNo) {
		
		return dao.selectProduct(productNo);
	}

	@Override
	public List<Map<String, String>> selectCategory(String productNo) {
		
		return dao.selectCategory(productNo);
	}

	@Override
	public String selectBcTitle(String bcNo) {
		
		return dao.selectBcTitle(bcNo);
	}
	
	@Override
	public List<ProductImg> selectProductImg(String productNo) {
		
		return dao.selectProductImg(productNo);
	}

	@Override
	public Map<String, String> selectProductDetail(String productNo) {
		
		return dao.selectProductDetail(productNo);
	}

	@Override
	public int selectWishCount(Wish wish) {
		
		return dao.selectWishCount(wish);
	}

	@Override
	public int insertWish(Wish wish) {
		
		return dao.insertWish(wish);
	}

	@Override
	public int deleteWish(Wish wish) {
		
		return dao.deleteWish(wish);
	}

	@Override
	public int selectCommentCount(String commentType) {
		
		return dao.selectCommentCount(commentType);
	}

	@Override
	public List<Map<String, String>> selectComment(Map<String, String> map, int cPage, int numPerPage) {
		
		return dao.selectComment(map,cPage,numPerPage);
	}

	@Override
	public List<Map<String, String>> selectProductOption(String productNo) {
		
		return dao.selectProductOption(productNo);
	}
	
	@Override
	public int selectProductCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.selectProductCount(map);
	}
	
	@Override
	public List<Map<String, String>> productList(Map<String, String> map, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.productList(map, cPage, numPerPage);
	}

	@Override
	public List<Map<String, String>> getMenuList() {
		return dao.getMenuList();
	}

	@Override
	public List<Map<String, String>> sCategoryList(String bCategory) {
		// TODO Auto-generated method stub
		return dao.sCategoryList(bCategory);
	}

	@Override
	public List<Map<String, String>> selectOrderList(Map<String, String> map) {
		
		return dao.selectOrderList(map);
	}

	@Override
	public Map<String, String> selectBrand(String productNo) {
		
		return dao.selectBrand(productNo);
	}
	
	
	
	
}
