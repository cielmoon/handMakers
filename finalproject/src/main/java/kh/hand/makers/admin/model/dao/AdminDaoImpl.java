package kh.hand.makers.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.shop.model.vo.Brand;

@Repository
public class AdminDaoImpl implements AdminDao {
	@Autowired
	SqlSessionTemplate session;
	

	@Override
	public List<Map<String, String>> selectProductList(int cPage,int numPerPage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("admin.selectProductList",null,rb);
	}

	@Override
	public int selectProductCount() {
		return session.selectOne("admin.selectProductCount");
	}

	@Override
	public List<Brand> selectBrandList(int cPage, int numPerPage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("admin.selectBrandList",null,rb);
	}

	@Override
	public int selectBrandCount() {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectBrandCount");
	}

	@Override
	public int brandStateUpdate(Map<String,String> bs) {
		// TODO Auto-generated method stub
		System.out.println("DAO왔음 업데이트");
		return session.update("admin.brandStateUpdate",bs);
	}
	
	
	
}
