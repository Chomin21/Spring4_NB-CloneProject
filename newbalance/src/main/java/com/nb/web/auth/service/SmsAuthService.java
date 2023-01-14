package com.nb.web.auth.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Service;

import com.nb.web.auth.dto.AuthInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@Service
public class SmsAuthService {
	public SmsAuthService() {}
	
	public String sendSMS(String receiveNumber, String imsiPwd) throws ClassNotFoundException, JSONException {
		JSONObject aCode = new JSONObject();
		String result = null;
		String content = "[일조 NB-CloneProject] ";
		
		  String hostNameUrl = AuthInfo.getHostnameurl(); 
		  String requestUrl =AuthInfo.getRequesturl(); 
		  String requestUrlType =  AuthInfo.getRequesturltype();
		  String accessKey = AuthInfo.getAccesskey();
		  String secretKey = AuthInfo.getSecretkey();
		  String serviceId =AuthInfo.getServiceid(); 
		  String method = "POST"; // 요청 method 
		  String timestamp = Long.toString(System.currentTimeMillis()); 
		  requestUrl += serviceId + requestUrlType; 
		  String apiUrl = hostNameUrl + requestUrl;
		  
		  // JSON 을 활용한 body data 생성 
		  JSONObject bodyJson = new JSONObject();
		  JSONObject toJson = new JSONObject(); 
		  JSONArray toArr = new JSONArray(); 
		  String authCode;

		  if(imsiPwd.equals("")) {
			  authCode = makeRandomCode();
			  aCode.put("authCode", Base64.getEncoder().encodeToString(authCode.getBytes()));
			 content += "인증번호는 "+authCode+"입니다.";
		  }else {
			  content += "임시 패스워드는 \n" + imsiPwd + "입니다.";
		  }
		  
		  toJson.put("to", receiveNumber);
		  toArr.add(toJson);   
		  bodyJson.put("type", "SMS");
	
		  bodyJson.put("from", "01082417055");
		  bodyJson.put("content", content); 
		  bodyJson.put("messages", toArr);
		  
		  // String body = bodyJson.toJSONString(); 
		  String body = bodyJson.toString();
		  
		  System.out.println(body); 
		  try { 
			  URL url = new URL(apiUrl);
		  HttpURLConnection con = (HttpURLConnection) url.openConnection();
		  con.setUseCaches(false); con.setDoOutput(true); con.setDoInput(true);
		  con.setRequestProperty("content-type", "application/json");
		  con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
		  con.setRequestProperty("x-ncp-iam-access-key", accessKey);
		  con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey)); 
		  //con.setRequestMethod(method);
		// con.setDoOutput(true); 
		  //DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		  
		  //wr.write(body.getBytes()); 
		  //wr.flush(); 
		  //wr.close();
		  
		  
		  int responseCode = con.getResponseCode(); 
		  BufferedReader br;
		  if (responseCode == 202) { // 정상 호출 
			  br = new BufferedReader(new InputStreamReader(con.getInputStream())); 
		}else { // 에러 발생
			br = new BufferedReader(new InputStreamReader(con.getErrorStream())); }
		  
		  String inputLine; StringBuffer response = new StringBuffer(); 
		  while ((inputLine = br.readLine()) != null) 
		  { response.append(inputLine); }
		  br.close(); 
		  System.out.println(response.toString());

		  System.out.println(content);
		
		  aCode.put("result", "00");
		result = aCode.toString();
		} catch (Exception e) {
			aCode.put("result", "99");
			result = aCode.toString();
		}
		  return result;
		
	}

	private String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey)
			throws NoSuchAlgorithmException, InvalidKeyException {
		String space = " "; // one space
		String newLine = "\n"; // new line

		String message = new StringBuilder().append(method).append(space).append(url).append(newLine).append(timestamp)
				.append(newLine).append(accessKey).toString();

		SecretKeySpec signingKey;
		String encodeBase64String;
		try {

			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
			encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		} catch (UnsupportedEncodingException e) {
			encodeBase64String = e.toString();
		}

		return encodeBase64String;
	}

	public String makeRandomCode() {
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		System.out.println("문자인증코드 => " + numStr);

		return numStr;
	}

	public String checkSMS(String sendAuthCode, String inputAuthCode) throws JSONException {
		JSONObject resultJSON = new JSONObject();
		
		if(sendAuthCode == null || inputAuthCode == null 
				|| "".equals(sendAuthCode) || "".equals(inputAuthCode)) {
			resultJSON.put("result", "99");
			return resultJSON.toString();
		}
		

		byte[] decodedBytes = Base64.getDecoder().decode(sendAuthCode);
		String decodedString = new String(decodedBytes);
		System.out.println("디코딩 : "+decodedString);
		
		//인증번호가 일치하는 경우
		if(decodedString.trim().equals(inputAuthCode.trim())) {
			resultJSON.put("result", "00");
		}else {
			resultJSON.put("result", "99");
		}
		return resultJSON.toString();
	}
}
