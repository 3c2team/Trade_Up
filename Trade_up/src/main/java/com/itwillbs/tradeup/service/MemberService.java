package com.itwillbs.tradeup.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.itwillbs.tradeup.mapper.MemberMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	// 아이디 중복 확인
	public Map<String, String> getMemberDup(String id) {
		return mapper.selectMemberDup(id);
	}
	
	// 메일 중복 판별 처리
	public Map<String, String> getMemberDupMail(Map<String, String> param) {
		return mapper.selectMemberDupMail(param);
	}
	
	// 휴대폰 중복 판별 처리
	public Map<String, String> getMemberDupPhone(String phone_num) {
		return mapper.selectMemberDupPhone(phone_num);
	}
	
	// 회원가입 등록
	public int registMember(Map<String, String> map) {
		return mapper.insertMember(map);
	}
	
	// 전화번호로 아이디 찾기
	public Map<String, String> getMemberToPhone(String member_phone_num) {
		return mapper.selectMemberToPhone(member_phone_num);
	}
	
	// 아이디로 메일 찾기
	public String getMemberEmail(String member_id) {
		return mapper.selectMemberEmail(member_id);
	}
	
	// 비밀번호 변경
	public int updateMemberPasswd(String member_id, String securePasswd) {
		return mapper.updateMemberPasswd(member_id, securePasswd);
	}
	
	// 로그인
	public Map<String, String> getMemberLogin(String member_id) {
		return mapper.selectMemberLogin(member_id);
	}
	
	// 카카오 로그인(access token 가져오기)
	public String getKaKaoAccessToken(String code) {
		String access_Token="";
        String refresh_Token ="";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try{
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=1582f2676c7805fc4f4fc798652b9f28");
            sb.append("&redirect_uri=http://c3d2306t2.itwillbs.com/Trade_up/kakao");
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            int responseCode = conn.getResponseCode();
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            
            //Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            br.close();
            bw.close();
        }catch (IOException e) {
            e.printStackTrace();
        }
        return access_Token;
	}
	
	// 카카오 로그인(유저 정보) 가져오기
	public HashMap<String, Object> createKakaoUser(String access_Token) {
		HashMap<String, Object> userInfo = new HashMap<>();
	    String reqURL = "https://kapi.kakao.com/v2/user/me";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String line = "";
	        String result = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        
	        JsonParser parser = new JsonParser();
	        JsonElement element = parser.parse(result);
	        String id = element.getAsJsonObject().get("id").getAsString();
	        
//	        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
//	        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	        
//	        userInfo.put("nickname", nickname);
	        userInfo.put("id", id);
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return userInfo;
	}
	
	// 카카오 아이디 유무 확인
	public Map<String, String> getMemberKakaoLogin(String kakao_id) {
		return mapper.selectMemberKakaoLogin(kakao_id);
	}
	
	// 카카오 아이디 업데이트
	public int addKakaoId(String member_id, String kakao_id) {
		return mapper.updateKakaoId(member_id, kakao_id);
	}
	
	public int updateCommission(String merchant_uid) {
		return mapper.updateCommission(merchant_uid);
	}
	
	public Map<String, String> getNaverAccessToken(String id) {
		// TODO Auto-generated method stub
		return mapper.getNaverAccessToken(id);
	}

	public int insertNaver(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertNaver(map);
	}
}
