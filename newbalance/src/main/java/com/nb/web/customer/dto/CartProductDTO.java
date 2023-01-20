package com.nb.web.customer.dto;

import lombok.Data;

@Data
public class CartProductDTO {
	private int cartNum;
	private String userCode;
	private String pdCode;
	private int sizeCode;
	private String color;
	private int cartCount;
	private String pdImage;
	private String pdName;
	private int pdPrice;
	private String size;
	private int maxCount;
}
