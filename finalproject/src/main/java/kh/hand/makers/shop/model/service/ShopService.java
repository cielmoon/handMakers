package kh.hand.makers.shop.model.service;

import java.util.List;

import kh.hand.makers.shop.model.vo.Shop;

public interface ShopService {

	List<Shop> selectBrandList(String memberNo);

}
