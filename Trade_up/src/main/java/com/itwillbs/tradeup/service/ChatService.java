package com.itwillbs.tradeup.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.ChatMapper;
import com.itwillbs.tradeup.vo.ChatMessage2;
import com.itwillbs.tradeup.vo.ChatRoomListVO;

@Service
public class ChatService {
	@Autowired
	private ChatMapper mapper;

	// 채팅방 저장 요청
	public void addChatRoom(ChatMessage2 chatMessage) {
		// 1개 방 정보(룸아이디, 사용자아이디)를 갖는 ChatRoomListVO 객체 생성하여 List 에 추가
		List<ChatRoomListVO> chatRoomList = new ArrayList<ChatRoomListVO>();
		chatRoomList.add(new ChatRoomListVO(chatMessage.getRoom_id(), chatMessage.getSender_id()));
		chatRoomList.add(new ChatRoomListVO(chatMessage.getRoom_id(), chatMessage.getReceiver_id()));
		mapper.insertChatRoom(chatRoomList);
	}

	// 채팅방 목록 조회 요청
	public List<Map<String, String>> getChatRoomList(String sender_id) {
		return mapper.selectChatRoomList(sender_id);
	}

	// 채팅방 채팅 내역 조회 요청
	public List<ChatMessage2> getChatList(String room_id) {
		return mapper.selectChatList(room_id);
	}

	// 채팅 메세지 저장 요청
	public void addMessage(ChatMessage2 chatMessage) {
		mapper.insertMessage(chatMessage);
	}

	// 채팅방 사용자 삭제 요청
	public int removeChatRoomUser(ChatMessage2 chatMessage) {
		return mapper.deleteChatRoomUser(chatMessage);
	}
}












