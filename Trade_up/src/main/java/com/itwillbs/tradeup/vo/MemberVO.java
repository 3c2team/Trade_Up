package com.itwillbs.tradeup.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	private int member_num;
	private String member_name;
	private String member_nick_name;
	private String member_id;
	private String member_passwd;
	private String postcode;
	private String member_address;
	private String member_address1;
	private String member_address2;
	private String member_e_mail;
	private String member_email1;
	private String member_email2;
	private Timestamp member_insert_date;
	private int member_point;
	private String member_phone_num;
	private Date member_birth;
	private String member_gender;
	private String mail_auth_status;
	private String kakao_id;
	private String naver_id;
	private String member_state;
}
