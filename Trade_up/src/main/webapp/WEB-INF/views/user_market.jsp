<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Male-Fashion | Template</title>
<style type="text/css">
.custom_div_box{
    background: white;
    border: solid;
    border-width: 1px;
    border-color: #b8bec5;
    padding: 1.25rem;
    border-radius: 0.5rem ;
    margin-bottom: 1rem ;
    display: flex;
    padding-top: 20px;
    padding-bottom: 20px;
}
.user_profile{
	width: 60px;
	height: 60px;
	border-color: rgb(255 255 255);
	border-radius: 9999px;
}
.user_name{
	font-size: 1.5rem;
	line-height: 2rem;
	font-weight: 600;
	margin-left: 20px;
}
.user_box{
    width: 50%;
    display: flex;
    border-right: solid;
    border-color: #b8bec5;
    border-width: 1px;
    padding: 20px;
}
.user_border{
	background: rgb(204 244 220);
    width: 95%;
    height: 0.375rem;
    margin-left: 20px;
    border-radius: 1rem;
}
*{
	font-family: "Pretendard Variable", "sans-serif";
}
.user_font{
    margin-bottom: 5px;
    margin-left: 20px;
    font-weight: bolder;
    color: rgb(12 182 80);
}
.icon_img{
	height: 30px;
}
.custom_chat_btn{
    border: solid;
    border-width: 2px;
    width: 100%;
    height: 3.5rem;
    color: rgb(20 19 19);
    font-weight: 600;
    padding-top: 0.5rem;
    padding-bottom: 0.5rem;
    border-radius: 0.375rem;
    background: white;
}
.custom_font{
	font-size: 1.1rem;
    color: rgb(156 163 175);
    margin-top: 2rem;
    margin-bottom: 2rem;
}

</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body >
	<jsp:include page="inc/top.jsp"></jsp:include>
		<div  style="min-height: 60rem; width: 80%; margin: auto;">
			<div class="custom_div_box">
				<div class="user_box">
					<img class="user_profile" alt="" src="https://img2.joongna.com/common/Profile/Default/profile_m.png">
					<div>
						<h1 class="user_name">${Seller.member_nick_name}
						<c:if test="${!empty Seller.naver_id}">
							<img class="icon_img" style="margin-left: 7px;" src="${pageContext.request.contextPath }/resources/img/icon/naver_icon.png">
						</c:if>
						<c:if test="${!empty Seller.kakao_id}">
							<img class="icon_img" style="height: 35px;" src="${pageContext.request.contextPath }/resources/img/icon/kakao_icon.jpg">
						</c:if>
						</h1>
						<div style="color: rgb(156 163 175);margin-left: 20px;margin-top: 5px;">생년월일 : ${Seller.member_birth}</div>
					</div>
				</div>
				<div style="width: 50%;    padding-top: 15px;">
					<div class="user_font fs-5">신뢰지수 ${sellerCount.count } 
						<span style="float: inline-end; margin-right: 5px; color: rgb(156 163 175);">1000</span>
					 </div>
					<div class="user_border">
						<div class="user_border" style="background-color: rgb(12 182 80); width: ${sellerCount.count }%; margin-left: 0px;"></div>
					</div>
				</div>
			</div>
			<input type="button" class="custom_chat_btn" value="채팅하기">
			<div class="custom_font">${Seller.Count }개의 상품</div>
			<div style="display: flex;">
				<c:forEach var="sellerProduct" items="${sellerProduct }">
					<div class="col-lg-4 col-md-6 col-sm-6 product${status.count} productList" >
						<div class="product__item">
							<div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath }${product.product_main_img}" onclick="location.href='ShopDetail?product_num=${sellerProduct.product_num}'">
								<ul class="product__hover">
									<li><a href="ShopDetail?product_num=${sellerProduct.product_num}"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt="찜"></a></li>
									<li><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt="자세히보기"></li>
								</ul>
							</div>
							<div class="product__item__text">
								<h6>${sellerProduct.product_name}</h6>
								<a href="ShopDetail?product_num=${sellerProduct.product_num}" class="add-cart">상세보기</a>
								<p>${sellerProduct.trading_location }<span> / ${sellerProduct.product_release }</span></p>
								<h5>${sellerProduct.product_price}원</h5>
		        			</div>
		    			</div>
					</div>
				</c:forEach>
			</div>
		</div>
	<jsp:include page="inc/bottom.jsp"></jsp:include>
</body>
</html>