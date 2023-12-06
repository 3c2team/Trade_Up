<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<title>Male-Fashion | Template</title>
<jsp:include page="../inc/style.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/shop_details.js"></script> --%>
<script type="text/javascript">
// 	function payCheck(){
// 		if(${sessionScope.sId} == null){
// 			alert("로그인 후 이용바랍니다.");
// 			return;
// 		}
// 		if(${sessionScope.sChat} == null){
// 			alert("채팅 후 안심거래 하시길 바랍니다.");
// 			return;
// 		}
		
// 	}


// var map = null,
// customOverlay = new kakao.maps.CustomOverlay({}),
// kkoMap = {
//   initKko: function (o) {
//     var e = o.mapId,
//       t = document.getElementById(e),
//       a = {
//         center: new kakao.maps.LatLng(37.567509, 126.980663),
//         level: 13,
//       };
//     (map = new kakao.maps.Map(t, a)),
//       $.getJSON("./json/sigu.json", function (o) {
//         let e = $(o.features);
//         e.each(function () {
//           kkoMap.getPolycode($(this)[0]);
//         });
//       });
//   },
//   getPolycode: function (o) {
//     var e = [],
//       t = o.geometry;
//     if ("Polygon" == t.type) {
//       var a = t.coordinates[0],
//         n = { name: o.properties.adm_nm, path: [] };
//       for (var s in a)
//         e.push({ x: p[s][1], y: p[s][0] }),
//           n.path.push(new kakao.maps.LatLng(a[s][1], a[s][0]));
//       kkoMap.setPolygon(n, e);
//     } else if ("MultiPolygon" == t.type)
//       for (var s in t.coordinates) {
//         var p = t.coordinates[s],
//           n = { name: o.properties.adm_nm, path: [] };
//         for (var r in p[0])
//           e.push({ x: p[0][r][1], y: p[0][r][0] }),
//             n.path.push(new kakao.maps.LatLng(p[0][r][1], p[0][r][0]));
//         kkoMap.setPolygon(n, e);
//       }
//   },
//   setPolygon: function (o, e) {
//     var t = new kakao.maps.Polygon({
//       name: o.name,
//       path: o.path,
//       strokeWeight: 2,
//       strokeColor: "#004c80",
//       strokeOpacity: 0.8,
//       fillColor: "#fff",
//       fillOpacity: 0.7,
//     });
//     kakao.maps.event.addListener(t, "mouseover", function (a) {
//       t.setOptions({ fillColor: "#09f" }),
//         customOverlay.setPosition(kkoMap.centroid(e)),
//         customOverlay.setContent(
//           "<div class='overlaybox'>" + o.name + "</div>"
//         ),
//         customOverlay.setMap(map);
//     }),
//       kakao.maps.event.addListener(t, "mouseout", function () {
//         t.setOptions({ fillColor: "#fff" }), customOverlay.setMap(null);
//       }),
//       t.setMap(map);
//   },
//   centroid: function (o) {
//     var e, t, a, n, s, p, r, i, l;
//     for (e = 0, r = i = l = 0, t = (a = o.length) - 1; e < a; t = e++)
//       (n = o[e]),
//         (s = o[t]),
//         (p = n.y * s.x - s.y * n.x),
//         (i += (n.x + s.x) * p),
//         (l += (n.y + s.y) * p),
//         (r += 3 * p);
//     return new kakao.maps.LatLng(i / r, l / r);
//   },
// };
// $(function () {
	
//   kkoMap.initKko({ mapId: "map" });
  
//   $("#product_info").getContents().replaceAll("<br>", "\r\n");
//   if()
//   $("#product_info").getContents().replaceAll("new", "\r\n");
  
