package com.nb.web.product.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nb.web.product.dao.ProductDAO;
import com.nb.web.product.dto.WishlistDTO;

@Service
@Transactional
public class ProductService {
	
	@Autowired
	public ProductDAO productDAO = null;
	
	public ProductService() {}
	
	public int addWishlist(WishlistDTO dto){
		
		int count = 0;
	    int rowCount = 0;
	      
	    try {
	    	count = this.productDAO.wishDuplicateCheck(dto);
	    	if(count == 0) {
	    		rowCount = this.productDAO.addWishlist(dto);
	    		
	    	}else {
				rowCount = 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	      
	      return rowCount;
	   }
}
