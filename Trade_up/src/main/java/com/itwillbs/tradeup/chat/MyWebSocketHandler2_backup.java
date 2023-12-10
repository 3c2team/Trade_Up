package com.itwillbs.tradeup.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONObject;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.itwillbs.tradeup.vo.ChatMessage;
import com.itwillbs.tradeup.vo.ChatMessage2;
import com.itwillbs.tradeup.vo.ChatUser;

// 웹소켓 핸들링을 위한 클래스 정의 - TextWebSocketHandler 클래스 상속
// => 기본적으로 서버에서 단 하나만 생성됨
public class MyWebSocketHandler2_backup extends TextWebSocketHandler {
	// 접속한 클라이언트(사용자)들의 정보를 Map 객체에 저장하기 위한 객체 생성
	// key : 웹소켓 세션 아이디(문자열)   value : 사용자 정보를 관리하는 ChatUser 타입(웹소켓 포함)
	// => HashMap 타입 대신 ConcurrentHashMap 타입 사용 시 여러 Thread 가 동시 접근 시에도 락(Lock)을 통해 안전하게 데이터 관리
	private Map<String, ChatUser> userSessions = new ConcurrentHashMap<String, ChatUser>();
	
	// 접속한 사용자의 아이디와 세션 아이디를 관리할 Map 객체 생성(String, String)
	private Map<String, String> users = new ConcurrentHashMap<String, String>();
	
