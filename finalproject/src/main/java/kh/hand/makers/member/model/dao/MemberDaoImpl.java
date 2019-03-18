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

@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	SqlSessionTemplate sqlSession;
	
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
		return sqlSession.delete("member.memberWithdrawal",memberNo);
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
	public int selectOrderCount() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.selectOrderCount");
	}
	
	
}
