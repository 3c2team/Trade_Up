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
	.custom_text{
		background-color: #e7e7e7;
	    border-radius: 10px 10px;
	}
	.custom_btn{
		height: 50px;
	    display: inline-block;
	    font-weight: 400;
	    color: #212529;
	    text-align: center;
	    vertical-align: middle;
	    user-select: none;
	    background-color: transparent;
	    border: 1px solid transparent;
	    padding: 0.375rem 0.75rem;
	    font-size: 1rem;
	    line-height: 1.5;
	    border-radius: 5rem;
	    border-color: #e1e3e5;
	    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
		margin: 1%;
	}
	.custom_hr{
		margin-top: 1rem;
	    margin-bottom: 0;
	    border-top: 1px solid rgba(0,0,0,.1);
	    border-color: black;
	}

	.custom_select{
	    padding-left: 20px;
	    padding-top: 1rem;
	    padding-bottom: 1rem;
	    border-bottom: solid;
	    border-color: aliceblue;
	    cursor: pointer;
	}
	.custom_sticky{
	    position: sticky;
	    top: 0;
	    z-index: 1020;
	    background-color: white;
	}
	.custom_qna_content{
		white-space: pre-line;
		height: 80px;
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
</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
		<div class="custom_flex2" style="width: 40%;">
			<h2 class="fw-bold" style="text-align: center;">고객센터</h2>
			<hr class="custom_border_grove">
			<h3 class="fw-bold">자주 묻는 질문FAQ</h3>
			<div class="shop__sidebar__search" style="margin-top: 5%;">
				<form onSubmit="return customer()">
					<input type="text" id="select" class="custom_text" placeholder="궁금하신점을 입력해주세요">
					<button id= "result"type="button"><span class="icon_search"></span></button>
				</form>
			</div>
			<div class="custom_sticky">
				<button class="custom_btn defualt" style="background-color: rgb(25 28 33); color: aliceblue;" value="0">전체</button>
				<button class="custom_btn" value="1">거래문의</button>
				<button class="custom_btn" value="2">이용문의</button>
				<button class="custom_btn" value="3">회원/계정</button>
				<button class="custom_btn" value="4">운영정책</button>
				<button class="custom_btn" value="5">기타</button>
			</div>
			<div  id="qna_board">
			</div>
			<div class="d-grid gap-2">
				<input type="button" class="btn btn-light" value="1대1 문의하기" onclick="location.href='RegistQuewstion'">
				<input type="button" id="open" class="btn btn-light" value="내 문의 내역"onclick="location.href='UserCustomer'">
			</div>
		</div>
	<jsp:include page="inc/bottom.jsp"></jsp:include>
	<script type="text/javascript">
		$(function() {
			$.ajax({
				type: "POST",
				url: "SelectOftenQna",
				data: {
					qna_filter : 0
				},
				dataType: 'json',
				success: function(data) {
					let count = 0;
					data.forEach(items => {
						$("#qna_board").append("<div class='custom_qna_content' name='non_hidden_" +count  +"'>"+items.qna_content+"</div>");
						$("#qna_board").append("<pre><div class='custom_qna_answer' hidden name='non_hidden_" +count  +"'>"+items.qna_answer+"</div></pre>");
						count++;
					});
					$(".custom_qna_content").on("click",function(){
						let name = $(this).attr("name");
						console.log(name);
						$(".custom_qna_answer").attr("hidden",true);
						$("[name="+name+"]").attr("hidden",false);
					});
				},erorr: function() {
					alert("실패");
				}
			});
		});
		$(".custom_btn").on("click",function(){
			$("#qna_board").html("");
			$(".custom_btn").css("background-color","transparent");
			$(".custom_btn").css("color","black");
			$(this).css("background-color","rgb(25 28 33)");
			$(this).css("color","aliceblue");
			$.ajax({
				type: "POST",
				url: "SelectOftenQna",
				data: {
					qna_filter : $(this).val()
				},
				dataType: 'json',
				success: function(data) {
					let count = 0;
					data.forEach(items => {
						$("#qna_board").append("<div class='custom_qna_content' name='non_hidden_" +count  +"'>"+items.qna_content+"</div>");
						$("#qna_board").append("<pre><div class='custom_qna_answer' hidden name='non_hidden_" +count  +"'>"+items.qna_answer+"</div></pre>");
						count++;
					});
					$(".custom_qna_content").on("click",function(){
						let name = $(this).attr("name");
						console.log(name);
						$(".custom_qna_answer").attr("hidden",true);
						$("[name="+name+"]").attr("hidden",false);
					});
				},erorr: function() {
					alert("실패");
				}
			});
		});
		function customer() {
			$(".custom_btn").css("background-color","transparent");
			$(".custom_btn").css("color","black");
			$(".defualt").css("background-color","rgb(25 28 33)");
			$(".defualt").css("color","aliceblue");
			$("#qna_board").html("");
// 			debugger;
			$.ajax({
				type: "POST",
				url: "SelectOftenQna",
				data: {
					qna_select : $("#select").val(),
					qna_filter : 0
				},
				dataType: 'json',
				success: function(data) {
					let count = 0;
					data.forEach(items => {
						$("#qna_board").append("<div class='custom_qna_content' name='non_hidden_" +count  +"'>"+items.qna_content+"</div>");
						$("#qna_board").append("<pre><div class='custom_qna_answer' hidden name='non_hidden_" +count  +"'>"+items.qna_answer+"</div></pre>");
						count++;
					});
					$(".custom_qna_content").on("click",function(){
						let name = $(this).attr("name");
						console.log(name);
						$(".custom_qna_answer").attr("hidden",true);
						$("[name="+name+"]").attr("hidden",false);
					});
				},erorr: function() {
					alert("실패");
				}
			});
			return false;	
		}
	</script>
</body>
</html>