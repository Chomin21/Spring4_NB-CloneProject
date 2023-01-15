package com.nb.web.my.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nb.web.auth.dto.UserInfo;
import com.nb.web.my.service.MyPageService;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/my/*")
public class RestMyController {

	@Autowired
	private MyPageService myPageService = null;
	
	public RestMyController() {}
	
	@PostMapping("deleteWishList.ajx")
	public String registSendAuthNo(
			 			@RequestBody Map<String, String[]> wishList
						, Authentication authentication
						, Model model) throws JSONException, ClassNotFoundException {
		JSONObject resultJSON = new JSONObject();
		try {
			System.out.println(wishList.toString());

			
			UserInfo userInfo = (UserInfo) authentication.getPrincipal();
			String userCode = userInfo.getUsercode();
			
			int rowCount = this.myPageService.deleteWishList(userCode, wishList.get("wishList"));

			if (rowCount >= 1) {
				resultJSON.put("result", "00");
			}else {
				resultJSON.put("result", "99");
			}
			System.out.println(resultJSON.toString());


		} catch (Exception e) {
			model.addAttribute("result", 99); 
		}

		return resultJSON.toString();
	}
}
