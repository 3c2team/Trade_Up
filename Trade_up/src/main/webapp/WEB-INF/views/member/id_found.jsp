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
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<body>
	<div id="mainLayout">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		<main>
		<div class="main">
			<p class="sign" align="center">아이디를 찾았습니다</p>
<!-- 			<form action="" method="" class="form1"> -->
				<p class="user" name="member_name" type="text" style="align-content: center">${sessionScope.sName }</p>
				<p class="phone" name="member_id" type="text" style="align-content: center">${sessionScope.sId }</p>
				<a href="Login" class="join" style="align-content: center; margin:18%">로그인</a>
				<a href="PassForgot" class="passForgot" style="margin-left: 15%">비밀번호찾기</a>
<!-- 			</form> -->
	    </div>
		</main>
	</div>
	<footer id="footer">
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>