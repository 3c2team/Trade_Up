package com.itwillbs.tradeup.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.itwillbs.tradeup.service.ChatService;
import com.itwillbs.tradeup.vo.ChatMessage2;

@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	Gson gson = new Gson();
	
	// 채팅하기(1:1 채팅방 작성중)
		@GetMapping("/MyChat")
		public String myChat(HttpSession session, String memberId, Model model) {
			String sId = (String)session.getAttribute("sId"); 
			System.out.println("sId : " + sId);
			
			System.out.println("판매자 아이디 : " + memberId);
			
			model.addAttribute("receiverId", memberId);
			
//			return "myChat";
//			return "chat/shopDetail_Main2";
//			return "chat/chat_main";
			return "chat/chat_room2";
		}
		
	// 채팅방
		@GetMapping("/ChatRoom")
		public String chatRoom(HttpSession session) {
			String sId = (String)session.getAttribute("sId");
			System.out.println("sId : " + sId);
			
			return "chat/chat_room2";
		}
		
		// 채팅방 채팅목록 조회
		@ResponseBody
		@GetMapping("requestChatList")
		public String chatList(String room_id) {
			// ChatService - getChatList() 메서드 호출하여 채팅 목록 조회 요청
			// => 파라미터 : room_id   리턴타입 : List<ChatMessage2>(chatList)
			List<ChatMessage2> chatList = chatService.getChatList(room_id);
			return gson.toJson(chatList);
		}
		
			
}
