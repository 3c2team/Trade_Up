<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<%-- 탑 메뉴 --%>
	<jsp:include page="../inc/top.jsp"></jsp:include>
    <!-- Layout wrapper -->
	    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<%-- 사이드 메뉴 --%>
			<jsp:include page="inc/side_menu.jsp"></jsp:include> 
				<!-- Layout container -->
			<div class="layout-page">
					<div class="content-wrapper">
				<!-- Content -->
				<div class="container-xxl flex-grow-1 container-p-y">
					<div class="row">
					<!-- 상단 1 -->
						<div class="col-lg-8 mb-4 order-0">
							<div class="card">
								<div class="d-flex align-items-end row">
									<div class="col-sm-7">
										<div class="card-body">
											<h5 class="card-title text-primary">신혜리님 안녕하세요!</h5>
											<p class="mb-4">
												신혜리님의 신뢰도 <span class="fw-bold">30%</span> 입니다.
											</p> 
											<div class="progress" style="height: 6px">
												<div
												class="progress-bar"
												role="progressbar"
												style="width: 30%"
												aria-valuenow="25"
												aria-valuemin="0"
												aria-valuemax="100"
												></div>
											</div>
											<a>거래를 통해 신뢰도를 올릴 수 있어요!</a>
										</div>
									</div>
									<div class="col-sm-5 text-center text-sm-left">
										<div class="card-body pb-0 px-0 px-md-4">
											<img
											src="${pageContext.request.contextPath }/resources/myPage/assets/img/illustrations/man-with-laptop-light.png"
											height="140"
											alt="View Badge User"
											data-app-dark-img="illustrations/man-with-laptop-dark.png"
											data-app-light-img="illustrations/man-with-laptop-light.png"
											/>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- /상단 1 -->
			
						<!-- 상단 2 -->
						<div class="col-lg-4 col-md-4 order-1">
							<div class="row">
								<div class="col-lg-6 col-md-12 col-6 mb-4">
									<div class="card">
										<div class="card-body">
											<div class="card-title d-flex align-items-start justify-content-between">
												<div class="avatar flex-shrink-0">
													<img
													src="${pageContext.request.contextPath }/resources/myPage/assets/img/icons/unicons/wallet.png"
													alt="chart success"
													class="rounded"
													/>
												</div>
												<div class="dropdown">
												</div>
											</div>
											<span class="fw-semibold d-block mb-1">Pay</span>
											<h3 class="card-title mb-2">50,000원</h3>
											<small
												class="text-success fw-semibold"
												data-bs-toggle="modal"
												data-bs-target="#smallModal"
												style="cursor:pointer"
											>충전하기</small>
										</div>
									</div>
								</div>
								<div class="col-lg-6 col-md-12 col-6 mb-4">
									<div class="card">
										<div class="card-body">
											<div class="card-title d-flex align-items-start justify-content-between">
												<div class="avatar flex-shrink-0">
													<img
													src="${pageContext.request.contextPath }/resources/myPage/assets/img/icons/unicons/wallet-info.png"
													alt="Credit Card"
													class="rounded"
													/>
												</div>
												<div class="dropdown">
													<button
													class="btn p-0"
													type="button"
													id="cardOpt6"
													data-bs-toggle="dropdown"
													aria-haspopup="true"
													aria-expanded="false"
													>
														<i class="bx bx-dots-vertical-rounded"></i>
													</button>
													<div class="dropdown-menu dropdown-menu-end" aria-labelledby="cardOpt6">
														<a class="dropdown-item" href="javascript:void(0);">View More</a>
														<a class="dropdown-item" href="javascript:void(0);">Delete</a>
													</div>
												</div>
											</div>
											<span>Sales</span>
											<h3 class="card-title text-nowrap mb-1">$4,679</h3>
											<small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i> +28.42%</small>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- / 상단 2 -->
					</div>
						
					<div class="row">
						<!-- 거래내역 -->
						<div class="col-md-6 col-lg-4 col-xl-4 order-0 mb-4">
							<div class="card h-100">
								<div class="card-header d-flex align-items-center justify-content-between pb-0">
									<div class="card-title mb-0">
										<h5 class="m-0 me-2">거래내역</h5>
										<small class="text-muted">이번달 거래내역</small>
									</div>
									<div class="dropdown">
										<button
										class="btn p-0"
										type="button"
										id="orederStatistics"
										data-bs-toggle="dropdown"
										aria-haspopup="true"
										aria-expanded="false"
										>
											<i class="bx bx-dots-vertical-rounded"></i>
										</button>
										<div class="dropdown-menu dropdown-menu-end" aria-labelledby="orederStatistics">
											<a class="dropdown-item" href="javascript:void(0);">Select All</a>
											<a class="dropdown-item" href="javascript:void(0);">Refresh</a>
											<a class="dropdown-item" href="javascript:void(0);">Share</a>
										</div>
									</div>
								</div>
								<div class="card-body">
									<div class="d-flex justify-content-between align-items-center mb-3">
										<div class="d-flex flex-column align-items-center gap-1">
											<h2 class="mb-2">8,258</h2>
											<span>Total Orders</span>
										</div>
										<div id="orderStatisticsChart"></div>
									</div>
									<ul class="p-0 m-0">
										<li class="d-flex mb-4 pb-1">
											<div class="avatar flex-shrink-0 me-3">
												<span class="avatar-initial rounded bg-label-success"><i class="bx bx-closet"></i></span>
											</div>
											<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
												<div class="me-2">
													<h6 class="mb-0">Fashion</h6>
													<small class="text-muted">T-shirt, Jeans, Shoes</small>
												</div>
												<div class="user-progress">
													<small class="fw-semibold">23.8k</small>
												</div>
											</div>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<!--/ 거래내역 -->
			
						<!-- Expense Overview -->
						<div class="col-md-6 col-lg-4 order-1 mb-4">
							<div class="card h-100">
								<div class="card-header">
									<ul class="nav nav-pills" role="tablist">
										<li class="nav-item">
											<button
											type="button"
											class="nav-link active"
											role="tab"
											data-bs-toggle="tab"
											data-bs-target="#navs-tabs-line-card-income"
											aria-controls="navs-tabs-line-card-income"
											aria-selected="true"
											>
												Income
											</button>
										</li>
										<li class="nav-item">
											<button type="button" class="nav-link" role="tab">Expenses</button>
										</li>
										<li class="nav-item">
											<button type="button" class="nav-link" role="tab">Profit</button>
										</li>
									</ul>
								</div>
								<div class="card-body px-0">
									<div class="tab-content p-0">
										<div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel">
											<div class="d-flex p-4 pt-3">
												<div class="avatar flex-shrink-0 me-3">
													<img src="${pageContext.request.contextPath }/resources/myPage/assets/img/icons/unicons/wallet.png" alt="User" />
												</div>
												<div>
													<small class="text-muted d-block">Total Balance</small>
													<div class="d-flex align-items-center">
														<h6 class="mb-0 me-1">$459.10</h6>
														<small class="text-success fw-semibold">
															<i class="bx bx-chevron-up"></i>
															42.9%
														</small>
													</div>
												</div>
											</div>
										<div id="incomeChart"></div>
											<div class="d-flex justify-content-center pt-4 gap-2">
												<div class="flex-shrink-0">
													<div id="expensesOfWeek"></div>
												</div>
												<div>
													<p class="mb-n1 mt-1">Expenses This Week</p>
													<small class="text-muted">$39 less than last week</small>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!--/ Expense Overview -->
			
						<!-- Transactions -->
							<div class="col-md-6 col-lg-4 order-2 mb-4">
								<div class="card h-100">
									<div class="card-header d-flex align-items-center justify-content-between">
										<h5 class="card-title m-0 me-2">Pay 사용내역</h5>
										<div class="dropdown">
											<button
											class="btn p-0"
											type="button"
											id="transactionID"
											data-bs-toggle="dropdown"
											aria-haspopup="true"
											aria-expanded="false"
											>
												<i class="bx bx-dots-vertical-rounded"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-end" aria-labelledby="transactionID">
												<a class="dropdown-item" href="javascript:void(0);">Last 28 Days</a>
												<a class="dropdown-item" href="javascript:void(0);">Last Month</a>
												<a class="dropdown-item" href="javascript:void(0);">Last Year</a>
											</div>
										</div>
									</div>
									<div class="card-body">
										<ul class="p-0 m-0">
											<li class="d-flex mb-4 pb-1">
												<div class="avatar flex-shrink-0 me-3">
													<img src="${pageContext.request.contextPath }/resources/myPage/assets/img/icons/unicons/paypal.png" alt="User" class="rounded" />
												</div>
												<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
													<div class="me-2">
														<small class="text-muted d-block mb-1">Paypal</small>
														<h6 class="mb-0">Send money</h6>
													</div>
													<div class="user-progress d-flex align-items-center gap-1">
														<h6 class="mb-0">+82.6</h6>
														<span class="text-muted">USD</span>
													</div>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>
						<!--/ Transactions -->
						</div>
					</div>
				<!-- / Content -->
				</div>
			</div>
		</div>
	</div>
	
	<%-- 모달  --%>
	<jsp:include page="modal/up_pay.jsp"></jsp:include>
	<%-- 바텀 메뉴 --%>
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	
	
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
