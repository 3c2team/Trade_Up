package com.itwillbs.tradeup.service;

import java.net.URI;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.itwillbs.tradeup.handler.BankValueGenerator;
import com.itwillbs.tradeup.vo.RequestTokenVO;
import com.itwillbs.tradeup.vo.ResponseAccountListVO;
import com.itwillbs.tradeup.vo.ResponseDepositListVO;
import com.itwillbs.tradeup.vo.ResponseTokenVO;
import com.itwillbs.tradeup.vo.ResponseUserInfoVO;
import com.itwillbs.tradeup.vo.ResponseWithdrawVO;

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
	
//	@Value("${fintech_use_num}")
//	private String fintech_use_num;
	
	@Value("${bank_code}")
	private String bank_code;
	
	@Value("${account_num}")
	private String account_num;
	
	@Autowired
	private BankValueGenerator bankValueGenerator;
	
	private static final Logger log = LoggerFactory.getLogger(bankApiClient.class);

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
	
	// 출금 이체
	public ResponseWithdrawVO requestWithdraw(Map<String, String> map) {
		HttpHeaders headers = new HttpHeaders();
		headers.setBearerAuth(map.get("access_token"));
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		String url = base_url + "/v2.0/transfer/withdraw/fin_num";
		
		JSONObject jo = new JSONObject();
		
		// ----- 업페이 -------
		jo.put("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호(참가기관)
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌, "C" 계정 => N 고정)
		jo.put("cntr_account_num", "2023032400"); // 약정 계좌/계정 번호(핀테크 서비스 기관 계좌)
		jo.put("dps_print_content", map.get("member_id") + "_충전"); // 입금계좌인자내역
		
		// ----- 고객 -------
		jo.put("fintech_use_num", "fintech_use_num"); // 출금계좌 핀테크이용번호
		jo.put("wd_print_content", "업페이_충전"); // 출금계좌인자내역
		jo.put("tran_amt", map.get("chargeMoney")); // 거래금액
		jo.put("tran_dtime", bankValueGenerator.getTranDTime()); // 요청일시
		jo.put("req_client_name", map.get("member_name")); // 요청고객성명(출금계좌)
		jo.put("req_client_fintech_use_num", "fintech_use_num"); // 요청고객핀테크이용번호(출금계좌)
		jo.put("req_client_num", map.get("member_id").toUpperCase()); // 요청고객회원번호(아이디처럼 사용) => 단, 영문자는 모두 대문자
		jo.put("transfer_purpose", "TR"); // 이체용도(송금(TR), 결제(ST))

		jo.put("recv_client_name", "트업_업페이"); // 최종수취고객성명
		jo.put("recv_client_bank_code", "002"); // 최종수취고객계좌 개설기관.표준코드
		jo.put("recv_client_account_num", "2023032400"); // 최종수취고객계좌번호
//		log.info(">>>>> 출금이체 요청 JSON 데이터 : " + jo.toString());
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), headers);
//		log.info(">>>>> httpEntity : " + httpEntity.getHeaders());
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<ResponseWithdrawVO> responseEntity = restTemplate.postForEntity(url, httpEntity, ResponseWithdrawVO.class);
//		log.info(">>>>> 출금이체결과 : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}
	
	// 입금 이체
	public ResponseDepositListVO requestDeposit(Map<String, String> map) {
		HttpHeaders headers = new HttpHeaders();
		headers.setBearerAuth(map.get("access_token"));
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		String url = base_url + "/v2.0/transfer/deposit/fin_num";
		
		JSONObject joReq = new JSONObject();
		joReq.put("tran_no", "1"); // 거래순번
		joReq.put("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호
		joReq.put("fintech_use_num", map.get("fintech_use_num")); // 입금계좌 핀테크이용번호(테스트 데이터 등록)
		joReq.put("print_content", map.get("member_id") + "_송금"); // 입금계좌인자내역(테스트 데이터 등록)
		joReq.put("tran_amt", map.get("refund_price")); // 거래금액(테스트 데이터 등록)
		joReq.put("req_client_name", map.get("member_name")); // 요청고객성명(거래를 요청한 사용자 이름)
		joReq.put("req_client_fintech_use_num", map.get("fintech_use_num")); // 요청고객 핀테크이용번호
		joReq.put("req_client_num", map.get("member_id").toUpperCase()); // 요청고객회원번호
		joReq.put("transfer_purpose", "TR"); // 이체용도(입금이체 = 송금 = TR)
		
		JSONArray jaReqList = new JSONArray();
		jaReqList.put(joReq);
		
		JSONObject jo = new JSONObject();
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌, "C" 계정 => N 고정)
		jo.put("cntr_account_num", "2023032400"); // 약정 계좌/계정 번호(핀테크 서비스 기관 계좌)
		
		jo.put("wd_pass_phrase", "NONE"); // 입금이체용 암호문구(테스트 시 "NONE" 값 설정)
		jo.put("wd_print_content", map.get("member_name") + "_입금"); // 출금계좌인자내역
		jo.put("name_check_option", "on"); // 수취인성명 검증 여부(on : 검증함, 생략 시 off)
		jo.put("tran_dtime", bankValueGenerator.getTranDTime()); // 요청일시
		jo.put("req_cnt", "1"); // 입금요청건수 (현재 여러건 이체 불가능하므로 단건이체 "1" 고정)
		
		jo.put("req_list", jaReqList);
		
		log.info(">>>>> 입금이체 요청 JSON 데이터 : " + jo.toString());
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), headers);
		log.info(">>>>> httpEntity : " + httpEntity.getHeaders());
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<ResponseDepositListVO> responseEntity = restTemplate.postForEntity(url, httpEntity, ResponseDepositListVO.class);
		log.info(">>>>> 입금이체결과 : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

}
