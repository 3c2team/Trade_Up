package com.itwillbs.tradeup.vo;

import com.google.protobuf.Timestamp;

import lombok.Data;

@Data
public class WithdrawVO {
	private int withdraw_idx;
	private String owner_bank;
	private String owner_acc;
	private String withdraw_bank; 
	private String withdraw_acc;
	private String commission;
	private String product_price; 
	private String member_id;
	private String method;
	private String buy_check;
	private Timestamp withdraw_date;
	private String member_name;
	private String merchant_uid;
}
