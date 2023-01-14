package com.nb.web.customer.dto;

public class UserDTO {
	private String id;
	private String userCode;
	
	public UserDTO(String id, String userCode) {
		this.id = id;
		this.userCode = userCode;
	}

	public String getId() {
		return id;
	}

	public String getUserCode() {
		return userCode;
	}
}
