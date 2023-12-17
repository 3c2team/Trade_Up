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

	<title>Trade Up</title>
	
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
												<h5 class="card-title text-primary">${sessionScope.sName }님 안녕하세요!</h5>
												<p class="mb-4">
													${sessionScope.sName }님은 지금까지 총 <span class="fw-bold">${depositCount }</span>번의 거래를 하셨어요!
												</p> 
<!-- 												<div class="progress" style="height: 6px"> -->
<!-- 													<div -->
<!-- 													class="progress-bar" -->
<!-- 													role="progressbar" -->
<!-- 													style="width: 100%" -->
<!-- 													aria-valuenow="25" -->
<!-- 													aria-valuemin="0" -->
<!-- 													aria-valuemax="100" -->
<!-- 													></div> -->
<!-- 												</div> -->
<!-- 												<a></a> -->
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
												<h3 class="card-title mb-2">${RemainPay }<c:if test="${empty RemainPay }">0</c:if>원</h3>
												<small
													class="text-success fw-semibold"
													data-bs-toggle="modal"
													data-bs-target="#up_pay"
													style="cursor:pointer"
												>충전하기</small>
												
												<small
													class="text-success fw-semibold"
													data-bs-toggle="modal"
													data-bs-target="#up_pay_re"
													style="cursor:pointer"
												>송금하기</small>
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
												</div>
												<span>이번달 지출금액</span>
												<h3 class="card-title text-nowrap mb-1"><c:if test="${empty totalWithdraw }">0</c:if>${totalWithdraw } 원</h3>
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
									<div class="card-header d-flex align-items-center justify-content-between">
										<h5 class="card-title m-0 me-2">관심목록</h5>
										<div class="dropdown">
										</div>
									</div>
									<div class="card-body">
										<ul class="p-0 m-0">
											<c:if test="${empty favoriteList }">
												<div class="text-center" onclick="location.href='Shop'" style="cursor: pointer;">
													<h5>앗!   관심목록에 등록한 상품이 없어요.</h5>
													<h6 class="mb-0"><small class="text-muted">우리 같이 다른 고객님이 올려주신 상품 구경하러 가볼까요?</small></h6>
													<h6 class="mb-0"><small class="text-muted">클릭 해주시면 저희가 이동시켜드릴게요!</small></h6>
													<br>
													<h6 class="mb-0"><small class="text-muted"> * : ˚·✧* : ˚·✧ ヾ꒰ྀི *ˊᵕˋ ꒱ྀིﾉ ✧·˚ : *✧·˚ : *</small></h6>
												</div>
											</c:if>
											<c:forEach var="favorite" items="${favoriteList }" end="7">
												<li class="d-flex mb-4 pb-1">
													<div class="avatar flex-shrink-0 me-3">
														<img src="${favorite.product_main_img }" class="rounded" />
													</div>
													<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
														<div class="me-2">
															<h6 class="mb-0">${favorite.product_name }</h6>
															<small class="text-muted d-block mb-1">${favorite.member_id }</small>
														</div>
														<div class="user-progress d-flex align-items-center gap-1">
															<h6 class="mb-0">${favorite.product_price }</h6>
														</div>
													</div>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
							<!--/ 거래내역 -->
				
							<!-- Expense Overview -->
							<div class="col-md-6 col-lg-4 order-1 mb-4">
								<div class="card h-100">
									<div class="card-header d-flex align-items-center justify-content-between">
										<h5 class="card-title m-0 me-2">구매내역</h5>
										<div class="dropdown">
										</div>
									</div>
									<div class="card-body">
										<ul class="p-0 m-0">
											<c:if test="${empty productsList }">
												<div class="text-center" onclick="location.href='Shop'" style="cursor: pointer;">
													<h5>앗!   구매하신 상품이 없어요.</h5>
													<h6 class="mb-0"><small class="text-muted">우리 같이 다른 고객님이 올려주신 상품 구경하러 가볼까요?</small></h6>
													<h6 class="mb-0"><small class="text-muted">클릭 해주시면 저희가 이동시켜드릴게요!</small></h6>
													<br>
													<h6 class="mb-0"><small class="text-muted">ଘ(❁•̀ 3 •́)━☆*✲⋆✧･ﾟ: *✧･ﾟ:* *:･ﾟ✧*:･ﾟ✧</small></h6>
												</div>
											</c:if>
											<c:forEach var="products" items="${productsList }" end="7">
												<li class="d-flex mb-4 pb-1">
													<div class="avatar flex-shrink-0 me-3">
														<img src="${products.product_main_img }" class="rounded" />
													</div>
													<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
														<div class="me-2">
															<h6 class="mb-0">${products.product_name }</h6>
															<small class="text-muted d-block mb-1">${products.member_id }</small>
														</div>
														<div class="user-progress d-flex align-items-center gap-1">
															<h6 class="mb-0">${products.product_price }</h6>
														</div>
													</div>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
							<!--/ Expense Overview -->
				
							<!-- Transactions -->
							<div class="col-md-6 col-lg-4 order-2 mb-4">
								<div class="card h-100">
									<div class="card-header d-flex align-items-center justify-content-between">
										<h5 class="card-title m-0 me-2">판매내역</h5>
										<div class="dropdown"></div>
									</div>
									<div class="card-body">
										<ul class="p-0 m-0">
											<c:if test="${empty salesList }">
												<div class="text-center" onclick="location.href='ShopForm'" style="cursor: pointer;">
													<h5>앗!   판매중인 상품이 없어요.</h5>
													<h6 class="mb-0"><small class="text-muted">우리 같이 상품등록 하러 가볼까요?</small></h6>
													<h6 class="mb-0"><small class="text-muted">클릭 해주시면 저희가 이동시켜드릴게요!</small></h6>
													<br>
													<h6 class="mb-0"><small class="text-muted">(つ˵•́ω•́˵)つ━☆.。.:*・°☆ ｡+.｡☆ﾟ:;｡+ﾟ</small></h6>
												</div>
											</c:if>
											<c:forEach var="sales" items="${salesList }" end="7">
												<li class="d-flex mb-4 pb-1">
													<div class="avatar flex-shrink-0 me-3">
														<img src="${sales.product_main_img }" class="rounded" />
													</div>
													<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
														<div class="me-2">
															<h6 class="mb-0">${sales.product_name }</h6>
															<small class="text-muted d-block mb-1">${sales.member_id }</small>
														</div>
														<div class="user-progress d-flex align-items-center gap-1">
															<h6 class="mb-0">${sales.product_price }</h6>
														</div>
													</div>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%-- 업페이 충전 모달 --%>
	<%@ include file="modal/up_pay.jsp" %>
	<%-- 업페이 송금 모달 --%>
	<%@ include file="modal/up_pay_re.jsp" %>
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
