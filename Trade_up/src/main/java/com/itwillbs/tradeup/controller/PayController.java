package com.itwillbs.tradeup.controller;

import java.text.DecimalFormat;
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
import com.itwillbs.tradeup.vo.ResponseDepositListVO;
import com.itwillbs.tradeup.service.MemberService;
import com.itwillbs.tradeup.service.PayService;
import com.itwillbs.tradeup.service.bankApiClient;
import com.itwillbs.tradeup.vo.ResponseWithdrawVO;

@Controller
public class PayController {
	@Autowired
	PayService service;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	private bankApiClient bankApiClient;
	
	@Value("${client_id}")
	private String client_id;
	
	// 직거래 페이지
	@GetMapping("CheckoutMeet")
	public String checkoutMeet(HttpSession session, Model model, @RequestParam int product_num, Map<String,String> map) {
		String sId = LoginNeed(session, model);
		model.addAttribute("sId", sId);
		String member_name = service.getMemberName(sId);
		map.put("member_name", member_name);
		
		String product_price = service.getProductPrice(product_num);
		String product_name = service.getProductName(product_num);
		int commission = (int)((Integer.parseInt(product_price.replaceAll("[^0-9 ]", ""))) * 0.01);
		DecimalFormat format = new DecimalFormat("###,###,###");
		int total = Integer.parseInt(product_price.replaceAll("[^0-9 ]", "")) + commission;
		model.addAttribute("product_price", product_price.replaceAll("[^0-9 ]", ""));
		model.addAttribute("product_priceShow", product_price);
		model.addAttribute("product_name", product_name);
		model.addAttribute("product_num", product_num);
		model.addAttribute("commission", commission + "");
		model.addAttribute("commissionShow", format.format(commission));
		model.addAttribute("total", total);
		model.addAttribute("totalShow", format.format(total));
		
		return "pay/checkout_meet";
	}
	
	// 결제 페이지
	@GetMapping("Checkout")
	public String checkout(HttpSession session, Model model, @RequestParam int product_num, Map<String,String> map) {
		String sId = LoginNeed(session, model);
		String sEmail = (String)session.getAttribute("sEmail");
		
		model.addAttribute("sId", sId);
		model.addAttribute("sEmail", sEmail);
		

		Map<String, String> getMyAdressMain = service.getMyAddressMain(sId);
		model.addAttribute("addressMain", getMyAdressMain);
		
		if(getMyAdressMain == null) {
			model.addAttribute("msg", "기본 배송지 정보가 없습니다.");
			model.addAttribute("targetURL", "MyAddress");
			return "forward";
		}
		
		List<Map<String, String>> getMyAdress = service.getMyAddress(sId);
		model.addAttribute("addressCount", getMyAdress.size());
		model.addAttribute("address", getMyAdress);

		JsonObject json = new JsonObject();
		for(Map.Entry<String, String> entry : getMyAdressMain.entrySet()) {
			json.addProperty(entry.getKey(), entry.getValue());
		}
		
		String product_price = service.getProductPrice(product_num);
		String product_name = service.getProductName(product_num);
		int commission = (int)((Integer.parseInt(product_price.replaceAll("[^0-9 ]", ""))) * 0.01);
		DecimalFormat format = new DecimalFormat("###,###,###");
		int total = Integer.parseInt(product_price.replaceAll("[^0-9 ]", "")) + commission;
		model.addAttribute("product_price", product_price.replaceAll("[^0-9 ]", ""));
		model.addAttribute("product_priceShow", product_price);
		model.addAttribute("product_name", product_name);
		model.addAttribute("product_num", product_num);
		model.addAttribute("commission", commission + "");
		model.addAttribute("commissionShow", format.format(commission));
		model.addAttribute("total", total);
		model.addAttribute("totalShow", format.format(total));
		
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
		String sId = LoginNeed(session, model);
		
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
		
		String bank_name = "KDB산업은행";
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
		System.out.println(map);
		String sId = LoginNeed(session, model);
		
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
		
		DecimalFormat format = new DecimalFormat("###,###,###");
		String remainPay = service.getRemainPay(sId);
		map.put("remainPay", remainPay);
		if(remainPay == null) {
			remainPay = "0";
		}
		map.put("remainPayShow", format.format(Integer.parseInt(remainPay)));
		
		String charge_money = Integer.parseInt(map.get("product_price")) + Integer.parseInt(map.get("commission")) - Integer.parseInt(remainPay) + "";
		map.put("chargeMoney", charge_money);
		map.put("chargeMoneyShow", format.format(Integer.parseInt(charge_money)));
		model.addAttribute("deliver", map);
		return "pay/pay";
	}
	
