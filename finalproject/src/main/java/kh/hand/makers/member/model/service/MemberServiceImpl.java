package kh.hand.makers.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.member.model.dao.MemberDao;
import kh.hand.makers.member.model.vo.ManageOrder;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.product.model.vo.Wish;



@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDao dao;
	
	@Override
	public Member memberLogin(String memberId) {
		return dao.memberLogin(memberId);
	}

	@Override
	public int memberEnroll(Member m) {
		return dao.memberEnroll(m);
	}

	@Override
	public int selectBrandCloseCount() {
		return dao.selectBrandCloseCount();
	}

	@Override
	public List<Map<String, String>> selectBrandCloseList(int cPage, int numPerPage) {
		return dao.selectBrandCloseList(cPage, numPerPage);
	}

	@Override
	public int checkId(String memberId) {
		return dao.checkId(memberId);
	}

	@Override
	public int memberUpdate(Member m) {
		// TODO Auto-generated method stub
		return dao.memberUpdate(m);
	}

	@Override
	public int memberWithdrawal(String memberNo) {
		// TODO Auto-generated method stub
		return dao.memberWithdrawal(memberNo);
	}

	@Override
	public List<Delivery> selectDeliveryList(String memberNo) {
		// TODO Auto-generated method stub
		return dao.selectDeliveryList(memberNo);
	}

	@Override
	public int enrollLocation(Delivery delivery) {
		// TODO Auto-generated method stub
		return dao.enrollLocation(delivery);
	}

	@Override
	public int memberPwdUpdate(Member m) {
		// TODO Auto-generated method stub
		return dao.memberPwdUpdate(m);
	}

	@Override
	public List<ManageOrder> selectOrderList(Member m, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectOrderList(m,cPage, numPerPage);
	}

	@Override
	public int selectOrderCount() {
		// TODO Auto-generated method stub
		return dao.selectOrderCount();
	}

	@Override
	public List<Map<String,String>> selectWishList(String memberNo, int cPage, int numPerPage) {
		
		return dao.selectWishList(memberNo, cPage, numPerPage);
	}

	@Override
	public int selectWishCount(String memberNo) {
		
		return dao.selectWishCount(memberNo);
	}

	@Override
	public int deleteLocation(String deliveryNo) {
		// TODO Auto-generated method stub
		return dao.deleteLocation(deliveryNo);
	}
	
}
