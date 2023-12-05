package com.itwillbs.tradeup.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PayMapper {
	
	// 주소 목록
	List<Map<String, String>> selectMyAddress(String sId);
	
	// 메인 주소
	Map<String, String> selectMyAddressMain(String sId);
	
	// 주소 추가
	int insertAddress(Map<String, String> map);
	
	// 원래 메인 주소 그냥 주소로 변경
	int updateMainAddress(Map<String, String> map);
	
	// 메인 주소 추가
	int insertMainAddress(Map<String, String> map);
	
	// 우리 계좌 정보 들고오기
	Map<String, String> selectOwnerBank(String bank_name);
	
	// 구매자 메인 계좌 정보 가져오기
	Map<String, String> selectMainAccount(String sId);
	
	// 우리 계좌로 돈 입금(무통장 입금)
	int insertDeposit(Map<String, String> map);

}
