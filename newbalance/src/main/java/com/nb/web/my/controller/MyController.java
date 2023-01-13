package com.nb.web.my.controller;

import java.util.Map;

import javax.naming.NamingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ctc.wstx.shaded.msv_core.driver.textui.Debug;
import com.nb.web.my.dto.MyDeliveryInfoDTO;
import com.nb.web.my.dto.MyMainDTO;
import com.nb.web.my.service.MyPageService;

@Controller
@RequestMapping("/my/*")
public class MyController {
	
	@Autowired
	MyPageService myPageService = null;
	
	public MyController() {}
	
	@GetMapping("main.action")
	public String myMain(Model model) throws NamingException {
		
		//todo : 나중에 member의 usercode 받아오기. 파라미터 Principal principal 사용.
		
		MyMainDTO myData = myPageService.getMyMainMenuInfo("M1");
		model.addAttribute("myData", myData);
		
		return "customer.myMain";
	}
	
	@GetMapping("memberDeliveryInfo.action")
	public String memberDeliveryInfo(Model model) throws NamingException {
		
		//todo : 나중에 member의 usercode 받아오기. 파라미터 Principal principal 사용.
		Map<String, Object> delData = myPageService.getMemberDeliveryInfo("M1");
			
		model.addAttribute("delData", delData);
		
		return "my.memberDeliveryInfo";
	}
	
	@PostMapping("memberDeliveryInsert.action")
	public String memberDeliveryInsert(Model model) throws NamingException {
		return "my.insertMemberDeliveryInfo";
	}
	
	@PostMapping("memberDeliveryInsertProc.action")
	public String memberDeliveryInsertProc(MyDeliveryInfoDTO myDeliveryInfoDTO, Model model) throws NamingException {
		int rowCount = 0;

		try {			
			myDeliveryInfoDTO.setUserCode("M1");
			myDeliveryInfoDTO.setMaName(myDeliveryInfoDTO.getMaName().trim());
			myDeliveryInfoDTO.setMaZipcode(myDeliveryInfoDTO.getMaZipcode().trim());
			myDeliveryInfoDTO.setMaAddress1(myDeliveryInfoDTO.getMaAddress1().trim());
			myDeliveryInfoDTO.setMaAddress2(myDeliveryInfoDTO.getMaAddress2().trim());
			
			rowCount = myPageService.insertMemberDeliveryInfo(myDeliveryInfoDTO);
		} catch (NamingException e) {
			e.printStackTrace();
		}
			
		model.addAttribute("process", "insert");
		if (rowCount == 1) {
			model.addAttribute("result", "success");
		} else if(rowCount == -1){
			model.addAttribute("result", "duplicate");
		}else {
			model.addAttribute("result", "fail"); 
		}
		
		return "my.confirmMemberDeliveryInfo";
	}
	
	@PostMapping("memberDeliveryDeleteProc.action")
	public String memberDeliveryDeleteProc(@RequestParam (value = "maSeq") int maSeq, Model model) throws NamingException {
		// 회원코드 받기
		int rowCount = 0;
		try {
			rowCount = myPageService.deleteMemberDeliveryInfo(maSeq);
		} catch (NamingException e) {
			e.printStackTrace();
		}
		model.addAttribute("process", "delete");
		if (rowCount == 1) {
			model.addAttribute("result", "success");
		} else {
			model.addAttribute("result", "fail"); 
		}
		
		return "my.confirmMemberDeliveryInfo";
	}
	
	
	@PostMapping("memberDeliveryUpdate.action")
	public String memberDeliveryUpdate(String maPhone, Model model) throws NamingException {
		try {
			String[] cellNos = maPhone.split("-");
			model.addAttribute("cellNo01", cellNos[0]);
			model.addAttribute("cellNo02", cellNos[1]);
			model.addAttribute("cellNo03", cellNos[2]);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		
		return "my.updateMemberDeliveryInfo";
	}
	
	
	@PostMapping("memberDeliveryUpdateProc.action")
	public String memberDeliveryUpdateProc(MyDeliveryInfoDTO myDeliveryInfoDTO, Model model) throws NamingException {
		int rowCount = 0;
		try {
			myDeliveryInfoDTO.setUserCode("M1");
			rowCount = myPageService.updateMemberDeliveryInfo(myDeliveryInfoDTO);
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("process", "update");
		if (rowCount == 1) {
			model.addAttribute("result", "success");
		} else {
			model.addAttribute("result", "fail"); 
		}
		
		return "my.confirmMemberDeliveryInfo";
	}
	
}
