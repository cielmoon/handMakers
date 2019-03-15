package kh.hand.makers.product.model.vo;

import java.io.Serializable;

public class Wish implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5652125324033186810L;
	private String productNo;
	private String memberNo;
	private String wishState;
	
	public Wish() {
	}

	public Wish(String productNo, String memberNo, String wishState) {
		super();
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.wishState = wishState;
	}

	public String getProductNo() {
		return productNo;
	}

	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	public String getWishState() {
		return wishState;
	}

	public void setWishState(String wishState) {
		this.wishState = wishState;
	}

	@Override
	public String toString() {
		return "Wish [productNo=" + productNo + ", memberNo=" + memberNo + ", wishState=" + wishState + "]";
	}
	
	

}
