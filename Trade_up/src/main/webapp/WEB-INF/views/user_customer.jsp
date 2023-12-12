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

	.custom_qna_content{
	    border-bottom: solid;
	    border-width: 1px;
	    padding-top: 25px;
	    cursor: pointer;
	}
	.custom_qna_answer{
		white-space: pre-line;
		background-color: rgb(241 244 246);
	    padding: 10px;
	    padding-top: 2rem;
	    padding-bottom: 2rem;
	}
	.custom_date{
		margin: 0.25rem;
		font-size: 0.7rem;
		color: rgb(156 163 175);
	}
	.custom_content2{
		overflow: hidden;
	    display: -webkit-box;
	    -webkit-box-orient: vertical;
	    margin: 0.25rem;
        font-size: 1.25rem;
        padding-top: 15px;
	}
	.custom_btn3{
		float: right;
	    font-size: 1.5rem;
	}
</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body style="font-family: inherit;">
	<jsp:include page="inc/top.jsp"></jsp:include>
		<div class="custom_flex2" style="width: 40%;">
			<h2 class="fw-bold" style="text-align: center;">고객센터</h2>
			<hr class="custom_border_grove">
			<h3 class="fw-bold" >문의내역</h3>
			<div  id="qna_board">
				<c:if test="${empty selectUserQna && empty selectUserReport}">
					<div style="text-align: center;">
						<img src="${pageContext.request.contextPath }/resources/img/mascote.jpg"/>
						<div style="font-size: xx-large;font-weight: bold;">문의 사항이 없어요!</div>
					</div>
				</c:if>
				<c:forEach var="UserQna" items="${selectUserQna}">
					<div class="custom_qna_content" onclick="location.href='UserCustomerDetail?qna_num=${UserQna.qna_num}'">
						<div class="custom_answer">
							${UserQna.qna_is_answer}
						</div>
						<div class="custom_content2">
							${UserQna.qna_content}
							<span><button class="btn custom_btn3" style=" font-size: 1.5rem;" >></button></span>
						</div>
						<div class="custom_date">
							${UserQna.qna_date}
						</div>
					</div>
				</c:forEach>
				
				
				<c:forEach var="UserReport" items="${selectUserReport}">
					<div class="custom_qna_content" style="cursor: auto;">
						<div class="custom_answer">
							${UserReport.report_is_accept}
						</div>
						<div class="custom_content2">
							${UserReport.qna_category_detail_name} : 
							${UserReport.report_content}
						</div>
						<div class="custom_date">
							${UserReport.report_date}
						</div>
					</div>
				</c:forEach>
				
			</div>
		</div>
	<jsp:include page="inc/bottom.jsp"></jsp:include>
</body>
</html>