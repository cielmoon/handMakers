package kh.hand.makers.order.model.vo;

import java.io.Serializable;

public class Delivery implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1125983237276001758L;
	private String deliveryNo;
	private String deliveryPostCode;
	private String deliveryAddr;
	private String deliveryDetailAddr;
	private String memberNo;
	
	public Delivery() {
	}

	public Delivery(String deliveryNo, String deliveryPostCode, String deliveryAddr, String deliveryDetailAddr,
			String memberNo) {
		super();
		this.deliveryNo = deliveryNo;
		this.deliveryPostCode = deliveryPostCode;
		this.deliveryAddr = deliveryAddr;
		this.deliveryDetailAddr = deliveryDetailAddr;
		this.memberNo = memberNo;
	}

	public String getDeliveryNo() {
		return deliveryNo;
	}

	public void setDeliveryNo(String deliveryNo) {
		this.deliveryNo = deliveryNo;
	}

	public String getDeliveryPostCode() {
		return deliveryPostCode;
	}

	public void setDeliveryPostCode(String deliveryPostCode) {
		this.deliveryPostCode = deliveryPostCode;
	}

	public String getDeliveryAddr() {
		return deliveryAddr;
	}

	public void setDeliveryAddr(String deliveryAddr) {
		this.deliveryAddr = deliveryAddr;
	}

	public String getDeliveryDetailAddr() {
		return deliveryDetailAddr;
	}

	public void setDeliveryDetailAddr(String deliveryDetailAddr) {
		this.deliveryDetailAddr = deliveryDetailAddr;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	@Override
	public String toString() {
		return "Delivery [deliveryNo=" + deliveryNo + ", deliveryPostCode=" + deliveryPostCode + ", deliveryAddr="
				+ deliveryAddr + ", deliveryDetailAddr=" + deliveryDetailAddr + ", memberNo=" + memberNo + "]";
	}
	
	

}
