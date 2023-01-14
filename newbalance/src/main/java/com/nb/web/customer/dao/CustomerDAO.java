package com.nb.web.customer.dao;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Param;

public interface CustomerDAO {
	//MemberDTO selectMemberById( String id)  throws SQLException;

	public int updateLastLoginDate(String userCode) throws SQLException;
	
	String selectIdByHp(@Param("custName")String custName, @Param("cellNo")String cellNo) throws SQLException;
	
	
	public int updatePwdById(@Param("custId") String custId, @Param("pwd") String pwd) throws SQLException;
	
	public int getCartCount(String userCode) throws SQLException;
	/*
	public int insert(MemberDTO mem) throws SQLException;

	public int update(MemberDTO mem) throws SQLException;
	
	public int updateCartQty( int cartNum, int cartCount, String userCode) throws SQLException;

	public List<CartOptionDTO> getCartOption( String pdCode) throws SQLException;
	
	public int deleteCartProduct( String userCode, String[] delCartList)  throws SQLException;
	
	public boolean isDuplicateOption( String userCode, String pdCode, int sizeCode) throws SQLException;

	public List<CartProductDTO> getCartList( String userCode) throws SQLException;
	
	public int updateCartOption(int cartNum, String pdCode, int sizeCode, String color) throws SQLException;
	*/
}
