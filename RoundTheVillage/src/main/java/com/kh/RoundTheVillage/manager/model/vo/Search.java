package com.kh.RoundTheVillage.manager.model.vo;

public class Search {
	private String sk;
	private String sv;
	private String ct;
	
	public Search() {
		// TODO Auto-generated constructor stub
	}

	public String getSk() {
		return sk;
	}

	public void setSk(String sk) {
		this.sk = sk;
	}

	public String getSv() {
		return sv;
	}

	public void setSv(String sv) {
		this.sv = sv;
	}

	public String getCt() {
		return ct;
	}

	public void setCt(String ct) {
		this.ct = ct;
	}

	@Override
	public String toString() {
		return "Search [sk=" + sk + ", sv=" + sv + ", ct=" + ct + "]";
	}
	
	
}
