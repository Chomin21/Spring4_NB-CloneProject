package com.nb.web.product.dao;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Param;

import com.nb.web.product.dto.WishlistDTO;

public interface ProductDAO {
	public int addWishlist(@Param("dto") WishlistDTO dto) throws SQLException;
	
	public int wishDuplicateCheck(@Param("dto") WishlistDTO dto) throws SQLException;
}
