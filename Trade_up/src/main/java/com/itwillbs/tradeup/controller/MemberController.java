package com.itwillbs.tradeup.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.tradeup.service.MemberService;
import com.itwillbs.tradeup.service.PayService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	@Autowired
	PayService payService;
	
	@GetMapping("Join")
	public String join(Map<String, String> map) {
		System.out.println(map);
		return "member/join";
	}
	
	// 아이디 중복 판별 처리
	@ResponseBody
	@GetMapping("MemberCheckDupId")
	public String checkDupId(String id) {
		Map<String, String> returnMember = service.getMemberDup(id);
		
		if(returnMember != null) { // 아이디 중복
			return "true"; // 리턴타입 String일 때 응답 데이터로 String 타입 "true" 문자열 리턴
		} else {
			return "false";
		}
	}
	
	// 메일 중복 판별 처리
	@ResponseBody
	@GetMapping("MemberCheckDupMail")
	public String checkDupMail(@RequestParam Map<String, String> param) {
		Map<String, String> returnMember = service.getMemberDupMail(param);
		
		if(returnMember != null) { // 아이디 중복
			return "true"; // 리턴타입 String일 때 응답 데이터로 String 타입 "true" 문자열 리턴
		} else {
			return "false";
		}
	}
	
	// 휴대폰 중복 판별 처리
	@ResponseBody
	@GetMapping("MemberCheckDupPhone")
	public String checkDupPhone(String phone_num) {
		Map<String, String> returnMember = service.getMemberDupPhone(phone_num);
		
		if(returnMember != null) { // 아이디 중복
			return "true"; // 리턴타입 String일 때 응답 데이터로 String 타입 "true" 문자열 리턴
		} else {
			return "false";
		}
	}
	
	// 본인인증 문자 전송
	@ResponseBody
	@GetMapping("SendSMS")
	public static Map<String, String> testSMS (String[] args, @RequestParam(defaultValue = "010-1111-1111") String phone_num) {
		String api_key = "NCSK052QH9QYVXN8";
		String api_secret = "WVOPYYGP5DVVQGLME8JCAD2UZN25U1RZ";
		int authCode = (int)(Math.random() * 899999) + 100000;
		Message coolsms = new Message(api_key, api_secret);
		String res = "false";
		
		System.out.println(coolsms);
		System.out.println(authCode);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("authCode", authCode + "");
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phone_num); // 받는 사람
		params.put("from", "0109249369"); // 보내는 사람(나) - 일부러 오류나게 해놓음
		params.put("type", "SMS");
		params.put("text", "[Trade UP] 본인 확인 인증번호[" + authCode + "]를 화면에 입력해주세요");
		params.put("app_version", "test app 1.2");
		
		System.out.println(params);
		
		try {
			JSONObject obj = (JSONObject)coolsms.send(params);
			System.out.println(obj.toString());
			res = "true";
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		map.put("result", res);
		return map;
	}
	
	// 회원가입 완료
	@PostMapping("JoinPro")
	public String joinPro(@RequestParam Map<String, String> map, Model model) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String securePasswd = passwordEncoder.encode(map.get("member_passwd"));
		map.put("member_passwd", securePasswd);
		
		int insertCount = service.registMember(map);
		
		if(insertCount <= 0) {
			model.addAttribute("msg", "오류가 생겼습니다. 다시 시도해주세요.");
			return "fail_back";
		}
		
		insertCount = payService.insertMainAddress(map);
		
		if(insertCount <= 0) {
			model.addAttribute("msg", "오류가 생겼습니다. 다시 시도해주세요.");
			return "fail_back";
		}
		
		model.addAttribute("msg", "회원가입이 완료되었습니다."); // 출력할 메세지
		model.addAttribute("targetURL", "Login"); // 이동시킬 페이지
		return "forward";
	}
	
	@GetMapping("Login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("LoginPro")
	public String loginPro(
			String member_id, String member_passwd, @RequestParam(required = false) boolean rememberId, 
			HttpSession session, HttpServletResponse response, Model model) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		Map<String, String> dbMember = service.getMemberLogin(member_id);
//		if(member_id.equals("admin")) {
//            return "admin/admin_login";
//         }
		
		if(dbMember == null || !passwordEncoder.matches(member_passwd, dbMember.get("member_passwd"))) {
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		}
		
		// 로그인 성공
		if(dbMember.get("mail_auth_status").equals("N")) { // 이메일 미인증 회원
			model.addAttribute("msg", "이메일 인증 후 로그인이 가능합니다.");
			return "fail_back";
		}
		
		// 이메일 인증 회원
		session.setAttribute("loginUser", dbMember);
		session.setAttribute("sId", dbMember.get("member_id"));
		session.setAttribute("sName", dbMember.get("member_name"));
		session.setAttribute("sPhone", dbMember.get("member_phone_num"));
		session.setAttribute("sEmail", dbMember.get("member_e_mail"));
		Cookie cookie = new Cookie("cookieId", dbMember.get("member_id"));
		
		if(rememberId) { // 아이디 저장 체크됨
			cookie.setMaxAge(60 * 60 * 24 * 30);
		} else { // 아이디 저장 미체크
			cookie.setMaxAge(0); // 쿠키 즉시 삭제한다는 의미
		}
		response.addCookie(cookie);
		return "redirect:/";
	}
	
	// Logout
	@GetMapping("Logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}