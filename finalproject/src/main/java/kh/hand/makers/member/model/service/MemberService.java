package kh.hand.makers.member.model.service;

import java.util.List;
import java.util.Map;

import kh.hand.makers.member.model.vo.Member;

public interface MemberService {
	Member memberLogin(String memberId);
	int memberEnroll(Member m);
	int selectBrandCloseCount();
	List<Map<String,String>> selectBrandCloseList(int cPage,int numPerPage);
	int checkId(String memberId);
}
