package com.nb.web.customer.dto;

import java.util.List;

import lombok.Data;

@Data
public class CartOptionDTO {
	private String color;
	private String colorUrl;
	private String pdCode;
	private List<CartProductDTO> options;
}