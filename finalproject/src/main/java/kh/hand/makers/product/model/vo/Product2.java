package kh.hand.makers.product.model.vo;

import java.io.Serializable;
import java.util.Date;

public class Product2 implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1197587658395152375L;
	
	private String no;
	private String title;
	private Date enrollDate;
	private Date updateDate;
	private Date endDate;
	private String detail;
	private String comment;
	private String state;
	private String step;
	private int price;
	private int stock;
	private int minOrder;
	//소카테고리 대카테고리 브랜드번호 관리자식별 유저식별 누적판매 현재판매 누적평점
	private String bigCategory;
	private String smallCategory;
	private String brandNo;
	private String AdminNo;
	private String MemberNo;
	
	private int sellCount;
	private int sellTotalCount;
	private double totalPoint;
	
	
	public Product2() {
	}


	public Product2(String no, String title, Date enrollDate, Date updateDate, Date endDate, String detail,
			String comment, String state, String step, int price, int stock, int minOrder, String bigCategory,
			String smallCategory, String brandNo, String adminNo, String memberNo, int sellCount, int sellTotalCount,
			double totalPoint) {
		super();
		this.no = no;
		this.title = title;
		this.enrollDate = enrollDate;
		this.updateDate = updateDate;
		this.endDate = endDate;
		this.detail = detail;
		this.comment = comment;
		this.state = state;
		this.step = step;
		this.price = price;
		this.stock = stock;
		this.minOrder = minOrder;
		this.bigCategory = bigCategory;
		this.smallCategory = smallCategory;
		this.brandNo = brandNo;
		AdminNo = adminNo;
		MemberNo = memberNo;
		this.sellCount = sellCount;
		this.sellTotalCount = sellTotalCount;
		this.totalPoint = totalPoint;
	}


	public String getNo() {
		return no;
	}


	public void setNo(String no) {
		this.no = no;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public Date getEnrollDate() {
		return enrollDate;
	}


	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}


	public Date getUpdateDate() {
		return updateDate;
	}


	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}


	public Date getEndDate() {
		return endDate;
	}


	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public String getDetail() {
		return detail;
	}


	public void setDetail(String detail) {
		this.detail = detail;
	}


	public String getComment() {
		return comment;
	}


	public void setComment(String comment) {
		this.comment = comment;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public String getStep() {
		return step;
	}


	public void setStep(String step) {
		this.step = step;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public int getStock() {
		return stock;
	}


	public void setStock(int stock) {
		this.stock = stock;
	}


	public int getMinOrder() {
		return minOrder;
	}


	public void setMinOrder(int minOrder) {
		this.minOrder = minOrder;
	}


	public String getBigCategory() {
		return bigCategory;
	}


	public void setBigCategory(String bigCategory) {
		this.bigCategory = bigCategory;
	}


	public String getSmallCategory() {
		return smallCategory;
	}


	public void setSmallCategory(String smallCategory) {
		this.smallCategory = smallCategory;
	}


	public String getBrandNo() {
		return brandNo;
	}


	public void setBrandNo(String brandNo) {
		this.brandNo = brandNo;
	}


	public String getAdminNo() {
		return AdminNo;
	}


	public void setAdminNo(String adminNo) {
		AdminNo = adminNo;
	}


	public String getMemberNo() {
		return MemberNo;
	}


	public void setMemberNo(String memberNo) {
		MemberNo = memberNo;
	}


	public int getSellCount() {
		return sellCount;
	}


	public void setSellCount(int sellCount) {
		this.sellCount = sellCount;
	}


	public int getSellTotalCount() {
		return sellTotalCount;
	}


	public void setSellTotalCount(int sellTotalCount) {
		this.sellTotalCount = sellTotalCount;
	}


	public double getTotalPoint() {
		return totalPoint;
	}


	public void setTotalPoint(double totalPoint) {
		this.totalPoint = totalPoint;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	@Override
	public String toString() {
		return "Product2 [no=" + no + ", title=" + title + ", enrollDate=" + enrollDate + ", updateDate=" + updateDate
				+ ", endDate=" + endDate + ", detail=" + detail + ", comment=" + comment + ", state=" + state
				+ ", step=" + step + ", price=" + price + ", stock=" + stock + ", minOrder=" + minOrder
				+ ", bigCategory=" + bigCategory + ", smallCategory=" + smallCategory + ", brandNo=" + brandNo
				+ ", AdminNo=" + AdminNo + ", MemberNo=" + MemberNo + ", sellCount=" + sellCount + ", sellTotalCount="
				+ sellTotalCount + ", totalPoint=" + totalPoint + "]";
	}
	
	
}
