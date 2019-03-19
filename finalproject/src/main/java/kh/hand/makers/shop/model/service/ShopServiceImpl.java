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
	public List<Map<String, Object>> selectBrandProductList(Map<String, Object> map, int cPage, int numPerPage) {
		return dao.selectBrandProductList(map, cPage, numPerPage);

	}

	@Override
	public int selectOrderCount(String productNo) {
		return dao.selectOrderCount(productNo);
	}

	@Override
	public List<Map<String, String>> selectOrderList(String productNo, int cPage, int numPerPage) {
		return dao.selectOrderList(productNo, cPage, numPerPage);

	}

	@Override
	public Map<String, String> selectProduct(String productNo) {
		return dao.selectProduct(productNo);
	}

	@Override
	public int selectProductQnaCount(String productNo) {
		return dao.selectProductQnaCount(productNo);
	}

	@Override
	public List<Map<String, String>> selectProductQnaList(String productNo, int cPage, int numPerPage) {
		return dao.selectProductQnaList(productNo, cPage, numPerPage);
	}

	@Override
	public List<Map<String, String>> selectProductAnswerList(String productNo) {
		return dao.selectProductAnswerList(productNo);
	}

	@Override
	public Map<String, String> selectProductQnaAnswer(String refNo) {
		return dao.selectProductQnaAnswer(refNo);
	}

	@Override
	public int productQnaAnswer(Map<String, String> map) {
		return dao.productQnaAnswer(map);
	}

	@Override
	public int insertSellerRequest(Map<String, String> map) {
		return dao.insertSellerRequest(map);
	}

	@Override
	public List<Map<String, String>> selectSellerReqList(String memberNo) {
		return dao.selectSellerReqList(memberNo);
	}

	@Override
	public int selectReqState(Map<String, String> map) {
		return dao.selectReqState(map);

	}

	@Override
	public int exportOrders(String order) {
		return dao.exportOrders(order);
	}

	@Override
	public Map<String, String> selectOrder(String orderNo) {
		return dao.selectOrder(orderNo);
	}

	@Override
	public int cancelExportOrder(String orderNo) {
		return dao.cancelExportOrder(orderNo);
	}

	@Override
	public int selectSalesRecordsCount(String productNo) {
		return dao.selectSalesRecordsCount(productNo);
	}

	@Override
	public List<Map<String, String>> selectSalesRecordsList(String productNo, int cPage, int numPerPage) {
		return dao.selectSalesRecordsList(productNo, cPage, numPerPage);
	}

	@Override
	public Map<String, String> selectRecord(String recordNo) {
		return dao.selectRecord(recordNo);
	}

	@Override
	public int updateSellerRequestRef(Map<String, String> map) {
		return dao.updateSellerRequestRef(map);
	}
	
	
	
	
}
