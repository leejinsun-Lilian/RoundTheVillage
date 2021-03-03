package com.kh.RoundTheVillage.pay.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.RoundTheVillage.pay.model.vo.Coupon;
import com.kh.RoundTheVillage.pay.model.vo.Pay;
import com.kh.RoundTheVillage.pay.model.vo.PayLes;
import com.kh.RoundTheVillage.board.model.vo.PageInfo;
import com.kh.RoundTheVillage.lesson.model.vo.Lesson;

@Repository
public class PayDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Coupon> selectCupon(int memNo) {
		return sqlSession.selectList("payMapper.selectCupon", memNo);
	}
	
	public PayLes selectLesson(int lesNo) {
		return sqlSession.selectOne("payMapper.selectLesson", lesNo);
	}
	
	public int insertPay(Pay pay) {
		return sqlSession.insert("payMapper.insertPay", pay);
	}
	
	public Pay selectPayByUid(String impUid) {
		return sqlSession.selectOne("payMapper.selectPayByUid", impUid);
	}

	public int getListCount(int memNo) {
		return sqlSession.selectOne("payMapper.getListCount", memNo);
	}

	public List<Pay> selectList(PageInfo pInfo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("payMapper.selectList", 1, rowBounds);
	}
	
	public Pay selectPay(int payNo) {
		return sqlSession.selectOne("payMapper.selectPay", payNo);
	}
}
