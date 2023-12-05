<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript">
	//카카오페이 연동
	window.onload = function requestPay() {
		IMP.init('imp37164056'); // 객체 초기화. 가맹점 식별코드 전달
	
		IMP.request_pay({
	    	pg: "kakaopay.TC0ONETIME",
	    	pay_method: "card",
	    	merchant_uid: "ORD" + getDateTimeString(),   // 주문번호
	    	name: "${deliver.product_name }", //"${paymentProduct}",
	    	amount: 30300, //${resultPrice },                         // 숫자 타입
	    	buyer_email: "${deliver.member_email }", //"${Member.member_e_mail}",
	    	buyer_name: "${deliver.member_name }", //"${Member.member_name}",
	    	buyer_tel: "${deliver.member_phone }", //"${Member.member_phone_num}",
	    	buyer_addr: "${deliver.member_address1 }" + "${deliver.member_address2 }", //"${Member.member_address}",
	    	buyer_postcode: "${deliver.zonecode }"//"01181"
	    }, function (rsp) { // callback
	     	if(rsp.success) { // 결제 성공 시
	 			console.log("rsp.imp_uid : " + rsp.imp_uid);
	 			console.log("rsp.merchant_uid : " + rsp.merchant_uid);
	 			$.ajax({
					type:"POST",
					url:"PaymentResult",
					data:{
						imp_uid: rsp.imp_uid,
	                    merchant_uid: rsp.merchant_uid,
	                    sId : "${sessionScope.sId}",
	                    member_name : "${deliver.member_name }",
	                    zonecode : "${deliver.zonecode }",
	                    member_address1 : "${deliver.member_address1 }",
	                    member_address2 : "${deliver.member_address2 }",
	                    member_phone : "${deliver.member_phone }",
	                    member_email : "${deliver.member_email }",
	                    diliver_ment : "${deliver.diliver_ment }",
	                    product_num : "${deliver.product_num }",
	                    product_name : "${deliver.product_name }",
	                    product_price : "${deliver.product_price }",
	                    product_commission : "${deliver.product_commission }",
						},
					success:function(result){
						console.log("데이터 전송 성공");
						alert("결제가 완료 됐습니다.");
						$("#complete").submit();
					},
					error:function(){
						console.log("작업 실패");
						alert("오류가 발생 했습니다.");
						location.href = "${pageContext.request.contextPath}/Checkout";
					}
				});
	     	}else{
	     		alert("결제에 실패하였습니다.");
	     		location.href = "${pageContext.request.contextPath}/Checkout";
	     	}
	    });
	}

// 현재 날짜 정보를 "yyyyMMdd" 형식의 문자열로 리턴하는 함수 정의
function getDateTimeString() {
	let now = new Date();
	// getFullYear() : 연도, getMonth() : 월(+1 필요), getDate() : 일 
	// => 문자열 결합(20231101)
	// => 단, 월과 일의 경우 1자리 일 때 앞자리 0 추가 필요
	let dateTime = "" + now.getFullYear() 
					+ (now.getMonth() + 1 < 10 ? "0" + (now.getMonth() + 1) : now.getMonth() + 1) 
					+ (now.getDate() < 10 ?  "0" + now.getDate() : now.getDate())
					+ (now.getHours() < 10 ?  "0" + now.getHours() : now.getHours())
					+ (now.getMinutes() < 10 ?  "0" + now.getMinutes() : now.getMinutes())
					+ (now.getSeconds() < 10 ?  "0" + now.getSeconds() : now.getSeconds())
					;
	console.log(dateTime); // 20231101172821
	return dateTime;
}
</script>
</head>
<body>
<form action="PaymentComplete" method="post" id="complete">
	<input type="hidden" name="member_name" value="${deliver.member_name}">
	<input type="hidden" name="zonecode" value="${deliver.zonecode}">
	<input type="hidden" name="member_address1" value="${deliver.member_address1}">
	<input type="hidden" name="member_address2" value="${deliver.member_address2}">
	<input type="hidden" name="member_phone" value="${deliver.member_phone}">
	<input type="hidden" name="member_email" value="${deliver.member_email}">
	<input type="hidden" name="diliver_ment" value="${deliver.diliver_ment}">
	<input type="hidden" name="product_num" value="${deliver.product_num}">
	<input type="hidden" name="product_name" value="${deliver.product_name}">
	<input type="hidden" name="product_price" value="${deliver.product_price}">
	<input type="hidden" name="product_commission" value="${deliver.product_commission}">
</form>
</body>
</html>