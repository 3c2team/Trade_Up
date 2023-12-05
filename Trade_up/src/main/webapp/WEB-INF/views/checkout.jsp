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
        <jsp:include page="inc/top.jsp"></jsp:include>
    </header>
    <!-- Header Section End -->

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>결제</h4>
                        <div class="breadcrumb__links">
                            <a href="./index.html">홈</a>
                            <a href="./shop.html">상품</a>
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
                <form action="#">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <h6 class="coupon__code"><span class="icon_tag_alt"></span>같은 상품을 2회 이상 주문 완료 후 취소하실 경우 그 상품은 구매하실 수 없으므로 신중하게 구매해 주세요.</h6>
                            <h6 class="checkout__title">결제 정보
	                            <input type="radio" name="diliver" id="" value="1" checked style="accent-color: #5F12D3; margin-left: 55%;">
								<label style="margin-right: 3%;">기존 배송지</label>
								<input type="radio" name="diliver" id="" value="2" style="accent-color: #5F12D3;">
								<label>새로운 배송지</label>
                            </h6>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>받으시는 분<span>*</span></p>
                                        <input type="text" placeholder="이름 가져와서 띄우기" id="member_name" value="이예림" style="color: black;">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>아이디<span>*</span></p>
                                        <input type="text" placeholder="아이디 가져와서 띄우기" style="color: black;">
                                    </div>
                                </div>
                            </div>
<!--                             <div class="checkout__input"> -->
<!--                                 <p>계좌<span>*</span></p> -->
<!--                                 <input type="text"> -->
<!--                             </div> -->
                            <div class="checkout__input">
                                <p>
                                	주소<span>*</span>
                                	<button type="button" style="cursor: pointer; margin-left:1%; color:white; background-color: #cb99c5; border: none; font-size: 0.8em" id="btnSearchAddress" >주소 검색</button>
                                </p> <!-- box-shadow:0px 4px 0px #AD83A8; -->
                                <input type="text" placeholder="주소" class="checkout__input__add" style="color: black;">
                                <input type="text" placeholder="상세주소" style="color: black;">
                            </div>
                            <div class="checkout__input">
                                <p>우편번호<span>*</span></p>
                                <input type="text"  placeholder="주소 검색할 때 우편번호 가져오기(api 알아보기)" style="color: black;">
                            </div>
<!--                             <div class="checkout__input"> -->
<!--                                 <p>우편번호<span>*</span></p> -->
<!--                                 <input type="text"> -->
<!--                             </div> -->
<!--                             <div class="checkout__input"> -->
<!--                                 <p>Postcode / ZIP<span>*</span></p> -->
<!--                                 <input type="text"> -->
<!--                             </div> -->
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>전화번호<span>*</span></p>
                                        <input type="text"  placeholder="전화번호 가져와서 띄우기" style="color: black;">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>이메일<span>*</span></p>
                                        <input type="text"  placeholder="이메일 가져와서 띄우기" style="color: black;">
                                    </div>
                                </div>
                            </div>
<!--                             <div class="checkout__input__checkbox"> -->
<!--                                 <label for="acc"> -->
<!--                                     Create an account? -->
<!--                                     <input type="checkbox" id="acc"> -->
<!--                                     <span class="checkmark"></span> -->
<!--                                 </label> -->
<!--                                 <p>Create an account by entering the information below. If you are a returning customer -->
<!--                                 please login at the top of the page</p> -->
<!--                             </div> -->
<!--                             <div class="checkout__input"> -->
<!--                                 <p>Account Password<span>*</span></p> -->
<!--                                 <input type="text"> -->
<!--                             </div> -->
<!--                             <div class="checkout__input__checkbox"> -->
<!--                                 <label for="diff-acc"> -->
<!--                                     Note about your order, e.g, special noe for delivery -->
<!--                                     <input type="checkbox" id="diff-acc"> -->
<!--                                     <span class="checkmark"></span> -->
<!--                                 </label> -->
<!--                             </div> -->
                            <div class="checkout__input">
                                <p>배송 메세지</p>
                                <input type="text"
                                placeholder="배송 문구를 입력해주세요." style="color: black;">
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4 class="order__title">주문 내역</h4>
                                <div class="checkout__order__products">Product <span>Total</span></div>
                                <ul class="checkout__total__products">
                                    <li>주문한 상품 <span>30,000</span></li>
                                    <li>배송비 <span>3,000</span></li>
                                </ul>
                                <ul class="checkout__total__all">
                                    <li>총 가격 <span>33,000</span></li>
                                </ul>
                                <div class="checkout__input__checkbox"> <!-- 셋 중 하나만 되게 고칠 것 -->
                                    <label for="acc-or">
                                        카카오 페이
                                        <input type="checkbox" id="acc-or" name="pay">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="checkout__input__checkbox">
                                    <label for="payment">
                                        카드 결제
                                        <input type="checkbox" id="payment" name="pay">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="checkout__input__checkbox">
                                    <label for="paypal">
                                        무통장 입금
                                        <input type="checkbox" id="paypal" name="pay">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div id="block" class="form-select" style="display:none">
                                	<select  name="bank">
                                		<option value="noSelect" disabled>입금 은행을 선택해주세요.</option>
                                		<option value="kakao">카카오뱅크</option>
                                		<option value="kb">국민은행</option>
                                		<option value="woori">우리은행</option>
                               		</select>
								</div>
                                <button type="submit" class="site-btn">결제하기</button>
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
        <jsp:include page="inc/bottom.jsp"></jsp:include>
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
    <script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
    <script type="text/javascript">
    $(document).ready(function() {
    	$('input[type="checkbox"][name="pay"]').click(function(){
    		if($(this).prop('checked')){
    			$('input[type="checkbox"][name="pay"]').prop('checked',false);
    			$(this).prop('checked',true);
   			}
   		});
    	
        $('input[type="radio"][name="diliver"]').change(function(){
    	   if($('input[type="radio"][name="diliver"]:checked').val()==1){
    		   $("#member_name").val("이예림");
//     		   $("#phone").val("${Member.member_phone_num}");
    		   
    	   } else{
    	         $('input[type="text"]').val("");
    	   }
        });
        
        $(function(){
            $('input[type="checkbox"][id="paypal"]').click(function() {
                if ($('input[type="checkbox"][id="paypal"]').is(":checked")) {
                    $("#block").show();
                } else {
                    $("#block").hide();
                }
            })
     
        });
   	});
    </script>
</body>

</html>