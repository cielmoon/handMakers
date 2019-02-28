package kh.hand.makers.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Member implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3348366790115760502L;
	private String memberNo;
	private String memberId;
	private String memberPwd;
	private String memberName;
	private String memberBirth;
	private String memberAddr;
	private String memberEmail;
	private String memberPhone;
	private String memberProfile;
	private String memberState;
	private String memberAuthority;
	private Date memberEnrollDate;

	public Member() {

	}

	public Member(String memberNo, String memberId, String memberPwd, String memberName, String memberBirth,
			String memberAddr, String memberEmail, String memberPhone, String memberProfile, String memberState,
			String memberAuthority, Date memberEnrollDate) {
		super();
		this.memberNo = memberNo;
		this.memberId = memberId;
		this.memberPwd = memberPwd;
		this.memberName = memberName;
		this.memberBirth = memberBirth;
		this.memberAddr = memberAddr;
		this.memberEmail = memberEmail;
		this.memberPhone = memberPhone;
		this.memberProfile = memberProfile;
		this.memberState = memberState;
		this.memberAuthority = memberAuthority;
		this.memberEnrollDate = memberEnrollDate;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPwd() {
		return memberPwd;
	}

	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberBirth() {
		return memberBirth;
	}

	public void setMemberBirth(String memberBirth) {
		this.memberBirth = memberBirth;
	}

	public String getMemberAddr() {
		return memberAddr;
	}

	public void setMemberAddr(String memberAddr) {
		this.memberAddr = memberAddr;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberPhone() {
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

	public String getMemberProfile() {
		return memberProfile;
	}

	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}

	public String getMemberState() {
		return memberState;
	}

	public void setMemberState(String memberState) {
		this.memberState = memberState;
	}

	public String getMemberAuthority() {
		return memberAuthority;
	}

	public void setMemberAuthority(String memberAuthority) {
		this.memberAuthority = memberAuthority;
	}

	public Date getMemberEnrollDate() {
		return memberEnrollDate;
	}

	public void setMemberEnrollDate(Date memberEnrollDate) {
		this.memberEnrollDate = memberEnrollDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Member [memberNo=" + memberNo + ", memberId=" + memberId + ", memberPwd=" + memberPwd + ", memberName="
				+ memberName + ", memberBirth=" + memberBirth + ", memberAddr=" + memberAddr + ", memberEmail="
				+ memberEmail + ", memberPhone=" + memberPhone + ", memberProfile=" + memberProfile + ", memberState="
				+ memberState + ", memberAuthority=" + memberAuthority + ", memberEnrollDate=" + memberEnrollDate + "]";
	}

}
