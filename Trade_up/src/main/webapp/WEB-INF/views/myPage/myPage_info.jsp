<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%--

	전화번호 수정
	이메일 수정
	정규식 추가
	계정 연동
	회원 탈퇴
	대표계좌. 대표주소 없을 때 아무것도 안뜸!
	프로필 업로드 성공하고 잘 불러오는데 오류뜸 확인
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
  <style type="text/css">
  	.info-img {
  		position: relative;
	    width: 200px;
	    height: 200px;
  	}
  	
  	.info-img img {
  		position: absolute;
	    top: 0;
	    left: 0;
	    transform: translate(50, 50);
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    margin: auto;
  	}
  </style>
  
  <script>
    function submitForm() {
    	var formData = $('#MyInfoModify').serialize();
    	$.ajax({
            type: 'POST',
            url: 'MyInfoModify',
            data: formData,
            dataType: "json",
            success: function(response) {
            	// 판별 추가하기
	            window.location.reload();
            },
            error: function() {
                alert('서버 오류가 발생했습니다.');
            }
    	});
    }
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
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">내 정보 /</span> 프로필 관리</h4>
					
						<div class="row">
							<div class="col-md-6 col-lg-4 col-xl-4 order-0 mb-4">
								<div class="card h-100">
									<div class="card-header d-flex align-items-center justify-content-center" style="flex-direction: column;">
										<div class="mb-4 mt-5">
											<div class="info-img">
												<a
													data-bs-toggle="modal"
													href="#modify_img"
												>	
													<%-- 등록된 이미지 없을 경우 추가! --%>
													<img src="${member.member_profile_img }" class="rounded-circle" />
												</a>
												<jsp:include page="modal/modify_img.jsp"></jsp:include>
											</div>
										</div>
										<h5>
											${member.member_nick_name }
											<a 
												data-bs-toggle="modal"
												href="#modify_nick_name"
											><i class="tf-icons bx bx-edit"></i>
											</a>
											<jsp:include page="modal/modify_nick_name.jsp"></jsp:include>
										</h5>
										<h5>${member.member_id } <span class="text-muted fw-light">(#${member.member_num })</span></h5>
									</div>
									<div class="card-body" style="padding-bottom: 0">
										<div class="divider">
											<div class="divider-text">
												계정 연동
											</div>									
										</div>
										<div class="card-header d-flex align-items-center justify-content-center" style="flex-direction: column;">
											<h5>카카오 <span class="text-muted fw-light">연동하기</span></h5>
											<h5>네이버 <span class="text-muted fw-light">연동하기</span></h5>
										</div>
									</div>
								</div>
							</div>
							<div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
								<div class="card">
									<div class="card-header d-flex justify-content-between align-items-center">
										<h5 class="mb-0 fw-bold"> 내 정보 </h5>
									</div>
									<div class="card-body">
										<div>
											<label class="form-label text-muted">이름</label>
											<h5>${member.member_name }</h5>
										</div>
										<div>
											<label class="form-label text-muted">전화번호</label>
											<h5>${member.member_phone_num }  <a 
												data-bs-toggle="modal"
												href="#modify_phone"
											><i class="tf-icons bx bx-edit"></i>
											</a></h5>
											<jsp:include page="modal/modify_phone.jsp"></jsp:include>
										</div>
										<div>
											<label class="form-label text-muted">이메일</label>
											<h5>${member.member_e_mail }  <a 
												data-bs-toggle="modal"
												href="#modify_email"
											><i class="tf-icons bx bx-edit"></i>
											</a></h5>
											<jsp:include page="modal/modify_email.jsp"></jsp:include>
										</div>
										<div class="divider">
											<div class="divider-text">
												대표 주소
											</div>
										</div>
										<button class="btn btn-outline-primary" style="float: right;" onclick="location.href='MyAddress'">
											<span class="tf-icons bx bx-edit me-1"></span>
											수정
										</button>
										<div>
											<label class="form-label text-muted">주소명
											</label>
											<h5>${member.address_name }</h5>
											
										</div>
										<div>
											<label class="form-label text-muted">주소</label>
											<h5>[${member.postcode }] ${member.address1 } ${member.address2 }</h5>
										</div>
										<div class="divider">
											<div class="divider-text">
												대표 계좌
											</div>
										</div>
										<div>
											<button class="btn btn-outline-primary" style="float: right;" onclick="location.href='MyAccount'">
												<span class="tf-icons bx bx-edit me-1"></span>
												수정
											</button>
											<label class="form-label text-muted">계좌명</label>
											<h5>${member.account_name }</h5>
										</div>
										<div>
											<label class="form-label text-muted">계좌 번호</label>
											<h5>(${member.account_bank }) ${member.account_num }</h5>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- 탈퇴 -->
						<div class="card">
							<h5 class="card-header">계정 삭제</h5>
							<div class="card-body">
								<div class="mb-3 col-12 mb-0">
									<div class="alert alert-warning">
										<h6 class="alert-heading fw-bold mb-1">정말로 계정을 삭제하시겠습니까?</h6>
										<p class="mb-0">계정을 삭제하면 되돌릴 수 없습니다. 다시 확인해주세요.</p>
									</div>
								</div>
<!-- 								<form id="formAccountDeactivation" onsubmit="return false"> -->
								<div class="form-check mb-3">
									<input
									class="form-check-input"
									type="checkbox"
									name="accountActivation"
									id="accountActivation"
									/>
									<label class="form-check-label" for="accountActivation"
									>계정을 삭제하겠습니다.</label
									>
								</div>
								<%-- 모달창 버튼 --%>
								
								<button type="button"
									class="btn btn-danger"
									id="deleteButton"
									data-bs-toggle="modal"
									data-bs-target="#delete_account_modal">회원탈퇴</button>
								<jsp:include page="modal/delete_account_modal.jsp"></jsp:include>
							</div>
						</div>
						<!-- 탈퇴 -->
						
						
					</div>
				</div> <!-- Content Wrapper -->
			</div> <!-- / Layout page -->
		</div> <!-- / Layout Container -->
	</div> <!-- / Layout Wrapper -->


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
