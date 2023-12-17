<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%--
	추가등록 모달 만들기
	계좌 10개까지 등록 가능
	(만약 10개 초과시 추가버튼 안보이게 버튼 수정)
	
	만약 대표계좌가 없으면 대표계좌 설정 오류는 안나는디.....찝찝하다...!!!

--%>
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

    <title>Trade Up</title>

    <meta name="description" content="" />

	<!-- top css -->
	<jsp:include page="../inc/style.jsp"></jsp:include>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
	<script src="${pageContext.request.contextPath }/resources/myPage/assets/js/config.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<style type="text/css">
		#account_security_btn {
			cursor: pointer;
		}
	</style>
	<script type="text/javascript">
		function authAccount() {
			let requestUri = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
								+ "response_type=code"
								+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
								+ "&redirect_uri=http://c3d2306t2.itwillbs.com/Trade_up/callback"	//나중에 수정
								+ "&scope=login inquiry transfer oob"
				//					+ "&scope=login inquiry transfer"
								+ "&state=12345678901234567890123456789012"
								+ "&auth_type=0";
			window.open(requestUri, "authWindow", "width=600, height=800");	
		}
	</script>
</head>

<body>
	<%-- 탑 메뉴 --%>
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<%-- 사이드 메뉴 --%>
			<jsp:include page="inc/side_menu.jsp"></jsp:include>  
			<div class="layout-page">
				<div class="content-wrapper">
					<div class="container-xxl flex-grow-1 container-p-y">
						<div class="container-xxl flex-grow-1 container-p-y">
							<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">내 정보 /</span> 계좌 관리
								<c:if test="${not empty my_account }">
									<button id="account_add"
											class="btn rounded-pill btn-icon btn-outline-primary"
											data-bs-toggle="modal"
											data-bs-target="#accountModal"
											style="float: right;">
										<span class="tf-icons bx bx-plus"></span>
									</button>
								</c:if>
							</h4>
							<div class="row">
								<c:if test="${empty token }">
									<div class="col-12" >
										<div class="card mb-4" id="account_security_btn" onclick="authAccount()" style="border: 2px dashed #cbd0d5;">
											<div class="card-body text-center" style="padding: 4.5rem 1.5rem;">
												<h5>계좌등록을 위해 본인인증이 필요합니다.</h5>
												<h6 class="mb-0"><small class="text-muted">클릭 시 본인인증을 진행합니다.</small></h6>
											</div>
										</div>
									</div>
								</c:if>
								<c:forEach var="account" items="${my_account }">
									<!-- Basic -->
									<div class="col-md-6">
										<div class="card mb-4" <c:if test="${account.account_main eq true }">style="border: 2px solid #696cff;"</c:if>>
											<div class="card-body demo-vertical-spacing demo-only-element">
												<div class="dropdown" style="float: right;">
													<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
														<i class="bx bx-dots-vertical-rounded"></i>
													</button>
													<div class="dropdown-menu">
														<c:if test="${account.account_main eq false or empty account.account_main }">
															<a class="dropdown-item" href="ChangeMainInfo?tb=MY_ACCOUNT&value=${account.account_idx }&col=account_idx&col2=account_main"
															><i class="bx bx-star me-1"></i> 대표계좌로 지정</a
															>
														</c:if>
														
														<a class="dropdown-item" href="DeleteInfo?tb=MY_ACCOUNT&value=${account.account_idx }&col=account_idx"
														><i class="bx bx-trash me-1"></i> 삭제</a
														>
													</div>
												</div>
												<h5 class="mb-0">${account.account_bank }</h5>											
												<hr>
												<p>${account.account_holder_name }</p>
												<p>${account.account_num }</p>
											</div>
										</div>
									</div>
									<!-- / Basic -->
								</c:forEach>
								<c:if test="${empty my_account and not empty token}">
									<div class="col-12" >
										<div class="card mb-4" id="account_security_btn" data-bs-toggle="modal"
											href="#accountModal" style="border: 2px dashed #cbd0d5; cursor: pointer;">
											<div class="card-body text-center" style="padding: 4.5rem 1.5rem;">
												<h5>앗!   등록한 계좌가 없어요.</h5>
												<h6 class="mb-0"><small class="text-muted">우리 같이 계좌등록 해볼까요?</small></h6>
												<h6 class="mb-0"><small class="text-muted">클릭 해주세요!</small></h6>
												<br>
												<h6 class="mb-0"><small class="text-muted">◝(⑅•ᴗ•⑅)◜..°♡</small></h6>
											</div>
										</div>
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div> <!-- Content Wrapper -->
			</div> <!-- / Layout page -->
		</div> <!-- / Layout Container -->
	</div> <!-- / Layout Wrapper -->
	
	<%-- 계좌 등록 모달 --%>
	<jsp:include page="modal/account_modal.jsp"></jsp:include>
	<%-- 바텀 메뉴 --%>
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>
