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

  <title>TRADEUP | 문의내역</title>

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
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">지원관리 /</span> 문의내역</h4>
						<!--/Table -->
						<div class="card">
							<h5 class="card-header">문의 내역</h5>

								<!-- --------------------------------------------------------------- -->
								
								<div class="table-responsive text-nowrap" style="padding: 20px;">
<!-- 								<input type="button" class="btn default"  id="open_notice_insert" style="border-radius: 3px; margin-bottom: 3px; font-size: small; color: #fff; background: darkgreen; float:right;" value="공지사항 등록"> -->
									<br>
<!-- 									<form action="MemberListPeriod" method="post" style="margin:30px"> -->
										<table id="datatablesSimple" >
											<thead>
												<tr>
													<th></th>
													<th>문의사진</th>
													<th>문의제목</th>
													<th>문의내용</th>
													<th>문의날짜</th>
													<th>답변완료 여부</th>
													<th>답변하기</th>
<!-- 													<th>관리자 권한 부여</th> -->
												</tr>
											</thead>
											<tbody>
											<c:forEach var="questoinList" items="${questoinList}">
												<tr>
													
													<td><input type="checkbox" id="checkbox" name="checkbox" value="${questoinList.qna_num}"></td>
													<td><img  src="${pageContext.request.contextPath }${questoinList.qna_image_real_file}"></td>
													<td>${questoinList.qna_category_detail_name}</td>
													<td>${questoinList.qna_content}</td>
													<td>${questoinList.qna_date}</td>
													<td>
														<c:choose>
															<c:when test="${questoinList.qna_is_answer eq 'N'}">
																<span class="badge bg-label-hold me-1" style="font-size:small;" id="checkedResult">미완료</span>
															</c:when>
															<c:when test="${questoinList.qna_is_answer eq 'Y'}">
																<span class="badge bg-label-prohibition" style="font-size:small;" id="checkedResult">완료</span>
															</c:when>
														</c:choose>
													</td>
													<td>
<!-- 														<input type="button" class="btn default delete_dangerous" id="open_question_insert" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: darkgreen;" value="답변하기"> -->
														<button class="btn default delete_dangerous" id="open_question_insert" value="${questoinList.qna_num}" style="border-radius: 3px; margin-bottom: 3px; font-size: 11px; color: #fff; background: darkgreen;">답변하기</button>
													</td>
<%-- 													<td>${memberList.member_phone_num}</td> --%>
												</tr>
											</c:forEach>
											</tbody>
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
	<script src="${pageContext.request.contextPath }/resources/js/admin_question.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_datatable.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_calender.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_search_list.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin_authorization.js"></script>
	</body>
</html>
