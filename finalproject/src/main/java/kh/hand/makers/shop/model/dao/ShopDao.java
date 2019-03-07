package kh.hand.makers.shop.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.shop.model.vo.Brand;

public interface ShopDao {
	
	List<Brand> selectBrandList(String memberNo);

	int insertBrand(Map<String, String> map);

}
