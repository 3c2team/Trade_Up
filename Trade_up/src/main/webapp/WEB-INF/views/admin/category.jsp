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
	.custom_div_box3{
	    width: 50%;
	    height: 100%;
	    overflow: auto;
	}
	.custom_div_box2{
		height: 80%;
		margin-top: 10%;
		margin-left: 5%;
		margin-right: 5%;
    }
	.custom_div_box{
		height: 80%;
	    width: 100%;
	    margin: auto;
	}
	li{
		width: 14%;
		float: left;
	    margin: 0;
	    padding: 0;
	    font-size: 15px;
	    line-height: 18px;
	    font-family: Nanum Barun Gothic, sans-serif;
	}
	.ul_menu{
		display: block;
	    background-color: #fdfdfd;
	    border: 1px solid #e7e8ea;
	    border-left: 0;
	    color: #999;
	    text-align: center;
	    line-height: 62px;
	    box-sizing: border-box;
	    list-style: none;
    }
    .custom_div_menu{
	    display: block;
	    height: 62px;
	    background-color: #fdfdfd;
	    border: 1px solid #e7e8ea;
	    border-left: 0;
	    color: #999;
	    text-align: center;
	    line-height: 62px;
	    box-sizing: border-box;
	    text-decoration: none;
	    cursor: pointer;
    }
    .on{
        background-color: #fff;
	    border-bottom: 0;
	    color: #323332;
    }
    button:hover{
    	background-color: #00ca30;
    }
    .custom_btn{
    	    margin-left: 2%;
    width: 8%;
    height: 8%;
    border: 1px solid #e7e8ea;
    background-color: white;
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
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">카테고리/</span>상품카테고리</h4>
						<!--/Table -->
						<div class="custom_div_box">
							<ul class="ul_menu">
								<li><div class="custom_div_menu on">상품 카테고리</div></li>
								<li><div class="custom_div_menu" onclick="location.href='CategoryQna'">문의사항 카테고리</div></li>
							</ul>
							<div class="custom_div_box2">
								<div class="custom_div_box3" style="background: #fafafa;float: inline-start;padding-top: 20%;padding-left: 1.5%;">
									<div style="width:100%; text-align: center;font-size: xx-large;font-weight: bold;">상품 카테고리 관리</div><br>
										<span style="font-size:14px; color: #9e9e9e;">현재 페이지에서는 상품 카테고리를 삭제하거나 등록을 할 수 있습니다.<br></span>
										<span style="font-size:14px;color: red;">*카테고리를 삭제할 시 그에 관한 상품도 같이 삭제되니 삭제할때는 주의하시길 바랍니다.*</span>
									</div>
								<div class="custom_div_box3" style="float: inline-end;">
									<c:forEach var="category" items="${category }">
										<div style="display: flex;align-items: baseline;">
											<input type="text" readonly class="form-text form-control" style="width: 80%;" value="${category.category_name }">
											<button class="custom_btn" style="margin-left: 2%;" value="${category.category_idx }">-</button>
										</div>
									</c:forEach>
									<div style="display: flex;align-items: baseline;">
										<input type="text" id="insert" class="form-text form-control" style="width: 80%;">
										<button class="custom_btn" style="margin-left: 2%;" value="insert">+</button>
									</div>
								</div>
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
		$(".custom_btn").on("click",function(){
			let button = $(this).val();
			if(button == "insert"){
				if(confirm("등록하시겠습니까?")){
					$.ajax({
						type: "POST",
						url: "InsertProductCategory",
						data: {
							product_category_name : $("#insert").val()
						},
						success: function(data) {
							alert("등록 되었습니다.");
						},erorr: function() {
							alert("등록에 실패했습니다.");
						}
					});
				}
				return;
			}
			if(confirm("삭제하시겠습니까?")){
				$.ajax({
					type: "POST",
					url: "DeleteProductCategory",
					data: {
						product_category_num : $(this).val()
					},
					success: function(data) {
						alert("삭제 되었습니다.");
					},erorr: function() {
						alert("삭제에 실패했습니다.");
					}
				});
			}
		});
	</script>
	</body>
</html>