// });
</script>
</head>
<body>
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	
    <!-- 본문 시작 -->
    <section class="shop-details">
        <div class="product__details__pic">
            <div class="container">
            	<!-- 1행 -->
                <div class="row">
					<!-- 왼쪽 -->
                    <div class="col-lg-6 col-md-9">
						<div class="tab-pane active" id="tabs-1" role="tabpanel">
						    <div class="product__details__pic__item">
							    <div id="carouselExampleIndicators" class="carousel slide" data-bs-interval="false">
									<div class="carousel-indicators">
										<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
										<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
										<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
									</div>
									<div class="carousel-inner">
										<div class="carousel-item active">
											<img class="product__details__pic__form" id="main_img" src="${pageContext.request.contextPath }${product.product_main_img}" class="d-block w-100" >
										</div>
										<c:forEach items="${productImg }" var="productImg" begin="0" varStatus="status">
											<div class="carousel-item">
												<img class="product__details__pic__form" src="${pageContext.request.contextPath }${productImg.product_image}" class="d-block w-100">
											</div>
										</c:forEach>
<!-- 											<div class="carousel-item"> -->
<%-- 												<img class="product__details__pic__form" src="${pageContext.request.contextPath }${productImg.product_image}" class="d-block w-100"> --%>
<!-- 											</div> -->
<!-- 										<div class="carousel-item"> -->
<%-- 											<img class="product__details__pic__form" id="main_img" src="${pageContext.request.contextPath }/resources/img/shop-details/product-big-2.png" class="d-block w-100"> --%>
<!-- 										</div> -->
									</div>
										<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
											<span class="carousel-control-prev-icon" aria-hidden="true"></span>
											<span class="visually-hidden">Previous</span>
										</button>
										<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
											<span class="carousel-control-next-icon" aria-hidden="true"></span>
											<span class="visually-hidden">Next</span>
										</button>
								</div>
						    </div>
							<div class="product__details__mini__pic">
								<ul>
								<!-- 이미지 업로드 수 만큼 조절해야함 -->
									<c:forEach var="product_img" items="${productImg }">
										<li><a><img src="${pageContext.request.contextPath }/resources/img/shop-details/ex.jpg" id="mini_img" ></a></li>
									</c:forEach>
<%-- 									<c:if test="${not empty reviewList }"> --%>
										<li><a><img src="${pageContext.request.contextPath }/resources/img/shop-details/thumb-1.png" id="mini_img" ></a></li>
										<li><a><img src="${pageContext.request.contextPath }/resources/img/shop-details/thumb-2.png" id="mini_img" ></a></li>
										<li><a><img src="${pageContext.request.contextPath }/resources/img/shop-details/thumb-3.png" id="mini_img" ></a></li>
