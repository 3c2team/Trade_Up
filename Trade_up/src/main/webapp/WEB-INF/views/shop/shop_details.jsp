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
<style type="text/css">
   .report_img{
      max-width: 100%;
       width: 20px;
       cursor: pointer;
       float: inline-end;
   }
   .custom_seller{
		cursor: pointer;
		border: solid;
		border-width: 1px;
		border-radius: 1rem;
		padding: 1rem;
		border-color: rgb(230 230 230);
   }

</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
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
                              <li><a><img src="${pageContext.request.contextPath }/resources/img/shop-details/thumb-1.png" id="mini_img" ></a></li>
                              <li><a><img src="${pageContext.request.contextPath }/resources/img/shop-details/thumb-2.png" id="mini_img" ></a></li>
                              <li><a><img src="${pageContext.request.contextPath }/resources/img/shop-details/thumb-3.png" id="mini_img" ></a></li>
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
                               
                               <div id="favorite_btn"class="favorite_off" style="cursor:pointer; width: 50px;float: inline-end;"></div>
                           </div>
                     <div class="container">
                        <div class="row d-flex justify-content-center">
                           <div class="col-lg-8" style="max-width: 100%;">
                              <div class="product__details__text">
                                 <h3>${product.product_name }</h3>
                                 <h3 style="padding-bottom: 1.25rem; border-bottom: 0.01em #adb5bd solid;">${product.product_price }
                                 <img onclick="location.href='RegistQuewstion?product_num=${param.product_num}'" class="report_img" src="${pageContext.request.contextPath }/resources/img/product/report.png">
                                 </h3>
                                 <span></span>
                                 <div style="display: flex; text-align: center;">
                                    <span>37분 전 · 찜 ${jjim}</span>
                                 </div>
                                 <div class="product__details__info">
                                    <div>
                                       <p>배송비</p><br><h6>${product.delivery_method }</h6>
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
                                    <c:forEach var="sellerProduct" items="${sellerProduct }">
                                       <input type="hidden" id="sellMember" value="${sellerProduct.member_id}">
                                       <input type="hidden" value="${product_num}">
                                       <c:choose>
                                          <c:when test="${empty sessionScope.sId }">
											<a class="primary-btn"  style="background: gray;">채팅하기</a>                                             
                                          </c:when>
                                          <c:otherwise>
											<a href="#" id="btnJoin" class="primary-btn" onclick="openChat()">채팅하기</a>
                                          </c:otherwise>
                                       </c:choose>
										<a href="#" class="primary-btn" onclick="payCheck()">안심거래하기</a>
									</c:forEach>
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
<!--                                            <a name="tabs-5"></a> -->
                                 <p id="product_info">${product.product_info }
                                        </div>
                                    </div>
                                </div>
								
								<!-- 판매자 시작 -->
                                <div class="tab-pane" id="tabs-6" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item custom_seller" onclick="location.href='UserMarket?member_id=${product.member_id}'">
