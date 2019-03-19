package kh.hand.makers.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.SellerRequest;
import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;

@Repository
public class AdminDaoImpl implements AdminDao {
	@Autowired
	SqlSessionTemplate session;

	@Override
	public int selectProductCount() {
		return session.selectOne("admin.selectProductCount");
	}

	@Override
	public List<Brand> selectBrandList(int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return session.selectList("admin.selectBrandList", null, rb);
	}

	@Override
	public int selectBrandCount() {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectBrandCount");
	}

	@Override
	public int brandStateUpdate(Map<String, String> bs) {

		return session.update("admin.brandStateUpdate", bs);
	}

	@Override
	public int selectPreProductCount() {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectPreProductCount");
	}

	@Override
	public List<managePreProduct> selectPreProductList(int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return session.selectList("admin.selectPreProductList", null, rb);
	}

	@Override
	public int preProductStateUpdate(Map<String, String> ps) {
		// TODO Auto-generated method stub
		return session.update("admin.preProductStateUpdate", ps);
	}

	@Override
	public PreProduct selectPreProduct(String preProductNo) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectPreProduct", preProductNo);
	}

	@Override
	public List<AdminProduct> selectProductList(int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return session.selectList("admin.selectProductList", null, rb);
	}

	@Override
	public int selectMemberCount() {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectMemberCount");
	}

	@Override
	public List<Member> selectMemberList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return session.selectList("admin.selectMemberList", null, rb);
	}

	@Override
	public int selectRequestCount(String reqRefType) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectRequestCount",reqRefType);
	}

	@Override
	public List<SellerRequest> selectRequestList(String reqRefType, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return session.selectList("admin.selectRequestList", reqRefType, rb);
	}

	@Override
	public String selectBrandName(String reqRef) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectBrandName",reqRef);
	}

	@Override
	public String selectProductName(String reqRef) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectProductName",reqRef);
	}

	@Override
	public int reqProcessUpdate(Map<String, String> sr1) {
		// TODO Auto-generated method stub
		return session.update("admin.reqProcessUpdate", sr1);
	}

	@Override
	public int reqStateUpdate(Map<String, String> sr2) {
		// TODO Auto-generated method stub
		return session.update("admin.reqStateUpdate", sr2);
	}

	@Override
	public int productStateUpdate(Map<String, String> ps) {
		// TODO Auto-generated method stub
		return session.update("admin.productStateUpdate", ps);
	}

	
}
