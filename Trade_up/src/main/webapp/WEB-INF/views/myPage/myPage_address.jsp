<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<%--
	계좌 10개까지 등록 가능
	(만약 10개 초과시 추가버튼 안보이게 버튼 수정)
	
	없는 상태에서 배송지 추가하면 404뜸.
	
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
	<script type="text/javascript">
		$(function() {
			let listSize = ${fn:length(my_address)};
			console.log(listSize);
			$("#address_add").on("click", function() {
				if(listSize < 10) {
					window.open('AddAddressFrom'
 							, 'question_from', 'width=600, height=800, location=no, status=no, scrollbars=no');
				} else {
					alert("배송지는 10개까지만 입력가능합니다.");
					return false;
				}
			})
		});	
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
							<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">내 정보 /</span> 배송지 관리
								<c:if test="${not empty my_address }">
									<button 
									id="address_add"
									class="btn rounded-pill btn-icon btn-outline-primary"
									style="float: right;"
									onclick="window.open('AddAddressFrom'
							 							, 'question_from', 'width=600, height=800, location=no, status=no, scrollbars=no')"
								>
									<span class="tf-icons bx bx-plus"></span>
								</button>
								</c:if>
							</h4>
							<div class="row">
								
								<c:forEach var="address" items="${my_address }">
									<!-- Basic -->
									<div class="col-md-6">
										<div class="card mb-4" <c:if test="${address.address_main eq true }">style="border: 2px solid #696cff;"</c:if>>
											<div class="card-body demo-vertical-spacing demo-only-element">
												<div class="dropdown" style="float: right;">
													<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
														<i class="bx bx-dots-vertical-rounded"></i>
													</button>
													<div class="dropdown-menu">
														<c:if test="${address.address_main eq false or empty address.address_main }">
															<a class="dropdown-item" href="ChangeMainInfo?tb=MY_ADDRESS&value=${address.address_idx }&col=address_idx&col2=address_main"
															><i class="bx bx-star me-1"></i> 대표배송지로 지정</a
															>
														</c:if>
														<a class="dropdown-item btn-modal"
														  type="button"
														  class="btn btn-primary"
														  data-bs-toggle="modal"
														  data-bs-target="#addressModal"
														  data-id="${address.address_idx }"
														  >
														  
															<i class="bx bx-edit-alt me-1"></i> 수정
														</a>
														<a class="dropdown-item" href="DeleteInfo?tb=MY_ADDRESS&value=${address.address_idx }&col=address_idx"
														><i class="bx bx-trash me-1"></i> 삭제</a
														>
													</div>
												</div>
												<h5 class="mb-0" id="address_name_${address.address_idx }">${address.address_name }</h5>											
												<hr>
												<p id="recipient_name_${address.address_idx }">${address.recipient_name }</p>
												<p id="recipient_phone_${address.address_idx }">${address.recipient_phone_num }</p>
												<p>
													<span id="postcode_${address.address_idx }">[${address.postcode }] </span>
													<span id="address1_${address.address_idx }">${address.address1 }</span>
													<span id="address2_${address.address_idx }"> ${address.address2 }</span>
												</p>
											</div>
										</div>
									</div>
									<!-- / Basic -->
								</c:forEach>
								<c:if test="${empty my_address}">
									<div class="col-12" >
										<div class="card mb-4" id="account_security_btn" data-bs-toggle="offcanvas"
											href="#offcanvasEnd" style="border: 2px dashed #cbd0d5; cursor: pointer;">
											<div class="card-body text-center" style="padding: 4.5rem 1.5rem;">
												<h5>앗!   등록한 배송지가 없어요.</h5>
												<h6 class="mb-0"><small class="text-muted">우리 같이 배송지등록 해볼까요?</small></h6>
												<h6 class="mb-0"><small class="text-muted">클릭 해주세요!</small></h6>
												<br>
												<h6 class="mb-0"><small class="text-muted">♡°⌒(⭒ᵔ દ ᵔ⭒)ノ</small></h6>
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
	
	<%-- 수정 모달 --%>
	<jsp:include page="modal/address_modal.jsp"></jsp:include>
	<%-- 추가 캔버스 --%>
<%-- 	<%@ include file="offcanvas/address_add.jsp"%> --%>
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
