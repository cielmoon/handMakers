package kh.hand.makers.shop.model.vo;

public class BigCategory {
	private String bcNo;
	private String bcTitle;
	
	public BigCategory() {
		super();
	}

	public BigCategory(String bcNo, String bcTitle) {
		super();
		this.bcNo = bcNo;
		this.bcTitle = bcTitle;
	}

	public String getBcNo() {
		return bcNo;
	}

	public void setBcNo(String bcNo) {
		this.bcNo = bcNo;
	}

	public String getBcTitle() {
		return bcTitle;
	}

	public void setBcTitle(String bcTitle) {
		this.bcTitle = bcTitle;
	}
	
	
}
