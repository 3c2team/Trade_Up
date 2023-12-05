package com.itwillbs.tradeup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.AdminMapper;
import com.itwillbs.tradeup.vo.DepositVO;
import com.itwillbs.tradeup.vo.MemberVO;
import com.itwillbs.tradeup.vo.WithdrawVO;



@Service
public class AdminService {
	@Autowired
	private AdminMapper adminMapper;

	// 금일 가입 회원 조회
	public Map<String, Integer> selectMemberJoin() {
		return adminMapper.selectMemberJoin();
	}

	// 총 회원 목록 조회
	public List<MemberVO> selectMemberAll() {
		return adminMapper.selectMemberAll();
	}

	// 총 회원 수 
	public Map<String, Integer> selectMemberCount() {
		return adminMapper.selectMemberCount();
	}

	// 관리자 계정인지 조회
	public List<MemberVO> selectAdminMember(Map<String, String> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminMember(map);
	}
	
	// 기간 회원 검색
	public List<MemberVO> selectMemberPeriodList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectMemberPeriod(map);
	}

	// 기간 조회 회원 수
	public Map<String, Integer> selectMemberPeriodCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectMemberCountPeriod(map);
	}

	// 구매자 계좌에서 출금한 내역
	public List<WithdrawVO> selectWithdrawList() {
		// TODO Auto-generated method stub
		return adminMapper.selectWithdrawList();
	}

	// 판매자에게 입금한 내역
	public List<DepositVO> selectDepositList() {
		// TODO Auto-generated method stub
		return adminMapper.selectDepositList();
	}
	
	// 거래 방법 출력
	public List<DepositVO> selectTransacList() {
		// TODO Auto-generated method stub
		return null;
	}

	// 관리자 권한 회수
	public int updateMemberRevoke(String member) {
		// TODO Auto-generated method stub
		return adminMapper.updateMemberRevoke(member);
	}

	// 관리자 권한 부여
	public int updateMemberAuth(String admin) {
		// TODO Auto-generated method stub
		return adminMapper.updateMemberAuth(admin);
	}

	// 금일 수수료 금액, 금일 거래량
	public Map<String, Integer> selectCommission() {
		// TODO Auto-generated method stub
		return adminMapper.selectCommission();
	}

	// 금일 회원 탈퇴 수
	public Map<String, Integer> selectMemberOut() {
		// TODO Auto-generated method stub
		return adminMapper.selectMemberOut();
	}

	// 출금내역 기간조회
	public List<WithdrawVO> selectWithdrawSearch(Map<String, String> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectWithdrawSearch(map);
	}

	// 입금내역 기간조회
	public List<DepositVO> selectDepositSearch(Map<String, String> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectDepositSearch(map);
	}

	// 구매확정 수수료 내역
	public List<WithdrawVO> selectWithdrawCharge() {
		// TODO Auto-generated method stub
		return adminMapper.selectWithdrawCharge();
	}

	// 공지사항 등록
	public int insertNotice(Map<String, String> map) {
		// TODO Auto-generated method stub
		return adminMapper.insertNotice(map);
	}

	//공지사항 조회
	public List<Map<String, String>> selectNoticeList() {
		// TODO Auto-generated method stub
		return adminMapper.selectNotice();
	}

	// 거래방법,총액 조회 
	public Map<String, Integer> selectTransactionList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectTrasactionList(map);
	}

	//거래방법, 총액 일주일 조회
	public Map<String, Integer> selectTransactionWeek(Map<String, String> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectTransactionWeek(map);
	}

	// 구매확정 수수료
	public Map<String, Integer> selectCommissionSum() {
		// TODO Auto-generated method stub
		return adminMapper.selectCommissionSum();
	}


	
	
	
}
