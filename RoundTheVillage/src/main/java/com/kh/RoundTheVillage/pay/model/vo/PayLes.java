package com.kh.RoundTheVillage.pay.model.vo;

public class PayLes {
	
	private int lesNo;
	private String lesTitle;
	private int lesPrice;
	private String craftshopName;
	private String fileName;
	
	public PayLes() {}

	public int getLesNo() {
		return lesNo;
	}

	public void setLesNo(int lesNo) {
		this.lesNo = lesNo;
	}

	public String getLesTitle() {
		return lesTitle;
	}

	public void setLesTitle(String lesTitle) {
		this.lesTitle = lesTitle;
	}

	public int getLesPrice() {
		return lesPrice;
	}

	public void setLesPrice(int lesPrice) {
		this.lesPrice = lesPrice;
	}


	public String getCraftshopName() {
		return craftshopName;
	}

	public void setCraftshopName(String craftshopName) {
		this.craftshopName = craftshopName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Override
	public String toString() {
		return "PayLes [lesNo=" + lesNo + ", lesTitle=" + lesTitle + ", lesPrice=" + lesPrice + ", craftshopName="
				+ craftshopName + ", fileName=" + fileName + "]";
	}
}
