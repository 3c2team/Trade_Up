<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>J'ai Faim</title>
</head>
<link href="${pageContext.request.contextPath }/resources/css/top.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buttom.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/id_forgot.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<body>
	<div id="mainLayout">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		<main>
		<div class="main">
			<p class="sign" align="center">아이디 찾기</p>
			<form action="IdForgotPro" method="post" class="form1">
				<input class="user" name="member_name" id="member_name" type="text" style="align-content: center" placeholder="이름">
				<input class="phone" name="member_phone_num" id="member_phone_num" type="text" style="align-content: center" placeholder="전화번호">
				<input type="submit" class="submit" id="btn_submit" style="margin-left: 38%; margin-top: 5%" value="확인">
<!-- 				<p class="submit" align="center">메일 인증</p> -->
				<a href="JoinAgree" class="join" style="align-content: center; margin:15%">회원가입</a>
				<a href="PassForgot" class="passForgot" style="margin-left: 15%">비밀번호찾기</a>
			</form>
	    </div>
		</main>
	</div>
	<footer id="footer">
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>