package com.itwillbs.tradeup.vo;

import java.util.List;

import lombok.Data;

//2.2. 사용자/서비스 관리 - 2.2.1. 사용자정보조회 API 응답 결과를 관리할 클래스 정의
@Data
public class ResponseUserInfoVO {
	private String api_tran_id;
	private String api_tran_dtm;
	private String rsp_code;    // 요청에 대한 결과 응답 코드
	private String rsp_message; // 요청에 대한 결과 응답 메세지
	private String user_seq_no; // 사용자 번호(고객마다 다른 고정값)
	private String user_ci;     // 사용자 연결 정보(고객마다 다른 고정값)
	private String user_name;
	private String user_info;
	private String user_gender;
	private String user_cell_no;
	private String user_email;
	private String res_cnt;
	// 사용자 계좌목록을 1개 저장하는 BankAccountVO 객체를 담는 List 타입 멤버변수 선언
	private List<BankAccountVO> res_list;
	// => Gson 라이브러리를 통해 JSON 타입 데이터가 자동으로 파싱됨
	//    이 때, List 객체에 저장될 BankAccountVO 타입에 계좌 목록들이 1개 객체씩 자동으로 파싱
}








