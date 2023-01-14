package com.nb.web.customer.controller;

import java.util.Map;

import javax.naming.NamingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nb.web.auth.service.SmsAuthService;
import com.nb.web.customer.service.CustomerService;
import com.nb.web.customer.service.FindIdFailException;
import com.nb.web.customer.service.UpdatePwdFailException;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/customer/*")
public class RestCustomerController {
	
	@Autowired
	private CustomerService customerService = null;
	
	@Autowired
	private SmsAuthService smsAuthService = null;
	
	public RestCustomerController() {}
	
	@PostMapping("getFindMemberIdHp.ajx")
	public String registSendAuthNo(
						@RequestBody Map<String, String> params) throws JSONException, ClassNotFoundException, NamingException {
		
		
		JSONObject resultJSON = new JSONObject();

		try {	
			String custName = params.get("custName");
			String cellNo = params.get("cellNo");
			
			String id = customerService.findId(custName, cellNo);

			resultJSON.put("result", "00");
			resultJSON.put("custId", id);
		} catch( FindIdFailException e) {
			System.out.println(e.getMessage());
			resultJSON.put("result", "99");
		}
		return resultJSON.toString();
	}
	
	@PostMapping("getImsiPwd.ajx")
	public String getImsiPwd(
						@RequestBody Map<String, String> params) throws JSONException, ClassNotFoundException, NamingException {
		
		JSONObject resultJSON = new JSONObject();

		try {	
			String custId = params.get("custId");
			String cellNo = params.get("cellNo").replaceAll("-", "");
			
			String imsiPwd = customerService.setImsiPwd(custId);

			return smsAuthService.sendSMS(cellNo, imsiPwd);
		} catch( UpdatePwdFailException e) {
			System.out.println(e.getMessage());
			resultJSON.put("result", "99");
		}
		return resultJSON.toString();
	}
	
}
