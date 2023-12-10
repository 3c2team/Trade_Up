<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>


    <!-- Header Section Begin -->
    <header class="header">
    	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
    	<script type="text/javascript">
			userId= "${sessionScope.sId}"; // 사용자 세션 아이디 저장
			let ws_base_url = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
			ws = new WebSocket(ws_base_url + "/echo2"); // 웹소켓 요청(Handshake)
			ws.onopen = onOpen; // 웹소켓 요청에 대한 연결 성공 시
    	</script>
        <div class="container" style="width: 100%; max-width: 100%;">
            <div class="customrow">
                <div class="col-lg-3 col-md-3">
                    <div class="header__logo" id="easterEgg" onclick="easterEgg()">
<!--                     <div class="header__logo" id="easterEgg" > -->
                        <a href="./"><img src="${pageContext.request.contextPath }/resources/img/logo.png" style="width: 70%" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <nav class="header__menu mobile-menu">
						<div class="shop__sidebar__search">
							<form action="Shop" onsubmit="return isSubmit()">
								<input type="text" name="search"style="margin-top:7%;" placeholder="상품 혹은 동네를 입력해주세요">
								<button style="margin-top:4%;" type="submit"><span class="icon_search"></span></button>
							</form> 
						</div>
                        <ul>
                            <li class="active"><a href="./">메인</a></li>
                            <li><a href="Shop">중고거래</a></li>
                            <li><a href="#">페이지</a>
                                <ul class="dropdown">
                                    <li><a href="About">About Us</a></li>
                                    <li><a href="ShopDetails">Shop Details</a></li>
                                    <li><a href="ShoppingCart">Shopping Cart</a></li>
                                    <li><a href="Checkout">Check Out</a></li>
                                    <li><a href="BlogDetails">Blog Details</a></li>
                                </ul>
                            </li>
                            <li><a href="FraudInquiry">사기조회</a></li>
                            <li><a href="MarketPriceInquiry">시세조회</a></li>
                            <li><a href="ChatMain">채팅테스트</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3 col-md-3">
                    <div class="header__nav__option" style="width: 100%;" >
                    <c:choose>
						<c:when test="${empty sessionScope.sId }">
	                        <a href="Login"><p>로그인</p></a>
	                        <a href="Join"><p>회원가입</p></a>
						</c:when>
						<c:otherwise>
							<strong>${sessionScope.sName }</strong> 님 반갑습니다. &nbsp;&nbsp;&nbsp;
								 <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false"> <i class="fa fa-solid fa-user fa-lg" style="color: #262626;"></i></a>
								      <ul class="dropdown-menu">
								     	 <li><a class="dropdown-item" href="MyPageMain">마이페이지</a></li>
								     	 <li><a class="dropdown-item" href="Logout">로그아웃</a></li>
								      </ul>
	                        <a href="#none" onclick="chatRoom()"><i class="fa fa-solid fa-comment fa-lg" style="color: #262626;"></i></a>
	                        <a href="ShopForm"><i class="fa fa-solid fa-money fa-lg" style="color: #262626;"></i></a>
						</c:otherwise>
					</c:choose>
                    </div>
                </div>
            </div>
            <div class="canvas__open"><i class="fa fa-bars"></i></div>
        </div>
        <script type="text/javascript">
        	function openChat() {
        		window.open("MyChat", "MyChat","top=200,left=700,width=500, height=500");
			}
        	function chatRoom() {
        		window.open("ChatRoom", "ChatRoom","top=200,left=700,width=437, height=618");
			}
        </script>
    </header>
    <!-- Header Section End -->
