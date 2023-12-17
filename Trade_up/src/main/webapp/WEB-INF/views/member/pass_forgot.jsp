<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trade Up</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/magnific-popup.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/id_forgot.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/id_forgot.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
const autoHyphen = (target) => {
	target.value = target.value
	.replace(/[^0-9]/g, '')
	.replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}
</script>
<body>
	<div id="mainLayout">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
	
	</div>
	<main>
	<div class="main">
		<p class="sign" align="center">비밀번호 찾기</p>
		<form action="PassForgotPro" method="post" class="form1">
			<input class="user" name="member_id" id="member_id" type="text" placeholder="아이디">
			<input class="phone" name="member_phone_num" id="member_phone_num" type="text" placeholder="전화번호" oninput="autoHyphen(this)" maxlength="13">
			<input type="submit" class="submit" id="btn_submit" style="margin-left: 31%" value="비밀번호 찾기">
<!-- 			<p class="submit" align="center">전화번호 인증</p> -->
			<a href="Join" class="join" style="margin-left:20%">회원가입</a>
			<a href="IdForgot" class="idForgot" style="margin-left: 30%">아이디찾기</a>
		</form>
    </div>
	</main>
	<footer id="footer" style="margin-top: 20%">
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>