	// 채팅방 1개의 정보를 관리할 Map 객체 생성
	// => 채팅방의 ID(roomId - 문자열)와 해당 채팅방 접속자들의 ID 를 관리할 List<String> 타입 지정
	private Map<String, List<String>> rooms = new ConcurrentHashMap<String, List<String>>();
	
	
	// 메세지 파싱을 수행하기 위한 Gson 객체 생성
	Gson gson = new Gson();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// WebSocket 객체 생성(연결)될 때 자동으로 호출되는 메서드
		System.out.println("웹소켓 연결됨(afterConnectionEstablished) - " + session.getId());
	}

	
	// 웹소켓 객체를 통해 메세지 전송 시 자동으로 호출되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		System.out.println("전송받은 메세지 : " + message.getPayload()); // JSON 형식 문자열 전달됨
		// ------------------------------------------------------------------
		// [ JSON 형식 문자열 파싱 - ChatMessage2 클래스 활용 ]
		ChatMessage2 chatMessage = gson.fromJson(message.getPayload(), ChatMessage2.class);
		System.out.println("ChatMessage : " + chatMessage);
		// ------------------------------------------------------------------
		// [ 채팅 페이지 진입 처리 또는 새 채팅창 추가 작업 처리 ]
		// 사용자 아이디와 상대방 아이디를 변수에 저장
		String userId = chatMessage.getUserId();
		String receiverId = chatMessage.getReceiverId();
		
		// 메세지 타입 판별
		if(chatMessage.getType().equals(ChatMessage2.TYPE_INIT)) { 
			// 채팅페이지 진입(새로고침 포함)
			// 기존 사용자 목록에서 userId 와 일치하는 키에 해당하는 값(세션아이디)을 가져와서
			// 사용자 세션 목록에서 일치하는 엔트리 제거
			if(userSessions.size() > 0 && users.size() > 0) { // 사용자 세션 목록이 하나라도 있을 경우에만 수행
				// users 객체에 사용자 아이디가 존재하고, userSessions 객체의 키에 사용자 세션 아이디가 있을 경우
				if(users.containsKey(userId) && userSessions.containsKey(users.get(userId))) {
					userSessions.remove(users.get(userId));
				}
			}
			
			// 사용자 목록(users) 에 자신의 아이디와 현재 세션 아이디 저장
			users.put(userId, session.getId());
			// 사용자 세션 목록(userSessions)에 세션 아이디와 사용자 정보 객체(ChatUser) 저장
			userSessions.put(session.getId(), new ChatUser(userId, session));
			System.out.println("클라이언트 목록 : " + users);
			System.out.println("클라이언트 세션 목록 : " + userSessions);
			
			// 사용자 세션 초기화 후 아무 작업도 수행하지 않고 종료
			return;
		} else if(chatMessage.getType().equals(ChatMessage2.TYPE_START)) { 
			// 채팅창 열기(신규, 기존)
			boolean needCreateRoom = true; // 새 채팅창 표시 여부 결정할 변수 선언
			
			// 기존 채팅방 존재여부 판별
			if(rooms.size() > 0) { // 채팅방이 1개라도 존재할 경우
				// 반복문을 통해 생성되어 있는 채팅방을 하나씩 탐색
				// => Map 객체(rooms) 에서 Entry 객체(키&값)를 하나씩 꺼내기
				// => Entry 객체의 getKey() 는 키 리턴, getValue() 는 값 리턴
				for(Entry<String, List<String>> room : rooms.entrySet()) {
					// 해당 방의 참가자 목록 꺼내기(Entry 객체의 getValue() 메서드 활용)
					List<String> roomUsers = room.getValue();
					
					// 상대방과 나의 채팅방 존재 여부 판별
					// 방의 참가자 수가 2명이고, 참가자 아이디에 자신과 상대방 아이디가 포함된 경우 판별
					// => List 객체의 contains() 메서드 활용하여 아이디 포함 여부 판별
					if(roomUsers.size() == 2 && roomUsers.contains(userId) && roomUsers.contains(receiverId)) {
						// 이미 존재하는 채팅방이므로 새 방 개설 불필요
						needCreateRoom = false;
						// 기존 채팅방번호(ID)를 메세지 객체에 저장
						chatMessage.setRoomId(room.getKey());
					}
				}
			}
			
			if(needCreateRoom) { // 새로운 채팅방 생성이 필요한 경우
				// 1. 새 채팅방의 방번호(roomId) 생성
				// => UUID 객체 활용하여 새로 생성하거나 현재 세션의 세션 아이디값 재사용도 가능
				chatMessage.setRoomId(UUID.randomUUID().toString()); // 새로 생성
//				chatMessage.setRoomId(session.getId()); // 세션 아이디 재사용
				
				// 2. 사용자에게 채팅방 생성 메세지 전송을 위해 메세지 설정
				chatMessage.setMessage("> " + receiverId + " 님과의 채팅방 생성 <");
				
				// 3. 채팅방 멤버 리스트 생성
				List<String> roomUsers = new ArrayList<String>();
				roomUsers.add(userId);
				roomUsers.add(receiverId);
				
				// 4. 방 목록에 새 채팅방 추가(채팅방의 룸ID, 채팅방 멤버 리스트)
				rooms.put(chatMessage.getRoomId(), roomUsers);
			} else { // 기존 채팅방 입장(열기)
				// 재입장 메세지 설정
				chatMessage.setMessage("> " + receiverId + " 님과의 채팅방 재입장 <");
			} 
			
			System.out.println("현재 룸 목록 : " + rooms);
			System.out.println("새 채팅방 생성 메세지 : " + chatMessage);
			
			// 사용자에게 새 채팅방 알림을 위한 메세지 전송
			sendMessage(session, chatMessage);
			
			return;
		}
		
		// ------------------------------------------------------------------
		// [ TYPE_ENTER, TYPE_LEAVE, TYPE_TALK 공통 작업 ]
		// 전체 채팅방 중 룸ID 가 일치하는 채팅방의 참가자 목록 가져오기
		// => 사용할 키는 메세지 객체의 룸ID 전달
		List<String> currentRoomUserList = rooms.get(chatMessage.getRoomId());
			
			System.out.println( "방 멤버 ==> " + currentRoomUserList);
		
		// 현재 채팅방 사용자 반복하면서 사용자 ID 와 일치하는 사용자 정보 객체(ChatUser) 꺼내기
		if(currentRoomUserList != null) {
			for(String roomUserId : currentRoomUserList) {
				// userSessions 객체에서 사용자아이디에 해당하는 세션 아이디로 탐색
				ChatUser userSession = userSessions.get(users.get(roomUserId));
				
				// sendMessage() 메서드 호출하여 메세지 전송
				// => 파라미터 : WebSocketSession 객체, ChatMessage2 객체
				// => 단, 자신의 세션이 아닌 세션에게만 전송
				//    (현재 채팅방 사용자 아이디와 전송된 메세지의 userId 가 일치하지 않을 경우 전송)
				if(!roomUserId.equals(chatMessage.getUserId())) {
					// [ 채팅방 입장 또는 퇴장 및 메세지 전송 처리 ]
					if(chatMessage.getType().equals(ChatMessage.TYPE_ENTER)) { // 입장 메세지
						// "[닉네임]님이 입장하셨습니다" 를 메세지로 설정 => ChatMessage 객체에 저장
						chatMessage.setMessage("> " + chatMessage.getUserId() + " 님이 입장하셨습니다. <");
					} else if(chatMessage.getType().equals(ChatMessage.TYPE_LEAVE)) { // 입장 메세지
						// "[닉네임]님이 입장하셨습니다" 를 메세지로 설정 => ChatMessage 객체에 저장
						chatMessage.setMessage(">" + chatMessage.getUserId() + " 님이 퇴장하셨습니다. <");
					}
					
					// 메세지 전송
					sendMessage(userSession.getSession(), chatMessage);
				} else if(chatMessage.getType().equals(ChatMessage.TYPE_LEAVE)) {
					// 현재 채팅방의 정보를 활용하여 rooms 객체에서 채팅방 제거
					rooms.remove(chatMessage.getRoomId());
					// 자신의 세션에도 메세지 전송(자신의 브라우저 화면에서 방 제거 위해)
					// => 단, 자신의 세션에 있는 채팅창만 제거하기 위해 타입을 REMOVE 로 변경 후 전송
					chatMessage.setType(ChatMessage2.TYPE_REMOVE);
					sendMessage(userSession.getSession(), chatMessage);
				}
				
			}
			
		} else { // 상대방이 채팅방을 삭제한 후 자신의 나가기를 눌렀을 때 아무 객체도 없을 경우
			// 자신의 채팅방 삭제에 필요한 메세지 전송
			chatMessage.setType(ChatMessage2.TYPE_REMOVE);
			sendMessage(session, chatMessage); // 현재 웹소켓 세션 객체 활용
		}
		
	}
	
	// 메세지 객체를 JSON 형식으로 변환하여 현재 세션에게 전송하는 메서드
	private void sendMessage(WebSocketSession session, ChatMessage2 chatMessage) throws IOException {
		session.sendMessage(new TextMessage(gson.toJson(chatMessage)));
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("웹소켓 연결 해제됨(afterConnectionClosed)");

		// 클라이언트 정보가 저장된 Map 객체에서 현재 종료 요청이 발생한 세션 객체를 제거
		// => Map 객체의 remove() 메서드를 호출하여 전달받은 세션 아이디를 키로 지정
//		userSessions.remove(session.getId());
		System.out.println("클라이언트 목록 : " + userSessions);
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("웹소켓 오류 발생됨! - " + exception.getMessage());
	}

	
}
