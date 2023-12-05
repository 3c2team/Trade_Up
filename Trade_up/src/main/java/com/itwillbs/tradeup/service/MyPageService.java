package com.itwillbs.tradeup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.MyPageMapper;

@Service
public class MyPageService {
	@Autowired
	private MyPageMapper mapper;
	// 프로필관리
	public Map<String, Object> getMember(String sId) {
		return mapper.selectMember(sId);
	}
	// 프로필관리 - 정보 수정 (닉네임, 전화번호, 이메일)
	public int myInfoModify(Map<String, Object> param) {
		return mapper.updateMember(param);
	}
	// 계좌관리&배송지관리
	public List<Map<String, Object>> getMemeberInfo(String sId, String table_name, String order_by) {
		return mapper.selectMemberInfo(sId, table_name, order_by);
	}
	public int registMyAddress(Map<String, Object> param) {
		return mapper.insertMyAddress(param);
	}
	// 계좌관리&배송지관리 - 정보 삭제
	public int deleteInfo(Map<String, Object> param) {
		return mapper.deleteInfo(param);
	}
	// 계좌관리&배송지관리 - 메인 변경
	public int changeMainInfo(Map<String, Object> param) {
		return mapper.updateMainInfo(param);
	}
	// 배송지관리 - 정보 수정
	public int updateAddress(Map<String, Object> param) {
		return mapper.updateAddress(param);
	}

}
