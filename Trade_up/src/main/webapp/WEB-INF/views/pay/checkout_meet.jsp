<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
                        <h4>결제(직거래)</h4>
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
    <!-- Breadcrumb Section End -->
    
	
    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                <form method="post" onsubmit="return meet_checks()">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <h6 class="coupon__code"><span class="icon_tag_alt"></span>같은 상품을 2회 이상 주문 완료 후 취소하실 경우 그 상품은 구매하실 수 없으므로 신중하게 구매해 주세요.</h6>
                            <h6 class="checkout__title">결제 정보</h6>
	                        <div class="col-lg-12">
	                            <div class="checkout__input">
	                                <p style="color: #5F12D3;">결제방식을 선택하신 후 결제하기 버튼을 눌려주시길 바랍니다.</p>
	                            </div>
	                        </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4 class="order__title">주문 내역</h4>
                                <div class="checkout__order__products">Product <span>Total</span></div>
                                <ul class="checkout__total__products">
                                    <li>주문한 상품 <span>${product_priceShow }원</span></li>
                                    <li>안전거래 수수료(1%) <span>${commissionShow }원</span></li>
                                </ul>
                                <input type="hidden" name="product_price"  value="${product_price }">
                                <input type="hidden" name="product_priceShow"  value="${product_priceShow }">
                                <input type="hidden" name="product_num"  value="${product_num }">
                                <input type="hidden" name="commission"  value="${commission }">
                                <input type="hidden" name="total"  value="${total }">
                                <input type="hidden" name="commissionShow"  value="${commissionShow }">
                                <input type="hidden" name="totalShow"  value="${totalShow }">
                                <input type="hidden" name="product_name" value="${product_name }">
                                <input type="hidden" name="member_name" value="${member_name }">
                                <ul class="checkout__total__all">
                                    <li>총 가격 <span>${totalShow }원</span></li>
                                </ul>
                                <div class="checkout__input__checkbox">
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
                                <input type="hidden" name="add" value="N">
                                <input type="hidden" name="pick" value="N">
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
    <script src="${pageContext.request.contextPath }/resources/js/checkout.js"></script>
</body>

</html>