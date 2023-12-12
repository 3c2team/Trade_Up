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
.custom_div_box{
    background: #f9fafc;
    border: solid;
    border-width: 1px;
    border-color: #b8bec5;
    padding: 1.25rem;
    border-radius: 0.5rem ;
    margin-bottom: 1rem ;
    display: flex;
    padding-top: 20px;
    padding-bottom: 20px;
}
.user_profile{
	width: 60px;
	height: 60px;
	border-color: rgb(255 255 255);
	border-radius: 9999px;
}
.user_name{
	font-size: 1.5rem;
	line-height: 2rem;
	font-weight: 600;
	margin-left: 20px;
}
.user_box{
    width: 50%;
    display: flex;
    border-right: solid;
    border-color: #b8bec5;
    border-width: 1px;
    padding: 20px;

}
</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
		<div  style="width: 80%; margin: auto;">
			<div class="custom_div_box">
				<div class="user_box">
					<img class="user_profile" alt="" src="https://img2.joongna.com/common/Profile/Default/profile_m.png">
					<div>
						<h1 class="user_name">응애</h1>
						<div style="color: rgb(156 163 175);margin-left: 20px;margin-top: 5px;">2023년12월12일</div>
					</div>
				</div>
			<div>
				<h1 class="user_name">거래횟수 : </h1>
			</div>
			</div>
		</div>
	<jsp:include page="inc/bottom.jsp"></jsp:include>
</body>
</html>