package kh.hand.makers.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDaoImpl implements AdminDao {
	@Autowired
	SqlSessionTemplate session;
	

	@Override
	public List<Map<String, String>> selectProductList(int cPage,int numPerPage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("product.selectProductList",null,rb);
	}

	@Override
	public int selectProductCount() {
		return session.selectOne("product.selectProductCount");
	}
}
