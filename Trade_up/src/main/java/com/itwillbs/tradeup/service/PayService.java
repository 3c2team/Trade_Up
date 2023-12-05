package com.itwillbs.tradeup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.PayMapper;

@Service
public class PayService {
	@Autowired
	PayMapper mapper;
	
	// 주소 목록
	public List<Map<String, String>> getMyAddress(String sId) {
		return mapper.selectMyAddress(sId);
	}
	
	// 메인 주소
	public Map<String, String> getMyAddressMain(String sId) {
		return mapper.selectMyAddressMain(sId);
	}
	
	// 주소 추가
	public int insertAddress(Map<String, String> map) {
		return mapper.insertAddress(map);
	}
	
	// 원래 메인 주소 그냥 주소로 변경
	public int updateMainAddress(Map<String, String> map) {
		return mapper.updateMainAddress(map);
	}
	
	// 메인 주소 추가
	public int insertMainAddress(Map<String, String> map) {
		return mapper.insertMainAddress(map);
	}
	
	// 우리 계좌 정보 들고오기
	public Map<String, String> getOwnerBank(String bank_name) {
		return mapper.selectOwnerBank(bank_name);
	}
	
	// 구매자 메인 계좌 정보 가져오기
	public Map<String, String> getMainAccount(String sId) {
		return mapper.selectMainAccount(sId);
	}
	
	// 우리 계좌로 돈 입금(무통장 입금)
	public int insertDeposit(Map<String, String> map) {
		return mapper.insertDeposit(map);
	}
}
