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
	
	List<Map<String, Object>> selectAccount(String sId);

	List<Map<String, Object>> selectAddress(String sId);
	// 계좌관리&배송지관리
	List<Map<String, Object>> selectMemberInfo(@Param("sId") String sId, @Param("table_name") String table_name, @Param("order_by") String order_by);
	
	int insertMyAddress(Map<String, Object> param);
	// 계좌관리&배송지관리 - 정보 삭제
	int deleteInfo(Map<String, Object> param);
	// 계좌관리&배송지관리 - 메인 변경
	int updateMainInfo(Map<String, Object> param);
	// 배송지관리 - 정보 수정
	int updateAddress(Map<String, Object> param);
}
