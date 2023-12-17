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
    content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
  />

  <title>TRADEUP | 회원조회</title>

  <meta name="description" content="" />

  <!-- Favicon -->
<!--   <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" /> -->

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
<!--   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin /> -->
  <link
    href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
    rel="stylesheet"
  />
	
	<!-- top css -->
	<jsp:include page="../inc/style.jsp"></jsp:include>
  <!-- Icons. Uncomment required icon fonts -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/fonts/boxicons.css" />

  <!-- Core CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/css/demo.css" />

  <!-- Vendors CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

  <!-- Page CSS -->
  <link href="${pageContext.request.contextPath }/resources/css/admin_style.css" rel="stylesheet" />
  <!-- Helpers -->
  <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/helpers.js"></script>

  <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
  <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
  <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/config.js"></script>
  	<script src="${pageContext.request.contextPath }/resources/js/admin_search_list.js"></script>
	<style type="text/css">
		.product{
		    display: flex;
    		align-items: center;
		}
		.product_info{
			margin-left: 20px;
		    display: flex;
		    flex-direction: column;
		}
	</style>  
</head>

<body>
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<%-- 사이드 메뉴 --%>
			<jsp:include page="inc/side_menu.jsp"></jsp:include>  
			<div class="layout-page">
				<div class="content-wrapper">
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">회원 조회 /</span> 회원 목록</h4>
						<!--/Table -->
						<div class="card">
							<h5 class="card-header">회원 목록</h5>
								<form action="MemberListPeriod" method="post">	
									<div class="reservationConfirmTerm" style="padding-right: 30px; padding-left: 30px; margin-bottom: 25px;padding-top: 30px;">
										<input type="hidden" id="searchType" name="searchType">
										<div id="reservation_confirm_term_right" >
											<div class="calanderWrap">
												<input type="date" id="startDate" name="startDate"> - <input type="date" id="endDate" name="endDate">
<!-- 												<button type="submit" class="btn default" id="search_btn" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: #5F12D3 ;">조회</button> -->
												<button class="btn default" id="search_btn" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: #5F12D3 ;">조회</button>
<!-- 															<button type="submit" class="primary-btn" id="search_btn">조회</button> -->

												<span class="card-header" style="float:inline-end; font-weight: bold; margin-bottom: 25px;">
													총 회원 수&nbsp; : &nbsp; ${memberCount} 명
												</span>
											</div>
										</div>
									</div>
								</form>	
								<!-- --------------------------------------------------------------- -->
								
								<div class="table-responsive text-nowrap">
									<form action="MemberListPeriod" method="post" style="margin:30px">
										<table id="datatablesSimple" >
											<thead>
												<tr>
													<th></th>
													<th>이름</th>
													<th>닉네임</th>
													<th>ID</th>
													<th>E-MAIL</th>
													<th>전화번호</th>
													<th>회원상태</th>
<!-- 													<th>관리자 권한 부여</th> -->
												</tr>
											</thead>
											<tbody>
											<c:forEach var="memberList" items="${memberList}">
												<tr>
													<td><input type="checkbox" id="checkbox" name="checkbox" value="${memberList.member_id}"></td>
													<td>${memberList.member_name}</td>
													<td>${memberList.member_nick_name}</td>
													<td>${memberList.member_id}</td>
													<td>${memberList.member_e_mail}</td>
													<td>${memberList.member_phone_num}</td>
													<td>
														<c:choose>
															<c:when test="${memberList.member_state eq '회원'}">
																<span class="badge bg-label-hold me-1" style="font-size:small;" id="checkedResult">${memberList.member_state}</span>
															</c:when>
															<c:when test="${memberList.member_state eq '관리자'}">
																<span class="badge bg-label-prohibition" style="font-size:small;" id="checkedResult">${memberList.member_state}</span>
															</c:when>
															<c:when test="${memberList.member_state eq '탈퇴'}">
																<span style="color: deeppink; font-size:small; font-weight:bold" id="checkedResult">${memberList.member_state}</span>
															</c:when>
															<c:when test="${memberList.member_state eq '정지'}">
																<span style="color: deeppink; font-size:small; font-weight:bold" id="checkedResult">${memberList.member_state}</span>
															</c:when>
														</c:choose>
													</td>
														
<!-- 													<td><span id="checkedResult">테스트</span></td> -->
<!-- 													<td> -->
<%-- 														<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: black;" onclick="orderPro('${productList.product_num}')">관리자 권한 회수</button> --%>
<%-- 	                        							<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: darkgreen;" onclick="favorite('${productList.product_num}')">관리자 권한 부여</button><br> --%>
<!-- 													</td> -->
												</tr>
											</c:forEach>
											</tbody>
										</table>	
<!-- 									<input type="submit" id="delete_btn"class="btn btn-primary" value="삭제">	 -->
<%-- 											<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 13px; color: #fff; background: black;" onclick="authorization('${memberList.member_id}')">관리자 권한 회수</button> --%>

											<input type="button" class="btn default"  id="revoke" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: black;" value="관리자 권한 회수">
											<input type="button" class="btn default"  id="authorization" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: darkgreen;" value="관리자 권한 부여">
<!-- 											<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 13px; color: #fff; background: black;" id="authorization" >관리자 권한 회수</button> -->
<!--                       						<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 13px; color: #fff; background: darkgreen;" id="revoke">관리자 권한 부여</button><br> -->
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

      <!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>
    <!-- / Layout wrapper -->

	<%-- 바텀 메뉴 --%>
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    
    
    
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/jquery/jquery.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/popper/popper.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/bootstrap.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script> --%>
	<!-- -------------------------------------------------------------------------------------------------- -->

<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/menu.js"></script> --%>
   
   
<%--     <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/main.js"></script> --%>

<!--     <script async defer src="https://buttons.github.io/buttons.js"></script> -->
<!--         <script -->
<!-- 		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" -->
<!-- 		crossorigin="anonymous"></script> -->
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/admin_datatable.js"></script> --%>
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/admin_calender.js"></script> --%>

	
	<!-- -------------------------------------------------------------------------------------------------- -->
	<script src="${pageContext.request.contextPath }/resources/js/admin_authorization.js"></script>
	<script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
    <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/admin_scripts.js"></script> --%>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/demo/admin_pay_pie_chart.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_datatable.js"></script>
	</body>
</html>
