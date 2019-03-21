package kh.hand.makers.admin.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class NewProduct implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1367871594674030652L;
	private String newProductName;
	private String newProductComment;
	private String newProductAdminNo;
	private String newProductMemberNo;
	private String newProductPrice;
	private String newProductSale;
	private String newProductSaleStart;
	private String newProductSaleEnd;
	private String newProductMin;
	private String newProductMax;
	private String newProductProfileImg;
	private ArrayList<String> newProductDetailImgList = new ArrayList<String>();
	private ArrayList<String> newProductOptionList = new ArrayList<String>();
	private String newProductDetailComments;
	
	private String newProductBrand;
	private String newProductBigCategory;
	private String newProductSmallCategory;	
	private String newProductUpdateDate;	
	private String newProductNo;
	
	public NewProduct() {
	}

	
	public String getNewProductName() {
		return newProductName;
	}

	public void setNewProductName(String newProductName) {
		this.newProductName = newProductName;
	}

	public String getNewProductComment() {
		return newProductComment;
	}

	public void setNewProductComment(String newProductComment) {
		this.newProductComment = newProductComment;
	}

	public String getNewProductAdminNo() {
		return newProductAdminNo;
	}

	public void setNewProductAdminNo(String newProductAdminNo) {
		this.newProductAdminNo = newProductAdminNo;
	}

	public String getNewProductMemberNo() {
		return newProductMemberNo;
	}

	public void setNewProductMemberNo(String newProductMemberNo) {
		this.newProductMemberNo = newProductMemberNo;
	}

	public String getNewProductPrice() {
		return newProductPrice;
	}

	public void setNewProductPrice(String newProductPrice) {
		this.newProductPrice = newProductPrice;
	}

	public String getNewProductSale() {
		return newProductSale;
	}

	public void setNewProductSale(String newProductSale) {
		this.newProductSale = newProductSale;
	}

	public String getNewProductSaleStart() {
		return newProductSaleStart;
	}

	public void setNewProductSaleStart(String newProductSaleStart) {
		this.newProductSaleStart = newProductSaleStart;
	}

	public String getNewProductSaleEnd() {
		return newProductSaleEnd;
	}

	public void setNewProductSaleEnd(String newProductSaleEnd) {
		this.newProductSaleEnd = newProductSaleEnd;
	}

	public String getNewProductMin() {
		return newProductMin;
	}

	public void setNewProductMin(String newProductMin) {
		this.newProductMin = newProductMin;
	}

	public String getNewProductMax() {
		return newProductMax;
	}

	public void setNewProductMax(String newProductMax) {
		this.newProductMax = newProductMax;
	}

	public String getNewProductProfileImg() {
		return newProductProfileImg;
	}

	public void setNewProductProfileImg(String newProductProfileImg) {
		this.newProductProfileImg = newProductProfileImg;
	}

	public ArrayList<String> getNewProductDetailImgList() {
		return newProductDetailImgList;
	}

	public void setNewProductDetailImgList(String detailImg) {
		this.newProductDetailImgList.add(detailImg);
	}

	public ArrayList<String> getNewProductOptionList() {
		return newProductOptionList;
	}

	public void setNewProductOptionList(String option) {
		this.newProductOptionList.add(option);
	}

	public String getNewProductDetailComments() {
		return newProductDetailComments;
	}

	public void setNewProductDetailComments(String newProductDetailComments) {
		this.newProductDetailComments = newProductDetailComments;
	}

	public String getNewProductBrand() {
		return newProductBrand;
	}

	public void setNewProductBrand(String newProductBrand) {
		this.newProductBrand = newProductBrand;
	}

	public String getNewProductBigCategory() {
		return newProductBigCategory;
	}

	public void setNewProductBigCategory(String newProductBigCategory) {
		this.newProductBigCategory = newProductBigCategory;
	}

	public String getNewProductSmallCategory() {
		return newProductSmallCategory;
	}

	public void setNewProductSmallCategory(String newProductSmallCategory) {
		this.newProductSmallCategory = newProductSmallCategory;
	}

	public String getNewProductUpdateDate() {
		return newProductUpdateDate;
	}

	public void setNewProductUpdateDate(String newProductUpdateDate) {
		this.newProductUpdateDate = newProductUpdateDate;
	}

	public String getNewProductNo() {
		return newProductNo;
	}

	public void setNewProductNo(String newProductNo) {
		this.newProductNo = newProductNo;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public NewProduct(String newProductName, String newProductComment, String newProductAdminNo,
			String newProductMemberNo, String newProductPrice, String newProductSale, String newProductSaleStart,
			String newProductSaleEnd, String newProductMin, String newProductMax, String newProductProfileImg,
			ArrayList<String> newProductDetailImgList, ArrayList<String> newProductOptionList,
			String newProductDetailComments, String newProductBrand, String newProductBigCategory,
			String newProductSmallCategory, String newProductUpdateDate, String newProductNo) {
		super();
		this.newProductName = newProductName;
		this.newProductComment = newProductComment;
		this.newProductAdminNo = newProductAdminNo;
		this.newProductMemberNo = newProductMemberNo;
		this.newProductPrice = newProductPrice;
		this.newProductSale = newProductSale;
		this.newProductSaleStart = newProductSaleStart;
		this.newProductSaleEnd = newProductSaleEnd;
		this.newProductMin = newProductMin;
		this.newProductMax = newProductMax;
		this.newProductProfileImg = newProductProfileImg;
		this.newProductDetailImgList = newProductDetailImgList;
		this.newProductOptionList = newProductOptionList;
		this.newProductDetailComments = newProductDetailComments;
		this.newProductBrand = newProductBrand;
		this.newProductBigCategory = newProductBigCategory;
		this.newProductSmallCategory = newProductSmallCategory;
		this.newProductUpdateDate = newProductUpdateDate;
		this.newProductNo = newProductNo;
	}


	@Override
	public String toString() {
		return "NewProduct [newProductName=" + newProductName + ", newProductComment=" + newProductComment
				+ ", newProductAdminNo=" + newProductAdminNo + ", newProductMemberNo=" + newProductMemberNo
				+ ", newProductPrice=" + newProductPrice + ", newProductSale=" + newProductSale
				+ ", newProductSaleStart=" + newProductSaleStart + ", newProductSaleEnd=" + newProductSaleEnd
				+ ", newProductMin=" + newProductMin + ", newProductMax=" + newProductMax + ", newProductProfileImg="
				+ newProductProfileImg + ", newProductDetailImgList=" + newProductDetailImgList
				+ ", newProductOptionList=" + newProductOptionList + ", newProductDetailComments="
				+ newProductDetailComments + ", newProductBrand=" + newProductBrand + ", newProductBigCategory="
				+ newProductBigCategory + ", newProductSmallCategory=" + newProductSmallCategory
				+ ", newProductUpdateDate=" + newProductUpdateDate + ", newProductNo=" + newProductNo + "]";
	}


}