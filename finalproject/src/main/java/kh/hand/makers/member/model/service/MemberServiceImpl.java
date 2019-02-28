package kh.hand.makers.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.hand.makers.member.model.dao.MemberDao;
import kh.hand.makers.member.model.vo.Member;



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

}
