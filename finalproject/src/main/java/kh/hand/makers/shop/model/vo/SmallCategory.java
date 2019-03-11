package kh.hand.makers.shop.model.vo;

public class SmallCategory {
	private String scNo;
	private String scTitle;
	private String bcNo;
	public SmallCategory() {
		super();
	}
	public SmallCategory(String scNo, String scTitle, String bcNo) {
		super();
		this.scNo = scNo;
		this.scTitle = scTitle;
		this.bcNo = bcNo;
	}
	public String getScNo() {
		return scNo;
	}
	public void setScNo(String scNo) {
		this.scNo = scNo;
	}
	public String getScTitle() {
		return scTitle;
	}
	public void setScTitle(String scTitle) {
		this.scTitle = scTitle;
	}
	public String getBcNo() {
		return bcNo;
	}
	public void setBcNo(String bcNo) {
		this.bcNo = bcNo;
	}
}
