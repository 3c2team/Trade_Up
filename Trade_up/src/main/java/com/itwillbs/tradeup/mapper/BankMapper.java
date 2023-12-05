package com.itwillbs.tradeup.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.tradeup.vo.ResponseTokenVO;


@Mapper
public interface BankMapper {

	void insertToken(ResponseTokenVO responseToken);
	
}
