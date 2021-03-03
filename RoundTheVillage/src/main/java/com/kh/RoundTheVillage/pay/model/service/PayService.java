package com.kh.RoundTheVillage.pay.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.RoundTheVillage.pay.model.dao.PayDAO;
import com.kh.RoundTheVillage.pay.model.vo.Coupon;
import com.kh.RoundTheVillage.pay.model.vo.Pay;
import com.kh.RoundTheVillage.pay.model.vo.PayLes;
import com.kh.RoundTheVillage.board.model.vo.PageInfo;
import com.kh.RoundTheVillage.lesson.model.vo.Lesson;

@Service
public class PayService {

	@Autowired
	private PayDAO dao;
	
	public List<Coupon> selectCupon(int memNo) {
		return dao.selectCupon(memNo);
	}
	
	public PayLes selectLesson(int lesNo) {
		return dao.selectLesson(lesNo);
	}
	
	@Transactional(rollbackFor = Exception.class)
	public int insertPay(Pay pay) {
		return dao.insertPay(pay);
	}
	
	public Pay selectPayByUid(String impUid) {
		return dao.selectPayByUid(impUid);
	}

	public PageInfo getPageInfo(int memNo, int cp) {
		int listCount = dao.getListCount(memNo);
		return new PageInfo(cp, listCount, memNo);
	}

	public List<Pay> selectList(PageInfo pInfo) {
		return dao.selectList(pInfo);
	}
	
	public Pay selectPay(int payNo) {
		return dao.selectPay(payNo);
	}
}