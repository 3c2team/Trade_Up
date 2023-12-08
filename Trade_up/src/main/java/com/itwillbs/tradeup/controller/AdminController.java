package com.itwillbs.tradeup.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.tradeup.service.AdminService;
import com.itwillbs.tradeup.vo.DepositVO;
import com.itwillbs.tradeup.vo.MemberVO;
import com.itwillbs.tradeup.vo.WithdrawVO;


@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
//	@Autowired
//	private MemberService service;
	
	//admin 로그인
	@GetMapping("/AdminLogin")
	public String adminLogin() {
		return "admin/admin_login";
	}

	// admin 메인 
	@GetMapping("/AdminMain") // 메인에 차트, 지표 표시 
	public String myPageMain(HttpSession session, Model model, Map<String, Integer> map) {
		
		// 주간 수수료 금액, 주간 거래량
		map = adminService.selectCommission();
		System.out.println("수수료 금액 : " + map.get("commission"));
		System.out.println("수수료 건수 : " + map.get("count"));
		model.addAttribute("commission",map.get("commission") );
		model.addAttribute("count",map.get("count"));
		
		// 금일 회원가입 인원
//		Map<String, Integer> memberIn = adminService.selectMemberJoin();
		map = adminService.selectMemberJoin();
		model.addAttribute("memberInCount",map.get("selectMemberIn"));
		
		// 금일 회원탈퇴 수
		map = adminService.selectMemberOut();
		model.addAttribute("memberOut",map.get("memberOut"));
		
		return "admin/admin_main";
	}
	
	// 신고회원
	@GetMapping("/Declaration")
	public String declaration() {
		
		return "admin/declaration";
	}
	
	// 수수료 내역
	@GetMapping("/ProductCharge")
	public String productSales(Map<String, Integer> map, Model model) {
		
			System.out.println("날짜 비였음");
			// 구매확정 수수료 내역
			List<WithdrawVO> WithdrawCharge = adminService.selectWithdrawCharge();
			System.out.println("확정완료 수수료 : " + WithdrawCharge);
			model.addAttribute("CommissionList",WithdrawCharge);
			
			// 금일 수수료 금액, 금일 거래량
			map = adminService.selectCommissionSum();
			model.addAttribute("commission",map.get("chargeSum") );
			return "admin/product_charge";
		
	}
	
	// 거래내역
	@GetMapping("/Transaction")
	public String transaction(
					@RequestParam Map<String, String> map
					, Model model
					, @RequestParam(defaultValue = "") String startDate
					, @RequestParam(defaultValue = "") String endDate) {
		
		// 거래 방법 출력(일주일)
//		Map<String, Integer> TransactionCount = adminService.selectTransaction();
//		model.addAttribute("TransactionCount", TransactionCount);
		
		map.put("startDate", startDate);
		map.put("endDate",endDate);
		
		Map<String, Integer> TransactionCount = adminService.selectTransactionWeek(map);
		
		if(TransactionCount.isEmpty()) {
			model.addAttribute("msg", "오늘 이전 날짜만 조회 가능합니다."); // 출력할 메세지
			return "fail_back";
		}
		
		System.out.println("뽑히는가1? : " + TransactionCount);
		model.addAttribute("TransactionCount", TransactionCount);
		
		return "admin/product_transaction";
	}
	
	//고객계좌 입금한 내역
	@GetMapping("/Deposit")
	public String deposit(Model model) {
		
		// 입금한 내역 조회
		List<DepositVO> depositList = adminService.selectDepositList();
		model.addAttribute("depositList",depositList);
		
		return "admin/deposit";
	}
	
	// 고객계좌 출금한 내역
	@GetMapping("/Withdraw")
	public String withdraw(Model model) {
		
		// 출금한 내역 조회
		List<WithdrawVO> withdrawList = adminService.selectWithdrawList();
		model.addAttribute("withdrawList", withdrawList);
		
		return "admin/withdraw";
	}
	
	// 차트 확인용(지울꺼임)
	@GetMapping("/Charts")
	public String charts() {
		return "admin/charts";
	}
	
	
	@PostMapping("/AdminLoginPro")
	public String adminLoginPro(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		
		Map<String, Integer> mapResult = new HashMap<String, Integer>();
		
		System.out.println("id : " + map.get("id") + ", passwd : " +  map.get("passwd"));
		
		// 관리자 계정인지 조회
		List<MemberVO> adminMember = adminService.selectAdminMember(map);
		System.out.println("관리자 계정이니? : " + adminMember);
		
		if(adminMember.isEmpty()) {
			model.addAttribute("msg", "관리자 계정이 아닙니다."); // 출력할 메세지
			return "fail_back";
		}
		
		String member_id = map.get("id");
//		MemberVO dbMember = adminService.getMemberLogin(member_id);
//		session.setAttribute("sId", map.get("id"));
//		session.setAttribute("sName", dbMember.getMember_name());
		
		// 금일 수수료 금액, 금일 거래량
		mapResult = adminService.selectCommission();
		System.out.println("수수료 금액 : " + mapResult.get("commission"));
		System.out.println("수수료 건수 : " + mapResult.get("count"));
		model.addAttribute("commission",mapResult.get("commission") );
		model.addAttribute("count",mapResult.get("count") );
		
		// 금일 회원가입 인원
		mapResult = adminService.selectMemberJoin();
		model.addAttribute("memberInCount",mapResult.get("selectMemberIn"));
		
		// 금일 회원탈퇴 수
		mapResult = adminService.selectMemberOut();
		model.addAttribute("memberOut",mapResult.get("memberOut"));
				
		
		return "admin/admin_main";
	}
	
	@GetMapping("/PagesTest")
	public String pageTest() {
		
		return "admin/pagesTest";
	}
	
	// 회원 목록 조회
	@GetMapping("/MemberList")
	public String memberList(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		
		String sId = (String)session.getAttribute("sId");
		map.put("id", sId);
		
		// 관리자 계정인지 조회
		List<MemberVO> adminMember = adminService.selectAdminMember(map);
		
//		if(adminMember.isEmpty()) {
//			model.addAttribute("msg", "로그인 후 이용 바랍니다."); // 출력할 메세지
//			return "fail_back";
//		}
		
		List<MemberVO> memberList = adminService.selectMemberAll();
		System.out.println("총 회원 조회 : " + memberList);
		model.addAttribute("memberList",memberList);

		Map<String, Integer> memberCount = adminService.selectMemberCount();
		System.out.println("총 회원 수 : " + memberCount.get("member"));
		model.addAttribute("memberCount",memberCount.get("member"));
		
		return "admin/admin_list";
	}
	
	// 회원 조회 페이지 기간별 검색 
	@PostMapping("/MemberListPeriod")
	public String memberListPeriod(
			@RequestParam Map<String, String> map,
			@RequestParam(defaultValue = "1990-01-01") String startDate, 
			@RequestParam(defaultValue = "") String endDate,
			Model model) {
		
		map.put("startDate", startDate);
		map.put("endDate",endDate);
		
		// 기간 회원 검색
		List<MemberVO> memberPeriod = adminService.selectMemberPeriodList(map);
		System.out.println("기간 검색 회원 : " + memberPeriod);
		
		if(memberPeriod.isEmpty()) {
			model.addAttribute("msg", "오늘 이전 날짜만 조회 가능합니다."); // 출력할 메세지
			return "fail_back";
		}
		
		model.addAttribute("memberList", memberPeriod);
		// 기간 회원 수 조회
		Map<String, Integer> memberCount = adminService.selectMemberPeriodCount(map);
		System.out.println("기간 회원 수 : " + memberCount.get("memberCount"));
		model.addAttribute("memberCount",memberCount.get("memberCount"));
		
		return "admin/admin_list";
	}
	
	@GetMapping("/MemberAuth")
	public String memberAuth(
			@RequestParam(value="auth_id", defaultValue = "", required = false) String[] auth_id
			, Model model
			) {
		
		// 관리자 권한 부여
		if(auth_id[0] != "") {
			for(String admin : auth_id) {
				
				int MemberAuth = adminService.updateMemberAuth(admin);
				if(MemberAuth > 0) {
					System.out.println(admin + " : 관리자 권한 부여");
				}
			}
		}
		
		List<MemberVO> memberList = adminService.selectMemberAll();
		System.out.println("총 회원 조회 : " + memberList);
		model.addAttribute("memberList",memberList);

		Map<String, Integer> memberCount = adminService.selectMemberCount();
		System.out.println("총 회원 수 : " + memberCount.get("member"));
		model.addAttribute("memberCount",memberCount.get("member"));
		
		return "admin/admin_list";
	}
	
	//관리자 권한 회수
	@GetMapping("/MemberRevoke")
	public String memberRevoke(
			@RequestParam(value="member_id", defaultValue = "", required = false) String[] member_id
			, Model model
			) {
		
		// 관리자 권한 회수
		if(member_id[0] != "") {
			for(String member : member_id) {
				
				int MemberAuth = adminService.updateMemberRevoke(member);
				if(MemberAuth > 0) {
					System.out.println(member + " : 관리자 권한 회수");
				}
			}
		}
		
		List<MemberVO> memberList = adminService.selectMemberAll();
		System.out.println("총 회원 조회 : " + memberList);
		model.addAttribute("memberList",memberList);

		Map<String, Integer> memberCount = adminService.selectMemberCount();
		System.out.println("총 회원 수 : " + memberCount.get("member"));
		model.addAttribute("memberCount",memberCount.get("member"));
		
		return "admin/admin_list";
	}
	
	// 출금내역 기간별 검색 
	@PostMapping("/WithdrawListPeriod")
	public String withdrawListPeriod(
			@RequestParam Map<String, String> map,
			@RequestParam(defaultValue = "") String startDate, 
			@RequestParam(defaultValue = "") String endDate,
			Model model) {
		
		map.put("startDate", startDate);
		map.put("endDate",endDate);
		
		System.out.println("기간 확인 : " + map.get("startDate") + ", ::> " + map.get("endDate"));
				
		// 출금내역 기간조회
		List<WithdrawVO> withdrawSearchList = adminService.selectWithdrawSearch(map);
		
		if(withdrawSearchList.isEmpty()) {
			model.addAttribute("msg", "오늘 이전 날짜만 조회 가능합니다."); // 출력할 메세지
			return "fail_back";
		}
		
		
		System.out.println("withdrawSearchList : " + withdrawSearchList);
		
		model.addAttribute("withdrawList",withdrawSearchList);
		
		
		return "admin/withdraw";
	}
	
	// 입금내역 기간별 검색 
		@PostMapping("/DepositListPeriod")
		public String depositListPeriod(
				@RequestParam Map<String, String> map,
				@RequestParam(defaultValue = "1990-01-01") String startDate, 
				@RequestParam(defaultValue = "") String endDate,
				Model model) {
			
			map.put("startDate", startDate);
			map.put("endDate",endDate);
			
			// 입금내역 기간조회
			List<DepositVO> depositSearchList = adminService.selectDepositSearch(map);
			
			if(depositSearchList.isEmpty()) {
				model.addAttribute("msg", "오늘 이전 날짜만 조회 가능합니다."); // 출력할 메세지
				return "fail_back";
			}
			
			model.addAttribute("depositList", depositSearchList);
			
			return "admin/deposit";
		}
		
		 //공지사항 페이지 이동(관리자)
		@GetMapping("/AdminNotice")
		public String adminNotice(Model model) {
			// 공지사항 조회
			List<Map<String, String>> noticeList = adminService.selectNoticeList();
			model.addAttribute("NoticeList", noticeList);
			
			return "admin/admin_notice_board";
		}
		
		 //공지사항 등록 페이지 이동(관리자)
		@GetMapping("/AdminNoticeRegist")
		public String adminNoticeRegit() {
			
			
			
			return "admin/admin_notice_regist";
		}
		
		 //공지사항 등록 처리(관리자)
		@PostMapping("AdminNoticeRegistPro")
		public String noticeRegetPro(@RequestParam Map<String, String> map, Model model) {
			
			System.out.println(map);
			
			int insertNoticeCount = adminService.insertNotice(map);
			if(insertNoticeCount == 0) return "fail_back";
	    	model.addAttribute("msg","등록 완료되었습니다.");
	    	return "success_close";
			
		}
		
		@GetMapping("/AdminEvenet")
		public String adminEvenet() {
			
			return "";
		}
		

	
	@PostMapping("/TransactionSearch")
	public String transactionSearch(
			@RequestParam Map<String, String> map,
			@RequestParam(defaultValue = "") String startDate, 
			@RequestParam(defaultValue = "") String endDate,
			Model model) {
		
		map.put("startDate", startDate);
		map.put("endDate",endDate);
		
		// 거래방법 카운터, 총액
		Map<String, Integer> TransactionCount = adminService.selectTransactionList(map);
		
		if(TransactionCount.isEmpty()) {
			model.addAttribute("msg", "오늘 이전 날짜만 조회 가능합니다."); // 출력할 메세지
			return "fail_back";
		}
		
		model.addAttribute("TransactionCount", TransactionCount);
		
		return "admin/product_transaction";
	}
	
	@ResponseBody
	@PostMapping("/TransactionMethod")
	public Map<String, Integer> transactionMethod(
			@RequestParam Map<String, String> map,
			@RequestParam(defaultValue = "") String startDate, 
			@RequestParam(defaultValue = "") String endDate){
		
		map.put("startDate", startDate);
		map.put("endDate",endDate);
		
		System.out.println("data 확인 : " + map.get("startDate") + ", : " + map.get("endDate"));
		
		// 거래 방법 출력(일주일)
		System.out.println("transactionMethod 들어옴");
		Map<String, Integer> TransactionCount = adminService.selectTransactionWeek(map);
		System.out.println("뽑히는가? : " + TransactionCount);
		
		return TransactionCount;
		
	}
	
	@PostMapping("/ChargeSearch")
	public String chargeSearch(@RequestParam Map<String, String> map,
			@RequestParam(defaultValue = "") String startDate, 
			@RequestParam(defaultValue = "") String endDate, 
			Model model) {
		
		map.put("startDate", startDate);
		map.put("endDate",endDate);
		
		System.out.println("chargeSearch - data 확인 : " + map.get("startDate") + ", : " + map.get("endDate"));
		
//		if(startDate.equals("") || endDate.equals("")) {
//			System.out.println("날짜 비였음");
//		}
				
		// 구매확정 수수료 내역 (기간)
		List<WithdrawVO> WithdrawCharge = adminService.selectFixWithdrawSearch(map);
		
		if(WithdrawCharge.isEmpty()) {
			model.addAttribute("msg", "오늘 이전 날짜만 조회 가능합니다."); // 출력할 메세지
			return "fail_back";
		}
		
		System.out.println("확정완료 수수료 (기간) : " + WithdrawCharge);
		model.addAttribute("CommissionList",WithdrawCharge);
		
		// 수수료 금액 (기간)
		Map<String, Integer> mapCommission = new HashMap<String, Integer>();
		mapCommission = adminService.selectCommissionSumSearch(map);
		System.out.println("수수료 금액 (기간) : " + mapCommission.get("commissionSum"));
		model.addAttribute("commission", mapCommission.get("commissionSum") );
		
		return "admin/product_charge";
	}
	
	// 채팅하기
	@GetMapping("/MyChat")
	public String myChat(HttpSession session, String memberId, Model model) {
		String sId = (String)session.getAttribute("sId"); 
		System.out.println("sId : " + sId);
		
		System.out.println("판매자 아이디 : " + memberId);
		
		model.addAttribute("receiverId", memberId);
		
//		return "myChat";
		return "chat/shopDetail_Main2";
//		return "chat/main";
	}
	
	// 채팅방(1:1 채팅방 작성중)
		@GetMapping("/ChatRoom")
		public String chatRoom(HttpSession session) {
			String sId = (String)session.getAttribute("sId");
			System.out.println("sId : " + sId);
			
			return "chat/main2";
		}
	
//	@GetMapping("/ChatMain")
//	public String chatMain() {
//		
//		return "chat/main";
//	}
	
	// 이전 채팅방 
	@GetMapping("/ChatMain")
	public String chatMain2() {
		
		return "chat/main";
	}
	
	
	
	
	
	
	
	
	
}
