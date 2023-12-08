package com.itwillbs.tradeup.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// 웹소켓 채팅 메세지를 자동으로 파싱하기 위한 클래스 정의
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ChatMessage2 {
	private String type;
	private String userId;
	private String receiverId;
	private String roomId;
	private String message;
	
	// 타입으로 사용될 문자열을 상수(public static final)로 제공
	public static final String TYPE_ENTER = "ENTER";
	public static final String TYPE_TALK = "TALK";
	public static final String TYPE_LEAVE = "LEAVE";
	public static final String TYPE_REMOVE = "REMOVE";
	public static final String TYPE_INIT = "INIT";
	public static final String TYPE_START = "START";
	
}









