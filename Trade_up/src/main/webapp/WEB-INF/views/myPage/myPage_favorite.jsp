<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	<title>Trade Up</title>
	
	<meta name="description" content="" />
	
	<!-- Favicon -->
	<!--   <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" /> -->
	
	<!-- Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
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
	
	<!-- Helpers -->
	<script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/helpers.js"></script>
	
	<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
	<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
	<script src="${pageContext.request.contextPath }/resources/myPage/assets/js/config.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/jquery.twbsPagination.min.js"></script>
	
	<style type="text/css">
		.form-check-input {
			position: initial;
			margin-top: 0px;
			margin-left: 0px;
		}
	</style>
	
	<script type="text/javascript">
// 		let totalCount = ${fn:length(favoriteList)};
// 		let pageSize = 5;
// 		let pageNumber = 1;
		
// 		let totalPages = totalCount / 10;
		
// 		if(totalCount % 10 > 0) {
// 			totalPages++;
// 		}
		
// 		$('#pagination').twbsPagination({ 
// 			startPage:1,
// 			totalPages: totalPages,
// 		    visiblePages: 10,
		    
// 		    first:'<span sris-hidden="true">«</span>' ,
		    
// 		    last:'<span sris-hidden="true">»</span>' ,
		    
// 		    prev:"<",
// 		    next:">",
// 		    onPageClick: function (event, page) {
		    
// 		        alert(page); 
// 		            }
// 		     })
		
	</script>
	
</head>
<body>
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<!-- container -->
		<div class="layout-container">
			<%-- 사이드 메뉴 --%>
			<jsp:include page="inc/side_menu.jsp"></jsp:include>  
			<!-- layout -->
			<div class="layout-page">
				<div class="content-wrapper">
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">나의 거래 /</span> 관심목록</h4>
						<!-- Table -->
						<div class="card" <c:if test="${empty favoriteList }">style="display: none;"</c:if>>
							<h5 class="card-header">관심목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="text-center align-middle">
										<tr>
											<th colspan="2">상품명</th>
											<th>금액</th>
											<th>판매자</th>
											<th>거래상태</th>
											<th>거래방법</th>
											<th></th>
										</tr>
									</thead>
									<tbody class="table-border-bottom-0 text-center">
										<c:forEach var="favorite" items="${favoriteList }">
											<tr>
												<td class="align-middle" width="120px"><img height="70px" src="${favorite.product_main_img }"></td>
												<td class="text-left align-middle" onclick="location.href='ShopDetail?product_num=${favorite.product_num }'" style="cursor:pointer">
													${favorite.product_name }
												</td>
												<td class="align-middle">${favorite.product_price }</td>
												<td class="align-middle">${favorite.member_id }</td>
												<td class="align-middle">
													<c:choose>
														<c:when test="${favorite.sales_status eq '거래중'}">
															<span class="badge bg-label-secondary">거래중</span>
														</c:when>
														<c:when test="${favorite.sales_status eq '거래완료' }">
															<span class="badge bg-label-success">거래완료</span>
														</c:when>
														<c:otherwise>
															<span class="badge bg-label-primary">판매중</span>
														</c:otherwise>
													</c:choose>

												</td>
												<td class="align-middle">
													<c:choose>
														<c:when test="${favorite.trading_method eq 'direct '}">
															<span class="badge bg-label-warning">직거래</span>
														</c:when>
														<c:when test="${favorite.trading_method eq 'delivery'}">
															<span class="badge bg-label-info">택배</span>
														</c:when>
														<c:otherwise>
															<span class="badge bg-label-info">택배</span>
															<span class="badge bg-label-warning">직거래</span>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="align-middle">
													<a href="DeleteFavorite?favorit_idx=${favorite.favorite_idx }">    
														<i class="tf-icons bx bx-trash"></i>
													</a>
												</td>
											</tr>
										</c:forEach>
										
									</tbody>
								</table>
							</div>
							<div class="row">
								<div class="align-middle">
									
								</div>
							</div>
						</div>
						<!--/Table -->
						<c:if test="${empty favoriteList}">
							<div class="col-12" >
								<div class="card mb-4" id="account_security_btn" onclick="location.href='Shop'" style="border: 2px dashed #cbd0d5; cursor: pointer;">
									<div class="card-body text-center" style="padding: 4.5rem 1.5rem;">
										<h5>앗!   관심목록에 등록한 상품이 없어요.</h5>
										<h6 class="mb-0"><small class="text-muted">우리 같이 다른 고객님이 올려주신 상품 구경하러 가볼까요?</small></h6>
										<h6 class="mb-0"><small class="text-muted">클릭 해주시면 저희가 이동시켜드릴게요!</small></h6>
										<br>
										<h6 class="mb-0"><small class="text-muted"> * : ˚·✧* : ˚·✧ ヾ꒰ྀི *ˊᵕˋ ꒱ྀིﾉ ✧·˚ : *✧·˚ : *</small></h6>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			<!-- layout -->
		</div>
		<!-- /container -->
	</div>
    <!-- / Layout wrapper -->
	
	<%-- 바텀 메뉴 --%>
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath }/resources/myPage/assets/vendor/js/bootstrap.js"></script>
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
