package kh.hand.makers.shop.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.shop.model.vo.Shop;

@Repository
public class ShopDaoImpl implements ShopDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Shop> selectBrandList(String memberNo) {
		return sqlSession.selectList("shop.selectBrandList", memberNo);
	}

}
