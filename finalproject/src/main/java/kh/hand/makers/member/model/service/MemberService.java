package kh.hand.makers.member.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.member.model.vo.ManageOrder;
import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Delivery;

public interface MemberService {
	Member memberLogin(String memberId);
	int memberEnroll(Member m);
	int selectBrandCloseCount();
	List<Map<String,String>> selectBrandCloseList(int cPage,int numPerPage);
	int checkId(String memberId);
	int memberUpdate(Member m);
	int memberWithdrawal(String memberNo);
	List<Delivery> selectDeliveryList(String memberNo);
	int enrollLocation(Delivery delivery);
	int memberPwdUpdate(Member m);
	
	List<ManageOrder> selectOrderList(Member m, int cPage,int numPerPage);
	int selectOrderCount();
	List<Map<String,String>> selectWishList(String memberNo, int cPage, int numPerPage);
	int selectWishCount(String memberNo);
	
	int deleteLocation(String deliveryNo);
	String memberIdFind(String memberEmail);
	Member memberFind(Map<String,String> findMember);
	int memberNewPwdUpdate(Map<String,String> cP);
}
