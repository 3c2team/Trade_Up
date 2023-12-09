package com.itwillbs.tradeup.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.tradeup.vo.DepositVO;
import com.itwillbs.tradeup.vo.MemberVO;
import com.itwillbs.tradeup.vo.WithdrawVO;



@Mapper
public interface AdminMapper {

	// 금일 가입회원 조회
	Map<String, Integer> selectMemberJoin();

	//총 회원 조회
	List<MemberVO> selectMemberAll();

	// 총 회원 수 
	Map<String, Integer> selectMemberCount();

	// 관리자 계정인지 조회
	List<MemberVO> selectAdminMember(Map<String, String> map);

	// 기간 회원 검색
	List<MemberVO> selectMemberPeriod(Map<String, String> map);

	// 기간 별 총 회원 수
	Map<String, Integer> selectMemberCountPeriod(Map<String, String> map);
	
	// 입금한 내역
	List<DepositVO> selectDepositList();

	// 출금한 내역
	List<WithdrawVO> selectWithdrawList();

	// 관리자 권한 회수
	int updateMemberRevoke(String member);

	// 관리자 권한 부여
	int updateMemberAuth(String admin);

	// 금일 수수료 금액, 금일 거래량
	Map<String, Integer> selectCommission();

	// 금일 회원탈퇴 수
	Map<String, Integer> selectMemberOut();

	// 출금내역 기간조회
	List<WithdrawVO> selectWithdrawSearch(Map<String, String> map);

	// 입금내역 기간조회
	List<DepositVO> selectDepositSearch(Map<String, String> map);

	// 구매확정 수수료 내역
	List<WithdrawVO> selectWithdrawCharge();

	// 공지사항 등록
	int insertNotice(Map<String, String> map);

	// 공지사항 조회
	List<Map<String, String>> selectNotice();

	// 거래방법 조회
	Map<String, Integer> selectTrasactionList(Map<String, String> map);

	// 거래방법 조회 (일주일)
	Map<String, Integer> selectTransactionWeek(Map<String, String> map);

	// 구매확정 수수료 합계
	Map<String, Integer> selectCommissionSum();

	// 수수료 내역, 합계
	List<WithdrawVO> selectFixWithdrawSearch(Map<String, String> map);

	// 수수료 금액 합산 (기간)
	Map<String, Integer> selectCommissionSumSearch(Map<String, String> map);

	List<Map<String, Object>> selectReport();

	void updateReport(int product_num);

	void insertDangerous(int product_num);

	void deleteDangerous(int product_num);


	
	
	
	

}
