package kh.hand.makers.product.model.vo;

import java.io.Serializable;
import java.util.Date;

public class Product implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3077995635206426085L;
	
	private String productNo;
	private String productTitle;
	private Date productEnrollDate;
	private Date productUpdateDate;
	private Date productEndDate;
	private String productDetail;
	private String productComment;
	private String productState;
	private String productStep;
	private int productPrice;
	private int productStock;
	private int productMinOrder;
	//소카테고리 대카테고리 브랜드번호 관리자식별 유저식별 누적판매 현재판매 누적평점
	private String productBigCategory;
	private String productSmallCategory;
	private String brandNo;
	private String AdminNo;
	private String MemberNo;
	
	private int sellCount;
	private int sellTotalCount;
	private double productTotalPoint;
	
	
	public Product() {
		
	}
	
	
}
