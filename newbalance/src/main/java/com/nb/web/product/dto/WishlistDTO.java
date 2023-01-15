package com.nb.web.product.dto;

import lombok.Data;

@Data
public class WishlistDTO {

	private int wishCode;
	private String[] pdCode;
	private String userCode;
}
