package kh.hand.makers.member.model.service;

import java.util.List;
import java.util.Map;

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
}
