package kh.hand.makers.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.member.model.dao.MemberDao;
import kh.hand.makers.member.model.vo.ManageOrder;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Delivery;
import kh.hand.makers.shop.model.vo.Brand;



@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDao dao;
	
	@Override
	public int memberNewPwdUpdate(Map<String, String> cP) {
		// TODO Auto-generated method stub
		return dao.memberNewPwdUpdate(cP);
	}

	@Override
	public Member memberFind(Map<String, String> findMember) {
		// TODO Auto-generated method stub
		return dao.memberFind(findMember);
	}

	@Override
	public String memberIdFind(String memberEmail) {
		// TODO Auto-generated method stub
		return dao.memberIdFind(memberEmail);
	}

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
	public int selectOrderCount(String memberNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderCount(memberNo);
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

	@Override
	public int checkEmail(String memberEmail) {
		// TODO Auto-generated method stub
		return dao.checkEmail(memberEmail);
	}

	@Override
	public int changeProfile(Member m) {
		// TODO Auto-generated method stub
		return dao.changeProfile(m);
	}
	
	@Override
	public int updateOrderState(String orderNo) {
		// TODO Auto-generated method stub
		return dao.updateOrderState(orderNo);
	}

	@Override
	public Member memberEmailFind(String memberEmail) {
		// TODO Auto-generated method stub
		return dao.memberEmailFind(memberEmail);
	}

	@Override
	public List<Brand> selectBrand(String memberNo) {
		// TODO Auto-generated method stub
		return dao.selectBrand(memberNo);
	}

	@Override
	public int updateProductWithdrawl(String brandNo) {
		// TODO Auto-generated method stub
		return dao.updateProductWithdrawl(brandNo);
	}

	@Override
	public int updateBrandWithdrawl(String brandNo) {
		// TODO Auto-generated method stub
		return dao.updateBrandWithdrawl(brandNo);
	}

	@Override
	public int selectProductState(String productNo) {
		// TODO Auto-generated method stub
		return dao.selectProductState(productNo);
	}

	@Override
	public int updateProductState(String productNo) {
		// TODO Auto-generated method stub
		return dao.updateProductState(productNo);
	}

	@Override
	public int deleteSaleProduct(String salesNo) {
		// TODO Auto-generated method stub
		return dao.deleteSaleProduct(salesNo);
	}

	@Override
	public String selectSalseNo(String productNo) {
		// TODO Auto-generated method stub
		return dao.selectSalseNo(productNo);
	}

	@Override
	public int selectCerrSell(String salesNo) {
		// TODO Auto-generated method stub
		return dao.selectCerrSell(salesNo);
	}
	
	
}
