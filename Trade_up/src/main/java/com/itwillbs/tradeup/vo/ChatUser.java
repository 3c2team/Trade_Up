package com.itwillbs.tradeup.vo;

import org.springframework.web.socket.WebSocketSession;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ChatUser {
	private String userId;
	private WebSocketSession session;
}
