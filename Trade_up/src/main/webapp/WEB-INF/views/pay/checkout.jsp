<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<meta charset="UTF-8">
	<meta name="description" content="Male_Fashion Template">
	<meta name="keywords" content="Male_Fashion, unica, creative, html">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Trade UP</title>
	
	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap"
	rel="stylesheet">
	
	<!-- Css Styles -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/elegant-icons.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/magnific-popup.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/nice-select.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/owl.carousel.min.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/slicknav.min.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" type="text/css">
	<style>
	#open {
		background: #5F12D3;
		color: #ffffff;
		border: none;
		border-radius: 5px;
		padding: 3px;
	}
	#modal-box {
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: rgba(0, 0, 0, 0.6);
		display: none;
		justify-content: center;
		align-items: center;
		z-index: 9999;
		overflow-y: initial !important
	}
	#modal-box.active {
		display: flex;
	}
	#modal-contents {
		background-color: #ffffff;
		width: 450px;
		padding: 20px;
		border-radius: 5px;
		position: relative;
		max-height: calc(100vh - 400px);
		overflow-y: auto;
	}
	#modal-contents botton {
		background-color: #ffffff;
	}
	#desc p {
		margin-bottom: 2%;
	}
	</style>
</head>

<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>
	
	<!-- Offcanvas Menu Begin -->
	<div class="offcanvas-menu-overlay"></div>
	<div class="offcanvas-menu-wrapper">
		<div class="offcanvas__option">
			<div class="offcanvas__links">
				<a href="#">Sign in</a>
				<a href="#">FAQs</a>
			</div>
			<div class="offcanvas__top__hover">
				<span>Usd <i class="arrow_carrot-down"></i></span>
				<ul>
					<li>USD</li>
					<li>EUR</li>
					<li>USD</li>
				</ul>
			</div>
		</div>
		<div class="offcanvas__nav__option">
			<a href="#" class="search-switch"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a>
			<a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a>
			<a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/cart.png" alt=""> <span>0</span></a>
			<div class="price">$0.00</div>
		</div>
		<div id="mobile-menu-wrap"></div>
		<div class="offcanvas__text">
			<p>Free shipping, 30-day return or refund guarantee.</p>
		</div>
	</div>
	<!-- Offcanvas Menu End -->

	<!-- Header Section Begin -->
	<header class="header">
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<!-- Header Section End -->

	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>결제(택배거래)</h4>
						<div class="breadcrumb__links">
							<a href="./">홈</a>
							<a href="Shop">상품</a>
							<span>결제</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<div>
		<div>
    	
		</div>
	</div>
    <!-- Breadcrumb Section End -->
    
    <!-- 주소 변경 모달 창 시작 -->
    <div id="modal-box">
    	<div id="modal-contents">
    		<button id="close" style="margin-bottom: 2%; "class="btn btn_primary">&times;</button>
    		<h5 id="title" style="font-style: bold; margin-top: 2%; margin-bottom: 4%;">주소지 선택</h5>
    		<div id="addresses">
    		 <input type="hidden" id="addressMain" value="${addressMain }">
    		 <input type="hidden" id="addressMain2" value='${addressMain2 }'>
    		<c:forEach var="i" begin="0" end="${addressCount - 1}">
    			<div id="desc${i}">
    				<hr>
    				<p class="user">주소지명 : ${address.get(i).address_name} &nbsp 이름 : ${address.get(i).recipient_name}</p>
    				<p class="user">주소 : (<span>${address.get(i).postcode}</span>)<span>${address.get(i).address1}</span> <span>${address.get(i).address2}</span></p> 
    				<p class="user">전화번호 : <span>${address.get(i).recipient_phone_num}</span> <button type="button" style="margin-left: 38%;" class="choice" value="${i}">선택</button></p>
   				</div>
   			</c:forEach>
    		</div>
    	</div>
    </div>
	<!-- 주소 변경 모달 창 끝 -->
	
    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                <form method="post" onsubmit="return checks()">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <h6 class="coupon__code"><span class="icon_tag_alt"></span>같은 상품을 2회 이상 주문 완료 후 취소하실 경우 그 상품은 구매하실 수 없으므로 신중하게 구매해 주세요.</h6>
                            <h6 class="checkout__title">결제 정보
	                            <input type="radio" name="diliver" id="origin" value="1" checked style="accent-color: #5F12D3; margin-left: 57%;">
								<label for="origin">기존 배송지</label>
								<button id="open" type="button">변경</button>
								<input type="radio" name="diliver" id="another" value="2" style="accent-color: #5F12D3; margin-left: 3%;">
								<label for="another">새로운 배송지</label>
                            </h6>
                           	<div id="new" style="display:none">
                            	<div class="checkout__input__checkbox">
                                    <label for="add">
                                        배송지 목록에 추가
                                        <input type="checkbox" id="add" name="add">
                                        <input type="hidden" id="add_hidden" name="add">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="checkout__input__checkbox">
                                    <label for="pick">
                                        기본 배송지로 선택
                                        <input type="checkbox" id="pick" name="pick">
                                        <input type="hidden" id="pick_hidden" name="pick">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                           	</div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>받으시는 분<span>*</span>&nbsp
                                        <span id="checkNameResult" style="color: gray; font-size: 0.8em;"></span></p>
                                        <input type="text" id="member_name" name="member_name" value="${addressMain.recipient_name }" style="color: black;">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>아이디<span>*</span></p>
                                        <input type="text" id="member_id" name="member_id" value="${sId }" style="color: black;" readonly>
                                        <input type="hidden" id="member_sId" value="${sId }">
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>
                                	주소<span>*</span>
                                	<button type="button" style="cursor: pointer; margin-left:1%; color:white; background-color: #cb99c5; border: none; font-size: 0.8em" id="btnSearchAddress">주소 검색</button>
                                </p>
                                <input type="text" id="member_address1" name="member_address1" value="${addressMain.address1 }" class="checkout__input__add" style="color: black;">
                                <input type="text" id="member_address2" name="member_address2" value="${addressMain.address2 }" style="color: black;">
                            </div>
                            <div class="checkout__input">
                                <p>우편번호<span>*</span></p>
                                <input type="text" id="zonecode" name="zonecode" value="${addressMain.postcode }" style="color: black;">
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>전화번호<span>*</span>&nbsp
                                        <span style="color: gray; font-size: 0.8em;">숫자만 입력해주세요.</span></p>
                                        <input type="text" id="member_phone" name="member_phone" value="${addressMain.recipient_phone_num }" style="color: black;" oninput="autoHyphen(this)" maxlength="13">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>이메일<span>*</span>&nbsp
                                        <span id="checkMailResult" style="color: gray; font-size: 0.8em;"></span></p>
                                        <input type="email" id="member_email" name="member_email" value="${sEmail }" style="color: black;" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>배송 메세지</p>
                                <input type="text" name="diliver_ment" placeholder="배송 문구를 입력해주세요." style="color: black;">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4 class="order__title">주문 내역</h4>
                                <div class="checkout__order__products">Product <span>Total</span></div>
                                <ul class="checkout__total__products">
                                    <li>주문한 상품 <span>${product_priceShow }</span></li>
                                    <li>안전거래 수수료(1%) <span>${commissionShow }</span></li>
                                </ul>
                                <input type="hidden" name="product_price"  value="${product_price }">
                                <input type="hidden" name="product_priceShow"  value="${product_priceShow }">
                                <input type="hidden" name="product_num"  value="${product_num }">
                                <input type="hidden" name="commission"  value="${commission }">
                                <input type="hidden" name="total"  value="${total }">
                                <input type="hidden" name="commissionShow"  value="${commissionShow }">
                                <input type="hidden" name="totalShow"  value="${totalShow }">
                                <input type="hidden" name="product_name" value="${product_name }">
                                <ul class="checkout__total__all">
                                    <li>총 가격 <span>${totalShow }</span></li>
                                </ul>
                                <div class="checkout__input__checkbox"> <!-- 셋 중 하나만 되게 고칠 것 -->
                                    <label for="acc-or">
                                        카카오 페이
                                        <input type="checkbox" id="acc-or" name="pay" value="1">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="checkout__input__checkbox">
                                    <label for="payment">
                                        업페이
                                        <input type="checkbox" id="payment" name="pay" value="2">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="checkout__input__checkbox">
                                    <label for="paypal">
                                        무통장 입금
                                        <input type="checkbox" id="paypal" name="pay" value="3">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div id="block" class="form-select" style="display:none">
                                	<select name="bank" id="bank">
                                		<option value="noSelect" disabled selected>입금 은행을 선택해주세요.</option>
                                		<option value="kakao">카카오뱅크</option>
                                		<option value="su">산업은행</option>
                                		<option value="sinhan">신한은행</option>
                               		</select>
								</div>
                                <button type="submit" class="site-btn" id="paymentCheck" style="padding: 3%; font-size: 18px;">결제하기</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->

    <!-- Footer Section Begin -->
    <footer class="footer">
        <jsp:include page="../inc/bottom.jsp"></jsp:include>
    </footer>
    <!-- Footer Section End -->

    <!-- Search Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">+</div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search End -->

    <!-- Js Plugins -->
<%--     <script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/js/jquery.nice-select.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/js/jquery.nicescroll.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/js/jquery.magnific-popup.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/js/jquery.countdown.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/js/jquery.slicknav.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/js/mixitup.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath }/resources/js/owl.carousel.min.js"></script> --%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%--     <script src="${pageContext.request.contextPath }/resources/js	/main.js"></script> --%>
    <script src="${pageContext.request.contextPath }/resources/js/checkout.js"></script>
</body>

</html>