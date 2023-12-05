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

  <title>TRADEUP | 거래내역</title>

  <meta name="description" content="" />
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
  <!-- Custom fonts for this template-->
<%--   <link href="${pageContext.request.contextPath }/resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"> --%>
  <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
  <link href="${pageContext.request.contextPath }/resources/admin/css/sb-admin-2.min.css" rel="stylesheet">
<%--   <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" /> --%>
  <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/helpers.js"></script>
  <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/config.js"></script>
	<style type="text/css">
		.text-xs{font-size:.9rem}
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
					<div class="container-xxl flex-grow-1 container-p-y container-admin-main">
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">관리자 페이지 /</span> 메인</h4>
						<!--/Table -->
<!-- 						<div class="card"> -->
<!-- 							<h5 class="card-header">거래 내역</h5> -->
								 <!-- Content Row -->
                    <div class="row">

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                              주간 수수료 금액</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><fmt:formatNumber value="${commission }" pattern="#,###" /> 원</div>
                                        </div>
                                        <div class="col-auto">
<!--                                             <i class="fas fa-calendar fa-2x text-gray-300"></i> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                주간 거래량</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><fmt:formatNumber value="${count }" pattern="#,###" /> 건</div>
                                        </div>
                                        <div class="col-auto">
<!--                                             <i class="fas fa-dollar-sign fa-2x text-gray-300"></i> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">주간 회원가입 수
                                            </div>
	                                        <div class="row no-gutters align-items-center">
	                                            <div class="col-auto">
	<!--                                                     <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div> -->
												<div class="h5 mb-0 font-weight-bold text-gray-800">${memberInCount} 명</div>
	                                            </div>
	                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                               주간 회원탈퇴 수</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${memberOut } 명</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
						<br><br>
                    <!-- Content Row -->
								<!-- -------------------------------------------------------------- -->
							<div id="layoutSidenav_content">
							<main>
								<div class="row">
									<!-- AreaChart  -->
									<div class="col-xl-6">
										<div class="card-header py-3">
                                			<h6 class="m-0 font-weight-bold text-primary">수수료 현황</h6>
                            			</div>
		                                <div class="card-body">
		                                    <div class="chart-area">
		                                        <canvas id="myAreaChart"></canvas>
		                                    </div>
		                                </div>
									</div>
									
									<!-- PieChart  -->
									<div class="col-xl-6">
											<div class="card-header">
												<h6 class="m-0 font-weight-bold text-primary">거래 방법 현황</h6>
											</div>
											<br><br>
											<div class="card-body">
												<canvas id="myPieChart" width="100%" height="40"></canvas>
											</div>
											<br>
									</div>
								</div>	
							</main>
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
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/main.js"></script>
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
    <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<%-- 	<script src="${pageContext.request.contextPath }/resources/js/admin_scripts.js"></script> --%>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>

	
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
	<script src="${pageContext.request.contextPath }/resources/demo/admin_pay_pie_chart.js"></script>
	<script src="${pageContext.request.contextPath }/resources/demo/admin_pay_area_chart.js"></script>

	</body>
</html>
