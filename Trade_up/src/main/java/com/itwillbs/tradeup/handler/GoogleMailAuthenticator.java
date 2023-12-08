package com.itwillbs.tradeup.handler;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

// 자바 메일 기능 사용 시 메일 서버(ex. Gmail 등) 인증을 위한 정보 관리를 수행할 클래스 정의
// => javax.mail.Authenticator 클래스를 상속받는 서브클래스로 정의
public class GoogleMailAuthenticator extends Authenticator {
	// 인증 정보(아이디, 패스워드(앱 비밀번호))를 관리할 javax.mail.PasswordAuthentication 타입 변수 선언
	PasswordAuthentication passwordAuthentication;

	// 기본 생성자 정의
	public GoogleMailAuthenticator() {
		/*
		 * 인증에 사용될 아이디와 패스워드를 갖는 PasswordAuthentication 객체 생성
		 * - 파라미터 : 메일 서버 계정명, 패스워드
		 *   => Gmail 기준 2단계 인증 사용 시 : Gmail 계정명(@gmail.com 생략), 2단계 인증 우회 앱비밀번호
		 *   => Gmail 기준 2단계 인증 미사용 시 : Gmail 계정명, Gmail 계정 패스워드
		 *   => 구글 계정 설정 - 보안 - 2단계 인증 - 앱 비밀번호 설정 필요
		 *      (설정 시 나타나는 앱 비밀번호 16자리를 계정 패스워드 대신 사용)
		 */
		passwordAuthentication = new PasswordAuthentication("k66453697", "emrepxgtnbswshuu");
	}

	// 인증 정보 관리 객체(PasswordAuthentication)를 외부로 리턴하는 getPasswordAuthentication() 메서드 정의
	// => 주의! Getter 메서드 정의 시 멤버변수명에 따라 메서드명이 달라질 수 있는데
	//    외부에서 이 메서드를 직접 호출하는 것이 아니라 객체 내에서 자동으로 호출되므로
	//    지정된 이름으로 메서드 정의 필수!
	// => Authenticator 클래스의 getPasswordAuthentication() 메서드를 오버라이딩 해서 정의할 것!
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return passwordAuthentication;
	}
	
}