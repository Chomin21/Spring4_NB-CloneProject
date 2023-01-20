package com.nb.web.customer.controller;

import java.util.List;

import javax.naming.NamingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nb.web.auth.dto.UserInfo;
import com.nb.web.customer.dto.CartProductDTO;
import com.nb.web.customer.service.CartService;

@Controller
@RequestMapping("/customer/*")
public class CustomerController {

	@Autowired
	private CartService cartService = null;
	
	public CustomerController() {}
	
	@GetMapping("login.action")
	public String login() {
		System.out.println("GET");
		return "customer.loginForm";
	}
	
	@GetMapping("findId.action")
	public String findId() {
		return "customer.findIdForm";
	}
	
	@GetMapping("cartList.action")
	public String cartList(Authentication authentication, Model model) throws NamingException {
		UserInfo userInfo = (UserInfo) authentication.getPrincipal();
		String userCode = userInfo.getUsercode();
		List<CartProductDTO> cartData = null;
		try {
			cartData = cartService.getCartList(userCode);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("cartData", cartData);
		return "customer.cartList";
	}
	
}
