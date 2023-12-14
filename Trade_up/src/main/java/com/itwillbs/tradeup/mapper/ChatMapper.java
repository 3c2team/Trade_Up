package com.itwillbs.tradeup.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.tradeup.vo.ChatMessage2;
import com.itwillbs.tradeup.vo.ChatRoomListVO;

@Mapper
public interface ChatMapper {

	void insertChatRoom(List<ChatRoomListVO> chatRoomList);

	List<Map<String, String>> selectChatRoomList(String sender_id);

	List<ChatMessage2> selectChatList(String room_id);

	void insertMessage(ChatMessage2 chatMessage);

	int deleteChatRoomUser(ChatMessage2 chatMessage);

}
