<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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

  <title>TRADEUP | 입금내역</title>

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

  <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/config.js"></script>
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
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">업페이 /</span> 수수료 내역</h4>
						<!--/Table -->
<!-- 						<div class="row"> -->
<!--                                <div class="card-header py-3"> -->
<!--                                    <h6 class="m-0 font-weight-bold text-primary" style="position: absolute;">수수료 차트</h6> -->
<!--                                </div> -->
<!--                                <div class="card-body"> -->
<!-- 	                        	<div class="chart-area"> -->
<%-- 	                            	<canvas id="myAreaChart" style="display: block;width: 1000px;height: 200px;"></canvas> --%>
<!-- 	                            </div> -->
<!-- 	                        </div> -->
<!-- 						</div>	 -->
<!-- 						<br><br> -->
						<div class="card">
							<h5 class="card-header">수수료 내역</h5>
								<form action="ChargeSearch" method="post" style="margin-bottom: -25px;">	
<!-- 								<form>	 -->
									<div class="reservationConfirmTerm" style="padding-right: 30px; padding-left: 30px; margin-bottom: 20px;padding-top: 30px;">
										<input type="hidden" id="searchType" name="searchType">
										<div id="reservation_confirm_term_right" >
											<div class="calanderWrap" style="margin-bottom: 25px;">
												<input type="date" id="startDate" name="startDate" > - <input type="date" id="endDate" name="endDate">
<!-- 												<button type="submit" class="badge bg-label-prohibition" id="search_btn">조회</button> -->
												<button type="submit" class="btn default" id="search_btn" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: #5F12D3 ;">조회</button>
												<span class="card-header" style="float:inline-end; font-weight: bold; margin-bottom: 25px;">
													수수료 합계 : <fmt:formatNumber value="${commission }" pattern="#,###" /> 원
												</span>
											</div>
										</div>
							    	</div>
								</form>	
							<!-- --------------------------------------------------------------- -->
								
								<div class="table-responsive text-nowrap">
									<form action="AdminNoticeDelete" method="post" style="margin:30px">
										<table id="datatablesSimple">
											<thead>
												<tr>
<!-- 													<th>#</th> -->
													<th>상품정보</th>
													<th>구매자</th>
													<th>구매완료 여부</th>
													<th>출금액</th>
													<th>수수료</th>
													<th>출금계좌</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach var="CommissionList" items="${CommissionList}">
												<tr>
<!-- 													<td><input type="checkbox" name="checkbox" value=""></td> -->
													<td>
<!-- 														<div class=""> -->
															<div class=""><strong>****상품명****</strong></div>
<!-- 														</div> -->
													</td>
													<td>${CommissionList.member_name}</td>
													<td>
														<c:choose>
															<c:when test="${CommissionList.buy_check eq '확정대기'}">
																<span class="badge bg-label-hold me-1" style="font-size:small;">${CommissionList.buy_check}</span>
															</c:when>
															<c:when test="${CommissionList.buy_check eq '구매 확정'}">
																<span class="badge bg-label-approval me-1" style="font-size:small;">${CommissionList.buy_check}</span>
															</c:when>
														</c:choose>
<%-- 														<span class="badge bg-label-hold me-1" style="font-size:small;">${depositList.buy_check }</span> --%>
													</td>
													<td>
								                        <span class="badge bg-label-approval me-1" style="font-size:small;">${CommissionList.product_price}원</span>	
													</td>
													<td>
								                        <span class="badge bg-label-prohibition" style="font-size:small;">${CommissionList.commission}원</span>	
													</td>
													<td>
								                        <span>${CommissionList.withdraw_bank} (${CommissionList.withdraw_acc})</span>	
													</td>
												</tr>												
											</c:forEach>
											</tbody>
										</table>
										
<!-- 										<input type="submit" id="delete_btn"class="btn btn-primary" value="삭제">	 -->
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- 바텀 메뉴 --%>
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/admin/product_sales.js"></script> --%>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
<%-- 		<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<!-- ---------------------------------------------------------------------------------------------------- -->
<!-- 	<script -->
<!-- 		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" -->
<!-- 		crossorigin="anonymous"></script> -->
<%-- 	<script src="${pageContext.request.contextPath }/resources/demo/sales_month_chart.js"></script> --%>
	
	<!-- -------------------------------------------------------------------------------------------- -->
	    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath }/resources/admin/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath }/resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath }/resources/admin/js/sb-admin-2.min.js"></script>
    <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath }/resources/admin/vendor/chart.js/Chart.min.js"></script>
    <!-- Page level custom scripts -->
<%--     <script src="${pageContext.request.contextPath }/resources/admin/js/demo/chart-area-demo.js"></script> --%>
    
    <script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_datatable.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_calender.js"></script>
	<script src="${pageContext.request.contextPath }/resources/demo/admin_pay_area_chart.js"></script>
	</body>
</html>
