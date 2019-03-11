package kh.hand.makers.shop.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.shop.model.dao.ShopDao;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
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

	
}
