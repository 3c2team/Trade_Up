package com.itwillbs.tradeup.vo;

import lombok.Data;

// 2.1.2. 토큰발급 API 요청 시 요청 파라미터 정보를 관리할 VO 객체
@Data
public class RequestTokenVO {
	private String code;
	private String client_id;
	private String client_secret;
	private String redirect_uri;
	private String grant_type;
}
