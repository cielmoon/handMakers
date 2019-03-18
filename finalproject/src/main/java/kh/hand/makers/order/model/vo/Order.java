package kh.hand.makers.order.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Order implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7856483667830292408L;
	private String orderNo; // 주문번호
	private int orderTotalPrice; // 토탈가격
	private String orderPayType; // 결제타입
	private String orderPayState; //주문상태
	private String productNo; // 상품번호	
	private String memberNo; // 주문 회원
	private String deliveryNo; // 배송지 번호
	private String orderState; //배송상태
	private Date orderDate; // 주문날짜
	private String imp_uid; //아임포트 고유번호
	private String merchant_uid; // 주문고유 번호
	private String productOptionSubject; // 상품 옵션
	private int productOptionQty; // 상품수량
	
	public Order() {
	}

	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", orderTotalPrice=" + orderTotalPrice + ", orderPayType=" + orderPayType
				+ ", orderPayState=" + orderPayState + ", productNo=" + productNo + ", memberNo=" + memberNo
				+ ", deliveryNo=" + deliveryNo + ", orderState=" + orderState + ", orderDate=" + orderDate
				+ ", imp_uid=" + imp_uid + ", merchant_uid=" + merchant_uid + ", productOptionSubject="
				+ productOptionSubject + ", productOptionQty=" + productOptionQty + "]";
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

	public String getOrderPayState() {
		return orderPayState;
	}

	public void setOrderPayState(String orderPayState) {
		this.orderPayState = orderPayState;
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

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
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

	public String getProductOptionSubject() {
		return productOptionSubject;
	}

	public void setProductOptionSubject(String productOptionSubject) {
		this.productOptionSubject = productOptionSubject;
	}

	public int getProductOptionQty() {
		return productOptionQty;
	}

	public void setProductOptionQty(int productOptionQty) {
		this.productOptionQty = productOptionQty;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Order(String orderNo, int orderTotalPrice, String orderPayType, String orderPayState, String productNo,
			String memberNo, String deliveryNo, String orderState, Date orderDate, String imp_uid, String merchant_uid,
			String productOptionSubject, int productOptionQty) {
		super();
		this.orderNo = orderNo;
		this.orderTotalPrice = orderTotalPrice;
		this.orderPayType = orderPayType;
		this.orderPayState = orderPayState;
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.deliveryNo = deliveryNo;
		this.orderState = orderState;
		this.orderDate = orderDate;
		this.imp_uid = imp_uid;
		this.merchant_uid = merchant_uid;
		this.productOptionSubject = productOptionSubject;
		this.productOptionQty = productOptionQty;
	}

		
	
}
