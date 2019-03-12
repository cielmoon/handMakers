package kh.hand.makers.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.product.model.dao.ProductDao;

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
	
	
	
	
	

}
