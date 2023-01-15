package com.nb.web.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nb.web.auth.dto.UserInfo;
import com.nb.web.product.dto.WishlistDTO;
import com.nb.web.product.service.ProductService;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("/product/*")
public class RestProductController {
	@Autowired
	private ProductService productService = null;
	
	public RestProductController() {}
	
	@PostMapping("wishList.ajx")
	public String addWishList(@RequestBody WishlistDTO wishList
			, Authentication authentication
			, Model model) throws Exception {
		
		JSONObject resultJSON = new JSONObject();
		
		try {
			UserInfo userInfo = (UserInfo) authentication.getPrincipal();
			String userCode = userInfo.getUsercode();
			
			wishList.setUserCode(userCode);  
			
			int rowCount = this.productService.addWishlist(wishList);

			if (rowCount >= 1) {
				resultJSON.put("result", "00");
			}else {
				resultJSON.put("result", "99");
			}
		} catch (Exception e) {
			model.addAttribute("result", "99") ; 
		}
		
		return resultJSON.toString();
	
	}
}





