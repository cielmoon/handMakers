package kh.hand.makers.admin.model.vo;

import java.sql.Date;

public class ViewMemberList {
	private String memberId;
	private String memberName;
	private String memberEmail;
	private String memberPhone;
	private Date memberEnrollDate;
	
	public ViewMemberList() {
	}

	public ViewMemberList(String memberId, String memberName, String memberEmail, String memberPhone,
			Date memberEnrollDate) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
		this.memberEmail = memberEmail;
		this.memberPhone = memberPhone;
		this.memberEnrollDate = memberEnrollDate;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
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

	public Date getMemberEnrollDate() {
		return memberEnrollDate;
	}

	public void setMemberEnrollDate(Date memberEnrollDate) {
		this.memberEnrollDate = memberEnrollDate;
	}

	@Override
	public String toString() {
		return "ViewMemberList [memberId=" + memberId + ", memberName=" + memberName + ", memberEmail=" + memberEmail
				+ ", memberPhone=" + memberPhone + ", memberEnrollDate=" + memberEnrollDate + "]";
	}
}
