package com.kh.RoundTheVillage.pay.model.vo;

import java.sql.Date;

public class Coupon {
	private int couponNo;
	private String couponName;
	private double discount;
	private Date issueDate;
	private Date expireDate;
	private Date useDate;
	private char uesFl;
	private int memNo;
	
	public Coupon() {}

	public int getCouponNo() {
		return couponNo;
	}

	public void setCouponNo(int couponNo) {
		this.couponNo = couponNo;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public Date getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	public Date getUseDate() {
		return useDate;
	}

	public void setUseDate(Date useDate) {
		this.useDate = useDate;
	}

	public char getUesFl() {
		return uesFl;
	}

	public void setUesFl(char uesFl) {
		this.uesFl = uesFl;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	@Override
	public String toString() {
		return "Coupon [couponNo=" + couponNo + ", couponName=" + couponName + ", discount=" + discount + ", issueDate="
				+ issueDate + ", expireDate=" + expireDate + ", useDate=" + useDate + ", uesFl=" + uesFl + ", memNo="
				+ memNo + "]";
	}
}
