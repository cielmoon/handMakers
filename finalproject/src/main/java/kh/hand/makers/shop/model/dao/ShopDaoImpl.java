package kh.hand.makers.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
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
	
	

}
