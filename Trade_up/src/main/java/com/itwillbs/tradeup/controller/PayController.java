package com.itwillbs.tradeup.controller;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.itwillbs.tradeup.service.PayService;

@Controller
public class PayController {
	@Autowired
	PayService service;
	
	@Value("${client_id}")
	private String client_id;
	
	// 직거래 페이지
	@GetMapping("CheckoutMeet")
	public String checkoutMeet() {
		return "pay/checkout_meet";
	}
	
	// 결제 페이지
	@GetMapping("Checkout")
	public String checkout(HttpSession session, Model model, Map<String,String> map) {
		String sId = (String)session.getAttribute("sId");
		String sEmail = (String)session.getAttribute("sEmail");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		model.addAttribute("sId", sId);
		model.addAttribute("sEmail", sEmail);
		
		List<Map<String, String>> getMyAdress = service.getMyAddress(sId);
		model.addAttribute("addressCount", getMyAdress.size());
		model.addAttribute("address", getMyAdress);

		Map<String, String> getMyAdressMain = service.getMyAddressMain(sId);
		model.addAttribute("addressMain", getMyAdressMain);
		
		if(getMyAdressMain == null) {
			model.addAttribute("msg", "기본 배송지 정보가 없습니다.");
			model.addAttribute("targetURL", "MyAddress");
			return "forward";
		}
		
		JsonObject json = new JsonObject();
		for(Map.Entry<String, String> entry : getMyAdressMain.entrySet()) {
			json.addProperty(entry.getKey(), entry.getValue());
//			System.out.println(entry.getKey());
		}
		
		model.addAttribute("addressMain2", json.toString());
		
		return "pay/checkout";
	}
	
