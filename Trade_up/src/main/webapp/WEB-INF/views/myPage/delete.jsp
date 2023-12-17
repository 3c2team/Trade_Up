<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html
	lang="en"
	class="light-style layout-menu-fixed"
	dir="ltr"
	data-theme="theme-default"
	data-assets-path="../assets/"
	data-template="vertical-menu-template-free"
>
<head>
  <meta charset="utf-8" />
  <meta
    name="viewport"
    content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

	<title>GARGE | MyPage</title>
	
	<meta name="description" content="" />
	
	<!-- top css -->
	<jsp:include page="../inc/style.jsp"></jsp:include>
	<!-- Favicon -->
	<!--     <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" /> -->
	
	<!-- Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
	<link
	  href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	  rel="stylesheet"
	/>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/apex-charts/apex-charts.css" />
	
	<%-- 카테고리 왼쪽 아이콘 --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/fonts/boxicons.css" />
	<!-- Core CSS -->
	<%-- 필수 --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/css/core.css" class="template-customizer-core-css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/css/demo.css" />
	<!-- 없으면 대분류 클릭 시 소분류 안나옴  -->
	<script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/helpers.js"></script>
	<script src="${pageContext.request.contextPath }/resources/myPage/assets/js/config.js"></script>
	
	
	<%----------%>
	
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
</head>
<body>
	<% session.invalidate(); %>
	<div class="layout-wrapper layout-content-navbar ">
		<div class="layout-container align-items-center justify-content-center">
			<div class="col-md-6 col-lg-4 mb-3">
				<div class="card text-center">
					<div class="card-header">
						Trade Up
					</div>
					<div class="card-body">
						<h5 class="card-title">회원탈퇴가 정상적으로 처리되었습니다.</h5>
						<small class="text-muted">
							고객님의 소중한 의견을 반영하여 더 따뜻한 Trade Up이 되도록 노력할게요.<br>
							언제나 이 자리에서 기다리고 있을게요. 언제든지 돌아와주세요.<br>
							지금까지 함께여서 진심으로 행복했어요.<br>
						</small> 
						<a href="./" class="btn btn-primary mt-3">홈페이지로 가기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/menu.js"></script><%-- 필수! --%>
    <!-- endbuild -->

    <!-- Vendors JS -->
	<script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/apex-charts/apexcharts.js"></script>
    <!-- Main JS -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/main.js"></script>	<%-- 필수! --%>

    <!-- Page JS -->
<!--     <script src="../assets/js/pages-account-settings-account.js"></script> -->	<%-- 몰루 --%>

    <!-- Place this tag in your head or just before your close body tag. -->
<!--     <script async defer src="https://buttons.github.io/buttons.js"></script> -->
</body>
</html>