package kh.hand.makers.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class ManageOrder implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 281270844649169809L;
	private String orderNo; // 주문번호
	private String productName; //상품명
	private String productOption; // 상품 옵션
	private int productOptionQty; // 상품수량
	private int orderTotalPrice; // 토탈가격
	private Date orderDate; // 주문날짜
	private String orderState; //배송상태
	private String orderPayState; //주문상태
	private String imp_uid; //고유 번호
	
	public ManageOrder() {
		
	}

	public ManageOrder(String orderNo, String productName, String productOption, int productOptionQty,
			int orderTotalPrice, Date orderDate, String orderState, String orderPayState, String imp_uid) {
		super();
		this.orderNo = orderNo;
		this.productName = productName;
		this.productOption = productOption;
		this.productOptionQty = productOptionQty;
		this.orderTotalPrice = orderTotalPrice;
		this.orderDate = orderDate;
		this.orderState = orderState;
		this.orderPayState = orderPayState;
		this.imp_uid = imp_uid;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
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

	public int getOrderTotalPrice() {
		return orderTotalPrice;
	}

	public void setOrderTotalPrice(int orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public String getOrderPayState() {
		return orderPayState;
	}

	public void setOrderPayState(String orderPayState) {
		this.orderPayState = orderPayState;
	}

	public String getImp_uid() {
		return imp_uid;
	}

	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "ManageOrder [orderNo=" + orderNo + ", productName=" + productName + ", productOption=" + productOption
				+ ", productOptionQty=" + productOptionQty + ", orderTotalPrice=" + orderTotalPrice + ", orderDate="
				+ orderDate + ", orderState=" + orderState + ", orderPayState=" + orderPayState + ", imp_uid=" + imp_uid
				+ "]";
	}

	
}
