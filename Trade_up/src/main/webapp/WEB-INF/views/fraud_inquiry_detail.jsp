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
	.custom_subject{
		width: 30%;
    	margin: 1.5%;
	}
	.custom_content{
		width: 70%;
	}
	.font{
		font-size: 11px;
		margin-top: 10%;
	}
	.font2{
		font-size: 12px;
		float: left;
		margin-left: 2%;
		cursor: pointer;		
	}
	   #modal-box {
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      right: 0;
      background-color: rgba(0, 0, 0, 0.6);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 9999;
   }   
   #modal-box.active {
      display: flex;
   }
   #modal-contents {
      background-color: #ffffff;
      width: 450px;
      padding: 20px;
      border-radius: 5px;
       position: relative;
   }
   #modal-contents botton {
      background-color: #ffffff;
      
   }
   #desc p {
      margin-bottom: 2%;
   }
</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
	<div class="custom_flex2">
		<h2 class="fw-bold">가지 사기 조회</h2>
		<hr class="custom_border_grove">
		<h4 style="margin: 1%;">검색 내용</h4>
		<h4 style="margin: 1%;">피해사례 조회</h4>
		<hr class="custom_border_grove">
		<div class="custom_flex">
			<div class="custom_subject fw-bold">
				가지
			</div>
			<div class="custom_content">
				<div >
					신고 건수 없음
				</div>
				<div class="font">(신고 내역이 없는 경우에도 안전한 거래라는 것을 보장할 수 없습니다. 안전거래를 이용해주세요. )</div>
			</div>
		</div>
		<hr class="custom_border_grove">
		<div class="custom_font_13px text">
			(주)가지는 범죄 피해방지를 위해 해당 서비스를 운영하고 있습니다. 피해 사례 결과에 대해 중고나라는 보증하지 않으며, 거래에 대한 법적 책임은 당사자에게 있습니다.
		</div>
		<div class="fw-bold font2" >
			<div id="police">경찰청 사이버 수사국 바로가기 ></div>
		</div>
		<hr class="custom_border_grove">
		<div class="d-grid gap-2">
			<input type="button" class="btn btn-light" value="다시 조회하기" onclick="location.href='FraudInquiry'">
			<input type="button" id="open" class="btn btn-light" value="신고하기"onclick="location.href='MyPurchase'">
		</div>
	</div>
	<jsp:include page="inc/bottom.jsp"></jsp:include>
	
</body>
</html>