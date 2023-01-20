package com.nb.web.my.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nb.web.my.dao.MyDAO;
import com.nb.web.my.dto.MyDeliveryInfoDTO;
import com.nb.web.my.dto.MyMainDTO;
import com.nb.web.my.dto.MyWishDTO;

@Service
@Transactional
public class MyPageService {

	@Autowired
	public MyDAO myDao = null;
	
	public MyPageService() {}

	public MyMainDTO getMyMainMenuInfo(String userCode){
		MyMainDTO myData = null;
		
		try {
			myData = this.myDao.getMyMainMenuInfo(userCode);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return myData;
		
	}
	
	public Map<String, Object> getMemberDeliveryInfo(String userCode) throws NamingException{
		Map<String, Object> myData = new HashMap<>();
		List<MyDeliveryInfoDTO> deliveryInfoList = null;
		try {
			deliveryInfoList = this.myDao.getMemberDeliveryInfo(userCode);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		myData.put("delCount", deliveryInfoList == null ? 0 : deliveryInfoList.size());
		myData.put("myData", deliveryInfoList);

		return myData;
	}
	
	
	public int insertMemberDeliveryInfo(MyDeliveryInfoDTO dto) throws NamingException{
		int rowCount = 0;
		
		try {
			if(this.myDao.checkDuplicateDeliveryInfo(dto) > 0) {
				rowCount = -1;
			}else {
				if(dto.getMaDefault() == 1) {
					this.myDao.updateMaDefault(dto.getUserCode());
				}
				rowCount = this.myDao.insertMemberDeliveryInfo(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rowCount;
	}
	
	public int deleteMemberDeliveryInfo(int maSeq) throws NamingException{
		int rowCount = 0;
		try {
			rowCount = this.myDao.deleteMemberDeliveryInfo(maSeq);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rowCount;
	}


	public int updateMemberDeliveryInfo(MyDeliveryInfoDTO dto) throws NamingException{
		int rowCount = 0;
		
		try {
			if(dto.getMaDefault() == 1) {
				this.myDao.updateMaDefault(dto.getUserCode());
			}
			rowCount = this.myDao.updateMemberDeliveryInfo(dto);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rowCount;
	}
	
	public List<MyWishDTO> getMemberWishList(String userCode) throws NamingException {
		List<MyWishDTO> wishList = null;
		try {
			wishList = myDao.getMemberWishList(userCode);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return wishList;
	}
	
	public int deleteWishList(String userCode, String[] wishList) throws NamingException {
		int rowCount = 0;
		try {
			rowCount = this.myDao.deleteWishList(userCode, wishList);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rowCount;
	}

}
