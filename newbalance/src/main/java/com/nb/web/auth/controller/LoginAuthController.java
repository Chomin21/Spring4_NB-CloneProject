package com.nb.web.auth.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.transaction.annotation.Transactional;

import com.nb.web.auth.dto.UserInfo;
import com.nb.web.customer.dto.UserDTO;
import com.nb.web.customer.service.CartService;
import com.nb.web.customer.service.CustomerService;

public class LoginAuthController implements AuthenticationSuccessHandler{

	@Autowired
	CustomerService customerService = null;
	
	@Autowired
	CartService cartService = null;
	
	private RequestCache requestCache = new HttpSessionRequestCache();
    private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		UserInfo userInfo = (UserInfo) authentication.getPrincipal();
		String userCode = userInfo.getUsercode();

		int cartCount = customerService.login(userCode);
		
		request.getSession().setAttribute("cartCount", cartCount);

		resultRedirectStrategy(request, response, authentication);
	}
	
	 protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
	            Authentication authentication) throws IOException, ServletException {
	        
	        SavedRequest savedRequest = requestCache.getRequest(request, response);
	        
	        if(savedRequest!=null) {
	            String targetUrl = savedRequest.getRedirectUrl();
	            redirectStratgy.sendRedirect(request, response, targetUrl);
	        } else {
	            redirectStratgy.sendRedirect(request, response,"/index.action");
	        }
	        
	    }

}
