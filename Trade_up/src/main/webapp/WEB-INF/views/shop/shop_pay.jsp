<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">

function direct(){
	window.opener.location.href="CheckoutMeet?product_num=${product_num}";
	self.close();
}

function delivery(){
	window.opener.location.href="Checkout?product_num=${product_num}";
	self.close();
}

</script>
<body>
	<input type="hidden" value="${product_num}">
	<button onclick="direct()">직거래</button>
	<button onclick="delivery()">택배거래</button>
</body>
</html>