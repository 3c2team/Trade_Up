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

  <title>GARGE | 신고회원</title>

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
		<div class="layout-container">
			<%-- 사이드 메뉴 --%>
			<jsp:include page="inc/side_menu.jsp"></jsp:include>  
			<div class="layout-page">
				<div class="content-wrapper">
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">신고회원 /</span> 회원목록</h4>
						<!--/Table -->
						<div class="card">
							<h5 class="card-header">신고 목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead>
										<tr>
											<th width="50px"><input type="checkbox"></th>
											<th>신고상품</th>
											<th>판매자</th>
											<th>회원상태</th>
											<th>회원설정</th>
										</tr>
									</thead>
									<tbody class="table-border-bottom-0">
										<tr>
											<td><input type="checkbox"></td>
											<td>
												<div class="product">
													<img width="80px" src="../assets/img/elements/1.jpg">
													<div class="product_info"><strong>****상품명****</strong><a>50,000원</a></div>
												</div>
											</td>
											<td>홍길동</td>
											<td>
<!--                         						<span class="badge bg-label-primary">판매중</span> -->
<!--                         						<span class="badge bg-label-secondary">예약중</span> -->
<!-- 						                        <span class="badge bg-label-success">판매완료</span>	 -->
						                        <span class="badge bg-label-prohibition">회원정지</span>	
											</td>
											<td>
												<button type="submit" class="btn default" style="border-radius: 3px; width:90px; margin-bottom: 3px; font-size: 11px; color: #fff; background: gray;" onclick="orderPro('${productList.product_num}')">회원정지</button><br>
                        						<button class="btn default" style="border-radius: 3px; width:90px; margin-bottom: 3px; font-size: 11px; color: #fff; background: gray;" onclick="favorite('${productList.product_num}')">회원복구</button><br>
											</td>
										</tr>
										<tr>
											<td><input type="checkbox"></td>
											<td>
												<div class="product">
													<img width="80px" src="../assets/img/elements/1.jpg">
													<div class="product_info"><strong>****상품명****</strong><a>50,000원</a></div>
												</div>
											</td>
											<td>강원하</td>
											<td><span class="badge bg-label-hold me-1">상태보류</span></td>
											<td>
												<button type="submit" class="btn default" style="border-radius: 3px; width:90px; margin-bottom: 3px; font-size: 11px; color: #fff; background: gray;" onclick="orderPro('${productList.product_num}')">회원정지</button><br>
                        						<button class="btn default" style="border-radius: 3px; width:90px; margin-bottom: 3px; font-size: 11px; color: #fff; background: gray;" onclick="favorite('${productList.product_num}')">회원복구</button><br>
											</td>
										</tr>
										<tr>
											<td><input type="checkbox"></td>
											<td>
												<div class="product">
													<img width="80px" src="../assets/img/elements/1.jpg">
													<div class="product_info"><strong>****상품명****</strong><a>50,000원</a></div>
												</div>
											</td>
											<td>고길동</td>
											<td><span class="badge bg-label-approval me-1">회원복구</span></td>
											<td>
												<button type="submit" class="btn default" style="border-radius: 3px; width:90px; margin-bottom: 3px; font-size: 11px; color: #fff; background: gray;" onclick="orderPro('${productList.product_num}')">회원정지</button><br>
                        						<button class="btn default" style="border-radius: 3px; width:90px; margin-bottom: 3px; font-size: 11px; color: #fff; background: gray;" onclick="favorite('${productList.product_num}')">회원복구</button><br>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!--/Table -->
					</div>
				</div>
              <!--/ Responsive Table -->
			</div>
            <!-- / Content -->

			<div class="content-backdrop fade"></div>
			</div>
          <!-- Content wrapper -->
		</div>
        <!-- / Layout page -->
	</div>

      <!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>
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
