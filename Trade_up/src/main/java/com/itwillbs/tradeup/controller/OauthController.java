package com.itwillbs.tradeup.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.tradeup.service.bankApiClient;
import com.itwillbs.tradeup.service.bankApiService;
import com.itwillbs.tradeup.vo.ResponseTokenVO;

@Controller
public class OauthController {
	@Autowired
	private bankApiClient bankApiClient;
	@Autowired
	private bankApiService bankApiService;
	
	@GetMapping("/callback")
	public String responseAuthCode(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		
//		System.out.println("응답결과 : " + authResponse);
		// Logger 객체의 debug() 메서드를 호출하여 디버그 레벨의 로그로 응답결과 출력
		System.out.println("응답결과 : " + authResponse + "/ 세션 아이디: " + sId);
		
		// 인증 실패 시(= 인증 정보 존재하지 않을 경우) 오류 메세지 출력 및 인증 창 닫기
		if(authResponse == null || authResponse.get("code") == null) {
			// Model 객체를 통해 출력할 메세지(msg) 및 창 닫기 여부(isClose) 전달
			model.addAttribute("msg", "인증하는데 오류가 발생하였습니다. 다시 인증해주세요.");
			model.addAttribute("isClose", true); // 현재 창(서브 윈도우) 닫기
			return "fail_back";
		}
		
		ResponseTokenVO responseToken = bankApiClient.requestToken(authResponse);
		System.out.println("Access Token - " + responseToken.toString());
		
		if(responseToken.getAccess_token() == null) {
			model.addAttribute("msg", "인증하는데 오류가 발생하였습니다. 다시 인증해주세요.");
			model.addAttribute("isClose", true);
			return "fail_back";
		}
		
		bankApiService.registToken(responseToken, sId);
		
		return "close";
	}
}
