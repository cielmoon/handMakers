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
	private String newProductAdminId;
	private String newProductMemberId;
	private int newProductPrice;
	private int newProductSale;
	private String newProductSaleStart;
	private String newProductSaleEnd;
	private int newProductMin;
	private int newProductMax;
	private String newProductProfileImg;
	private List<String> newProductDetailImgList = new ArrayList<String>();
	private List<String> newProductOptionList = new ArrayList<String>();
	private String newProductDetailComments;
	
	private String newProductBrand;
	private String newProductBigCategory;
	private String newProductSmallCategory;
	
	private String newProductUpdateDate;
	
	private String newProductNo;
	
	public NewProduct() {
	}

	public NewProduct(String newProductName, String newProductComment, String newProductAdminId,
			String newProductMemberId, int newProductPrice, int newProductSale, String newProductSaleStart,
			String newProductSaleEnd, int newProductMin, int newProductMax, String newProductProfileImg,
			List<String> newProductDetailImgList, List<String> newProductOptionList, String newProductDetailComments,
			String newProductBrand, String newProductBigCategory, String newProductSmallCategory,
			String newProductUpdateDate, String newProductNo) {
		super();
		this.newProductName = newProductName;
		this.newProductComment = newProductComment;
		this.newProductAdminId = newProductAdminId;
		this.newProductMemberId = newProductMemberId;
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

	
	
	public String getNewProductAdminId() {
		return newProductAdminId;
	}



	public void setNewProductAdminId(String newProductAdminId) {
		this.newProductAdminId = newProductAdminId;
	}



	public String getNewProductMemberId() {
		return newProductMemberId;
	}

	public void setNewProductMemberId(String newProductMemberId) {
		this.newProductMemberId = newProductMemberId;
	}


	public int getNewProductPrice() {
		return newProductPrice;
	}

	public void setNewProductPrice(int newProductPrice) {
		this.newProductPrice = newProductPrice;
	}

	public int getNewProductSale() {
		return newProductSale;
	}

	public void setNewProductSale(int newProductSale) {
		this.newProductSale = newProductSale;
	}

	public int getNewProductMin() {
		return newProductMin;
	}

	public void setNewProductMin(int newProductMin) {
		this.newProductMin = newProductMin;
	}

	public int getNewProductMax() {
		return newProductMax;
	}

	public void setNewProductMax(int newProductMax) {
		this.newProductMax = newProductMax;
	}

	public String getNewProductProfileImg() {
		return newProductProfileImg;
	}

	public void setNewProductProfileImg(String newProductProfileImg) {
		this.newProductProfileImg = newProductProfileImg;
	}

	public List<String> getNewProductDetailImgList() {
		return newProductDetailImgList;
	}

	public void setNewProductDetailImgList(String newProductDetailImgt) {
		this.newProductDetailImgList.add(newProductDetailImgt);
	}

	public List<String> getNewProductOptionList() {
		return newProductOptionList;
	}

	public void setNewProductOptionList(String newProductOption) {
		this.newProductOptionList.add(newProductOption);
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

	

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	

	public String getNewProductNo() {
		return newProductNo;
	}

	public void setNewProductNo(String newProductNo) {
		this.newProductNo = newProductNo;
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

	public String getNewProductUpdateDate() {
		return newProductUpdateDate;
	}

	public void setNewProductUpdateDate(String newProductUpdateDate) {
		this.newProductUpdateDate = newProductUpdateDate;
	}

	@Override
	public String toString() {
		return "NewProduct [newProductName=" + newProductName + ", newProductComment=" + newProductComment
				+ ", newProductAdminId=" + newProductAdminId + ", newProductMemberId=" + newProductMemberId
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