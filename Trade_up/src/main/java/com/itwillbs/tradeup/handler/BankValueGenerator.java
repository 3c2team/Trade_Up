package com.itwillbs.tradeup.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class BankValueGenerator {
	@Value("${client_use_code}")
	private String client_use_code;
	
	public String getBankTranId() {
		String bank_tran_id = "";
		
		bank_tran_id = client_use_code + "U" + GenerateRandomCode.getRandomCode(9).toUpperCase();
		
		return bank_tran_id;
	}

	public String getTranDTime() {
		LocalDateTime localDateTime = LocalDateTime.now(); 
		
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		
		return localDateTime.format(dateTimeFormatter);
	}
}