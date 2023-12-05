<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Male-Fashion | Template</title>
<style type="text/css">
	.font{
		font-size: 12px;
		float: left;
		margin-left: 2%;
		cursor: pointer;		
	}

</style>

	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
	<div class="custom_div">
		<h2 class="text-start">가지 사기조회</h2>
		<hr style="border: groove;">
		<span class="text-start">
			판매자의 휴대폰, 계좌번호, 메신저 ID, 이메일로<br>
			피해 사례 조회를 이용해 보세요!
		</span>
		<form action="FraudInquiryPro" method="post" style="margin-top: 20px;">
			<select class="form-select">
				<option value="">휴대폰 번호</option>
				<option value="">이메일</option>
				<option value="">계좌번호</option>
			</select>
			<input type="text" class="form-control" style="margin-top: 20px;">
			<input type="submit" class="btn btn-dark float-start" style="margin-top: 20px;"value="조회">
		</form>
		<hr style="border: groove; margin-top: 13%;">
		<div class="custom_font_13px text">
			(주)가지는 범죄 피해방지를 위해 해당 서비스를 운영하고 있습니다. 피해 사례 결과에 대해 중고나라는 보증하지 않으며, 거래에 대한 법적 책임은 당사자에게 있습니다.
		</div>
		<div class="fw-bold font">
			<div id="police">경찰청 사이버 수사국 바로가기 ></div>
		</div>
	</div>
	<jsp:include page="inc/bottom.jsp"></jsp:include>
</body>
</html>