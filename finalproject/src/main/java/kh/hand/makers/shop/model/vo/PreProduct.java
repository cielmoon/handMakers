package kh.hand.makers.shop.model.vo;

import java.io.Serializable;
import java.util.Date;

public class PreProduct implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2678906938493797742L;
	private String preProductNo;
	private String preProductTitle;
	private String preProductDiscript;
	private char preProductState;
	private Date preProductDate;
	private String brandNo;
	private String bcNo;
	private String scNo;
	private String bcTitle;
	private String scTitle;
	
	public PreProduct() {
		super();
	}
	public PreProduct(String preProductNo, String preProductTitle, String preProductDiscript, char preProductState,
			Date preProductDate, String brandNo, String bcNo, String scNo, String bcTitle, String scTitle) {
		super();
		this.preProductNo = preProductNo;
		this.preProductTitle = preProductTitle;
		this.preProductDiscript = preProductDiscript;
		this.preProductState = preProductState;
		this.preProductDate = preProductDate;
		this.brandNo = brandNo;
		this.bcNo = bcNo;
		this.scNo = scNo;
		this.bcTitle = bcTitle;
		this.scTitle = scTitle;
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
	public String getBcTitle() {
		return bcTitle;
	}
	public void setBcTitle(String bcTitle) {
		this.bcTitle = bcTitle;
	}
	public String getScTitle() {
		return scTitle;
	}
	public void setScTitle(String scTitle) {
		this.scTitle = scTitle;
	}
	
	
	
}
