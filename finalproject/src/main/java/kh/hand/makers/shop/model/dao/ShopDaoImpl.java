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
	public List<Product> selectBrandProductList(Map<String, Object> map, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectBrandProductList", map, rb);
	}

	@Override
	public List<Order> selectOrderList(String productNo, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("shop.selectOrderList", productNo, rb);
	}

	@Override
	public int selectOrderCount(String productNo) {
		return sqlSession.selectOne("shop.selectOrderCount", productNo);
	}
	
	
	
}
