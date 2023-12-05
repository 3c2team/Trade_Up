package com.itwillbs.tradeup.handler;

import org.apache.commons.lang3.RandomStringUtils;

// 특정 난수 생성에 사용할 클래스 정의
// => 단, 별도의 사용자 클래스 정의 없이도 RandomStringUtils 클래스 접근하여 사용 가능
public class GenerateRandomCode {
	// 파라미터로 전달받은 난수 길이에 해당하는 난수 생성을 수행하는 getRandomCode() 메서드 정의
	// => 파라미터 : 난수 길이(정수)   리턴타입 : String
	// => 인스턴스 생성없이 즉시 접근 가능하도록 static 메서드로 선언
	// => RandomStringUtils 클래스 활용(commons-lang3 라이브러리 필요)
	public static String getRandomCode(int length) {
		// RandomStringUtils 클래스의 static 메서드 randomAlphanumeric() 메서드 활용
		// => 알파벳, 숫자 조합 난수 생성 가능
		return RandomStringUtils.randomAlphanumeric(length);
	}
	
	// => 숫자 조합 난수 생성
	public static String getRandomNumCode(int minLength, int maxLength) {
//		if (Integer.parseInt(GenerateRandomCode.getRandomNumCode(6, 6)) < maxLength) {
//			
//		}
		
		return RandomStringUtils.randomNumeric(minLength, maxLength);
	}
	
	public static void main(String[] args) {
		System.out.println(GenerateRandomCode.getRandomNumCode(6, 6));
	}
}
