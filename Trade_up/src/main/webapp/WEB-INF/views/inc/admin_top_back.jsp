<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>


    <!-- Header Section Begin -->
    <header class="header">
        <div class="container">
            <div class="customrow">
                <div class="col-lg-3 col-md-3">
                    <div class="header__logo" id="easterEgg" onclick="easterEgg()">
                       <a href="./"><img src="${pageContext.request.contextPath }/resources/img/tradeup.jpg" style="width: 70%" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <nav class="header__menu mobile-menu">
						<div class="shop__sidebar__search">
							<form action="#">
								<input type="text" style="margin-top:7%;" placeholder="상품 혹은 동네를 입력해주세요">
								<button style="margin-top:4%;" type="submit"><span class="icon_search"></span></button>
							</form> 
						</div>
<!--                         <ul> -->
<!--                             <li class="active"><a href="./">메인</a></li> -->
<!--                             <li><a href="Shop">중고거래</a></li> -->
<!--                             <li><a href="#">페이지</a> -->
<!--                                 <ul class="dropdown"> -->
<!--                                     <li><a href="About">About Us</a></li> -->
<!--                                     <li><a href="ShopDetails">Shop Details</a></li> -->
<!--                                     <li><a href="ShoppingCart">Shopping Cart</a></li> -->
<!--                                     <li><a href="Checkout">Check Out</a></li> -->
<!--                                     <li><a href="BlogDetails">Blog Details</a></li> -->
<!--                                 </ul> -->
<!--                             </li> -->
<!--                             <li><a href="FraudInquiry">사기조회</a></li> -->
<!--                             <li><a href="MarketPriceInquiry">시세조회</a></li> -->
<!--                         </ul> -->
                    </nav>
                </div>
                <div class="col-lg-3 col-md-3">
                    <div class="header__nav__option" >
                        <a href="MyPageMain"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a>&nbsp;&nbsp;
                        <a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/chatting.png" style=" width: 20px" alt=""></a>
                        <a href="${pageContext.request.contextPath }/Login"><img src="${pageContext.request.contextPath }/resources/img/icon/person.png" style=" width: 30px" alt=""></a>
                    </div>
                </div>
            </div>
            <div class="canvas__open"><i class="fa fa-bars"></i></div>
        </div>
    </header>
    <!-- Header Section End -->
