package com.itwillbs.tradeup.vo;

import java.util.List;
import lombok.Data;

@Data
public class ResponseAccountListVO {
	private String api_tran_id;
	private String api_tran_dtm;
	private String rsp_code;
	private String rsp_message;
	private String user_name;
	private String res_cnt;
	private List<BankAccountVO> res_list;
}
