package kh.hand.makers.member.model.service;

import kh.hand.makers.member.model.vo.Member;

public interface MemberService {
	Member memberLogin(String memberId);
	int memberEnroll(Member m);
	
}
