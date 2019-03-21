package kh.hand.makers.shop.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

public interface ShopDao {
	
	List<Brand> selectBrandList(String memberNo);

	int insertBrand(Map<String, String> map);

	Brand selectBrand(String brandNo);

	int insertPreProduct(Map<String, String> map);

	List<BigCategory> selectBcList();

	List<SmallCategory> selectScList(String bcNo);

	int updateBrand(Map<String, String> map);

	List<PreProduct> selectPreProductList(Map<String, Object> map, int cPage, int numPerPage);

	PreProduct selectPreProduct(String preNo);

	int selectPreProductCount(Map<String, Object> map);

	int selectBrandProductCount(Map<String, Object> map);

	List<Map<String, Object>> selectBrandProductList(Map<String, Object> map, int cPage, int numPerPage);

	List<Map<String, String>> selectOrderList(String productNo, int cPage, int numPerPage);

	int selectOrderCount(String productNo);

	Map<String, String> selectProduct(String productNo);

	int selectProductQnaCount(String productNo);

	List<Map<String, String>> selectProductQnaList(String productNo, int cPage, int numPerPage);

	List<Map<String, String>> selectProductAnswerList(String productNo);

	Map<String, String> selectProductQnaAnswer(String refNo);

	int productQnaAnswer(Map<String, String> map);

	int insertSellerRequest(Map<String, String> map);

	List<Map<String, String>> selectSellerReqList(String memberNo);

	int selectReqState(Map<String, String> map);

	int exportOrders(String order);

	Map<String, String> selectOrder(String orderNo);

	int selectSalesRecordsCount(String productNo);

	List<Map<String, String>> selectSalesRecordsList(String productNo, int cPage, int numPerPage);

	Map<String, String> selectRecord(String recordNo);

	int updateSellerRequestRef(Map<String, String> map);

	int updateTracking(Map<String, String> map);

	
}
