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

    <title>Tables - Basic Tables | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>

    <meta name="description" content="" />

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
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	  	
	function searchAddress() {
		
	    new daum.Postcode({
	        oncomplete: function(data) {
	            let address = data.address; // 기본 주소 저장
	            let postcode = data.zonecode;
	            if(data.buildingName != '') { // 건물명이 있을 경우
	            	address += " (" + data.buildingName + ")";
	            }
	            
	            $("#address1").val(address);
	            $("#postcode").val(postcode);
	            $("#address2").focus();
	        }
	    }).open();
	}
	 	
	</script>
	
  	
  </head>
<body>
	<h5 id="offcanvasEndLabel" class="offcanvas-title">배송지 추가</h5>
	<div class="offcanvas-body my-auto mx-0 flex-grow-0">
	<form action="AddAddress" method="post">
		<div class="modal-body">
			<div class="card-body demo-vertical-spacing demo-only-element">
			
				<label class="form-label" for="address_name">배송지명</label>
				<div class="input-group">
					<input
						type="text"
						name="address_name"
						class="form-control"
					/>
				</div>
				
				<label class="form-label" for="recipient_name">받으시는 분</label>
				<div class="input-group">
					<input
						type="text"
						name="recipient_name"
						class="form-control"
					/>
				</div>
				
				<label class="form-label" for="phone_num">전화번호</label>
				<div class="input-group">
					<input
						type="tel"
						name="recipient_phone_num"
						class="form-control"
					/>
				</div>
				
				<label class="" for="address1">주소</label>
				<div class="">
					<input
						type="text"
						id="address1"
						name="address1"
						class="form-control"
						onclick="searchAddress()"
					/>
				</div>
				<label class="form-label" for="address2">상세주소</label>
				<div class="input-group">
					<input
						type="text"
						id="address2"
						name="address2"
						class="form-control"
					/>
				</div>
				<input type="hidden" id="postcode" name="postcode">
			</div>
		</div>
		<button type="submit" class="btn btn-primary mb-2 d-grid w-100">저장</button>
		<button
			type="button"
			class="btn btn-outline-secondary d-grid w-100"
		>
			취소
		</button>
	</form>
	</div>
</body>
</html>