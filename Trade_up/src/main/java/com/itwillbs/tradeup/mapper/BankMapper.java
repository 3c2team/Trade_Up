package com.itwillbs.tradeup.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.tradeup.vo.ResponseTokenVO;


@Mapper
public interface BankMapper {

	void insertToken(@Param("responseToken") ResponseTokenVO responseToken, @Param("sId")String sId);

	void insertFintechUseNum(@Param("fintech_use_num") String fintech_use_num, @Param("sId") String sId);
	
}
