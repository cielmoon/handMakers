package kh.hand.makers.shop.model.vo;

import java.util.Date;

public class PreProduct {
	private String preProductNo;
	private String preProductTitle;
	private String preProductDiscript;
	private char preProductState;
	private Date preProductDate;
	private String brandNo;
	private String bcNo;
	private String scNo;
	
	public PreProduct() {
		super();
	}
	
	public PreProduct(String preProductNo, String preProductTitle, String preProductDiscript, char preProductState,
			Date preProductDate, String brandNo, String bcNo, String scNo) {
		super();
		this.preProductNo = preProductNo;
		this.preProductTitle = preProductTitle;
		this.preProductDiscript = preProductDiscript;
		this.preProductState = preProductState;
		this.preProductDate = preProductDate;
		this.brandNo = brandNo;
		this.bcNo = bcNo;
		this.scNo = scNo;
	}

	public String getPreProductNo() {
		return preProductNo;
	}

	public void setPreProductNo(String preProductNo) {
		this.preProductNo = preProductNo;
	}

	public String getPreProductTitle() {
		return preProductTitle;
	}

	public void setPreProductTitle(String preProductTitle) {
		this.preProductTitle = preProductTitle;
	}

	public String getPreProductDiscript() {
		return preProductDiscript;
	}

	public void setPreProductDiscript(String preProductDiscript) {
		this.preProductDiscript = preProductDiscript;
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

	public String getBrandNo() {
		return brandNo;
	}

	public void setBrandNo(String brandNo) {
		this.brandNo = brandNo;
	}

	public String getBcNo() {
		return bcNo;
	}

	public void setBcNo(String bcNo) {
		this.bcNo = bcNo;
	}

	public String getScNo() {
		return scNo;
	}

	public void setScNo(String scNo) {
		this.scNo = scNo;
	}
	
}