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

  <title>GARGE | 사기신고 조회</title>

  <meta name="description" content="" />

  <!-- Favicon -->
<!--   <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" /> -->

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

  <!-- Vendors CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/myPage/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

  <!-- Page CSS -->
  <link href="${pageContext.request.contextPath }/resources/css/admin_style.css" rel="stylesheet" />
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
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">사기 신고 /</span> 신고 목록</h4>
						<!--/Table -->
						<div class="card">
							<h5 class="card-header">신고 목록</h5>
								<form  id="frm">	
												<div class="reservationConfirmTerm" style="padding-right: 30px; padding-left: 30px; margin-bottom: 25px;padding-top: 30px;">
<!-- 													<div class="calendarContainer" style="float:left;"> -->
<%-- 														<button type="button"   onclick="setToday(this)"  class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '1' ? 'active':''}" >오늘</button> --%>
<%-- 														<button type="button"  onclick="setMonths(this, -1)" class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-1' ? 'active':''} "  >1개월</button> --%>
<%-- 														<button type="button"  onclick="setMonths(this, -3)" class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-3' ? 'active':''} ">3개월</button> --%>
<%-- 														<button type="button"  onclick="setMonths(this,-6)"  class="calendarContainer badge bg-label-prohibition ${pageMaker.searchType eq '-6' ? 'active':''} ">6개월</button> --%>
<%-- 														<button type="button"  onclick="setAllPeriod(this)" class="calendarContainer badge bg-label-prohibition ${ (empty pageMaker.searchType) or (pageMaker.searchType eq 'NaN') ? 'active':''}"  >전체기간</button> --%>
<!-- 													</div> -->
													<input type="hidden" id="searchType" name="searchType">
													<div id="reservation_confirm_term_right" >
														<div class="calanderWrap">
															<input type="date" id="startDate" name="startDate" value="${pageMaker.startDate}"> - <input type="date" id="endDate" name="endDate" 
															value="${pageMaker.endDate}">
															<button type="submit" class="btn default" id="search_btn" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: #5F12D3 ;">조회</button>
<!-- 															<button type="submit" class="badge bg-label-prohibition" id="search_btn">조회</button> -->
<!-- 															<button type="submit" class="primary-btn" id="search_btn">조회</button> -->
														</div>
													</div>
												</div>
											</form>	
								<!-- --------------------------------------------------------------- -->
								
								<div class="table-responsive text-nowrap">
<!-- 									<form action="AdminNoticeDelete" method="post" style="margin:30px"> -->
										<table id="datatablesSimple" >
											<thead>
												<tr>
													<th></th>
													<th>신고사진</th>
													<th>신고상품</th>
													<th>신고사유</th>
													<th>회원상태</th>
													<th>회원설정</th>
												</tr>
											</thead>
											<c:forEach var="selectReport" items="${selectReport }">
												<tr>
													<td><input type="checkbox" name="checkbox" value="${selectReport.report_idx }"></td>
													<td><img style="height: 40px;" src="${selectReport.report_image_real_file }"></td>
													<td><button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: #7173db;" onclick="location.href='ShopDetail?product_num=${selectReport.report_product_num }'">자세히보기</button></td>
													<td>${selectReport.qna_category_detail_name } : ${selectReport.report_content }
													</td>
													<td style="text-align: center;"><span class="badge bg-label-hold me-1" style="font-size:small;">${selectReport.report_is_accept }</span></td>
													<td>
														<button value="${selectReport.report_product_num }" class="btn default not_dangerous" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: #7173db;">보류</button>
														<button value="${selectReport.report_product_num }" class="btn default insert_dangerous" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: black;" onclick="orderPro('')">회원정지</button>
	                        							<button value="${selectReport.report_product_num }" class="btn default delete_dangerous" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: darkgreen;" onclick="favorite('')">회원복구</button><br>
													</td>
												</tr>
<!-- 												<tr> -->
<!-- 													<td><input type="checkbox" name="checkbox" value=""></td> -->
<!-- 													<td></td> -->
<!-- 													<td>니트</td> -->
<!-- 													<td style="text-align: center;">강원하</td> -->
<!-- 													<td> -->
													
<!-- 													</td> -->
<!-- 													<td style="text-align: center;"><span class="badge bg-label-prohibition" style="font-size:small;">회원정지</span></td> -->
<!-- 													<td> -->
<%-- 														<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: black;" onclick="orderPro('${productList.product_num}')">회원정지</button> --%>
<%-- 	                        							<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: darkgreen;" onclick="favorite('${productList.product_num}')">회원복구</button><br> --%>
<!-- 													</td> -->
<!-- 												</tr> -->
<!-- 												<tr> -->
<!-- 													<td><input type="checkbox" name="checkbox" value=""></td> -->
<!-- 													<td></td> -->
<!-- 													<td>니트</td> -->
<!-- 													<td style="text-align: center;">강원하</td> -->
<!-- 													<td> -->
													
<!-- 													</td> -->
<!-- 													<td style="text-align: center;"><span class="badge bg-label-approval me-1" style="font-size:small;">회원복구</span></td> -->
<!-- 													<td> -->
<%-- 														<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: black;" onclick="orderPro('${productList.product_num}')">회원정지</button> --%>
<%-- 	                        							<button class="btn default" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: darkgreen;" onclick="favorite('${productList.product_num}')">회원복구</button><br> --%>
<!-- 													</td> -->
<!-- 												</tr> -->
											</c:forEach>
										</table>
									<input type="submit" id="delete_btn"class="btn btn-primary" value="삭제">	
<!-- 								</form> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

      <!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>
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
        <script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_datatable.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_calender.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_search_list.js"></script>
	<script type="text/javascript">
		$(function() {
			$(".not_dangerous").on("click",function(){
				  $.ajax({
			            type: "POST",
			            url: "UpdateReport",
			            data: {
			               product_num : $(this).val()
			            },
			            success: function(data) {
			            	alert("보류되었습니다.");
			            	location.href="Declaration";
		            	},
		            	error:function(){
		            		alert("실패");
		            	}
					});
			});
			$(".insert_dangerous").on("click",function(){
				  $.ajax({
			            type: "POST",
			            url: "InsertDangerous",
			            data: {
			               product_num : $(this).val()
			            },
			            success: function(data) {
			            	alert("정지되었습니다");
			            	location.href="Declaration";
		            	},
		            	error:function(){
		            		alert("실패");
		            	}
					});
			});
			$(".delete_dangerous").on("click",function(){
				  $.ajax({
			            type: "POST",
			            url: "deleteDangerous",
			            data: {
			               product_num : $(this).val()
			            },
			            success: function(data) {
			            	alert("해제되었습니다");
			            	location.href="Declaration";
		            	},
		            	error:function(){
		            		alert("실패");
		            	}
					});
			});
		});
	</script>
	</body>
</html>
