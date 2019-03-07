package kh.hand.makers.shop.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.shop.model.dao.ShopDao;
import kh.hand.makers.shop.model.vo.Brand;

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

	
}
