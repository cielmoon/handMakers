package kh.hand.makers.shop.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.shop.model.dao.ShopDao;
import kh.hand.makers.shop.model.vo.Shop;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	ShopDao dao;
	
	@Override
	public List<Shop> selectBrandList(String memberNo) {
		return dao.selectBrandList(memberNo);
	}

}
