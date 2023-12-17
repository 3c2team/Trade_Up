package com.itwillbs.tradeup.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MyPageMapper {
	// 프로필관리
	Map<String, Object> selectMember(String sId);
	// 프로필관리 - 정보 수정 (닉네임, 전화번호, 이메일)
	int updateMember(Map<String, Object> param);
	// 계좌관리 - 계좌 조회
	List<Map<String, Object>> selectAccount(String sId);
	// 배송지관리 - 배송지 조회
	List<Map<String, Object>> selectAddress(String sId);
	// 계좌관리&배송지관리
	List<Map<String, Object>> selectMemberInfo(@Param("sId") String sId, @Param("table_name") String table_name, @Param("order_by") String order_by);
	// 배송지관리 - 배송지 등록
	int insertMyAddress(Map<String, Object> param);
	// 계좌관리&배송지관리 - 정보 삭제
	int deleteInfo(Map<String, Object> param);
	// 계좌관리&배송지관리 - 메인 변경
	int updateMainInfo(Map<String, Object> param);
	// 배송지관리 - 정보 수정
	int updateAddress(Map<String, Object> param);
	// 유저 핀테크 정보
	Map<String, String> selecFintechInfo(String sId);
	// 계좌관리 - 계좌 등록
	int insertMyAccount(Map<String, Object> param);
	// 판매내역 조회
	List<Map<String, Object>> selectMyProduct(String sId);
	// 판매내역 삭제
	int delectProcut(Map<String, Object> param);
	// 관심목록 조회
	List<Map<String, Object>> selectMyFavorite(String sId);
	// 관심목록 삭제
	int deleteFavorite(Map<String, Object> param);
	// 계좌관리 - 계좌 조회
	List<Map<String, Object>> selectMyAccount(String sId);
	// 유저정보 - 탈퇴 사유 조회
	List<Map<String, Object>> selectFeedback();
	// 구매내역 - 내역 조회
	List<Map<String, Object>> selectMyPurchase(String sId);
	// 프로필관리 - 회원 탈퇴 
	int updateDeletMember(Map<String, Object> param);
	// 거래건수 조회
	String selectDepositCount(String sId);
	// 한달 사용금액 
	String selectTotalWithdraw(String sId);
}
