package com.itwillbs.tradeup.service;

import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.handler.GenerateRandomCode;
import com.itwillbs.tradeup.handler.SendMailClient;

@Service
public class SendMailService {
	
	// 변경된 비밀번호 메일로 전송
	public String sendAuthMail_passwd(String id, String email) {
		String authCode = GenerateRandomCode.getRandomCode(8);
		String subject = "[Trade Up] 비밀번호 변경 메일입니다.";
		String content = "변경된 임시 비밀번호입니다. 로그인 후 비밀번호 변경해주세요!<br>" + authCode;
		new Thread(new Runnable() {
			@Override
			public void run() {
				SendMailClient mailClient = new SendMailClient();
				mailClient.sendMail(email, subject, content);
			}
		}).start();
		
		return authCode;
	}
}