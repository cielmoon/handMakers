package kh.hand.makers.member.model.dao;

import kh.hand.makers.member.model.vo.Member;

public interface MemberDao {
	Member memberLogin(String memberId);
	int memberEnroll(Member m);

}
