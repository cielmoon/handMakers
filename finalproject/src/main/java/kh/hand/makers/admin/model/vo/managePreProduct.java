package kh.hand.makers.admin.model.vo;

import java.sql.Date;

public class managePreProduct {
	
	private String preProductBcTitle;
	private String preProductScTitle;
	private String preProductBrandTitle;
	private String preProductTitle;
	private char preProductState;
	private Date preProductDate;
	private String preProductNo;
	
	public managePreProduct() {
		super();
	}
	
	public managePreProduct(String preProductBcTitle, String preProductScTitle, String preProductBrandTitle,
			String preProductTitle, char preProductState, Date preProductDate, String preProductNo) {
		super();
		this.preProductBcTitle = preProductBcTitle;
		this.preProductScTitle = preProductScTitle;
		this.preProductBrandTitle = preProductBrandTitle;
		this.preProductTitle = preProductTitle;
		this.preProductState = preProductState;
		this.preProductDate = preProductDate;
		this.preProductNo = preProductNo;
	}


	public String getPreProductBcTitle() {
		return preProductBcTitle;
	}


	public void setPreProductBcTitle(String preProductBcTitle) {
		this.preProductBcTitle = preProductBcTitle;
	}


	public String getPreProductScTitle() {
		return preProductScTitle;
	}


	public void setPreProductScTitle(String preProductScTitle) {
		this.preProductScTitle = preProductScTitle;
	}


	public String getPreProductBrandTitle() {
		return preProductBrandTitle;
	}


	public void setPreProductBrandTitle(String preProductBrandTitle) {
		this.preProductBrandTitle = preProductBrandTitle;
	}


	public String getPreProductTitle() {
		return preProductTitle;
	}


	public void setPreProductTitle(String preProductTitle) {
		this.preProductTitle = preProductTitle;
	}


	public char getPreProductState() {
		return preProductState;
	}


	public void setPreProductState(char preProductState) {
		this.preProductState = preProductState;
	}


	public Date getPreProductDate() {
		return preProductDate;
	}


	public void setPreProductDate(Date preProductDate) {
		this.preProductDate = preProductDate;
	}


	public String getPreProductNo() {
		return preProductNo;
	}


	public void setPreProductNo(String preProductNo) {
		this.preProductNo = preProductNo;
	}


	@Override
	public String toString() {
		return "managePreProduct [preProductBcTitle=" + preProductBcTitle + ", preProductScTitle=" + preProductScTitle
				+ ", preProductBrandTitle=" + preProductBrandTitle + ", preProductTitle=" + preProductTitle
				+ ", preProductState=" + preProductState + ", preProductDate=" + preProductDate + ", preProductNo="
				+ preProductNo + "]";
	}
	

	
}
