package com.itwillbs.tradeup.service;

import java.net.URI;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.itwillbs.tradeup.handler.BankValueGenerator;
import com.itwillbs.tradeup.vo.RequestTokenVO;
import com.itwillbs.tradeup.vo.ResponseAccountListVO;
import com.itwillbs.tradeup.vo.ResponseTokenVO;
import com.itwillbs.tradeup.vo.ResponseUserInfoVO;

@Service
public class bankApiClient {
	
	@Value("${client_id}")
	private String client_id;
	
	@Value("${client_secret}")
	private String client_secret;
	
	@Value("${client_use_code}")
	private String client_use_code;
	
	@Value("${base_url}")
	private String base_url;
	
	@Value("${fintech_use_num}")
	private String fintech_use_num;
	
	@Value("${bank_code}")
	private String bank_code;
	
	@Value("${account_num}")
	private String account_num;
	
	@Autowired
	private BankValueGenerator bankValueGenerator;

	public ResponseTokenVO requestToken(Map<String, String> authResponse) {
		RequestTokenVO requestToken = new RequestTokenVO();
		requestToken.setCode(authResponse.get("code"));
		requestToken.setClient_id(client_id);
		requestToken.setClient_secret(client_secret);
		requestToken.setRedirect_uri("http://localhost:8081/tradeup/callback");
		requestToken.setGrant_type("authorization_code");
		
		URI uri = UriComponentsBuilder
					.fromUriString(base_url) // 기본 주소
					.path("/oauth/2.0/token") // 작업 요청 상세 주소
					.encode() // 파라미터에 대한 인코딩 수행
					.build() // UriComponents 객체 생성
					.toUri(); // java.net.URI 객체로 변환
		
		LinkedMultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("code", authResponse.get("code"));
		parameters.add("client_id", client_id);
		parameters.add("client_secret", client_secret);
		parameters.add("redirect_uri", "http://localhost:8081/tradeup/callback");
		parameters.add("grant_type", "authorization_code");
		
		HttpEntity<LinkedMultiValueMap<String, String>> httpEntity = 
				new HttpEntity<LinkedMultiValueMap<String,String>>(parameters);
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<ResponseTokenVO> responseEntity 
				= restTemplate.exchange(uri, HttpMethod.POST, httpEntity, ResponseTokenVO.class);
		// ------------------------------------
		System.out.println("응답코드 : " + responseEntity.getStatusCode());
		System.out.println("응답헤더 : " + responseEntity.getHeaders());
		System.out.println("응답데이터 : " + responseEntity.getBody()); // 리턴타입 : ResponseTokenVO
		
		return responseEntity.getBody();
	}
	
	public ResponseUserInfoVO requestUserInfo(Map<String, String> map) {
		HttpHeaders headers = new HttpHeaders();
		
		headers.add("Authorization", "Bearer" + map.get("access_token"));
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
		
		URI uri = UriComponentsBuilder
				.fromUriString(base_url)
				.path("/v2.0/user/me")
				.queryParam("user_seq_no", map.get("user_seq_no"))
				.encode()
				.build()
				.toUri();
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<ResponseUserInfoVO> responseEntity = 
				restTemplate.exchange(uri, HttpMethod.GET, httpEntity, ResponseUserInfoVO.class);
		
		return responseEntity.getBody();
	}
	
	
	public ResponseAccountListVO requestAccountList(Map<String, String> map) {
		System.out.println("requestAccountList =====================");
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer" + map.get("access_token"));
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
		
		URI uri = UriComponentsBuilder
					.fromUriString(base_url)
					.path("/v2.0/account/list")
					.queryParam("user_seq_no", map.get("user_seq_no"))
					.queryParam("include_cancel_yn", "N")
					.queryParam("sort_order", "D")
					.encode()
					.build()
					.toUri();
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<ResponseAccountListVO> responseEntity = 
				restTemplate.exchange(uri, HttpMethod.GET, httpEntity, ResponseAccountListVO.class);
		
		return responseEntity.getBody();
	}

}
