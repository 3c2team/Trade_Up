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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.tradeup.service.MemberService;
import com.itwillbs.tradeup.service.PayService;
import com.itwillbs.tradeup.service.SendMailService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	@Autowired
	PayService payService;

	@Autowired
	SendMailService mailService;
	
	@GetMapping("Join")
	public String join(Map<String, String> map) {
		System.out.println(map);
		return "member/join";
	}
	@PostMapping("AddNaver")
	public String addNaver(@RequestParam Map<String, String> map,Model model,HttpSession session) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		System.out.println("받은 값 : " + map);
		Map<String, String> dbMember = service.getMemberLogin(map.get("member_id"));
		
		if(dbMember == null || !passwordEncoder.matches(map.get("member_passwd"), dbMember.get("member_passwd"))) {
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		}
		int addNaverCount = service.insertNaver(map);
		if(addNaverCount == 0) {
			model.addAttribute("msg", "연동에 실패하였습니다.");
			return "fail_back";
		} 
		session.setAttribute("naver_id", dbMember.get("naver_id"));
        session.setAttribute("sId", dbMember.get("member_id"));
        session.setAttribute("sName", dbMember.get("member_name"));
        session.setAttribute("sPhone", dbMember.get("member_phone_num"));
        session.setAttribute("sEmail", dbMember.get("member_e_mail"));
        session.setAttribute("loginUser", dbMember);
		return "redirect:/";
	}
	@GetMapping("NaverLogin")
	public String naverLogin(@RequestParam String id, HttpSession session, Model model) {
		
		System.out.println("네이버 아이디 : " + id );
		Map<String, String> naver = service.getNaverAccessToken(id);
		
		if(naver == null) {
			session.setAttribute("naver_id", id);
			return "member/loginNaver";
		}
		if(naver.get("member_state").equals("정지")) {
			model.addAttribute("msg", "회원님의 계정은 이용이 정지된 계정입니다."
					+ "자세한사항은 정지 조회에서 조회하시길 바랍니다");
			return "fail_back";
		}
		session.setAttribute("naver_id", naver.get("naver_id"));
        session.setAttribute("sId", naver.get("member_id"));
        session.setAttribute("sName", naver.get("member_name"));
        session.setAttribute("sPhone", naver.get("member_phone_num"));
        session.setAttribute("sEmail", naver.get("member_e_mail"));
        session.setAttribute("loginUser", naver);
		return "redirect:/";
	}
	@GetMapping("NaverLoginCallBack")
	public String NaverLoginCallBack() {
		return "member/naverLoginCallBack";
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
		params.put("from", "01092493697"); // 보내는 사람(나)
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
		String securePasswd = passwordEncoder.encode((String)map.get("member_passwd"));
		map.put("member_passwd", securePasswd);
		map.put("member_birth", "");		
		
		if(map.containsKey("birth-year") && map.containsKey("birth-month") && map.containsKey("birth-day")) {
			String birth_month = Integer.parseInt(map.get("birth-month")) < 10 ? "0" + map.get("birth-month") : map.get("birth-month");
			String birth_day = Integer.parseInt(map.get("birth-day")) < 10 ? "0" + map.get("birth-day") : map.get("birth-day");
			map.put("member_birth", map.get("birth-year") + "-" + birth_month + "-" + birth_day);
		}
		
		int insertCount = service.registMember(map);
		
		if(insertCount <= 0) {
			model.addAttribute("msg", "오류가 생겼습니다. 다시 시도해주세요.");
			return "fail_back";
		}
		
		Map<String, String> address = new HashMap<String, String>();
		address.put("member_id", (String)map.get("member_id"));
		address.put("member_name", (String)map.get("member_name"));
		address.put("member_phone", (String)map.get("member_phone_num"));
		address.put("member_address1", (String)map.get("member_address1"));
		address.put("member_address2", (String)map.get("member_address2"));
		address.put("zonecode", (String)map.get("zonecode"));
		
		insertCount = payService.insertMainAddress(address);
		
		if(insertCount <= 0) {
			model.addAttribute("msg", "오류가 생겼습니다. 다시 시도해주세요.");
			return "fail_back";
		}
		
		model.addAttribute("msg", "회원가입이 완료되었습니다."); // 출력할 메세지
		model.addAttribute("targetURL", "Login"); // 이동시킬 페이지
		return "forward";
	}
	
	// 아이디 찾기
	@GetMapping("IdForgot")
	public String idForgot() {
		return "member/id_forgot";
	}
	
	// 아이디 찾기 완료
	@PostMapping("IdForgotPro")
	public String idForgotPro(String member_name, String member_phone_num, @RequestParam Map<String, String> map, Model model, HttpSession session) {
		Map<String, String> member = service.getMemberToPhone(member_phone_num);
		
		if(member == null || !member.get("member_name").equals(member_name)) { // 실패
			model.addAttribute("msg", "정보에 해당하는 회원이 없습니다.");
			return "fail_back";
		}
		
		if(member.get("member_state").equals("탈퇴")) {
			model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
			return "fail_back";
		}
		
		session.setAttribute("sName", member_name);
		session.setAttribute("sPhone", member_phone_num);
		session.setAttribute("sId", member.get("member_id"));
		return "member/id_found";
	}
	
	// PassForgot 클릭 시 PassForgot 폼으로 이동
	@GetMapping("PassForgot")
	public String passForgot() {
		return "member/pass_forgot";
	}
	
	// 비밀번호 업데이트 후 메일 전송
	@PostMapping("PassForgotPro")
	public String passForgotPro(String member_id, String member_phone_num, @RequestParam Map<String, String> map, Model model) {
		Map<String, String> member = service.getMemberToPhone(member_phone_num);
		if (member == null || !member_id.equals(member.get("member_id"))) {
			model.addAttribute("msg", "정보에 해당하는 회원이 없습니다.");
			return "fail_back";
		}
		
		if(member.get("member_state").equals("탈퇴")) {
			model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
			return "fail_back";
		}
		
		String email = service.getMemberEmail(member_id);
		String authCode = mailService.sendAuthMail_passwd(member_id, email);
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String securePasswd = passwordEncoder.encode(authCode);
		int updatePasswdCount = service.updateMemberPasswd(member_id, securePasswd);
		
		if (updatePasswdCount <= 0) {
			model.addAttribute("msg", "비밀번호 변경에 오류가 생겼습니다. 다시 시도해주세요.");
			return "fail_back";
		}
		
		model.addAttribute("msg", email + "로 변경된 비밀번호를 전송했습니다. 로그인 페이지로 이동합니다."); // 출력할 메세지
		model.addAttribute("targetURL", "Login"); // 이동시킬 페이지
		return "forward";
	}
	
	@GetMapping("Login")
	public String login() {
		return "member/login";
	}
	
	// 카카오 로그인
	@RequestMapping(value = "/kakao", method = RequestMethod.GET)
	public String kakaoLogin( @RequestParam(value = "code", required = false) String code,
			@RequestParam Map<String, String> map, HttpSession session, Model model) throws Throwable {
		String access_Token = service.getKaKaoAccessToken(code);
        HashMap<String, Object> userInfo = service.createKakaoUser(access_Token);
        
        if (userInfo.get("id") == null) {
        	model.addAttribute("msg", "다시 시도해주세요."); // 출력할 메세지
			return "fail_back";
        }
        
        String kakao_id = (String)userInfo.get("id");
        Map<String, String> dbMember = service.getMemberKakaoLogin(kakao_id);
    	
    	if(dbMember != null) { // 연동 이력이 있는 경우
    		
    		if(dbMember.get("member_state").equals("탈퇴")) {
    			model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
    			return "fail_back";
    		}
    		
    		session.setAttribute("kakao_id", kakao_id);
            session.setAttribute("access_Token", access_Token);
            session.setAttribute("sId", dbMember.get("member_id"));
            session.setAttribute("sName", dbMember.get("member_name"));
            session.setAttribute("sPhone", dbMember.get("member_phone_num"));
            session.setAttribute("sEmail", dbMember.get("member_e_mail"));
            session.setAttribute("loginUser", dbMember);
            model.addAttribute("msg", "로그인에 성공했습니다. 상품페이지로 이동합니다."); // 출력할 메세지
			model.addAttribute("targetURL", "Shop"); // 이동시킬 페이지
			return "forward";
    	}
    	
		session.setAttribute("kakao_id", (String)userInfo.get("id"));
        session.setAttribute("access_Token", access_Token);
        model.addAttribute("msg", "입력된 정보가 없습니다. 이미 회원가입 하신 분이라면 카카오 연동을 위해 로그인 해주세요."); // 출력할 메세지
		model.addAttribute("targetURL", "KakaoConnectLogin"); // 이동시킬 페이지
		return "forward";
	}
	
	// 카카오아이디랑 로그인 아이디 연동
	@GetMapping("KakaoConnectLogin")
	public String kakaoConnectLogin() {
		return "member/loginKakao";
	}
	
	// 카카오 로그인 완료
	@PostMapping("KakaoLoginPro")
	public String kakaoLoginPro(@RequestParam Map<String, String> map, HttpSession session, String member_id, Model model) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		Map<String, String> dbMember = service.getMemberLogin(member_id);
		if(dbMember == null || !passwordEncoder.matches(map.get("member_passwd"), dbMember.get("member_passwd"))) {
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		}
		
		if(dbMember.get("member_state").equals("탈퇴")) {
			model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
			return "fail_back";
		}
		
		session.setAttribute("sId", map.get("member_id"));
		session.setAttribute("sName", dbMember.get("member_name"));
        session.setAttribute("sPhone", dbMember.get("member_phone_num"));
        session.setAttribute("sEmail", dbMember.get("member_e_mail"));
        session.setAttribute("loginUser", dbMember);
		String kakao_id = (String)session.getAttribute("kakao_id");
		int updateCount = service.addKakaoId(member_id, kakao_id);
		
		if(updateCount <= 0) {
			model.addAttribute("msg", "로그인 정보를 다시 확인해주세요.");
			return "fail_back";
		}
		return "redirect:/";
		
	}
	
	@PostMapping("LoginPro")
	public String loginPro(
			String member_id, String member_passwd, @RequestParam(required = false) boolean rememberId, 
			HttpSession session, HttpServletResponse response, Model model) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		Map<String, String> dbMember = service.getMemberLogin(member_id);
//		Map<String, String> Dangerous = service.getDangerous(member_id);
//		if(Dangerous.get("member_idx") ==null) {
//			model.addAttribute("msg", "회원님의 계정은 이용이 정지된 계정입니다."
//					+ "자세한사항은 정지 조회에서 조회하시길 바랍니다");
//			return "fail_back";
//		}
//		if(member_id.equals("admin")) {
//            return "admin/admin_login";
//         }
		
		if(dbMember.get("member_state").equals("탈퇴")) {
			model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
			return "fail_back";
		}
		if(dbMember.get("member_state").equals("정지")) {
			model.addAttribute("msg", "회원님은 정지된 회원입니다.");
			return "fail_back";
		}
		
		if(dbMember == null || !passwordEncoder.matches(member_passwd, dbMember.get("member_passwd"))) {
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		}
		
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