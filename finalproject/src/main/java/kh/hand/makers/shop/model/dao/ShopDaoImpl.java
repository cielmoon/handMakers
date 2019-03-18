package kh.hand.makers.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.order.model.vo.Order;
import kh.hand.makers.product.model.vo.Product;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

@Repository
public class ShopDaoImpl implements ShopDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Brand> selectBrandList(String memberNo) {
		return sqlSession.selectList("shop.selectBrandList", memberNo);
	}

	@Override
	public int insertBrand(Map<String, String> map) {
		return sqlSession.insert("shop.insertBrand", map);
	}

	@Override
	public Brand selectBrand(String brandNo) {
		return sqlSession.selectOne("shop.selectBrand", brandNo);
	}

	@Override
	public int insertPreProduct(Map<String, String> map) {
		return sqlSession.insert("shop.insertPreProduct", map);
				
	}

	@Override
	public List<BigCategory> selectBcList() {
		return sqlSession.selectList("shop.selectBcList");
	}

	@Override
	public List<SmallCategory> selectScList(String bcNo) {
		return sqlSession.selectList("shop.selectScList", bcNo);
	}

	@Override
	public int updateBrand(Map<String, String> map) {
		return sqlSession.update("shop.updateBrand", map);
	}

	@Override
	public List<PreProduct> selectPreProductList(String brandNo, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectPreProductList", brandNo, rb);
	}

	@Override
	public PreProduct selectPreProduct(String preNo) {
		return sqlSession.selectOne("shop.selectPreProduct", preNo);
	}

	@Override
	public int selectPreProductCount(String brandNo) {
		return sqlSession.selectOne("shop.selectPreProductCount", brandNo);
	}

	@Override
	public int selectBrandProductCount(Map<String, Object> map) {
		return sqlSession.selectOne("shop.selectBrandProductCount", map);
	}

	@Override
	public List<Map<String, Object>> selectBrandProductList(Map<String, Object> map, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectBrandProductList", map, rb);
	}

	@Override
	public List<Map<String, String>> selectOrderList(String productNo, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectOrderList", productNo, rb);
	}

	@Override
	public int selectOrderCount(String productNo) {
		return sqlSession.selectOne("shop.selectOrderCount", productNo);
	}

	@Override
	public Map<String, String> selectProduct(String productNo) {
		return sqlSession.selectOne("shop.selectProduct", productNo);
	}

	@Override
	public int selectProductQnaCount(String productNo) {
		return sqlSession.selectOne("shop.selectProductQnaCount", productNo);
	}

	@Override
	public List<Map<String, String>> selectProductQnaList(String productNo, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectProductQnaList", productNo, rb);
	}

	@Override
	public List<Map<String, String>> selectProductAnswerList(String productNo) {
		return sqlSession.selectList("shop.selectProductAnswerList", productNo);

	}

	@Override
	public Map<String, String> selectProductQnaAnswer(String refNo) {
		return sqlSession.selectOne("shop.selectProductQnaAnswer", refNo);

	}

	@Override
	public int productQnaAnswer(Map<String, String> map) {
		String state = (String) map.get("state");
		if(state.equals("insert")) 
		{
			return sqlSession.insert("shop.insertProductQnaAnswer", map);
		}
		else
		{
			return sqlSession.insert("shop.updateProductQnaAnswer", map);	
		}

	}

	@Override
	public int insertSellerRequest(Map<String, String> map) {
		return sqlSession.insert("shop.insertSellerRequest", map);
	}
	
	@Override
	public List<Map<String, String>> selectSellerReqList(String memberNo) {
		return sqlSession.selectList("shop.selectSellerReqList", memberNo);

	}

	@Override
	public int selectReqState(Map<String, String> map) {
		return sqlSession.selectOne("shop.selectReqState", map);

	}

	@Override
	public int exportOrders(String order) {
		return sqlSession.update("shop.exportOrders", order);
	}

	@Override
	public Map<String, String> selectOrder(String orderNo) {
		return sqlSession.selectOne("shop.selectOrder", orderNo);
	}

	@Override
	public int cancelExportOrder(String orderNo) {
		return sqlSession.update("shop.cancelExportOrder", orderNo);

	}

	@Override
	public int selectSalesRecordsCount(String productNo) {
		return sqlSession.selectOne("shop.selectSalesRecordsCount", productNo);
	}

	@Override
	public List<Map<String, String>> selectSalesRecordsList(String productNo, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectSalesRecordsList", productNo, rb);
	}

	@Override
	public Map<String, String> selectRecord(String recordNo) {
		return sqlSession.selectOne("shop.selectRecord", recordNo);
	}
	
	
}
