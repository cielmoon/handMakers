package kh.hand.makers.shop.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

public interface ShopService {

	List<Brand> selectBrandList(String memberNo);

	int insertBrand(Map<String, String> map);

	Brand selectBrand(String brandNo);

	int insertPreProduct(Map<String, String> map);

	List<BigCategory> selectBcList();

	List<SmallCategory> selectScList(String bcNo);

	int updateBrand(Map<String, String> map);

	List<PreProduct> selectPreProductList(String brandNo, int cPage, int numPerPage);

	PreProduct selectPreProduct(String preNo);

	int selectPreProductCount(String brandNo);

	int selectBrandProductCount(Map<String, Object> map);

	List<Product> selectBrandProductList(Map<String, Object> map, int cPage, int numPerPage);

	int selectOrderCount(String productNo);

	List<Order> selectOrderList(String productNo, int cPage, int numPerPage);

	

}
