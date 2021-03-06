package kh.hand.makers.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.hand.makers.member.model.vo.ManageOrder;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.product.model.vo.Wish;
import kh.hand.makers.shop.model.vo.Brand;

@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public int memberNewPwdUpdate(Map<String, String> cP) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.memberNewPwdUpdate", cP);
	}

	@Override
	public String memberIdFind(String memberEmail) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.memberIdFind",memberEmail);
	}

	@Override
	public Member memberFind(Map<String, String> findMember) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.memberFind",findMember);
	}

	@Override
	public Member memberLogin(String memberId) {
		return sqlSession.selectOne("member.login",memberId);
	}

	@Override
	public int memberEnroll(Member m) {
		return sqlSession.insert("member.insertMember",m);
	}

	@Override
	public int selectBrandCloseCount() {
		return sqlSession.selectOne("member.selectBrandCloseCount");
	}

	@Override
	public List<Map<String, String>> selectBrandCloseList(int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);
		return sqlSession.selectList("member.selectBrandCloseList", null, rb);
	}

	@Override
	public int checkId(String memberId) {
		return sqlSession.selectOne("member.checkId", memberId);
	}

	@Override
	public int memberUpdate(Member m) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.memberUpdate",m);
	}

	@Override
	public int memberWithdrawal(String memberNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.memberWithdrawal",memberNo);
	}

	@Override
	public List<Delivery> selectDeliveryList(String memberNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("member.selectDeliveryList",memberNo);
	}

	@Override
	public int enrollLocation(Delivery delivery) {
		// TODO Auto-generated method stub
		return sqlSession.insert("member.enrollLocation",delivery);
	}

	@Override
	public int memberPwdUpdate(Member m) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.memberPwdUpdate",m);
	}

	@Override
	public List<ManageOrder> selectOrderList(Member m, int cPage, int numPerPage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("member.selectOrderList",m,rb);
	}

	@Override
	public int selectOrderCount(String memberNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.selectOrderCount", memberNo);
	}

	@Override
	public List<Map<String,String>> selectWishList(String memberNo, int cPage, int numPerPage) {
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sqlSession.selectList("member.selectWishList", memberNo, rb);
		
	}

	@Override
	public int selectWishCount(String memberNo) {
		
		return sqlSession.selectOne("member.selectWishCount",memberNo);
	}

	@Override
	public int deleteLocation(String deliveryNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("member.deleteLocation", deliveryNo);
	}

	@Override
	public int checkEmail(String memberEmail) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.checkEmail", memberEmail);
	}

	@Override
	public int changeProfile(Member m) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.changeProfile", m);
	}
	
	@Override
	public int updateOrderState(String orderNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.updateOrderState", orderNo);
	}

	@Override
	public Member memberEmailFind(String memberEmail) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.memberEmailFind", memberEmail);
	}

	@Override
	public List<Brand> selectBrand(String memberNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("member.selectBrand", memberNo);
	}

	@Override
	public int updateProductWithdrawl(String brandNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.updateProductWithdrawl", brandNo);
	}

	@Override
	public int updateBrandWithdrawl(String brandNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.updateBrandWithdrawl", brandNo);
	}

	@Override
	public int selectProductState(String productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.selectProductState", productNo);
	}

	@Override
	public int updateProductState(String productNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("member.updateProductState", productNo);
	}

	@Override
	public int deleteSaleProduct(String salesNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("member.deleteSaleProduct", salesNo);
	}

	@Override
	public String selectSalseNo(String productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.selectSalseNo", productNo);
	}

	@Override
	public int selectCerrSell(String salesNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.selectCerrSell", salesNo);
	}	
	
}
