package com.itwillbs.tradeup.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	Map<String, String> selectMemberLogin(String member_id);

}
