package com.nb.web.customer.controller;

import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nb.web.auth.dto.UserInfo;

@Controller
@RequestMapping("/customer/*")
public class CustomerController {
	//@Autowired
	//MemberService memberService = null;
	
	public CustomerController() {}
	
	@GetMapping("login.action")
	public String login() {
		System.out.println("GET");
		return "customer.loginForm";
	}
	
	@GetMapping("loginProc.action")
	public String loginProc(@AuthenticationPrincipal UserInfo userInfo) {
		System.out.println("POST");
		System.out.println(userInfo.getUsercode());
		
		
		return "my.main";
	}
	
	@GetMapping("findId.action")
	public String findId() {
		return "customer.findIdForm";
	}
	
	
}
