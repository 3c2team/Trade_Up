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
	
	// 상품 가격 가져오기
	String selectProductPrice(int product_num);
	
	// 상품 이름 가져오기
	String selectProductName(int product_num);
	
	// 주소 추가
	int insertAddress(Map<String, String> map);
	
	// 원래 메인 주소 그냥 주소로 변경
	int updateMainAddress(Map<String, String> map);
	
	// 메인 주소 추가
	int insertMainAddress(Map<String, String> map);
	
	// 업페이 잔액 가져오기
	String selectRemainPay(String sId);
	
	// 우리 계좌 정보 들고오기
	Map<String, String> selectOwnerBank(String bank_name);
	
	// 구매자 메인 계좌 정보 가져오기
	Map<String, String> selectMainAccount(String sId);
	
	// 우리 계좌로 돈 입금(무통장 입금)
	int insertDeposit(Map<String, String> map);
	
	// 업페이 충전 내역 여부 확인
	Map<String, String> selectMyUppay(String sId);
	
	// 토큰 정보 가져오기
	Map<String, String> selectTokenInfo(String sId);
	
	// 업페이 자동 충전
	void insertChargeAutoUppay(Map<String, String> map);
	
	// 업페이 자동 결제
	void insertAutoUppay(Map<String, String> map);
	
	// 상품 판매상태 바꾸기
	void updateSalesStatus(@Param("product_num") String product_num, @Param("state") String state);
	
	// 거래 정보 가져오기(WITHDRAW 테이블 접근)
	Map<String, String> selectDealInfo(@Param("product_num") String string);
	
	// 판매자 아이디
	String selectSellerId(@Param("product_num") String string);
	
	// 판매자 정보 가져오기(MY_ACCOUNT 테이블 접근)
	Map<String, String> selectSellerInfo(String sellerId);
	
	// 우리 계좌에서 돈 출금
	int insertWithdraw(Map<String, String> map);
	
	// withdraw 테이블에서 구매 상태 구매확정으로 바꾸기
	void updateDeposit(@Param("product_num") String string);
	
	// 이름 가져오기
	String selectMemberName(String sId);

}
