package kh.hand.makers.shop.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.shop.model.dao.ShopDao;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	ShopDao dao;
	
	@Override
	public List<Brand> selectBrandList(String memberNo) {
		return dao.selectBrandList(memberNo);
	}

	@Override
	public int insertBrand(Map<String, String> map) {
		return dao.insertBrand(map);
	}

	@Override
	public Brand selectBrand(String brandNo) {
		return dao.selectBrand(brandNo);
	}

	@Override
	public int insertPreProduct(Map<String, String> map) {
		return dao.insertPreProduct(map);
	}

	@Override
	public List<BigCategory> selectBcList() {
		return dao.selectBcList();
	}

	@Override
	public List<SmallCategory> selectScList(String bcNo) {
		return dao.selectScList(bcNo);
	}

	@Override
	public int updateBrand(Map<String, String> map) {
		return dao.updateBrand(map);
	}

	@Override
	public List<PreProduct> selectPreProductList(String brandNo, int cPage, int numPerPage) {
		return dao.selectPreProductList(brandNo, cPage, numPerPage);
	}

	@Override
	public PreProduct selectPreProduct(String preNo) {
		return dao.selectPreProduct(preNo);
	}

	@Override
	public int selectPreProductCount(String brandNo) {
		return dao.selectPreProductCount(brandNo);
	}


	@Override
	public int selectBrandProductCount(Map<String, Object> map) {
		return dao.selectBrandProductCount(map);
	}

	@Override
	public List<Product> selectBrandProductList(Map<String, Object> map, int cPage, int numPerPage) {
		return dao.selectBrandProductList(map, cPage, numPerPage);

	}

	@Override
	public int selectOrderCount(String productNo) {
		return dao.selectOrderCount(productNo);
	}

	@Override
	public List<Order> selectOrderList(String productNo, int cPage, int numPerPage) {
		return dao.selectOrderList(productNo, cPage, numPerPage);

	}
	
	
	
}
