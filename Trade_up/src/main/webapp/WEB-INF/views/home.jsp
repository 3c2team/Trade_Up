<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Trade Up</title>
<style type="text/css">
    .main_heart{
	    background-size: contain;
	    width: 30px;
	    height: 30px;
    }
</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>

<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
    <!-- Hero Section Begin -->
    <section class="hero">
        <div class="hero__slider owl-carousel">
            <div class="hero__items set-bg" data-setbg="${pageContext.request.contextPath }/resources/img/hero/5128322.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-5 col-lg-7 col-md-8">
                            <div class="hero__text">
                                <div class="hero__social">
                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                    <a href="#"><i class="fa fa-pinterest"></i></a>
                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hero__items set-bg" data-setbg="${pageContext.request.contextPath }/resources/img/hero/hero-2.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-5 col-lg-7 col-md-8">
                            <div class="hero__text">
                                <div class="hero__social">
                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                    <a href="#"><i class="fa fa-pinterest"></i></a>
                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->

    <!-- Banner Section Begin -->
    
    <!-- Banner Section End -->

    <!-- Product Section Begin -->
    <section class="product spad" style="margin-top: 5rem;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="filter__controls">
                        <li data-filter=".new-arrivals">새로운 상품</li>
                    </ul>
                </div>
            </div>
            <div class="row product__filter" style="overflow:auto; flex-wrap: nowrap;">
            <c:forEach items="${productList }" var="productList">
	                <div class="col-lg-3 col-md-6 col-sm-6 col-md-6 col-sm-6 mix new-arrivals" onclick="location.href='ShopDetail?product_num=${productList.product_num}'">
	                    <div class="product__item">
	                        <div class="product__item__pic set-bg" data-setbg="${productList.product_main_img}">
	                            <span class="label">New</span>
	                            <ul class="product__hover">
	                            	<c:if test="${empty productList.favorite_idx}">
	                                	<li style="margin-left:10px;background-size: contain; width: 30px; height: 30px;" class="favorite_off"></li>
	                                </c:if>
	                            	<c:if test="${!empty productList.favorite_idx}">
	                                	<li style="margin-left:10px; background-size: contain; width: 30px; height: 30px;"class="main_heart favorite_on"></li>
	                                </c:if>
	                                <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
	                            </ul>
	                        </div>
	                        <div class="product__item__text">
	                            <h6>${productList.product_name}</h6>
	                            <div class="rating">
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                            </div>
	                            <p>${productList.trading_location } <span> / ${productList.productRelease}</span></p>
	                            <h5>${productList.product_price}</h5>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
            </div>
        </div>
    </section>
    <!-- Product Section End -->

    <!-- Categories Section Begin -->
    <!-- Categories Section End -->

    <!-- Instagram Section Begin -->
    <!-- Instagram Section End -->

    <!-- Latest Blog Section Begin -->
    <!-- Latest Blog Section End -->

	<jsp:include page="inc/bottom.jsp"></jsp:include>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7a037ee7b5defdef9bd8b44dd31e3eac&libraries=services"></script>
  <script type="text/javascript">
    navigator.geolocation.getCurrentPosition(position => {
		const gps = {
			latitude: position.coords.latitude,
			longitude: position.coords.longitude
		}
		// 검색이름
		var SEARCH_KEYWORD = "동사무소";
		
        const options = {
   			x: gps.longitude,
   			y: gps.latitude,
   			redius: 1000
   		};
		
		const places = new kakao.maps.services.Places();

		var callback = function(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
				for(let i = 0; i < result.length; i++){
					if(result[i].category_name.includes("주민센터")){
						console.log(result[i]);
					}
				}
		    }
		};
		console.log("성공");
		places.keywordSearch(SEARCH_KEYWORD, callback,options); 
	});
	</script>

</body>

</html>