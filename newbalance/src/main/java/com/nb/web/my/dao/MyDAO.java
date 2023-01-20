package com.nb.web.my.dao;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import org.apache.ibatis.annotations.Param;

import com.nb.web.my.dto.MyDeliveryInfoDTO;
import com.nb.web.my.dto.MyMainDTO;
import com.nb.web.my.dto.MyWishDTO;

public interface MyDAO {

	public MyMainDTO getMyMainMenuInfo(String userCode) throws SQLException;
	public List<MyDeliveryInfoDTO> getMemberDeliveryInfo(String userCode) throws SQLException;
	public void updateMaDefault(String userCode) throws SQLException;
	public int insertMemberDeliveryInfo(MyDeliveryInfoDTO dto) throws SQLException;
	public int checkDuplicateDeliveryInfo(MyDeliveryInfoDTO dto ) throws SQLException;
	public int updateMemberDeliveryInfo( MyDeliveryInfoDTO dto) throws SQLException;
	public int deleteMemberDeliveryInfo(int maSeq) throws SQLException;
	public List<MyWishDTO> getMemberWishList(String userCode) throws SQLException;
	public int deleteWishList(@Param("userCode") String userCode, @Param("wishList") String[] wishList) throws SQLException;
}