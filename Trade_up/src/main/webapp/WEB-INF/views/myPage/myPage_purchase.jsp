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
		<!-- container -->
		<div class="layout-container">
			<%-- 사이드 메뉴 --%>
			<jsp:include page="inc/side_menu.jsp"></jsp:include>  
			<!-- layout -->
			<div class="layout-page">
				<div class="content-wrapper">
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">나의 거래 /</span> 구매내역</h4>
						<!-- Table -->
						<div class="card" <c:if test="${empty productList }">style="display: none;"</c:if>>
							<h5 class="card-header">구매목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="text-center">
										<tr>
											<th colspan="2">상품명</th>
											<th>상품금액</th>
											<th>판매자</th>
											<th>거래상태</th>
											<th>거래방법</th>
											<th></th>
										</tr>
									</thead>
									<tbody class="text-center table-border-bottom-0">
										<c:forEach var="product" items="${productList }">
												<tr>
													<td class="align-middle"><img height="80px" src="${product.product_main_img }"></td>
													<td class="align-middle" onclick="location.href='ShopDetail?product_num=${product.product_num }'" style="cursor:pointer">
														<strong>${product.product_name }</strong>
													</td>
													<td class="align-middle">
														${product.product_price }
													</td>
													<td class="align-middle">
														<a>${product.member_id }</a>
													</td>
													<td class="align-middle">
														<c:choose>
															<c:when test="${product.sales_status eq '거래중'}">
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
														<button class="btn btn-sm btn-outline-primary" onclick="buyCheck(${product.product_num })">거래완료</button>
													</td>
												</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<!--/Table -->
						<c:if test="${empty productList}">
							<div class="col-12" >
								<div class="card mb-4" id="account_security_btn" onclick="location.href='Shop'" style="border: 2px dashed #cbd0d5; cursor: pointer;">
									<div class="card-body text-center" style="padding: 4.5rem 1.5rem;">
										<h5>앗!   구매하신 상품이 없어요.</h5>
										<h6 class="mb-0"><small class="text-muted">우리 같이 다른 고객님이 올려주신 상품 구경하러 가볼까요?</small></h6>
										<h6 class="mb-0"><small class="text-muted">클릭 해주시면 저희가 이동시켜드릴게요!</small></h6>
										<br>
										<h6 class="mb-0"><small class="text-muted">ଘ(❁•̀ 3 •́)━☆*✲⋆✧･ﾟ: *✧･ﾟ:* *:･ﾟ✧*:･ﾟ✧</small></h6>
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
    <script type="text/javascript">
    function buyCheck(productNum) {
    	if (!confirm("해당 상품을 구매확정 처리 하시겠습니까? (구매 확정 처리 이후 환불은 어렵습니다.)")) {
            return;
        }
		alert("구매확정 처리 되었습니다.")
		location.href='BuyCheck?product_num=' + productNum;
	}
    </script>
	</body>
</html>
