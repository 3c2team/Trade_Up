package com.itwillbs.tradeup.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.tradeup.service.MemberService;

//import com.itwillbs.tradeup.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	@GetMapping("Join")
	public String join(Map<String, String> map) {
		System.out.println(map);
		return "member/join";
	}
	
	@PostMapping("JoinPro")
	public String joinPro(Map<String, String> map) {
		System.out.println(map);
		
		return "member/join";
	}
	
	@GetMapping("Login")
	public String login() {
		return "login/login";
	}
	
	@PostMapping("LoginPro")
	public String loginPro(
			String member_id, Map<String, String> map, @RequestParam(required = false) boolean rememberId, 
			HttpSession session, HttpServletResponse response, Model model) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		Map<String, String> dbMember = service.getMemberLogin(member_id);
//		if(member_id.equals("admin")) {
//            return "admin/admin_login";
//         }
		
//		if(dbMember == null || !passwordEncoder.matches(map.get("member_passwd"), dbMember.get("member_passwd"))) {
//			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
//			return "fail_back";
//		}
		
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
}