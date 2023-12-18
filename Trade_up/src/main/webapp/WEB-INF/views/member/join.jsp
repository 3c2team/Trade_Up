<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 공통 메소드들 정리해논 파일 -->
<meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Trade UP</title>
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap"
    rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/join.css" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
input[type="text"] {
	font-size: 0.8em;
}
</style>
</head>
<body>
	<header>
	
		<!-- top.jsp 페이지를 현재 페이지에 삽입 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<p class="sign" align="center">회원가입</p>
		<%-- MemberJoinPro.me 서블릿 주소 요청 --%>
		<form action="JoinPro" name="joinForm" method="post" onsubmit="return checks()">
			<table style="margin-top: -9%">
				<tr>
					<th>ID<span style="color: red; margin-left: 6%;">*</span></th>
					<td>
						<input type="text" name="member_id" value="${param.email1 }"  id="member_id" size="24">
						<br><span id="checkIdResult">영문소문자/숫자, 4~16자</span>
					</td>
				</tr>
				<tr>
					<th>비밀번호<span style="color: red; margin-left: 6%;">*</span></th>
					<td>
						<input type="password" name="member_passwd"  id="member_passwd" size="24">
						<br><span id="checkPasswdResult">영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자</span>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인<span style="color: white; margin-left: 6%;">*</span></th>
					<td>
						<input type="password" name="member_passwd2" id="member_passwd2" size="24">
						<br><span id="checkPasswd2Result"></span>
					</td>
				</tr>
				<tr>
					<th>이름<span style="color: red; margin-left: 6%;">*</span></th>
					<td><input type="text" value="${param.name }"  name="member_name" id="member_name" size="20"></td>
				</tr>
				<tr>
					<th>닉네임<span style="color: red; margin-left: 6%;">*</span></th>
					<td><input type="text" name="member_nick_name"  value="${param.nickname }"  id="member_nick_name" size="20"></td>
				</tr>
				<tr>
					<th>E-Mail<span style="color: red; margin-left: 6%;">*</span></th>
					<td>
						<input type="text" name="member_email1"  value="${param.email1 }"  id="member_email1" size="10">&nbsp;@<input type="text" name="member_email2"  value="${param.email2 }"  id="member_email2" size="10">
						<select id="member_emailDomain">
							<option value="">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
						</select>
						<br><span style="color: gray;"></span>
					</td>
				</tr>
				<tr>
					<th>전화번호<span style="color: red; margin-left: 6%;">*</span></th>
					<td>
						<input type="text" name="member_phone_num" id="member_phone_num" size="20" oninput="autoHyphen(this)" maxlength="13">
						<br><span id="checkPhoneResult">숫자만 입력해주세요.</span>
					</td>
				</tr>
				<tr>
					<th>본인인증<span style="color: red; margin-left: 6%;">*</span></th>
					<td>
						<input type="button" id="btnAuthCode" value="본인인증" onclick="sendSMS()">
						<input type="text" name="member_auth_code" id="member_auth_code" size="6" maxlength="6">
						<br><span id="checkSendResult">본인인증 버튼 클릭 후 문자로 전송된 인증번호를 입력해주세요.</span>
						<input type="hidden" id="authCode" name="authCode" value="">
					</td>
				</tr>
				<tr>
					<th>주소<span style="color: red; margin-left: 6%;">*</span></th>
					<td>
						<input type="text" name="member_address1" id="member_address1" placeholder="기본주소" size="25" readonly>
						<input type="hidden" name="zonecode" id="zonecode" value="">
						<input type="button" id="btnSearchAddress" value="주소검색" onclick="daumPostcode()"><br>
						<input type="text" name="member_address2" id="member_address2" placeholder="상세주소" size="25">
					</td>
				</tr>
				<tr>
					<th>생일</th>
					<td id="birthTd">
					<br>
					<div class="info" id="info__birth">
						  <select class="box" id="birth-year" name="birth-year">
						    <option disabled selected>출생 연도</option>
						  </select>
						  <select class="box" id="birth-month" name="birth-month">
						    <option disabled selected>월</option>
						  </select>
					  <select class="box" id="birth-day" name="birth-day">
					    <option disabled selected>일</option>
					  </select>
					
					</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" >
						<input type="submit" id="btnCheck" value="가입">
<!-- 						<input type="button" id="btnTest" value="테스트"> -->
<!-- 						<input type="submit" id="btnCheck" value="가입"> -->
						<input type="reset" value="초기화">
<!-- 						<input type="button" value="돌아가기" onclick=""> -->
					</td>
				</tr>
			</table>
		</form>
	</article>
	<footer id="footer">
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</footer>
<!-- Js Plugins -->
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.nicescroll.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.magnific-popup.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.slicknav.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/mixitup.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/owl.carousel.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/join.js"></script>
</body>
</html>