package com.itwillbs.tradeup.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.MemberMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	// 아이디 중복 확인
	public Map<String, String> getMemberDup(String id) {
		return mapper.selectMemberDup(id);
	}
	
	// 메일 중복 판별 처리
	public Map<String, String> getMemberDupMail(Map<String, String> param) {
		return mapper.selectMemberDupMail(param);
	}
	
	// 휴대폰 중복 판별 처리
	public Map<String, String> getMemberDupPhone(String phone_num) {
		return mapper.selectMemberDupPhone(phone_num);
	}
	
	// 회원가입 등록
	public int registMember(Map<String, String> map) {
		return mapper.insertMember(map);
	}
	
	// 로그인
	public Map<String, String> getMemberLogin(String member_id) {
		return mapper.selectMemberLogin(member_id);
	}

	public int updateCommission(String merchant_uid) {
		// TODO Auto-generated method stub
		return mapper.updateCommission(merchant_uid);
	}
}
