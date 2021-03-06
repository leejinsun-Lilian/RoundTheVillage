package com.kh.RoundTheVillage.manager.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.RoundTheVillage.manager.model.vo.ManagerPageInfo;
import com.kh.RoundTheVillage.shop.model.vo.Shop;
import com.kh.RoundTheVillage.shop.model.vo.ShopAttachment;

@Repository
public class ManagerShopDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/**  N 상태인 공방 카운트
	 * @param cp
	 * @return
	 */
	public int getListCount() {
		
		
		return sqlSession.selectOne("shopMapper.getListCount");
	}

	
	/** 신청된 공방 리스트 가져오기
	 * @param pInfo
	 * @param shopNo 
	 * @return
	 */
	public List<Shop> selectList(ManagerPageInfo pInfo) {
		
		int offset = (pInfo.getCurrentPage() - 1) * pInfo.getLimit();

		RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		
		return sqlSession.selectList("shopMapper.selectList",rowBounds);
	}


	/** 공방 내용 가져오기
	 * @param shopNo
	 * @return
	 */
	public Shop selectShop(int shopNo) {
		return sqlSession.selectOne("shopMapper.selectShopManager",shopNo);
		
	}


	public int updateShopFl(int shopNo) {
		return sqlSession.update("shopMapper.updateShopFl",shopNo);
	}


	public ShopAttachment selectThumb(int shopNo) {
		
		return sqlSession.selectOne("shopMapper.selectThumb",shopNo);
	}


	

}
