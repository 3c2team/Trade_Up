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
	
	// 상품 가격 가져오기
	public String getProductPrice(int product_num) {
		return mapper.selectProductPrice(product_num);
	}
	
	// 상품 이름 가져오기
	public String getProductName(int product_num) {
		return mapper.selectProductName(product_num);
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
	
	// 업페이 잔액 가져오기
	public String getRemainPay(String sId) {
		return mapper.selectRemainPay(sId);
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
	
	// 업페이 충전 내역 여부 확인
	public Map<String, String> getMyUppay(String sId) {
		return mapper.selectMyUppay(sId);
	}
	
	// 토큰 정보 가져오기
	public Map<String, String> getTokenInfo(String sId) {
		return mapper.selectTokenInfo(sId);
	}
	
	// 업페이 자동 충전
	public void chargeAutoUppay(Map<String, String> map) {
		mapper.insertChargeAutoUppay(map);
	}
	
	// 업페이 자동 결제
	public void payAutoUppay(Map<String, String> map) {
		mapper.insertAutoUppay(map);
	}
	
	// 상품 판매상태 거래중으로 바꾸기
	public void updateSalesStatus(String product_num) {
		mapper.updateSalesStatus(product_num);
	}
}
