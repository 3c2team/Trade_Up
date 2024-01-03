<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trade Up</title>
</head>
<style>
</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">

function delivery(){
	let result = confirm("채팅 후 거래하시겠습니까?");
	if(!result){
		window.opener.location.href="Checkout?product_num=${product_num}";
		self.close();
	} else{
		window.open("MyChat?memberId=" + "${product.member_id}", "MyChat","top=200, left=700, width=400, height=530");
		self.close();
	}
}

function direct(){
	let result = confirm("채팅 후 거래하시겠습니까?");
	if(!result){
		window.opener.location.href="CheckoutMeet?product_num=${product_num}";
		self.close();
	} else{
		window.open("MyChat?memberId=" + "${product.member_id}", "MyChat","top=200, left=700, width=400, height=530");
		self.close();
	}
}


</script>
<jsp:include page="../inc/style.jsp"></jsp:include>
<body>
	<input type="hidden" value="${product_num}">
	<div class="product__details__option" style="text-align: center; margin: 30px; ">
		<h5 style="font-weight: 700;">거래방법 선택</h5>
		<div class="product__details__option__size" style="margin: 30px;">
			<c:if test="${product.trading_method ne 'direct'}">
				<label for="xxl">
					<input type="radio" id="xxl" style="accent-color:#5F12D3;" onclick="delivery()">택배거래
		        </label>
			</c:if>
			<c:if test="${product.trading_method ne 'delivery'}">
				<label class="active" for="xl">
		            <input type="radio" id="xl" style="accent-color:#5F12D3;" onclick="direct()">직거래
		        </label>
			</c:if>
		</div>
	</div>
</body>
</html>