<!--                                            <a name="tabs-6"></a> -->
                                            <h5>판매자 정보</h5>
                                            ${product.member_id}님
                                            <p>판매상품 ${sellerCount} / 안전거래 43</p>
                                        </div>
                                        <div class="product__details__tab__content__item">
                                            <h6>${product.member_id }님의 판매 상품 ${sellerCount}</h6>
                                        </div>
		                               <div class="container">
		                                   <div class="row" style="justify-content: space-between;">
		                                   <c:forEach items="${sellerProduct }" var="sellerProduct" end="2">
		                                       <div class="col">
		                                           <div class="product__item">
		                                                 <div class="product__item__pic set-bg" style="width: 170px; height: 170px;" data-setbg="${pageContext.request.contextPath }${sellerProduct.product_main_img}">
		                                                     <ul class="product__hover">
		                                                         <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt=""></a></li>
		                                                         <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
		                                                     </ul>
		                                                 </div>
		                                                 <div class="product__item__text">
		                                                     <h6>${sellerProduct.product_name}</h6>
		                                                     <a href="ShopDetail?product_num=${sellerProduct.product_num}" class="add-cart">상세보기</a>
		                                            <p>${sellerProduct.trading_location} <span> / ${sellerProduct.product_release }</span></p>
		                                                     <h5>${sellerProduct.product_price }</h5>
		                                                 </div>
		                                             </div>
		                                       </div>
		                                   </c:forEach>
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
    
    <!-- 인기상품 시작 -->
    <section class="related spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="related-title">최신 등록 상품</h3>
                </div>
            </div>
            <div class="row">
            	<c:forEach items="${productList }" var="product" end="4" varStatus="status">
                       <div class="col-lg-4 col-md-6 col-sm-6 product${status.count} productList" >
                           <div class="product__item">
                               <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath }${product.product_main_img}" onclick="location.href='ShopDetail?product_num=${product.product_num}'">
                                   <ul class="product__hover">
                                       <li><a href="ShopDetail?product_num=${product.product_num}"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt="찜"></a></li>
                                       <li><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt="자세히보기"></li>
                                   </ul>
                               </div>
                               <div class="product__item__text">
                                   <h6>${product.product_name}</h6>
                                   <a href="ShopDetail?product_num=${product.product_num}" class="add-cart">상세보기</a>
								<p>${product.trading_location }<span> / ${product.product_release }</span></p>
                                   <h5>${product.product_price}</h5>
                               </div>
                           </div>
                       </div>
				</c:forEach>
            </div>
        </div>
    </section>
    
    <!-- 바텀 시작 -->
   <footer class="footer">
      <jsp:include page="../inc/bottom.jsp"></jsp:include>
    </footer>
    
</body>
<script type="text/javascript">
	// 채팅 연결
	function openChat() {
	   let memberId = $("#sellMember").val();
	//      alert(memberId);
	//    window.open("MyChat?memberId=" + memberId, "MyChat","top=200,left=700,width=500, height=430");
	   window.open("MyChat?memberId=" + memberId, "MyChat","top=200,left=700,width=520, height=395");
	}
   
   function payCheck(){
      let sId = "${sessionScope.sId}";
      if(sId == null){
         alert("로그인 후 이용바랍니다.");
         return;
      }
      window.open("ShopPay?product_num=" + ${product.product_num}, "ShopPay","top=200,left=700,width=500, height=430");
      
   }

   $(function() {
	   let isRun = false;
	   let proNum = ${param.product_num};
	   let sId = "${sessionScope.sId}";
	      $.ajax({
	            url: "selectFavorite",
	            method: 'POST',
	            data: { proNum: proNum, sId: sId },
	            success: function(data) {
	               $("#favorite_btn").removeClass();
	               $("#favorite_btn").addClass('favorite_' + data);
	            },
	            error: function(error) {
	               if(${empty sessionScope.sId }) {
	                  alert("로그인이 필요합니다.");
	               }
	            }
	         });
	

	      // ===== 중복 방어 코드 =====

	      $("#favorite_btn").on('click', function() {
	         if(isRun) {
	            return;
	         }
	         
	         isRun = true;
	      // ======================
	         
	       
	         let favBtnClass = $("#favorite_btn").attr("class");
	         let url = favBtnClass == "favorite_on" ? "RemoveFavorite" : "AddFavorite";
	         
	         alert(url);
// 	         return;
	         $.ajax({
	            url: url,
	            method: 'POST',
	            data: { proNum: proNum, sId: sId },
	            success: function(data) {
	               $("#favorite_btn").removeClass();
	               $("#favorite_btn").addClass('favorite_' + data);
	               isRun = false;
	            },
	            error: function(error) {
	               if(${empty sessionScope.sId }) {
	                  alert("로그인이 필요합니다.");
	               }
	            }
	         });
	      });
   });
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
</html>