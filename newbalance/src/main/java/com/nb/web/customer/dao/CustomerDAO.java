package com.nb.web.customer.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nb.web.customer.dto.CartOptionDTO;
import com.nb.web.customer.dto.CartProductDTO;

public interface CustomerDAO {
	
	public int updateLastLoginDate(String userCode) throws SQLException;
	
	String selectIdByHp(@Param("custName")String custName, @Param("cellNo")String cellNo) throws SQLException;
	
	public int updatePwdById(@Param("custId") String custId, @Param("pwd") String pwd) throws SQLException;
	
	public int getCartCount(String userCode) throws SQLException;
	
	public List<CartProductDTO> getCartList(String userCode) throws SQLException;
	
	public int deleteCartProduct(@Param("userCode") String userCode, @Param("delList") String[] delList)  throws SQLException;
	
	public int updateCartQty(@Param("cartNum") int cartNum, @Param("cartCount") int cartCount,@Param("userCode") String userCode) throws SQLException;

	// 컬러명, 컬러 이미지, 상품코드 추출 
	public List<CartOptionDTO> getCartOptionPdcode( String pdCode) throws SQLException;
	
	// 상품코드에 따른 사이즈별 재고
	public List<CartProductDTO> getSizeOption(String pdCode) throws SQLException;
	
	public int getCartOptionCount(String pdCode) throws SQLException;
	
	public int isDuplicateOption(CartProductDTO dto) throws SQLException;

	public int updateCartOption(CartProductDTO dto) throws SQLException;
	
}
