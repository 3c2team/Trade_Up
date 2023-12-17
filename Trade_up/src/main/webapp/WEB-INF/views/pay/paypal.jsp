<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Male-Fashion | Template</title>

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
                        <h4>주문 완료</h4>
                        <div class="breadcrumb__links">
                            <a href="./">홈</a>
                            <a href="Shop">상품</a>
                            <span>주문 완료</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
    
    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                <form method="get" action="MyPageMain">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <h6 class="coupon__code"><span class="icon_tag_alt"></span>상품이 주문 완료 되었습니다. 상품 수령 후 구매확정 버튼을 눌러주세요.</h6>
                            <h6 class="checkout__title">결제 정보</h6>
                            <c:if test="${!empty deliver.member_address1 }">
	                            <div class="col-lg-6">
	                                <div class="checkout__input">
	                                    <p>받으시는 분 : ${deliver.member_name }</p>
	                                </div>
	                            </div>
	                            <div class="col-lg-12">
	                                <div class="checkout__input">
	                                    <p>주소 : (${deliver.zonecode })${deliver.member_address1 } ${deliver.member_address2 }</p>
	                                </div>
	                            </div>
	                            <div class="col-lg-6">
	                                <div class="checkout__input">
	                                    <p>전화번호 : ${deliver.member_phone }</p>
	                                </div>
	                            </div>
	                            <div class="col-lg-6">
	                                <div class="checkout__input">
	                                    <p>이메일 : ${deliver.member_email }</p>
	                                </div>
	                            </div>
	                            <div class="col-lg-12">
	                                <div class="checkout__input">
	                                    <p>배송문구 : 
	                                    <c:choose>
		                                    <c:when test="${empty deliver.diliver_ment }">
		                                   		작성된 배송문구가 없습니다.
		                                   	</c:when>
		                                   	<c:otherwise>
		                                   		${deliver.diliver_ment }
		                                   	</c:otherwise>
	                                    </c:choose>
	                                    </p>
	                                </div>
	                            </div>
	                            <hr>
                            </c:if>
                            <div class="col-lg-12">
                                <div class="checkout__input">
                                	<c:if test="${deliver.bank eq 'kakao' }">
                                    	<p>계좌 정보 : 카카오뱅크 3333-10-6668888</p>
                                	</c:if>
                                	<c:if test="${deliver.bank eq 'su' }">
	                                    <p>계좌 정보 : 산업은행 2023120106</p>
                                	</c:if>
                                	<c:if test="${deliver.bank eq 'sinhan' }">
	                                    <p>계좌 정보 : 신한은행 3333-10-6668888</p>
                                	</c:if>
                                    <p style="color: #5F12D3;">24시간 내에 대표 계좌에서 자동 출금되므로 대표 계좌 잔액 확인 바랍니다.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4 class="order__title">주문 내역</h4>
                                <div class="checkout__order__products">Product <span>Total</span></div>
                                <ul class="checkout__total__products">
                                    <li>주문한 상품 <span>${deliver.product_priceShow }원</span></li>
                                    <li>안전거래 수수료(1%) <span>${deliver.commissionShow }원</span></li>
                                </ul>
                                <ul class="checkout__total__all">
                                    <li>총 가격 <span>${deliver.totalShow }원</span></li>
                                </ul>
                                <button type="submit" class="site-btn" id="paymentCheck" style="padding: 3%; font-size: 18px;">마이 페이지로 가기</button>
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
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<%--     <script src="${pageContext.request.contextPath }/resources/js/jquery.nice-select.min.js"></script> --%>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.nicescroll.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.magnific-popup.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.slicknav.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/mixitup.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/owl.carousel.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/pay.js"></script>
</body>

</html>