package kh.hand.makers.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.product.model.dao.ProductDao;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.product.model.vo.Wish;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductDao dao;

	
	
	@Override
	public int selectProductCount() {
		// TODO Auto-generated method stub
		return dao.selectProductCount();
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
	

}
