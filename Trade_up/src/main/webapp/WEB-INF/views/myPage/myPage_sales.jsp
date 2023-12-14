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
	
	<title>GARGE | MyPage</title>
	
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
	<script type="text/javascript">
		function deleteMyProduct(pro_num, sales_status) {
			console.log(pro_num, sales_status);
			
			if(sales_status == '거래중') {
				alert("거래중인 상품은 삭제할 수 없습니다.");
				return false;
			}
			if(sales_status == '거래완료') {
				alert("거래완료 상품은 삭제할 수 없습니다.")
				return false;
			}
			
			location.href = "DeleteMySales?product_num=" + pro_num;
		}
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
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">나의 거래 /</span> 판매내역</h4>
						<!-- Table -->
						<div class="card" <c:if test="${empty productsList }">style="display: none;"</c:if>>
							<h5 class="card-header">판매내역</h5>
							<div class="text-nowrap">
								<table class="table">
									<thead class="text-center align-middle">
										<tr>
											<th>카테고리</th>
											<th colspan="2">상품명</th>
											<th>금액</th>
											<th>거래상태</th>
											<th>거래방법</th>
											<th></th>
										</tr>
									</thead>
									<tbody class="table-border-bottom-0 text-center">
										<c:forEach var="product" items="${productsList }">
										
											<tr>
												<td class="align-middle">${product.category_name }</td>
												<td class="align-middle" width="120px"><img height="70px" src="${pageContext.request.contextPath }/resources/img/shop-details/product-big-3.png"></td>
												<td class="text-left align-middle" onclick="location.href='ShopDetail?product_num=${product.product_num }'" style="cursor:pointer">
													${product.product_name }
												</td>
												<td class="align-middle">
													${product.product_price }
												</td>
												<td class="align-middle">
													<c:choose>
														<c:when test="${product.sales_status eq '거래중' }">
															<span class="badge bg-label-secondary">거래중</span>
														</c:when>
														<c:when test="${product.sales_status eq '거래완료' }">
															<span class="badge bg-label-success">거래완료</span>
														</c:when>
														<c:otherwise>
															<span class="badge bg-label-primary">판매중</span>
														</c:otherwise>
													</c:choose>

												</td>
												<td class="align-middle">
													<c:choose>
														<c:when test="${product.trading_method eq 'direct '}">
															<span class="badge bg-label-warning">직거래</span>
														</c:when>
														<c:when test="${product.trading_method eq 'delivery'}">
															<span class="badge bg-label-info">택배</span>
														</c:when>
														<c:otherwise>
															<span class="badge bg-label-info">택배</span>
															<span class="badge bg-label-warning">직거래</span>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="align-middle">
													<div class="dropdown">
													<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
														<i class="bx bx-dots-vertical-rounded"></i>
													</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" href="">
															<i class="bx bx-edit-alt me-1"></i>수정
														</a>
														<a class="dropdown-item" onclick="deleteMyProduct(${product.product_num }, '${product.sales_status}')" href="#">
															<i class="bx bx-trash me-1"></i>삭제
														</a>
													</div>
												</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<!--/Table -->
						<c:if test="${empty productsList}">
							<div class="col-12" >
								<div class="card mb-4" id="account_security_btn" onclick="location.href=''" style="border: 2px dashed #cbd0d5;">
									<div class="card-body text-center" style="padding: 4.5rem 1.5rem;">
										<h5>앗!   판매중인 상품이 없어요.</h5>
										<h6 class="mb-0"><small class="text-muted">우리 같이 상품등록 하러 가볼까요?</small></h6>
										<h6 class="mb-0"><small class="text-muted">클릭 해주시면 저희가 이동시켜드릴게요!</small></h6>
										<br>
										<h6 class="mb-0"><small class="text-muted">(つ˵•́ω•́˵)つ━☆.。.:*・°☆ ｡+.｡☆ﾟ:;｡+ﾟ</small></h6>
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
