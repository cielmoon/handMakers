package kh.hand.makers.member.model.dao;

import java.util.List;
import java.util.Map;

import kh.hand.makers.member.model.vo.Member;
import kh.hand.makers.order.model.vo.Delivery;

public interface MemberDao {
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
}
