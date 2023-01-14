package com.nb.web.auth.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nb.web.auth.service.SmsAuthService;

import net.sf.json.JSONException;

@RestController
@RequestMapping("/sms/*")
public class RestSmsController {

	@Autowired
	private SmsAuthService smsAuthService = null;
	
	public RestSmsController() {}
	
	
	@PostMapping("registSendAuthNo.ajx")
	public String registSendAuthNo(
						@RequestBody String receiveNumber) throws JSONException, ClassNotFoundException {
		
		
		return this.smsAuthService.sendSMS(receiveNumber, "");
	}
	
	@PostMapping("checkSmsAuthCode.ajx")
	public String checkSmsAuthCode(
						@RequestBody Map<String, String> params) throws JSONException, ClassNotFoundException {
			
		String sendAuthCode = params.get("sendAuthCode");
		String inputAuthCode = params.get("inputAuthCode");
		
		return this.smsAuthService.checkSMS(sendAuthCode, inputAuthCode);
	}
}