	// 무통장 입금
	@PostMapping("PaypalPro")
	public String paypalPro(@RequestParam String bank, @RequestParam Map<String, String> map, Model model, HttpSession session) {
		String bank_name = "신한은행";
		String sId = LoginNeed(session, model);
		
		if(bank.equals("kakao")) { // 카카오뱅크 계좌 정보 들고오기
			bank_name = "카카오뱅크";
		}
		if(bank.equals("su")) { // 산업은행 계좌 정보 들고오기
			bank_name = "KDB산업은행";
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
		String state = "거래중";
		service.updateSalesStatus(map.get("product_num"), state);
		return "pay/paypal";
	}
	
	@PostMapping("PaymentComplete")
	public String paymentComplete(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		System.out.println(map);
		model.addAttribute("deliver", map);
		if(map.containsKey("upPay")) { // 업페이에서 넘어올 경우
			Map<String, String> my_uppay = service.getMyUppay(sId);
			map.put("method", "업페이");
			if(my_uppay == null) {
				model.addAttribute("msg", "업페이 충전 내역이 없습니다. 충전 후 결제 진행해주세요.");
				model.addAttribute("targetURL", "MyPageMain");
				return "forward";
			}
			
			if(Integer.parseInt(map.get("chargeMoney")) > 0) { // 충전해야할 금액이 있는 경우
				Map<String, String> tokenInfo = service.getTokenInfo(sId); // 토큰 정보 가져오기
				map.put("access_token", tokenInfo.get("access_token"));
				map.put("user_seq_no", tokenInfo.get("user_seq_no"));
				map.put("fintech_use_num", tokenInfo.get("fintech_use_num"));
				Map<String, String> mainAccount = service.getMainAccount(sId);
				map.put("account_num", mainAccount.get("account_num"));
				map.put("account_bank", mainAccount.get("account_bank"));
				map.put("acc_num", "2023120106");
				map.put("acc_bank","KDB산업은행");
				map.put("member_id", sId);
				ResponseWithdrawVO withdrawResult = bankApiClient.requestWithdraw(map);
				System.out.println("4" + withdrawResult);
				model.addAttribute("withdrawResult", withdrawResult);
				map.put("state", "자동 충전");
				service.chargeAutoUppay(map);
			}
			Calendar now = Calendar.getInstance();
			String dateTime = "" + now.get(Calendar.YEAR) 
									+ (now.get(Calendar.MONTH) + 1 < 10 ? "0" + (now.get(Calendar.MONTH) + 1) : now.get(Calendar.MONTH) + 1) 
									+ (now.get(Calendar.DATE) < 10 ?  "0" + now.get(Calendar.DATE) : now.get(Calendar.DATE))
									+ (now.get(Calendar.HOUR_OF_DAY) < 10 ?  "0" + now.get(Calendar.HOUR_OF_DAY) : now.get(Calendar.HOUR_OF_DAY))
									+ (now.get(Calendar.MINUTE) < 10 ?  "0" + now.get(Calendar.MINUTE) : now.get(Calendar.MINUTE))
									+ (now.get(Calendar.SECOND) < 10 ?  "0" + now.get(Calendar.SECOND) : now.get(Calendar.SECOND))
									;
			map.put("merchant_uid", "ORD" + dateTime);
			service.insertDeposit(map);
			String remainPay = service.getRemainPay(sId);
			remainPay = (Integer.parseInt(remainPay) - Integer.parseInt(map.get("total"))) + "";
			map.put("remainPay", remainPay);
			service.payAutoUppay(map);
		}
		String state = "거래중";
		service.updateSalesStatus(map.get("product_num"), state);
		return "pay/orderPro";
	}
	
	// 구매확정
	@PostMapping("BuyCheck")
	public String buyCheck(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		System.out.println(map);
		// Map으로 받아올 정보 - 구매자가 구매확정을 누름 판매자 정보는 상품 번호로 조인해서 들고 올 것
		// 상품 번호
		
		String sId = LoginNeed(session, model);
		
		map.put("owner_bank", "KDB산업은행"); // 우리 은행 정보
		map.put("owner_num", "2023120106"); // 우리 계좌
		
		Map<String, String> deal = service.getDealInfo(map.get("product_num")); // 거래 정보 가져오기(WITHDRAW 테이블 접근)
		map.put("product_price", deal.get("product_price")); // 상품 가격
		map.put("merchant_uid", deal.get("merchant_uid")); // 거래 번호
		
		String sellerId = service.getSellerId(map.get("product_num")); // 판매자 정보 가져오기(PRODUCT 테이블 접근)
		map.put("member_id", sellerId); // 판매자 아이디
		
		Map<String, String> sellerInfo = service.getSellerInfo(sellerId); // 판매자 정보 가져오기(MY_ACCOUNT 테이블 접근)
		map.put("account_num", sellerInfo.get("account_num")); // 판매자 계좌
		map.put("account_bank", sellerInfo.get("account_bank")); // 판매자 계좌 은행
		map.put("member_name", sellerInfo.get("account_holder_name")); // 판매자 계좌 은행
		
		int insertCount = service.insertWithdraw(map); // 우리 계좌에서 돈 출금 (판매자에게 채팅으로 판매 완료되었습니다 보내기)
		if(insertCount < 0) { // 구매자 계좌에서 돈 출금 (구매자에게 채팅으로 구매 확정되었습니다 보내기)
			model.addAttribute("msg", "오류가 발생하였습니다. 다시 주문해주세요.");
			return "fail_back";
		}
		
		service.updateDeposit(map.get("product_num")); // withdraw 테이블에서 구매 상태 구매 확정으로 바꾸기
		String state = "거래완료";
		service.updateSalesStatus(map.get("product_num"), state);
		memberService.updateCommission(map.get("merchant_uid"));
		return "myPage/myPage_purchase";
	}
	
	// 업페이 충전
	@PostMapping("UpPayCharge")
	public String upPayCharge(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		String sId = LoginNeed(session, model);
		System.out.println("1" + map);
		
		String member_name = service.getMemberName(sId);
		System.out.println("2" + member_name);
		map.put("member_name", member_name);
		Map<String, String> tokenInfo = service.getTokenInfo(sId); // 토큰 정보 가져오기
		map.put("access_token", tokenInfo.get("access_token"));
		map.put("user_seq_no", tokenInfo.get("user_seq_no"));
		map.put("fintech_use_num", tokenInfo.get("fintech_use_num"));
		map.put("member_id", sId);
		System.out.println("3" + map);
		
		ResponseWithdrawVO withdrawResult = bankApiClient.requestWithdraw(map);
		System.out.println("4" + withdrawResult);
		model.addAttribute("withdrawResult", withdrawResult);
		
		String remainPay = service.getRemainPay(sId);
		String total = Integer.parseInt(remainPay) + Integer.parseInt(map.get("chargeMoney")) + "";
		map.put("total", total);
		map.put("state", "충전");
		service.chargeAutoUppay(map);
		
		return "myPage/myPage_main";
	}
	
	// 업페이 환불
	@PostMapping("UpPayRefund")
	public String upPayRefund(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		String sId = LoginNeed(session, model);
		String remainPay = service.getRemainPay(sId);
		
		if(Integer.parseInt(remainPay) < Integer.parseInt(map.get("refund_price"))) {
			model.addAttribute("msg", "남아있는 금액보다 더 많은 금액 작성 시 환불이 불가능합니다.");
			return "fail_back";
		}
		
		String member_name = service.getMemberName(sId);
		map.put("member_name", member_name);
		Map<String, String> tokenInfo = service.getTokenInfo(sId); // 토큰 정보 가져오기
		map.put("access_token", tokenInfo.get("access_token"));
		map.put("user_seq_no", tokenInfo.get("user_seq_no"));
		map.put("fintech_use_num", tokenInfo.get("fintech_use_num"));
//		map.put("acc_num", "2023120106");
//		map.put("acc_bank","KDB산업은행");
		map.put("member_id", sId);
		
		ResponseDepositListVO depositResult = bankApiClient.requestDeposit(map);
		
		model.addAttribute("depositResult", depositResult);
		String remain_pay = (Integer.parseInt(remainPay) - Integer.parseInt(map.get("refund_price"))) + "";
		map.put("remain_pay", remain_pay);
		service.refundUppay(map);
		
		return "myPage/myPage_main";
	}
	
	public String LoginNeed(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		return sId;
	}
}