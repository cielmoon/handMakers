package kh.hand.makers.admin.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class AdminProduct implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2621441858268751377L;
	private String productBcTitle;
	private String productScTitle;
	private String productBrandTitle;
	private String productTitle;
	private Date productEnrollDate;
	private Date productEndDate;
	private String productNo;
	
	public AdminProduct() {
		
	}

	public AdminProduct(String productBcTitle, String productScTitle, String productBrandTitle, String productTitle,
			Date productEnrollDate, Date productEndDate, String productNo) {
		super();
		this.productBcTitle = productBcTitle;
		this.productScTitle = productScTitle;
		this.productBrandTitle = productBrandTitle;
		this.productTitle = productTitle;
		this.productEnrollDate = productEnrollDate;
		this.productEndDate = productEndDate;
		this.productNo = productNo;
	}

	@Override
	public String toString() {
		return "AdminProduct [productBcTitle=" + productBcTitle + ", productScTitle=" + productScTitle
				+ ", productBrandTitle=" + productBrandTitle + ", productTitle=" + productTitle + ", productEnrollDate="
				+ productEnrollDate + ", productEndDate=" + productEndDate + ", productNo=" + productNo + "]";
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
