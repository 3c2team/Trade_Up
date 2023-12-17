<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trade up</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">

function delivery(){
	let result = confirm("채팅 후 거래하시겠습니까?");
	if(!result){
		window.opener.location.href="Checkout?product_num=${product_num}";
		self.close();
	}
	window.open("MyChat?memberId=" + "${product.member_id}", "MyChat","top=200, left=700, width=300, height=300");
	self.close();
	
}

function direct(){
	let result = confirm("채팅 후 거래하시겠습니까?");
	if(!result){
		window.opener.location.href="CheckoutMeet?product_num=${product_num}";
		self.close();
	}
	window.open("MyChat?memberId=" + "${product.member_id}", "MyChat","top=200, left=700, width=300, height=300");
	self.close();
}


</script>
<jsp:include page="../inc/style.jsp"></jsp:include>
<body>
	<input type="hidden" value="${product_num}">
	<div class="product__details__option">
		<div class="product__details__option__size">
			<span>거래방법 선택</span>
			<c:if test="${product.trading_method ne 'direct'}">
				<label for="xxl">택배거래
					<input type="radio" id="xxl" onclick="delivery()">
		        </label>
			</c:if>
			<c:if test="${product.trading_method ne 'delivery'}">
				<label class="active" for="xl">직거래
		            <input type="radio" id="xl" onclick="direct()">
		        </label>
			</c:if>
		</div>
	</div>
</body>
</html>