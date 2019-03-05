package kh.hand.makers.shop.model.dao;

import java.util.List;

import kh.hand.makers.shop.model.vo.Shop;

public interface ShopDao {
	
	List<Shop> selectBrandList(String memberNo);

}
