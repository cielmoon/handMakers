package kh.hand.makers.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.admin.model.vo.AdminProduct;
import kh.hand.makers.admin.model.vo.Products;
import kh.hand.makers.admin.model.vo.SellerRequest;
import kh.hand.makers.admin.model.vo.managePreProduct;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.shop.model.vo.BigCategory;
import kh.hand.makers.shop.model.vo.Brand;
import kh.hand.makers.shop.model.vo.PreProduct;
import kh.hand.makers.shop.model.vo.SmallCategory;

@Repository
public class AdminDaoImpl implements AdminDao {
	@Autowired
	SqlSessionTemplate session;

	@Override
	public List<Brand> selectBrandList() {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectAllBrandList");
	}

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

	@Override
	public int selectReProductCount() {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectReProductCount");
	}

	@Override
	public List<AdminProduct> selectReProductList(int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return session.selectList("admin.selectReProductList", null, rb);
	}

	@Override
	public List<BigCategory> selectBcList() {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectBcList");
	}

	@Override
	public List<SmallCategory> selectScList(String bcNo) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectScList", bcNo);
	}

	@Override
	public int enrollProduct(Products p) {
		// TODO Auto-generated method stub
		return session.insert("admin.enrollProduct", p);
	}

	@Override
	public int enrollProductImg(Map<String, String> img) {
		// TODO Auto-generated method stub
		return session.insert("admin.enrollProductImg", img);
	}

	@Override
	public int enrollProductOption(Map<String, String> option) {
		// TODO Auto-generated method stub
		return session.insert("admin.enrollProductOption", option);
	}

	@Override
	public int enrollProductDetail(Map<String, String> detail) {
		// TODO Auto-generated method stub
		return session.insert("admin.enrollProductDetail", detail);
	}

	@Override
	public String selectSellerNo(String brandNo) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectSellerNo",brandNo);
	}

	@Override
	public int memberStateUpdate(String memberNo) {
		// TODO Auto-generated method stub
		return session.update("admin.memberStateUpdate", memberNo);
	}

	@Override
	public int memberAuthorityChange(String memberNo) {
		// TODO Auto-generated method stub
		return session.update("admin.memberAuthorityChange", memberNo);
	}

	@Override
	public int selectBrandStateCount(String memberNo) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectBrandStateCount",memberNo);
	}

	@Override
	public int updateProductState(String brandNo) {
		// TODO Auto-generated method stub
		return session.update("admin.updateProductState", brandNo);
	}
	
	
}
