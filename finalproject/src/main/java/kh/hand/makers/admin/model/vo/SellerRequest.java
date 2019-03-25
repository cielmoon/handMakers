package kh.hand.makers.admin.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class SellerRequest implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3872014559814556433L;
	private String sellerReqNo;
	private String memberNo;
	private String sellerReqRef;
	private String sellerReqType;
	private String sellerReqState;
	private String sellerReqTitle;
	private String sellerReqContent;
	private Date sellerReqDate;
	private String sellerReqProcess;
	private String refName;
	private String memberId;

	
	public SellerRequest() {
		
	}


	public String getSellerReqNo() {
		return sellerReqNo;
	}


	public void setSellerReqNo(String sellerReqNo) {
		this.sellerReqNo = sellerReqNo;
	}


	public String getMemberNo() {
		return memberNo;
	}


	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}


	public String getSellerReqRef() {
		return sellerReqRef;
	}


	public void setSellerReqRef(String sellerReqRef) {
		this.sellerReqRef = sellerReqRef;
	}


	public String getSellerReqType() {
		return sellerReqType;
	}


	public void setSellerReqType(String sellerReqType) {
		this.sellerReqType = sellerReqType;
	}


	public String getSellerReqState() {
		return sellerReqState;
	}


	public void setSellerReqState(String sellerReqState) {
		this.sellerReqState = sellerReqState;
	}


	public String getSellerReqTitle() {
		return sellerReqTitle;
	}


	public void setSellerReqTitle(String sellerReqTitle) {
		this.sellerReqTitle = sellerReqTitle;
	}


	public String getSellerReqContent() {
		return sellerReqContent;
	}


	public void setSellerReqContent(String sellerReqContent) {
		this.sellerReqContent = sellerReqContent;
	}


	public Date getSellerReqDate() {
		return sellerReqDate;
	}


	public void setSellerReqDate(Date sellerReqDate) {
		this.sellerReqDate = sellerReqDate;
	}


	public String getSellerReqProcess() {
		return sellerReqProcess;
	}


	public void setSellerReqProcess(String sellerReqProcess) {
		this.sellerReqProcess = sellerReqProcess;
	}


	public String getRefName() {
		return refName;
	}


	public void setRefName(String refName) {
		this.refName = refName;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public SellerRequest(String sellerReqNo, String memberNo, String sellerReqRef, String sellerReqType,
			String sellerReqState, String sellerReqTitle, String sellerReqContent, Date sellerReqDate,
			String sellerReqProcess, String refName, String memberId) {
		super();
		this.sellerReqNo = sellerReqNo;
		this.memberNo = memberNo;
		this.sellerReqRef = sellerReqRef;
		this.sellerReqType = sellerReqType;
		this.sellerReqState = sellerReqState;
		this.sellerReqTitle = sellerReqTitle;
		this.sellerReqContent = sellerReqContent;
		this.sellerReqDate = sellerReqDate;
		this.sellerReqProcess = sellerReqProcess;
		this.refName = refName;
		this.memberId = memberId;
	}


	@Override
	public String toString() {
		return "SellerRequest [sellerReqNo=" + sellerReqNo + ", memberNo=" + memberNo + ", sellerReqRef=" + sellerReqRef
				+ ", sellerReqType=" + sellerReqType + ", sellerReqState=" + sellerReqState + ", sellerReqTitle="
				+ sellerReqTitle + ", sellerReqContent=" + sellerReqContent + ", sellerReqDate=" + sellerReqDate
				+ ", sellerReqProcess=" + sellerReqProcess + ", refName=" + refName + ", memberId=" + memberId + "]";
	}


}