	// 카카오페이
	@PostMapping("AccPro")
	public String accPro(
					@RequestParam Map<String, String> map
					, HttpSession session
					, Model model
					) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		if(map.get("pick").equals("Y")) {
			int changeCount = service.updateMainAddress(map); // 원래 메인 주소 그냥 주소로 변경
			if(changeCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
			int insertCount = service.insertMainAddress(map); // 메인 주소 추가
			if(insertCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
		}
		
		if(map.get("add").equals("Y") && map.get("pick").equals("N")) {
			int insertCount = service.insertAddress(map); // 주소 추가
			if(insertCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
		}
		
		Map<String, String> mainAccount = service.getMainAccount(sId); // 구매자 메인 계좌 정보 가져오기
		if(mainAccount == null) {
			model.addAttribute("msg", "등록된 대표 계좌가 없습니다. 계좌 등록 후 구매를 진행해주세요.");
			model.addAttribute("targetURL", "MyAccount");
			return "forward";
		}
		
		model.addAttribute("deliver", map);
		System.out.println(map);
		return "pay/acc";
	}
	
	@PostMapping("PaymentResult")
	@ResponseBody
	public void paymentResult(HttpSession session, @RequestParam Map<String, String> map, Model model) {
		System.out.println(map);
		System.out.println("주문번호 : " + map.get("merchant_uid"));
		String sId = (String)session.getAttribute("sId");
		map.put("sId", sId);
		
		String bank_name = "산업은행";
		Map<String, String> ownerBank = service.getOwnerBank(bank_name); // 우리 계좌 정보 가져오기
		Map<String, String> mainAccount = service.getMainAccount(sId); // 구매자 메인 계좌 정보 가져오기
		map.put("acc_bank", ownerBank.get("acc_bank"));
		map.put("acc_num", ownerBank.get("acc_num"));
		map.put("member_id", mainAccount.get("member_id"));
		map.put("account_bank", mainAccount.get("account_bank"));
		map.put("account_num", mainAccount.get("account_num"));
		map.put("method", "카카오페이");
		
		int insertCount = service.insertDeposit(map); // 우리 계좌로 돈 입금 (판매자에게 채팅으로 입금 완료되었습니다 보내기)
		
		model.addAttribute("deliver", map);
	}
	
	// 업페이
	@PostMapping("PaymentPro")
	public String paymentPro(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		model.addAttribute("deliver", map);
		System.out.println(map);
		if(map.get("pick").equals("Y")) {
			int changeCount = service.updateMainAddress(map); // 원래 메인 주소 그냥 주소로 변경
			if(changeCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
			int insertCount = service.insertMainAddress(map); // 메인 주소 추가
			if(insertCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
		}
		
		if(map.get("add").equals("Y") && map.get("pick").equals("N")) {
			int insertCount = service.insertAddress(map); // 주소 추가
			if(insertCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
		}
		return "pay/pay";
	}
	
	// 무통장 입금
	@PostMapping("PaypalPro")
	public String paypalPro(@RequestParam String bank, @RequestParam Map<String, String> map, Model model, HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		String bank_name = "신한은행";
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		if(bank.equals("kakao")) { // 카카오뱅크 계좌 정보 들고오기
			bank_name = "카카오뱅크";
		}
		if(bank.equals("su")) { // 국민 계좌 정보 들고오기
			bank_name = "산업은행";
		}
		Map<String, String> ownerBank = service.getOwnerBank(bank_name); // 우리 계좌 정보 가져오기
		Map<String, String> mainAccount = service.getMainAccount(sId); // 구매자 메인 계좌 정보 가져오기
		if(mainAccount == null) {
			model.addAttribute("msg", "등록된 대표 계좌가 없습니다. 계좌 등록 후 구매를 진행해주세요.");
			model.addAttribute("targetURL", "MyAccount");
			return "forward";
		}
		map.put("bank", bank);
		map.put("acc_bank", ownerBank.get("acc_bank"));
		map.put("acc_num", ownerBank.get("acc_num"));
		map.put("member_id", mainAccount.get("member_id"));
		map.put("account_bank", mainAccount.get("account_bank"));
		map.put("account_num", mainAccount.get("account_num"));
		map.put("method", "무통장입금(" + mainAccount.get("account_bank") + ")");
		System.out.println(map);
		if(map.get("pick").equals("Y")) {
			int changeCount = service.updateMainAddress(map); // 원래 메인 주소 그냥 주소로 변경
			if(changeCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
			int insertCount = service.insertMainAddress(map); // 메인 주소 추가
			if(insertCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
		}
		
		if(map.get("add").equals("Y") && map.get("pick").equals("N")) {
			int insertCount = service.insertAddress(map); // 주소 추가
			if(insertCount < 0) {
				model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
				return "fail_back";
			}
		}
		
		Calendar now = Calendar.getInstance();
		// getFullYear() : 연도, getMonth() : 월(+1 필요), getDate() : 일 
		// => 문자열 결합(20231101)
		// => 단, 월과 일의 경우 1자리 일 때 앞자리 0 추가 필요
		String dateTime = "" + now.get(Calendar.YEAR) 
						+ (now.get(Calendar.MONTH) + 1 < 10 ? "0" + (now.get(Calendar.MONTH) + 1) : now.get(Calendar.MONTH) + 1) 
						+ (now.get(Calendar.DATE) < 10 ?  "0" + now.get(Calendar.DATE) : now.get(Calendar.DATE))
						+ (now.get(Calendar.HOUR_OF_DAY) < 10 ?  "0" + now.get(Calendar.HOUR_OF_DAY) : now.get(Calendar.HOUR_OF_DAY))
						+ (now.get(Calendar.MINUTE) < 10 ?  "0" + now.get(Calendar.MINUTE) : now.get(Calendar.MINUTE))
						+ (now.get(Calendar.SECOND) < 10 ?  "0" + now.get(Calendar.SECOND) : now.get(Calendar.SECOND))
						;
		map.put("merchant_uid", "ORD" + dateTime);
		int insertCount = service.insertDeposit(map); // 우리 계좌로 돈 입금 (판매자에게 채팅으로 입금 완료되었습니다 보내기)
		if(insertCount < 0) { // 구매자 계좌에서 돈 출금 (구매자에게 채팅으로 출금 확인되었습니다 보내기) + 구매자 정보 같이 보내기
			model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
			return "fail_back";
		}
		
//		map.put("access_token", (String)session.getAttribute("access_token"));
//		map.put("id", "lyl3697"); // 테스트 출금 정보 등록(요청 사용자 번호용 임시 아이디)
//		
//		Map<String, Object> transferResult = bankApiService.requestTransfer(map);
//		
//		model.addAttribute("transferResult", transferResult);
		
		model.addAttribute("deliver", map);
		return "pay/paypal";
	}
	
	@PostMapping("PaymentComplete")
	public String paymentComplete(@RequestParam Map<String, String> map, Model model) {
		model.addAttribute("deliver", map);
		System.out.println("!!!!!!!!!!!!!!" + map);
		return "pay/orderPro";
	}
}