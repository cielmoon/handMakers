package kh.hand.makers.admin.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class AdminProduct implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2621441858268751377L;
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	private String productBcTitle;
	private String productScTitle;
	private String productBrandTitle;
	private String productTitle;	
	private Date productEnrollDate;
	private Date updateDate;
	private Date productEndDate;
	private String productNo;
	private String productState;
	
	private String pEnrollDate;
	private String pUpdateDate;	
	private String pEndDate;


	public AdminProduct() {
		
	}


	public AdminProduct(String productBcTitle, String productScTitle, String productBrandTitle, String productTitle,
			Date productEnrollDate, Date updateDate, Date productEndDate, String productNo, String productState) {
		super();
		this.productBcTitle = productBcTitle;
		this.productScTitle = productScTitle;
		this.productBrandTitle = productBrandTitle;
		this.productTitle = productTitle;
		this.productEnrollDate = productEnrollDate;
		this.updateDate = updateDate;
		this.productEndDate = productEndDate;
		this.productNo = productNo;
		this.productState = productState;
	}



	public String getProductBcTitle() {
		return productBcTitle;
	}


	public void setProductBcTitle(String productBcTitle) {
		this.productBcTitle = productBcTitle;
	}


	public String getProductScTitle() {
		return productScTitle;
	}


	public void setProductScTitle(String productScTitle) {
		this.productScTitle = productScTitle;
	}


	public String getProductBrandTitle() {
		return productBrandTitle;
	}


	public void setProductBrandTitle(String productBrandTitle) {
		this.productBrandTitle = productBrandTitle;
	}


	public String getProductTitle() {
		return productTitle;
	}


	public void setProductTitle(String productTitle) {
		this.productTitle = productTitle;
	}


	public Date getProductEnrollDate() {
		return productEnrollDate;
	}


	public void setProductEnrollDate(Date productEnrollDate) {
		this.productEnrollDate = productEnrollDate;
	}


	public Date getUpdateDate() {
		return updateDate;
	}


	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}


	public Date getProductEndDate() {
		return productEndDate;
	}


	public void setProductEndDate(Date productEndDate) {
		this.productEndDate = productEndDate;
	}


	public String getProductNo() {
		return productNo;
	}


	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}


	public String getProductState() {
		return productState;
	}


	public void setProductState(String productState) {
		this.productState = productState;
	}


	public String getpEnrollDate() {
		return pEnrollDate;
	}


	public void setpEnrollDate(String pEnrollDate) {
		this.pEnrollDate = pEnrollDate;
	}


	public String getpUpdateDate() {
		return pUpdateDate;
	}


	public void setpUpdateDate(String pUpdateDate) {
		this.pUpdateDate = pUpdateDate;
	}


	public String getpEndDate() {
		return pEndDate;
	}


	public void setpEndDate(String pEndDate) {
		this.pEndDate = pEndDate;
	}


	@Override
	public String toString() {
		return "AdminProduct [productBcTitle=" + productBcTitle + ", productScTitle=" + productScTitle
				+ ", productBrandTitle=" + productBrandTitle + ", productTitle=" + productTitle + ", productEnrollDate="
				+ productEnrollDate + ", updateDate=" + updateDate + ", productEndDate=" + productEndDate
				+ ", productNo=" + productNo + ", productState=" + productState + ", pEnrollDate=" + pEnrollDate
				+ ", pupdateDate=" + pUpdateDate + ", pEndDate=" + pEndDate + "]";
	}


	
}
