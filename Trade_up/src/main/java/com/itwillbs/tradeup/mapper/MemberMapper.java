package com.itwillbs.tradeup.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

	// 전화번호로 아이디 찾기
	Map<String, String> selectMemberToPhone(String member_phone_num);
	
	// 아이디로 메일 찾기
	String selectMemberEmail(String member_id);

	// 비밀번호 변경
	int updateMemberPasswd(@Param("member_id") String member_id, @Param("securePasswd") String securePasswd);
	
	// 로그인
	Map<String, String> selectMemberLogin(String member_id);
	
	// 카카오 아이디 유무 확인
	Map<String, String> selectMemberKakaoLogin(String kakao_id);
	
	// 카카오 아이디 업데이트
	int updateKakaoId(@Param("member_id") String member_id, @Param("kakao_id") String kakao_id);
	
	int updateCommission(String merchant_uid);

	Map<String, String> getDangerous(String member_id);

	Map<String, String> getNaverAccessToken(String id);

	int insertNaver(Map<String, String> map);

}
