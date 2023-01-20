package com.nb.web.customer.service;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import org.springframework.beans.factory.annotation.Autowired;

import com.nb.web.customer.dao.CustomerDAO;
import com.nb.web.customer.dto.CartOptionDTO;
import com.nb.web.customer.dto.CartProductDTO;

public class CartService {
	
	@Autowired
	CustomerDAO customerDao = null;
	
	private CartService() {}
	
	public int getCartCount(String userCode) throws NamingException {
		int cartCount;
		try {
			cartCount = customerDao.getCartCount(userCode);
		
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return cartCount;
		
	}
	
	
	public List<CartProductDTO> getCartList(String userCode) throws NamingException {
		List<CartProductDTO> cartList = null;
		try{
			cartList = this.customerDao.getCartList(userCode);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cartList;
	}
	
	public int deleteCartProduct(String userCode, String[] delList) throws NamingException{
		int rowCount = 0;
		try {
			rowCount = customerDao.deleteCartProduct(userCode, delList);
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return rowCount;
	}

	
	public int updateCartQty(String userCode, int cartNum, int cartCount) throws NamingException {
		int rowCount = 0;
		try {
			rowCount = this.customerDao.updateCartQty(cartNum, cartCount, userCode);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rowCount;
	}
	


	public int updateCartOption(CartProductDTO dto) throws NamingException {
		int rowCount = 0;
		
		System.out.println("tttt: " + dto.toString());
		try {
			if(this.customerDao.isDuplicateOption(dto) >= 1) {
				rowCount = 2;
			}else {
				rowCount = this.customerDao.updateCartOption(dto);					
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rowCount;
	}

	public List<CartOptionDTO> getCartOption(String pdCode) throws NamingException {
		List<CartOptionDTO> result = null;
		try {
			result = this.customerDao.getCartOptionPdcode(pdCode);
			System.out.println(result.toString());
			
			for (int i = 0; i < result.size(); i++) {
				List<CartProductDTO> options = this.customerDao.getSizeOption(result.get(i).getPdCode());
				result.get(i).setOptions(options);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
