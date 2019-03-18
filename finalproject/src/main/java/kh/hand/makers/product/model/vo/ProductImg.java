package kh.hand.makers.product.model.vo;

import java.io.Serializable;

public class ProductImg implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2575576172872624612L;
	private String productImgNo;
	private String productSubImg;
	private String productNo;
	
	public ProductImg() {
	}

	public ProductImg(String productImgNo, String productSubImg, String productNo) {
		super();
		this.productImgNo = productImgNo;
		this.productSubImg = productSubImg;
		this.productNo = productNo;
	}

	public String getProductImgNo() {
		return productImgNo;
	}

	public void setProductImgNo(String productImgNo) {
		this.productImgNo = productImgNo;
	}

	public String getProductSubImg() {
		return productSubImg;
	}

	public void setProductSubImg(String productSubImg) {
		this.productSubImg = productSubImg;
	}

	public String getProductNo() {
		return productNo;
	}

	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}

	@Override
	public String toString() {
		return "ProductImg [productImgNo=" + productImgNo + ", productSubImg=" + productSubImg + ", productNo="
				+ productNo + "]";
	}
	
	

}
