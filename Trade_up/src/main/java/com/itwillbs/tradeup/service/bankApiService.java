package com.itwillbs.tradeup.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.BankMapper;
import com.itwillbs.tradeup.vo.ResponseTokenVO;

@Service
public class bankApiService {
	@Autowired
	private BankMapper mapper;
	
//	@Autowired
//	private bankApiClient bankApiClient;
	
	public void registToken(ResponseTokenVO responseToken, String sId) {
		mapper.insertToken(responseToken, sId);
	}
	
	public void registFintechUseNum(String fintech_use_num, String sId) {
		mapper.insertFintechUseNum(fintech_use_num, sId);
	}

}
