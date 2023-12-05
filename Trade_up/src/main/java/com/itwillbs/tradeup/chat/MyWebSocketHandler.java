package com.itwillbs.tradeup.chat;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class MyWebSocketHandler extends TextWebSocketHandler{
	
	// 접속한 클라이언트(사용자)들의 정보를 Map 객체에 저장
		// => ConcurrentHashMap : 여러 쓰레드가 동시에 접근하더라도 락(Lock)을 통해 안전하게 데이터 관리
		private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
		private Map<String, String> nicknames = new ConcurrentHashMap<String, String>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//		System.out.println("웹소켓 연결~~!!");
		printLog(session.getId() + " 웹소켓 연결~~!!");
		// Map 객체에 클라이언트 정보 저장
		users.put(session.getId(), session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메세지 전송~~!!");
		System.out.println(session.getId() + " : " + message.getPayload());
		
		// 클라이언트 목록에 저장된 모든 세션에게 메세지 전송
		for(WebSocketSession ws : users.values()) {
			ws.sendMessage(message);
			System.out.println(ws.getId() + " 에게 메세지 전송 : " + message.getPayload());
		}
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