<%-- 									</c:if> --%>
								</ul>					
							</div>
						</div>
                    </div>
					<!-- 오른쪽 -->
                    <div class="col-lg-6 col-md-9">
						<div class="product__details__content" style="margin: 10%;">
	                        <div class="product__details__breadcrumb">
	                            <a href="Main">홈</a>
	                            <a href="Shop?category=${category.category_name }">${category.category_name }</a>
	                            <span>${product.product_num }</span>
	                        </div>
							<div class="container">
								<div class="row d-flex justify-content-center">
									<div class="col-lg-8" style="max-width: 100%;">
										<div class="product__details__text">
											<h3>${product.product_name }</h3>
											<h3 style="padding-bottom: 1.25rem; border-bottom: 0.01em #adb5bd solid;">${product.product_price }</h3>
											<div style="display: flex; text-align: center;">
												<span>37분 전 · 조회 16 · 찜 0</span>
											</div>
											<div class="product__details__info">
												<div>
													<p>배송비</p><br><h6>배송비 별도</h6>
												</div>
												<div style="border-left: 0.1em #adb5bd solid; padding-left: 20px;">
													<p>업페이</p><br><h6>${product.uppay }</h6>
												</div>
												<div style="border-left: 0.1em #adb5bd solid; padding-left: 20px; margin-right: 50px;">
													<p>제품상태</p><br><h6 id="product_status">${product.product_status }</h6>
												</div>
											</div>
											<h6 style="text-align: left; margin-top: 30px">직거래 희망장소</h6>
											<div id="map" style="margin-bottom:1em; width:400px; height:190px;"></div>
											<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0d79e4be802855b8c8c9dc38e9b02f6d"></script>
											<script>
												var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
											    mapOption = { 
											        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
											        level: 3 // 지도의 확대 레벨
											    };
	
												var map = new kakao.maps.Map(mapContainer, mapOption);
		
												// 마커가 표시될 위치입니다 
												var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 
		
												// 마커를 생성합니다
												var marker = new kakao.maps.Marker({
												    position: markerPosition
												});
		
												// 마커가 지도 위에 표시되도록 설정합니다
												marker.setMap(map);
		
												var iwContent = '<div style="padding:5px;">직거래 희망장소<br><a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:#5F12D3 padding:5px;" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
												    iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다
		
												// 인포윈도우를 생성합니다
												var infowindow = new kakao.maps.InfoWindow({
												    position : iwPosition, 
												    content : iwContent 
												});
												  
												// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
												infowindow.open(map, marker); 
											</script>
											<div class="product__details__option">
				                                <div class="product__details__option__size">
				                                    <span>거래방법 선택</span>
				                                    <label for="xxl">택배거래
				                                        <input type="radio" id="xxl">
				                                    </label>
				                                    <label class="active" for="xl">직거래
				                                        <input type="radio" id="xl">
				                                    </label>
				                                </div>
				                            </div>
											<div class="product__details__cart__option">
				                                <a href="#" class="primary-btn">채팅하기</a>
				                                <a href="#" class="primary-btn" onclick="payCheck()">안심거래하기</a>
				                            </div>
										</div>
									</div>
								</div>
							</div>
						</div>
                    </div>
                </div>
            </div>
        </div>
				<!-- 상세정보 시작 -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__tab">
							<div class="row">
                            <div class="tab-content">
                            <div class="product__content__all">
                                <div class="tab-pane active" id="tabs-5" role="tabpanel">
                                    <div class="product__details__tab__content">
										<h5>상품내용</h5>
                                        <p class="note">거래 전 주의사항 안내<br>
														판매자가 별도의 메신저로 결제링크를 보내거나 직거래(직접송금)을<br>
														유도하는 경우 사기일 가능성이 높으니 거래를 자제해 주시고<br>
														Garge 고객센터로 신고해주시기 바랍니다.</p>
<!--                                         <div class="product__details__tab__content__item"> -->
                                        <div class="product__details__tab__content__item">
