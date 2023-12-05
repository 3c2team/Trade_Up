package com.itwillbs.tradeup.chat;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class MyWebSocketHandler extends TextWebSocketHandler{
	
	// 접속한 클라이언트(사용자)들의 정보를 Map 객체에 저장하기 위한 객체 생성
	// key : 웹소켓 세션 아이디(문자열)   value : 웹소켓 세션 객체(WebSocketSession)
	// => HashMap 타입 대신 ConcurrentHashMap 타입 사용 시 여러 Thread 가 동시 접근 시에도 락(Lock)을 통해 안전하게 데이터 관리
	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//		System.out.println("웹소켓 연결~~!!");
		printLog(session.getId() + " 웹소켓 연결~~!!");
		// Map 객체에 클라이언트 정보 저장
		users.put(session.getId(), session);
		System.out.println("클라이언트 목록 : " + users);
	}

	// 웹소켓 객체를 통해 메세지 전송 시 자동으로 호출되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		System.out.println("메세지 전송~~!!");
		System.out.println(" 전송받은 메세지 :  " + message.getPayload()); // JSON 형식 문자열 전달됨
		
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//		System.out.println("웹소켓 종료~~!!");
		printLog(session.getId() + " 웹소켓 종료~~!!");
		users.remove(session.getId());
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
//		System.out.println("웹소켓 에러~~!!");
		printLog(session.getId() + " 예외 발생 : " + exception.getMessage());
	}

	public void printLog(String msg) {
		System.out.println(new Date() + " : " + msg);
	}

	
}
