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
<script type="text/javascript">
	function sendSMS() {
		let phone_num = $("#member_phone_num").val();
		let lengthRegex = /^[0-9]{3}[-][0-9]{4}[-][0-9]{4}$/;
		
		if(phone_num == "") {
			msg = "전화번호를 입력해주세요.";
			color = "red";
		} else if(!lengthRegex.exec(phone_num)) {
			msg = "000-0000-0000형식으로 작성해주세요.";
			color = "red";
		} else {
			$.ajax({
				url: "SendSMS",
				data: {
					"phone_num" : phone_num
				},
				success: function(result) {
					alert("인증번호를 발송했습니다. 문자 확인 후 번호를 입력해주세요.")
				} ,
				error: function (result) {
					alert("인증번호 발송에 실패하였습니다. 전화번호를 다시 한번 확인해 주세요")
				},
			});
		}
		// 텍스트와 글자색상 변수를 활용하여 상태 변경
		$("#checkPhoneResult").html(msg);
		$("#checkPhoneResult").css("color", color);
	}
</script>
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
					<th>ID</th>
					<td>
						<input type="text" name="member_id" id="member_id" size="24">
						<br><span id="checkIdResult">영문소문자/숫자, 4~16자</span>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="member_passwd" id="member_passwd" size="24">
						<br><span id="checkPasswdResult">영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자</span>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input type="password" name="member_passwd2" id="member_passwd2" size="24">
						<br><span id="checkPasswd2Result"></span>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="member_name" id="member_name" size="20"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" name="member_nick_name" id="member_nick_name" size="20"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="member_phone_num" id="member_phone_num" size="20">
						<br><span id="checkPhoneResult">000-0000-0000</span>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="button" id="btnSearchAddress" value="본인인증" onclick="sendSMS()">
						<input type="text" name="member_phone_num" id="member_phone_num" size="8">
						<br><span id="checkSendResult">본인인증 버튼 클릭 후 문자로 전송된 인증번호를 입력해주세요.</span>
						<input type="hidden" name="authCode" value="${authCode }">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="member_address1" id="member_address1" placeholder="기본주소" size="25">
						<input type="button" id="btnSearchAddress" value="주소검색"><br>
						<input type="text" name="member_address2" id="member_address2" placeholder="상세주소" size="25">
					</td>
				</tr>
				<tr>
					<th>생일</th>
					<td><input type="date" name="member_birth" id="member_birth" size="20"></td>
				</tr>
				<tr>
					<td colspan="2" align="center" >
						<!-- <button type="button" id="btnCheck" value="가입" onclick="checks()"> -->
<!-- 						<input type="button" id="btnTest" value="테스트"> -->
						<input type="submit" id="btnCheck" value="가입">
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
</body>
</html>