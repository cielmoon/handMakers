package kh.hand.makers.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.shop.model.vo.Brand;

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
	
	

}
