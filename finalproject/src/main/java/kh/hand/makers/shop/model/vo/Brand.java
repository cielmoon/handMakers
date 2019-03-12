package kh.hand.makers.shop.model.vo;

import java.io.Serializable;
import java.util.Date;

public class Brand implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8697881280526170957L;
	private String brandNo;
	private String brandTitle;
	private String brandLicense;
	private String brandType;
	private String brandAddr;
	private String brandDetailAddr;
	private Date brandEnrollDate;
	private char brandState;
	private String memberNo;
	
	public Brand() {
		super();
	}

	public Brand(String brandNo, String brandTitle, String brandLicense, String brandType, String brandAddr,
			String brandDetailAddr, Date brandEnrollDate, char brandState, String memberNo) {
		super();
		this.brandNo = brandNo;
		this.brandTitle = brandTitle;
		this.brandLicense = brandLicense;
		this.brandType = brandType;
		this.brandAddr = brandAddr;
		this.brandDetailAddr = brandDetailAddr;
		this.brandEnrollDate = brandEnrollDate;
		this.brandState = brandState;
		this.memberNo = memberNo;
	}

	public String getBrandNo() {
		return brandNo;
	}

	public void setBrandNo(String brandNo) {
		this.brandNo = brandNo;
	}

	public String getBrandTitle() {
		return brandTitle;
	}

	public void setBrandTitle(String brandTitle) {
		this.brandTitle = brandTitle;
	}

	public String getBrandLicense() {
		return brandLicense;
	}

	public void setBrandLicense(String brandLicense) {
		this.brandLicense = brandLicense;
	}

	public String getBrandType() {
		return brandType;
	}

	public void setBrandType(String brandType) {
		this.brandType = brandType;
	}

	public String getBrandAddr() {
		return brandAddr;
	}

	public void setBrandAddr(String brandAddr) {
		this.brandAddr = brandAddr;
	}

	public String getBrandDetailAddr() {
		return brandDetailAddr;
	}

	public void setBrandDetailAddr(String brandDetailAddr) {
		this.brandDetailAddr = brandDetailAddr;
	}

	public Date getBrandEnrollDate() {
		return brandEnrollDate;
	}

	public void setBrandEnrollDate(Date brandEnrollDate) {
		this.brandEnrollDate = brandEnrollDate;
	}

	public char getBrandState() {
		return brandState;
	}

	public void setBrandState(char brandState) {
		this.brandState = brandState;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	
	
}
