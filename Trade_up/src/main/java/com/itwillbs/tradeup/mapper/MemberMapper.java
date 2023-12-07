package com.itwillbs.tradeup.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	// 아이디 중복
	Map<String, String> selectMemberDup(String id);
	
	// 메일 중복
	Map<String, String> selectMemberDupMail(Map<String, String> param);
	
	// 휴대폰 중복
	Map<String, String> selectMemberDupPhone(String phone_num);
	
	// 회원가입 등록
	int insertMember(Map<String, String> map);
	
	// 로그인
	Map<String, String> selectMemberLogin(String member_id);

	int updateCommission(String merchant_uid);
}
