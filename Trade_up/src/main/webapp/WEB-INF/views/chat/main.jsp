<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일(css/default.css) 불러오기 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
	#chatArea {
		width: 300px;
		height: 200px;
		border: 1px solid black;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/chatting.js"></script>

</head>
<body>
	<header>
		<%-- Login, Join 등의 링크 표시 메뉴 영역 --%>
		<%-- 주의! JSP 파일은 WEB-INF/views 디렉토리 내에 위치 --%>
<%-- 		<jsp:include page="../inc/top.jsp"></jsp:include> --%>
	</header>
	<article>
		<%-- 본문 표시 영역 --%>
<%-- 		<c:if test="${empty sessionScope.sId}"> --%>
<!-- 			<script type="text/javascript"> -->
// 				alert("로그인 후 사용 가능합니다!");
// 				location.href = "MemberLoginForm";
<!-- 			</script> -->
<%-- 		</c:if> --%>
		<h1>채팅 페이지</h1>
		<hr>
		닉네임 : <input type="text" value="${sessionScope.sId}" id="nickname">
		<input type="button" value="채팅방 입장" id="btnJoin" onclick="openChat()">
		<input type="button" value="채팅방 나가기" id="btnQuit">
		<hr>
		<div id="chatArea">
			<span id="chatMessageArea"></span>
		</div>
		<input type="text" id="chatMsg">
		<input type="button" value="전송" id="btnSend">
	</article>
	<hr>
	<footer>
		<!-- bottom.jsp 페이지를 현재 페이지에 삽입 -->
<%-- 		<jsp:include page="../inc/bottom.jsp"></jsp:include> --%>
	</footer>
	<script type="text/javascript">
        	function openChat() {
        		window.open("MyChat", "MyChat","top=200,left=700,width=500, height=500");
			}
    </script>
    
</body>
</html>