<!--                                         	<a name="tabs-5"></a> -->
											<p id="product_info">${product.product_info }
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-6" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
<!--                                         	<a name="tabs-6"></a> -->
                                            <h5>판매자 정보</h5>
                                            <p>빈조우님</p>
                                            <p>판매상품 999+ / 안전거래 43 / 후기 10</p>
                                        </div>
                                        <div class="product__details__tab__content__item">
                                            <h6>빈조우님의 판매 상품 50</h6>
                                        </div>
								        <div class="container">
								            <div class="row" style="justify-content: space-between;">
								                <div class="col">
								                    <div class="product__item">
						                                <div class="product__item__pic set-bg" style="width: 170px; height: 170px;" data-setbg="${pageContext.request.contextPath }/resources/img/shop-details/ex.jpg">
						                                    <ul class="product__hover">
						                                        <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a></li>
						<%--                                         <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li> --%>
						                                        <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
						                                    </ul>
						                                </div>
						                                <div class="product__item__text">
						                                    <h6>유틸리티 자켓</h6>
						                                    <a href="#" class="add-cart">상세보기</a>
															<p>부산진구 <span> / 6분 전</span></p>
						                                    <h5>30000원</h5>
						                                </div>
						                            </div>
								                </div>
								                <div class="col">
								                    <div class="product__item sale">
						                                <div class="product__item__pic set-bg" style="width: 170px; height: 170px;" data-setbg="${pageContext.request.contextPath }/resources/img/shop-details/ex.jpg">
						                                    <span class="label">무료나눔</span>
						                                    <ul class="product__hover">
						                                        <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a></li>
						<%--                                         <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li> --%>
						                                        <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
						                                    </ul>
						                                </div>
						                                <div class="product__item__text">
						                                    <h6>가방 팔아요</h6>
						                                    <a href="#" class="add-cart">상세보기</a>
															<p>서울 마포구 중앙동 <span> / 15분 전</span></p>
						                                    <h5>5000원</h5>
						                                </div>
						                            </div>
								                </div>
								                <div class="col">
								                    <div class="product__item sale">
						                                <div class="product__item__pic set-bg" style="width: 170px; height: 170px;" data-setbg="${pageContext.request.contextPath }/resources/img/shop-details/ex.jpg">
						                                    <span class="label">무료나눔</span>
						                                    <ul class="product__hover">
						                                        <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a></li>
						<%--                                         <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li> --%>
						                                        <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
						                                    </ul>
						                                </div>
						                                <div class="product__item__text">
						                                    <h6>가방 팔아요</h6>
						                                    <a href="#" class="add-cart">상세보기</a>
															<p>서울 마포구 중앙동 <span> / 15분 전</span></p>
						                                    <h5>5000원</h5>
						                                </div>
						                            </div>
								                </div>
								            </div>
								        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Details Section End -->

    <!-- 판매자 시작 -->
    
    <!-- 인기상품 시작 -->
    <section class="related spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="related-title">최신 등록 상품</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath }/resources/img/product/product-1.jpg">
                            <span class="label">New</span>
                            <ul class="product__hover">
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6>PiquÃ© Biker Jacket</h6>
                            <a href="#" class="add-cart">+ Add To Cart</a>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5>$67.24</h5>
                            <div class="product__color__select">
                                <label for="pc-1">
                                    <input type="radio" id="pc-1">
                                </label>
                                <label class="active black" for="pc-2">
                                    <input type="radio" id="pc-2">
                                </label>
                                <label class="grey" for="pc-3">
                                    <input type="radio" id="pc-3">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath }/resources/img/product/product-2.jpg">
                            <ul class="product__hover">
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6>PiquÃ© Biker Jacket</h6>
                            <a href="#" class="add-cart">+ Add To Cart</a>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5>$67.24</h5>
                            <div class="product__color__select">
                                <label for="pc-4">
                                    <input type="radio" id="pc-4">
                                </label>
                                <label class="active black" for="pc-5">
                                    <input type="radio" id="pc-5">
                                </label>
                                <label class="grey" for="pc-6">
                                    <input type="radio" id="pc-6">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item sale">
                        <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath }/resources/img/product/product-3.jpg">
                            <span class="label">Sale</span>
                            <ul class="product__hover">
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6>Multi-pocket Chest Bag</h6>
                            <a href="#" class="add-cart">+ Add To Cart</a>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5>$43.48</h5>
                            <div class="product__color__select">
                                <label for="pc-7">
                                    <input type="radio" id="pc-7">
                                </label>
                                <label class="active black" for="pc-8">
                                    <input type="radio" id="pc-8">
                                </label>
                                <label class="grey" for="pc-9">
                                    <input type="radio" id="pc-9">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath }/resources/img/product/product-4.jpg">
                            <ul class="product__hover">
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6>Diagonal Textured Cap</h6>
                            <a href="#" class="add-cart">+ Add To Cart</a>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5>$60.9</h5>
                            <div class="product__color__select">
                                <label for="pc-10">
                                    <input type="radio" id="pc-10">
                                </label>
                                <label class="active black" for="pc-11">
                                    <input type="radio" id="pc-11">
                                </label>
                                <label class="grey" for="pc-12">
                                    <input type="radio" id="pc-12">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- 바텀 시작 -->
	<footer class="footer">
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
    </footer>
</body>

</html>