package com.itwillbs.tradeup.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.MemberMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	public Map<String, String> getMemberLogin(String member_id) {
		return mapper.selectMemberLogin(member_id);
	}
}
