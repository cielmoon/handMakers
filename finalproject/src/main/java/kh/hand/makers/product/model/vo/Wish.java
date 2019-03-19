package kh.hand.makers.product.model.vo;

import java.io.Serializable;

public class Wish implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5652125324033186810L;
	private String productNo;
	private String memberNo;
	private String wishNo;
	
	public Wish() {
	}

	public Wish(String productNo, String memberNo, String wishNo) {
		super();
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.wishNo = wishNo;
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

	public String getWishNo() {
		return wishNo;
	}

	public void setWishNo(String wishNo) {
		this.wishNo = wishNo;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memberNo == null) ? 0 : memberNo.hashCode());
		result = prime * result + ((productNo == null) ? 0 : productNo.hashCode());
		result = prime * result + ((wishNo == null) ? 0 : wishNo.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Wish other = (Wish) obj;
		if (memberNo == null) {
			if (other.memberNo != null)
				return false;
		} else if (!memberNo.equals(other.memberNo))
			return false;
		if (productNo == null) {
			if (other.productNo != null)
				return false;
		} else if (!productNo.equals(other.productNo))
			return false;
		if (wishNo == null) {
			if (other.wishNo != null)
				return false;
		} else if (!wishNo.equals(other.wishNo))
			return false;
		return true;
	}

	

}
