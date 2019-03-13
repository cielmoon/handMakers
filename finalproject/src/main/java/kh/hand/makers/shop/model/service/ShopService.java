package kh.hand.makers.shop.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.SmallCategory;

public interface ShopService {

	List<Brand> selectBrandList(String memberNo);

	int insertBrand(Map<String, String> map);

	Brand selectBrand(String brandNo);

	int insertPreProduct(Map<String, String> map);

	List<BigCategory> selectBcList();

	List<SmallCategory> selectScList(String bcNo);

	int updateBrand(Map<String, String> map);

}
