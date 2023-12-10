<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html><html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Male_Fashion Template">
<meta name="keywords" content="Male_Fashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Male-Fashion | Template</title>
<jsp:include page="../inc/style.jsp"></jsp:include>
<style type="text/css">
.btn{
	 background-color:#e0e0e0;
	 margin: 5px;
	 font-size: 13px;
}
.cusor{
	cursor: pointer;
}
</style>
</head>
<body>
	<jsp:include page="../inc/top.jsp"></jsp:include>
	
    <!-- 주메뉴 -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>거래하기</h4>
                        <div class="breadcrumb__links">
                            <a href="./index.html">홈</a>
                            <span>거래하기</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 거래하기 메인 시작 -->
    <section class="shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="shop__sidebar">
                        <div class="fs-5 fw-bold">
                       		필터
                        </div>
                        <div>
							<div class="btn delete" hidden="" id="category">
							</div>	
							<div class="btn delete" hidden="" id="price">
							</div>	
							<div class="btn delete" hidden="" id="search">
							</div>	
                        </div>
                        
                        <!-- 왼쪽 사이드바 -->
                        <div class="shop__sidebar__accordion">
                            <div class="accordion" id="accordionExample">
								<!-- 카테고리 -->
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapseOne">카테고리</a>
                                    </div>
                                    <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="card-main">
                                                <ul class="nice-scroll">
                                                	<c:forEach var="selectCategory" items="${selectCategory }">
														<li><div class="cusor">${selectCategory.category_name }</div></li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- 가격 -->
                                <div id="collapseThree" class="collapse show" data-parent="#accordionExample">
                                    <div class="card-body">
                                        <div class="shop__sidebar__price">
                                            <ul>
                                                <li class="custom_li">
                                                	<label><input type="radio" class="radio form-check-input"name="radio" value="10만원 이하">10만원 이하</label>
                                                </li>
                                                <li class="custom_li">
                                                	<label><input type="radio" class="radio form-check-input" name="radio" value="10만원 - 30만원 이하">10만원 - 30만원 이하</label>
                                                </li>
                                                <li class="custom_li">
                                                	<label><input type="radio" class="radio form-check-input" name="radio" value="30만원 - 50만원 이하">30만원 - 50만원 이하</label>
                                                </li>
                                                <li class="custom_li">
                                                	<label><input type="radio" class="radio form-check-input" name="radio" value="50만원 이상">50만원 이상</label>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 본문 시작 -->
                <div class="col-lg-9">
                    <div class="shop__product__option">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__left">
                                    <p>Showing DBAll of DBselect results</p>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__right">
                                    <p>정렬:&nbsp;</p>
                                    <select>
                                        <option value="">추천순</option>
                                        <option value="">최신순</option>
                                        <option value="">낮은가격순</option>
                                        <option value="">높은가격순</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach items="${productList }" var="product" begin="0" varStatus="status">
	                        <div class="col-lg-4 col-md-6 col-sm-6 product${status.count} productList" >
	                            <div class="product__item">
	                                <div class="product__item__pic set-bg" data-setbg="${pageContext.request.contextPath }${product.product_main_img}" onclick="location.href='ShopDetail?product_num=${product.product_num}'">
	                                    <ul class="product__hover">
	                                        <li><a href="ShopDetail?product_num=${product.product_num}"><img src="${pageContext.request.contextPath }/resources/img/icon/heart.png" alt="찜"></a></li>
<%-- 	                                        <li><a href="#"><img src="${pageContext.request.contextPath }/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li> --%>
	                                        <li><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt="자세히보기"></li>
	                                    </ul>
	                                </div>
	                                <div class="product__item__text">
	                                    <h6>${product.product_name}</h6>
	                                    <a href="ShopDetail?product_num=${product.product_num}" class="add-cart">상세보기</a>
										<p>${product.trading_location }<span> / ${product.product_release }</span></p>
	                                    <h5>${product.product_price}원</h5>
<%-- 	                                    <fmt:formatDate value="${product.product_release }" pattern="yy-MM-dd HH:mm"/> --%>
	                                </div>
	                            </div>
	                        </div>
						</c:forEach>
			        </div>
			    </div>
			</div>
        </div>
    </section>
    <footer class="footer">
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
    </footer>
    <script type="text/javascript">
    $(function() {
// 		debugger;
//			alert("${param}")
//			if(search){
		var search = "";
		var category = "";
		var price = "";
		if("${param.category}"){
			category = "&category=${param.category}";
			$(".cusor").each(function(){
// 				debugger;				
				if($(this).text() == "${param.category}"){
					$(this).css("color","red");
				}
			});
			$("#category").attr("hidden",false);
			$("#category").html("${param.category} <i class='bi bi-x'></i>");
		}
		if("${param.search}"){
			search = "&search=${param.search}";
			$("#search").attr("hidden",false);
			$("#search").html("${param.search} <i class='bi bi-x'></i>");
		}
		if("${param.price}"){
			$("input[type=radio][name=radio]").each(function(){
				if($(this).val() == "${param.price}"){
					$(this).prop("checked",true);
				}
			});
			price = "&price=${param.price}";
			$("#price").attr("hidden",false);
			$("#price").html("${param.price} <i class='bi bi-x'></i>");
		}
		
		
		$(".delete").on("click",function(){
			let totalSearch = search + price + category;
			let deleteSearch = $(this).text().trim();
			
			if(deleteSearch == "${param.price}"){
				
				totalSearch = totalSearch.replace(price,"");		
			}else if(deleteSearch == "${param.search}"){
				
				totalSearch = totalSearch.replace(search,"");
			}else if(deleteSearch == "${param.category}"){
				
				totalSearch = totalSearch.replace(category,"");
			}
			location.href="Shop?" + totalSearch;
		});
		
		$(".cusor").on("click",function(){
			location.href="Shop?category=" + $(this).text() + search + price;
		});
		$(".radio").on("click",function(){
			location.href="Shop?price=" + $(this).val() + search + category;
		});
			
	});

    </script>
</body>

</html>