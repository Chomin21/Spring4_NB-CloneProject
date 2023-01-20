package com.nb.web.customer.controller;

import java.util.List;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nb.web.auth.dto.UserInfo;
import com.nb.web.auth.service.SmsAuthService;
import com.nb.web.customer.dto.CartOptionDTO;
import com.nb.web.customer.dto.CartProductDTO;
import com.nb.web.customer.service.CartService;
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
	private CartService cartService = null;
	
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
			resultJSON.put("result", "99");
		}
		return resultJSON.toString();
	}
	
	@PostMapping("deleteCartProduct.ajx")
	public String deleteCartProduct(@RequestBody Map<String, String[]> delList
			, Authentication authentication
			, Model model
			, HttpServletRequest request){
		
		JSONObject resultJSON = new JSONObject();
		
		try {
			UserInfo userInfo = (UserInfo) authentication.getPrincipal();
			String userCode = userInfo.getUsercode();
			int rowCount = cartService.deleteCartProduct(userCode, delList.get("delList"));
			int cartCount = cartService.getCartCount(userCode);
			request.getSession().setAttribute("cartCount", cartCount);
			
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
	
	@PostMapping("updateCartQty.ajx")
	public String updateCartQty(@RequestBody Map<String, Integer> params
			, Authentication authentication
			, Model model){
		
		JSONObject resultJSON = new JSONObject();
		
		int cartNum = params.get("cartNum");
		int cartCount = params.get("qty");

		int rowCount = 0;

		try {
			UserInfo userInfo = (UserInfo) authentication.getPrincipal();
			String userCode = userInfo.getUsercode();
			rowCount = cartService.updateCartQty(userCode, cartNum, cartCount);
	
			if(rowCount >= 1) {
				resultJSON.put("result", "00");			
			} else {
				resultJSON.put("result", "99");		
			}
		}catch (Exception e) {
			e.printStackTrace();
		}

		return resultJSON.toString();
	
	}
	
	@PostMapping("updateCartOption.ajx")
	public String updateCartOption(@RequestBody CartProductDTO dto
			, Authentication authentication
		) throws Exception {
		JSONObject resultJSON = new JSONObject();
		
		int result = 0;
		try {
			UserInfo userInfo = (UserInfo) authentication.getPrincipal();
			String userCode = userInfo.getUsercode();
			dto.setUserCode(userCode);
			
			result = cartService.updateCartOption(dto);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		if(result == 1) {
			resultJSON.put("result", "00");			
		} else if(result == 2){ //동일 옵션이 장바구니에 존재하는 경우
			resultJSON.put("result", "22");		
		} else {
			resultJSON.put("result", "99");		
		}

		return resultJSON.toString();
		
	}
	
	@PostMapping("getCartOption.ajx")
	public String getCartOption(@RequestBody Map<String, String> param
			, Model model) throws Exception {
		JSONObject resultJSON = new JSONObject();
		List<CartOptionDTO> result = null;
		
		try {
			result = cartService.getCartOption(param.get("pdCode"));

			resultJSON.put("result", result);	
		}catch (Exception e) {
			e.printStackTrace();
		}

		return resultJSON.toString();
		
	}
	
	
	
}
