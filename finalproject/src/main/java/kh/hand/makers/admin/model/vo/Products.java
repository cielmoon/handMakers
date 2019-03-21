package kh.hand.makers.admin.model.vo;

import java.io.Serializable;

public class Products implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5885493237784270867L;
	private String productNo;
	private String productTitle;
	private String productProfile; // 상품 메인사진[0]~ 옵션사진
	private String productEnrollDate; // 최초 판매 시작 날짜
	private String productUpdate; // 업데이트 날짜
	private String productEndDate; // 판매 종료 날짜
	private String productDetail; // 상품 상세설명
	private String productComment; // 상품 간략설명
	private int productState;
	private int productStep;
	private int productPrice;
	private int productMax;
	private int productMin;
	private String scNo; // 소카테고리 대카테고리 브랜드번호 관리자식별 유저식별 누적판매 현재판매 누적평점
	private String bcNo;
	private String brandNo;
	private String adminNo;
	private String memberNo;
	private int productCurSell; // 현재 누적 판매량
	private int productTotalSell;
	private double productDiscount; // 상품 할인율
	
	public Products() {
		
	}

	@Override
	public String toString() {
		return "Products [productNo=" + productNo + ", productTitle=" + productTitle + ", productProfile="
				+ productProfile + ", productEnrollDate=" + productEnrollDate + ", productUpdate=" + productUpdate
				+ ", productEndDate=" + productEndDate + ", productDetail=" + productDetail + ", productComment="
				+ productComment + ", productState=" + productState + ", productStep=" + productStep + ", productPrice="
				+ productPrice + ", productMax=" + productMax + ", productMin=" + productMin + ", scNo=" + scNo
				+ ", bcNo=" + bcNo + ", brandNo=" + brandNo + ", adminNo=" + adminNo + ", memberNo=" + memberNo
				+ ", productCurSell=" + productCurSell + ", productTotalSell=" + productTotalSell + ", productDiscount="
				+ productDiscount + "]";
	}

	public String getProductNo() {
		return productNo;
	}

	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}

	public String getProductTitle() {
		return productTitle;
	}

	public void setProductTitle(String productTitle) {
		this.productTitle = productTitle;
	}

	public String getProductProfile() {
		return productProfile;
	}

	public void setProductProfile(String productProfile) {
		this.productProfile = productProfile;
	}

	public String getProductEnrollDate() {
		return productEnrollDate;
	}

	public void setProductEnrollDate(String productEnrollDate) {
		this.productEnrollDate = productEnrollDate;
	}

	public String getProductUpdate() {
		return productUpdate;
	}

	public void setProductUpdate(String productUpdate) {
		this.productUpdate = productUpdate;
	}

	public String getProductEndDate() {
		return productEndDate;
	}

	public void setProductEndDate(String productEndDate) {
		this.productEndDate = productEndDate;
	}

	public String getProductDetail() {
		return productDetail;
	}

	public void setProductDetail(String productDetail) {
		this.productDetail = productDetail;
	}

	public String getProductComment() {
		return productComment;
	}

	public void setProductComment(String productComment) {
		this.productComment = productComment;
	}

	public int getProductState() {
		return productState;
	}

	public void setProductState(int productState) {
		this.productState = productState;
	}

	public int getProductStep() {
		return productStep;
	}

	public void setProductStep(int productStep) {
		this.productStep = productStep;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductMax() {
		return productMax;
	}

	public void setProductMax(int productMax) {
		this.productMax = productMax;
	}

	public int getProductMin() {
		return productMin;
	}

	public void setProductMin(int productMin) {
		this.productMin = productMin;
	}

	public String getScNo() {
		return scNo;
	}

	public void setScNo(String scNo) {
		this.scNo = scNo;
	}

	public String getBcNo() {
		return bcNo;
	}

	public void setBcNo(String bcNo) {
		this.bcNo = bcNo;
	}

	public String getBrandNo() {
		return brandNo;
	}

	public void setBrandNo(String brandNo) {
		this.brandNo = brandNo;
	}

	public String getAdminNo() {
		return adminNo;
	}

	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	public int getProductCurSell() {
		return productCurSell;
	}

	public void setProductCurSell(int productCurSell) {
		this.productCurSell = productCurSell;
	}

	public int getProductTotalSell() {
		return productTotalSell;
	}

	public void setProductTotalSell(int productTotalSell) {
		this.productTotalSell = productTotalSell;
	}

	public double getProductDiscount() {
		return productDiscount;
	}

	public void setProductDiscount(double productDiscount) {
		this.productDiscount = productDiscount;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Products(String productNo, String productTitle, String productProfile, String productEnrollDate,
			String productUpdate, String productEndDate, String productDetail, String productComment, int productState,
			int productStep, int productPrice, int productMax, int productMin, String scNo, String bcNo, String brandNo,
			String adminNo, String memberNo, int productCurSell, int productTotalSell, double productDiscount) {
		super();
		this.productNo = productNo;
		this.productTitle = productTitle;
		this.productProfile = productProfile;
		this.productEnrollDate = productEnrollDate;
		this.productUpdate = productUpdate;
		this.productEndDate = productEndDate;
		this.productDetail = productDetail;
		this.productComment = productComment;
		this.productState = productState;
		this.productStep = productStep;
		this.productPrice = productPrice;
		this.productMax = productMax;
		this.productMin = productMin;
		this.scNo = scNo;
		this.bcNo = bcNo;
		this.brandNo = brandNo;
		this.adminNo = adminNo;
		this.memberNo = memberNo;
		this.productCurSell = productCurSell;
		this.productTotalSell = productTotalSell;
		this.productDiscount = productDiscount;
	}
	
	
}
