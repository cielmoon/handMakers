package kh.hand.makers.shop.model.dao;

import java.util.HashMap;
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
	public int selectNextOrder(int saleCount, String productNo) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("saleCount", saleCount);
		map.put("productNo", productNo);
		
		return sqlSession.selectOne("shop.selectNextOrder", map);
	}

	@Override
	public int selectSaleEmpty(String productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shop.selectSaleEmpty", productNo);
	}

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
	public List<PreProduct> selectPreProductList(Map<String, Object> map, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		if(map.get("bcNo").equals("all"))
		{
			return sqlSession.selectList("shop.selectPreProductList", map, rb);
		}
		else
		{
			return sqlSession.selectList("shop.selectPreProductBcList", map, rb);
		}
	}

	@Override
	public PreProduct selectPreProduct(String preNo) {
		return sqlSession.selectOne("shop.selectPreProduct", preNo);
	}

	@Override
	public int selectPreProductCount(Map<String, Object> map) {
		if(map.get("bcNo").equals("all"))
		{
			return sqlSession.selectOne("shop.selectPreProductCount", map);			
		}
		else 
		{
			return sqlSession.selectOne("shop.selectPreProductBcCount", map);
		}
	}

	@Override
	public int selectBrandProductCount(Map<String, Object> map) {
		if(map.get("bcNo").equals("all"))
		{
			return sqlSession.selectOne("shop.selectBrandProductCount", map);			
		}
		else 
		{
			return sqlSession.selectOne("shop.selectBrandProductBcCount", map);			
		}
	}

	@Override
	public List<Map<String, Object>> selectBrandProductList(Map<String, Object> map, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		if(map.get("bcNo").equals("all"))
		{
			return sqlSession.selectList("shop.selectBrandProductList", map, rb);
		}
		else 
		{
			return sqlSession.selectList("shop.selectBrandProductBcList", map, rb);			
		}
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
	public int selectSalesRecordsCount(String productNo) {
		return sqlSession.selectOne("shop.selectSalesRecordsCount", productNo);
	}

	@Override
	public List<Map<String, String>> selectSalesRecordsList(String productNo, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectSalesRecordsList", productNo, rb);
	}

	@Override
	public List<Map<String, Object>> selectOrderAll(Map<String, Object> map, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectOrderAll", map, rb);
	}

	@Override
	public int orderAllListCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shop.orderAllListCount", map);
	}

	@Override
	public Map<String, String> selectRecord(String recordNo) {
		return sqlSession.selectOne("shop.selectRecord", recordNo);
	}

	@Override
	public int updateSellerRequestRef(Map<String, String> map) {
		if(map.get("requestType").equals("B")) //브랜드 폐점요청
		{
			return sqlSession.update("shop.updateBrandSellerReq", map);
		}else //상품 관련 요청
		{
			return sqlSession.update("shop.updateProductSellerReq", map);
		}
	}

	@Override
	public int updateTracking(Map<String, String> map) {
		return sqlSession.update("shop.updateTracking", map);
	}

	@Override
	public Map<String, String> selectProductQnaComment(String qnaNo) {
		return sqlSession.selectOne("shop.selectProductQnaComment", qnaNo);
	}

	@Override
	public int orderDeliveryCheck(String qnaNo) {
		return sqlSession.selectOne("shop.orderDeliveryCheck", qnaNo);

	}

	
}
