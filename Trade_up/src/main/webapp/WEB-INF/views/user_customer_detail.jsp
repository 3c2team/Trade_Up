<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	.custom_qna_answer{
		white-space: pre-line;
	    background-color: rgb(241 244 246);
	    padding: 10px;
	    padding-top: 10px;
	    padding-right: 10px;
	    padding-bottom: 10px;
	    padding-left: 10px;
	    padding-top: 0px;
	    padding-bottom: 2rem;
}
	.custom_date{
		margin: 0.25rem;
		font-size: 0.7rem;
		color: rgb(156 163 175);
	}
	.custom_btn{
	    width: 100%;
	    margin-top: 2rem;
	    line-height: 1.25rem;
	    font-size: .875rem;
	    padding-top: 1rem;
	    padding-bottom: 1rem;
	    color: rgb(255 255 255);
	    background-color: rgb(33 33 33);
	    border-radius: 0.5rem;
	}
	
</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body style="font-family: inherit;">
	<jsp:include page="inc/top.jsp"></jsp:include>
		<div class="custom_flex2" style="width: 40%;">
			<h2 class="fw-bold" style="text-align: center;">고객센터</h2>
			<hr class="custom_border_grove">
			<h4 class="fw-bold" >문의내역 상세</h4>
			<div class="fw-bold fs-5" style="margin-top: 2rem;">Q.</div>
			<div  id="qna_board">
				<div class="custom_qna_content" style="margin-top: 1.1rem;">
					<div style="margin-bottom: 0.5rem;">문의 내용 :</div>
							${QnaDetail.qna_content}
					<div class="custom_date">${QnaDetail.qna_date}</div>
				</div>
				<hr class="custom_border_grove">
				<div class="fw-bold fs-5" style="margin-top: 2rem;">A.</div>
				<div class="custom_qna_answer" style="margin-top: 0.5rem; font-size: 0.8rem;">
						<div class="fw-bold "style="margin-bottom: 0.5rem;">트레이드업 고객센터 :</div>
						<c:choose> 
							<c:when test="${empty QnaDetail.qna_anwer}">
								<div class="fw-bold "style="text-align: center; margin-bottom: 0.5rem;">답변 대기중입니다.</div>
							</c:when>
							<c:otherwise>
								${QnaDetail.qna_anwer}
								<div class="custom_date">${QnaDetail.qna_date}</div>
							</c:otherwise>
						</c:choose>
				</div>
				<button class="custom_btn"type="button">확인</button>
			</div>
		</div>
	<jsp:include page="inc/bottom.jsp"></jsp:include>
	<script type="text/javascript">
	</script>
</body>
</html>