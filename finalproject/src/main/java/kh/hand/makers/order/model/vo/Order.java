package kh.hand.makers.order.model.vo;

import java.io.Serializable;

public class Order implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7856483667830292408L;
	private String orderNo; // 주문번호
	private int orderTotalPrice; // 토탈가격
	private String orderPayType; // 결제타입
	private String productNo; // 상품번호
	private String memberNo; // 주문 회원
	private String deliveryNo; // 배송지 번호
	private String orderDate; // 주문날짜
	private String imp_uid; //아임포트 고유번호
	private String merchant_uid; // 주문고유 번호
	private String productOption; // 상품 옵션
	private int productOptionQty; // 상품수량
	private String orderPayStatus;//주문상태
	
	public Order() {
	}

	public Order(String orderNo, int orderTotalPrice, String orderPayType, String productNo, String memberNo,
			String deliveryNo, String orderDate, String imp_uid, String merchant_uid, String productOption,
			int productOptionQty, String orderPayStatus) {
		super();
		this.orderNo = orderNo;
		this.orderTotalPrice = orderTotalPrice;
		this.orderPayType = orderPayType;
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.deliveryNo = deliveryNo;
		this.orderDate = orderDate;
		this.imp_uid = imp_uid;
		this.merchant_uid = merchant_uid;
		this.productOption = productOption;
		this.productOptionQty = productOptionQty;
		this.orderPayStatus = orderPayStatus;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public int getOrderTotalPrice() {
		return orderTotalPrice;
	}

	public void setOrderTotalPrice(int orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
	}

	public String getOrderPayType() {
		return orderPayType;
	}

	public void setOrderPayType(String orderPayType) {
		this.orderPayType = orderPayType;
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

	public String getDeliveryNo() {
		return deliveryNo;
	}

	public void setDeliveryNo(String deliveryNo) {
		this.deliveryNo = deliveryNo;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getImp_uid() {
		return imp_uid;
	}

	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}

	public String getMerchant_uid() {
		return merchant_uid;
	}

	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}

	public String getProductOption() {
		return productOption;
	}

	public void setProductOption(String productOption) {
		this.productOption = productOption;
	}

	public int getProductOptionQty() {
		return productOptionQty;
	}

	public void setProductOptionQty(int productOptionQty) {
		this.productOptionQty = productOptionQty;
	}

	public String getOrderPayStatus() {
		return orderPayStatus;
	}

	public void setOrderPayStatus(String orderPayStatus) {
		this.orderPayStatus = orderPayStatus;
	}

	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", orderTotalPrice=" + orderTotalPrice + ", orderPayType=" + orderPayType
				+ ", productNo=" + productNo + ", memberNo=" + memberNo + ", deliveryNo=" + deliveryNo + ", orderDate="
				+ orderDate + ", imp_uid=" + imp_uid + ", merchant_uid=" + merchant_uid + ", productOption="
				+ productOption + ", productOptionQty=" + productOptionQty + ", orderPayStatus=" + orderPayStatus + "]";
	}
	
		
	
}
