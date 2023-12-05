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

  <title>GARGE | 거래내역</title>

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
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">거래내역 /</span> 수수료 내역</h4>
						<!--/Table -->
						<div class="card">
							<h5 class="card-header">월간 수수료 내역</h5>
							<div class="table-responsive text-nowrap">
								
								<!-- -------------------------------------------------------------- -->
								<div class="row">
<!-- 									<div class="col-xl-6"> -->
										<div class="card shadow mb-4">
			                                <div class="card-header py-3">
			                                    <h6 class="m-0 font-weight-bold text-primary">Area Chart</h6>
			                                </div>
			                                <div class="card-body">
					                        	<div class="chart-area">
					                            	<canvas id="myAreaChart"></canvas>
					                            </div>
<!-- 					                         Styling for the area chart can be found in the -->
<%-- 					                        <code>/js/demo/chart-area-demo.js</code> file. --%>
					                        </div>
			                            </div>
									</div>		
									<!--/Table -->
									<div class="card">
										<h5 class="card-header">수수료 상세  내역</h5>
<!-- 										<div class="calendarContainer "> -->
<%-- 											<button type="button"  onclick="setToday(this)"  class="calendarContainer  badge bg-label-prohibition ${pageMaker.searchType eq '1' ? 'active':''}" >오늘</button> --%>
<%-- 											<button type="button"  onclick="setMonths(this, -1)" class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-1' ? 'active':''} "  >1개월</button> --%>
<%-- 											<button type="button"  onclick="setMonths(this, -3)" class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-3' ? 'active':''} ">3개월</button> --%>
<%-- 											<button type="button"  onclick="setMonths(this,-6)"  class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-6' ? 'active':''} ">6개월</button> --%>
<%-- 											<button type="button"  onclick="setAllPeriod(this)" class="calendarContainer badge bg-label-prohibition ${ (empty pageMaker.searchType) or (pageMaker.searchType eq 'NaN') ? 'active':''}"  >전체기간</button> --%>
<!-- 										</div> -->
<!-- 										<input type="hidden" id="searchType" name="searchType"> -->
<!-- 										<div id="reservation_confirm_term_right" > -->
<!-- 											<div class="calanderWrap" style="float: right;"> -->
<%-- 												<input type="date" id="startDate" name="startDate" value="${pageMaker.startDate}"> - <input type="date" id="endDate" name="endDate"  --%>
<%-- 												value="${pageMaker.endDate}"> --%>
<!-- 												<button type="submit" id="search_btn">조회</button> -->
<!-- 											</div> -->
<!-- 										</div>	 -->
											<form  id="frm">	
												<div class="reservationConfirmTerm" style="padding-right: 30px; padding-left: 30px; margin-bottom: 50px;">
													<div class="calendarContainer" style="float: right;">
														<button type="button"   onclick="setToday(this)"  class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '1' ? 'active':''}" >오늘</button>
														<button type="button"  onclick="setMonths(this, -1)" class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-1' ? 'active':''} "  >1개월</button>
														<button type="button"  onclick="setMonths(this, -3)" class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-3' ? 'active':''} ">3개월</button>
														<button type="button"  onclick="setMonths(this,-6)"  class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-6' ? 'active':''} ">6개월</button>
														<button type="button"  onclick="setAllPeriod(this)" class="calendarContainer badge bg-label-prohibition ${ (empty pageMaker.searchType) or (pageMaker.searchType eq 'NaN') ? 'active':''}"  >전체기간</button>
													</div>
													<input type="hidden" id="searchType" name="searchType">
													<div id="reservation_confirm_term_right" style="float: left;">
														<div class="calanderWrap">
															<input type="date" id="startDate" name="startDate" value="${pageMaker.startDate}"> - <input type="date" id="endDate" name="endDate" 
															value="${pageMaker.endDate}">
															<button type="submit" class="badge bg-label-prohibition" id="search_btn">조회</button>
<!-- 															<button type="submit" class="primary-btn" id="search_btn">조회</button> -->
														</div>
													</div>
												</div>
											</form>	

										<div class="table-responsive text-nowrap">
											<table class="table">
												<thead>
													<tr>
														<th width="50px"><input type="checkbox"></th>
														<th>상품정보</th>
														<th>구매자</th>
														<th>입금액</th>
														<th>수수료</th>
													</tr>
												</thead>
												<tbody class="table-border-bottom-0">
													<tr>
														<td><input type="checkbox"></td>
														<td>
															<div class="product">
																<img width="80px" src="../assets/img/elements/1.jpg">
																<div class="product_info"><strong>****상품명****</strong><a>15,000원</a></div>
															</div>
														</td>
														<td>홍길동</td>
														<td>
									                        <span class="badge bg-label-approval me-1">15,000원</span>	
														</td>
														<td>
															<span class="badge bg-label-hold me-1">450원</span>
														</td>
														
													</tr>
													
													<tr>
														<td><input type="checkbox"></td>
														<td>
															<div class="product">
																<img width="80px" src="../assets/img/elements/1.jpg">
																<div class="product_info"><strong>****상품명****</strong><a>35,000원</a></div>
															</div>
														</td>
														<td>고길동</td>
														<td>
									                        <span class="badge bg-label-approval me-1">32,000원</span>	
														</td>
														<td>
															<span class="badge bg-label-hold me-1">960원</span>
														</td>
													</tr>
													<tr>
														<td><input type="checkbox"></td>
														<td>
															<div class="product">
																<img width="80px" src="../assets/img/elements/1.jpg">
																<div class="product_info"><strong>****상품명****</strong><a>35,000원</a></div>
															</div>
														</td>
														<td>고길동</td>
														<td>
									                        <span class="badge bg-label-approval me-1">32,000원</span>	
														</td>
														<td>
															<span class="badge bg-label-hold me-1">960원</span>
														</td>
													</tr>
													<tr>
														<td><input type="checkbox"></td>
														<td>
															<div class="product">
																<img width="80px" src="../assets/img/elements/1.jpg">
																<div class="product_info"><strong>****상품명****</strong><a>35,000원</a></div>
															</div>
														</td>
														<td>고길동</td>
														<td>
									                        <span class="badge bg-label-approval me-1">32,000원</span>	
														</td>
														<td>
															<span class="badge bg-label-hold me-1">960원</span>
														</td>
													</tr>
													<tr>
														<td><input type="checkbox"></td>
														<td>
															<div class="product">
																<img width="80px" src="../assets/img/elements/1.jpg">
																<div class="product_info"><strong>****상품명****</strong><a>35,000원</a></div>
															</div>
														</td>
														<td>고길동</td>
														<td>
									                        <span class="badge bg-label-approval me-1">32,000원</span>	
														</td>
														<td>
															<span class="badge bg-label-hold me-1">960원</span>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									  	
								
								
								<!-- -------------------------------------------------------------- -->
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
	<script src="${pageContext.request.contextPath }/resources//js/admin/product_sales.js"></script>
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
    <script src="${pageContext.request.contextPath }/resources/admin/js/demo/chart-area-demo.js"></script>
	</body>
</html>
