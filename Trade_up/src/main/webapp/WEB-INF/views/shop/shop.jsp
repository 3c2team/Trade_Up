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
<title>Trade Up</title>
<jsp:include page="../inc/style.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<style type="text/css">
.select{
	background-color: #5F12D3;
	color: white;
}
.btn{
	 background-color:#e0e0e0;
	 margin: 5px;
	 font-size: 13px;
}
.nice-scroll li{
	cursor: pointer;
}
</style>
</head>
<script type="text/javascript">
	const searchParams = new URLSearchParams(location.search);
	let category_name = "";
	for (const param of searchParams) {
	  category_name = param[1];
	}
// 	console.log(category_name);
    $(function() {
		var search = "";
		var category = "";
		var price = "";
		
// 		let selectCategory = "";
		$(".cusor").on("click",function(){
			category_name = $(this).text();
			$(this).addClass("select");
			location.href="Shop?category=" + $(this).text() + search;
		});
		
// 		$(".nice-scroll li").click(function() {
// 			$(".nice-scroll li").css("background-color" , "white");
// 			$(".nice-scroll li").css("color" , "#6c757d");
// 			$(this).css("background-color" , "#5F12D3");
// 			$(this).css("color" , "white");
// 		});
// 			$(".nice-scroll li").each(function(){
// // // 				debugger;				
// 				if($(this).text() == "${param.category}"){
// 					$(".nice-scroll li").css("background-color" , "white");
// 					$(".nice-scroll li").css("color" , "#6c757d");
// 					$(this).css("background-color" , "#5F12D3");
// 					$(this).css("color" , "white");
// 				}
// 			});
		
		if("${param.category}"){
			category = "&category=${param.category}";
			$("#category").attr("hidden",false);
			$("#category").html("${param.category} <i class='bi bi-x'></i>");
// 			alert("${param.search}");
			$.ajax({
				type: "POST",
				url: "FillterProduct",
				data: {
					category_name : category_name
				},
				dataType: 'json',
				success: function(data) {
					$(".rightList").html("");
// 					parent.removeChild(dom);
					data.forEach( product =>{
						let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
						let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
							$(".rightList").append( 
								"<div class='col-lg-4 col-md-6 col-sm-6'>"
		                        +"<div class='product__item'>"
		                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
		                        +"         <ul class='product__hover'>"
		                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
		                        +"         </ul>"
		                        +"      </div> "
		                        +"      <div class='product__item__text'>"
		                        +"         <h6>"+product.product_name+"</h6> "
		                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
		                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
		                        +"         <h5>"+product.product_price+"</h5> "
		                        +"      </div>"
		                        +"   </div>"   
		                        +"   </div>"   
							);
// 							$(".product__item__text h6").remove();
// 							$(".product__item__text h6").append(product.product_name);
// 						alert(product.product_name);
					});
				},erorr: function() {
					location.href="Shop";
				}
			
			});
		}
		if("${param.search}"){
			search = "&search=${param.search}";
			$("#search").attr("hidden",false);
			$("#search").html("${param.search} <i class='bi bi-x'></i>");
// 			alert("${param.search}");
			$.ajax({
				type: "POST",
				url: "SearchProduct",
				data: {
					search : "${param.search}"
				},
				dataType: 'json',
				success: function(data) {
					$(".rightList").html("");
					data.forEach( product =>{
					let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
					let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
					let h6 = "<h6>" + product.product_name + "</h6>";
						$(".rightList").append( 
								"<div class='col-lg-4 col-md-6 col-sm-6'>"
		                        +"<div class='product__item'>"
		                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
		                        +"         <ul class='product__hover'>"
		                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
		                        +"         </ul>"
		                        +"      </div> "
		                        +"      <div class='product__item__text'>"
		                        +"         <h6>"+product.product_name+"</h6> "
		                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
		                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
		                        +"         <h5>"+product.product_price+"</h5> "
		                        +"      </div>"
		                        +"   </div>"   
		                        +"   </div>"
						);
					});
				},erorr: function() {
					alert("검색 결과가 없습니다.")
					location.href="Shop";
				}
			
			});
		}
// 		if("${param.price}"){
// 			$("input[type=radio][name=radio]").each(function(){
// 				if($(this).val() == "${param.price}"){
// 					$(this).prop("checked",true);
// 				}
// 			});
// 			price = "&price=${param.price}";
// 			$("#price").attr("hidden",false);
// 			$("#price").html("${param.price} <i class='bi bi-x'></i>");
// 			alert("${param.price}");
// 			$.ajax({
// 				type: "POST",
// 				url: "FillterProduct",
// 				data: {
					
// 					search : "${param.search}",
// 					price : "${param.price}"
// 				},
// 				dataType: 'json',
// 				success: function(data) {
// 					$(".rightList").html("");
// 					data.forEach( product =>{
// 						$(".rightList").append( 
// 							"<div class='col-lg-4 col-md-6 col-sm-6'>"
// 							+ 	"<div class='product__item'>"
// 							+ 		"<div class='product__item__pic set-bg' data-setbg='${pageContext.request.contextPath}"+ product.product_main_img +"' onclick='location.href=ShopDetail?product_num="+ product.product_num+"'>"
// 							+ 			"<ul class='product__hover'>"
// 							+ 				"<li><a href='ShopDetail?product_num=" + product.product_num + "'><img src='${pageContext.request.contextPath}/resources/img/icon/heart.png' alt='찜'></a></li>"
// 							+ 				"<li><img src='${pageContext.request.contextPath}/resources/img/icon/search.png' alt='자세히보기'></li>"
// 							+ 			"</ul>"
// 							+ 		"</div>"
// 							+ 		"<div class='product__item__text'>"
// 							+ 			"<h6>" + product.product_name + "</h6>"
// 							+ 			"<a href='ShopDetail?product_num=" + product.product_num + "' class='add-cart'>상세보기</a>"
// 							+ 			"<p>" + product.trading_location + "</p>"
// 							+ 			"<h5>" + product.product_price + "</h5>"
// 							+ 		"</div>"
// 							+	 "</div>"
// 							+ "</div>"
// 						);
// 					});
// 				},erorr: function() {
// 					alert("검색 결과가 없습니다.")
// 					location.href="Shop";
// 				}
			
// 			});
// 		}
		
		
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
		
		$(".radio").on("click",function(){
			location.href="Shop?price=" + $(this).val() + search + category;
		});

		$("#selectBox").change(function() {		    
// 	 		debugger;
			var result = $("#selectBox option:selected").val();
// 			alert(category_name);
			console.log(category_name);
		    if (result == 'last') {
				$.ajax({
					type: "POST",
					url: "LastProduct",
					data: {
						category_name : category_name
					},
					dataType: 'json',
					success: function(data) {
						$(".rightList").html("");
						data.forEach( product =>{
						let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
						let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
							$(".rightList").append( 
									"<div class='col-lg-4 col-md-6 col-sm-6'>"
			                        +"<div class='product__item'>"
			                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
			                        +"         <ul class='product__hover'>"
			                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
			                        +"         </ul>"
			                        +"      </div> "
			                        +"      <div class='product__item__text'>"
			                        +"         <h6>"+product.product_name+"</h6> "
			                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
			                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
			                        +"         <h5>"+product.product_price+"</h5> "
			                        +"      </div>"
			                        +"   </div>"   
			                        +"   </div>"
							);
						});
					},erorr: function() {
						location.href="Shop";
					}
				
				});
			    if (category_name == null || category_name == "" || category_name == "undefined") {
					$.ajax({
						type: "POST",
						url: "ReLastProduct",
						dataType: 'json',
						success: function(data) {
							$(".rightList").html("");
							data.forEach( product =>{
							let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
							let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
								$(".rightList").append( 
										"<div class='col-lg-4 col-md-6 col-sm-6'>"
				                        +"<div class='product__item'>"
				                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
				                        +"         <ul class='product__hover'>"
				                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
				                        +"         </ul>"
				                        +"      </div> "
				                        +"      <div class='product__item__text'>"
				                        +"         <h6>"+product.product_name+"</h6> "
				                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
				                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
				                        +"         <h5>"+product.product_price+"</h5> "
				                        +"      </div>"
				                        +"   </div>"   
				                        +"   </div>"
								);
							});
						},erorr: function() {
							location.href="Shop";
						}
					
					});
				}
			}
		    if (result == 'jjim') {
				$.ajax({
					type: "POST",
					url: "JjimProduct",
					data: {
						category_name : category_name
					},
					dataType: 'json',
					success: function(data) {
						$(".rightList").html("");
						data.forEach( product =>{
						let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
						let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
							$(".rightList").append( 
									"<div class='col-lg-4 col-md-6 col-sm-6'>"
			                        +"<div class='product__item'>"
			                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
			                        +"         <ul class='product__hover'>"
			                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
			                        +"         </ul>"
			                        +"      </div> "
			                        +"      <div class='product__item__text'>"
			                        +"         <h6>"+product.product_name+"</h6> "
			                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
			                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
			                        +"         <h5>"+product.product_price+"</h5> "
			                        +"      </div>"
			                        +"   </div>"   
			                        +"   </div>"
							);
						});
					},erorr: function() {
						location.href="Shop";
					}
				
				});
				if (category_name == null || category_name == "" || category_name == "undefined") {
					$.ajax({
						type: "POST",
						url: "ReJjimProduct",
						dataType: 'json',
						success: function(data) {
							$(".rightList").html("");
							data.forEach( product =>{
							let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
							let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
								$(".rightList").append( 
										"<div class='col-lg-4 col-md-6 col-sm-6'>"
				                        +"<div class='product__item'>"
				                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
				                        +"         <ul class='product__hover'>"
				                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
				                        +"         </ul>"
				                        +"      </div> "
				                        +"      <div class='product__item__text'>"
				                        +"         <h6>"+product.product_name+"</h6> "
				                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
				                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
				                        +"         <h5>"+product.product_price+"</h5> "
				                        +"      </div>"
				                        +"   </div>"   
				                        +"   </div>"
								);
							});
						},erorr: function() {
							location.href="Shop";
						}
					
					});
				}
			}
		    if (result == 'low') {
				$.ajax({
					type: "POST",
					url: "LowProduct",
					data: {
						category_name : category_name
					},
					dataType: 'json',
					success: function(data) {
						$(".rightList").html("");
						data.forEach( product =>{
						let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
						let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
							$(".rightList").append( 
									"<div class='col-lg-4 col-md-6 col-sm-6'>"
			                        +"<div class='product__item'>"
			                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
			                        +"         <ul class='product__hover'>"
			                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
			                        +"         </ul>"
			                        +"      </div> "
			                        +"      <div class='product__item__text'>"
			                        +"         <h6>"+product.product_name+"</h6> "
			                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
			                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
			                        +"         <h5>"+product.product_price+"</h5> "
			                        +"      </div>"
			                        +"   </div>"   
			                        +"   </div>"
							);
						});
					},erorr: function() {
						location.href="Shop";
					}
				
				});
				if (category_name == null || category_name == "" || category_name == "undefined") {
					$.ajax({
						type: "POST",
						url: "ReLowProduct",
						dataType: 'json',
						success: function(data) {
							$(".rightList").html("");
							data.forEach( product =>{
							let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
							let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
								$(".rightList").append( 
										"<div class='col-lg-4 col-md-6 col-sm-6'>"
				                        +"<div class='product__item'>"
				                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
				                        +"         <ul class='product__hover'>"
				                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
				                        +"         </ul>"
				                        +"      </div> "
				                        +"      <div class='product__item__text'>"
				                        +"         <h6>"+product.product_name+"</h6> "
				                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
				                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
				                        +"         <h5>"+product.product_price+"</h5> "
				                        +"      </div>"
				                        +"   </div>"   
				                        +"   </div>"
								);
							});
						},erorr: function() {
							location.href="Shop";
						}
					
					});
				}
			}
		    if (result == 'high') {
				$.ajax({
					type: "POST",
					url: "HighProduct",
					data: {
						category_name : category_name
					},
					dataType: 'json',
					success: function(data) {
						$(".rightList").html("");
						data.forEach( product =>{
						let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
						let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
							$(".rightList").append( 
									"<div class='col-lg-4 col-md-6 col-sm-6'>"
			                        +"<div class='product__item'>"
			                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
			                        +"         <ul class='product__hover'>"
			                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
			                        +"         </ul>"
			                        +"      </div> "
			                        +"      <div class='product__item__text'>"
			                        +"         <h6>"+product.product_name+"</h6> "
			                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
			                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
			                        +"         <h5>"+product.product_price+"</h5> "
			                        +"      </div>"
			                        +"   </div>"   
			                        +"   </div>"
							);
						});
					},erorr: function() {
						location.href="Shop";
					}
				});
				if (category_name == null || category_name == "" || category_name == "undefined") {
					$.ajax({
						type: "POST",
						url: "ReHighProduct",
						dataType: 'json',
						success: function(data) {
							$(".rightList").html("");
							data.forEach( product =>{
							let style = "style= cursor: pointer;'background-image: url(&quot;" + product.product_main_img+"&quot;);'";
							let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
								$(".rightList").append( 
										"<div class='col-lg-4 col-md-6 col-sm-6'>"
				                        +"<div class='product__item'>"
				                        +"      <div class='product__item__pic set-bg' "+style+"data-setbg='"+product.product_main_img+"' onclick="+goProductDetail+">"
				                        +"         <ul class='product__hover'>"
				                        +"            <li><img src='${pageContext.request.contextPath }/resources/img/icon/search.png' alt='자세히보기'></li>"
				                        +"         </ul>"
				                        +"      </div> "
				                        +"      <div class='product__item__text'>"
				                        +"         <h6>"+product.product_name+"</h6> "
				                        +"         <a href='ShopDetail?product_num="+product.product_num+"' class='add-cart'>상세보기</a>"
				                        +"         <p>"+product.trading_location+" <span> / "+product.productRelease+"</span> </p>"
				                        +"         <h5>"+product.product_price+"</h5> "
				                        +"      </div>"
				                        +"   </div>"   
				                        +"   </div>"
								);
							});
						},erorr: function() {
							location.href="Shop";
						}
					
					});
				}
			}
		});
		
	});
    </script>
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
                            <a href="./">홈</a>
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
                        <div class="fs-5 fw-bold" style="margin-bottom: 30px;">
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
														<li class="cusor" value="${selectCategory.category_name }">
														${selectCategory.category_name }
														</li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 가격 -->
<!--                                 <div id="collapseThree" class="collapse show" data-parent="#accordionExample"> -->
<!--                                     <div class="card-body"> -->
<!--                                         <div class="shop__sidebar__price"> -->
<!--                                             <ul> -->
<!--                                                 <li class="custom_li"> -->
<!--                                                 	<label><input type="radio" class="radio form-check-input"name="radio" value="10만원 이하">10만원 이하</label> -->
<!--                                                 </li> -->
<!--                                                 <li class="custom_li"> -->
<!--                                                 	<label><input type="radio" class="radio form-check-input" name="radio" value="10만원 - 30만원 이하">10만원 - 30만원 이하</label> -->
<!--                                                 </li> -->
<!--                                                 <li class="custom_li"> -->
<!--                                                 	<label><input type="radio" class="radio form-check-input" name="radio" value="30만원 - 50만원 이하">30만원 - 50만원 이하</label> -->
<!--                                                 </li> -->
<!--                                                 <li class="custom_li"> -->
<!--                                                 	<label><input type="radio" class="radio form-check-input" name="radio" value="50만원 이상">50만원 이상</label> -->
<!--                                                 </li> -->
<!--                                             </ul> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
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
                                    <p>총 ${allCount }개의 상품</p>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__right">
                                    <p>정렬:&nbsp;</p>
                                    <select id="selectBox">
                                        <option value="last">최신순</option>
                                        <option value="jjim">찜많은순</option>
                                        <option value="low">낮은가격순</option>
                                        <option value="high">높은가격순</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="rightList" style="display: flex; flex-wrap: wrap;">
	                    <div class="row">
	                        <c:forEach items="${productList }" var="product" begin="0" varStatus="status">
		                        <div class="col-lg-4 col-md-6 col-sm-6 product${status.count} productList" >
		                            <div class="product__item">
		                                <div class="product__item__pic set-bg" data-setbg="${product.product_main_img}" onclick="location.href='ShopDetail?product_num=${product.product_num}'">
		                                    <ul class="product__hover">
		                                        <li><a href="ShopDetail?product_num=${product.product_num}"><img src="${pageContext.request.contextPath }/resources/img/icon/search.png" alt=""></a></li>
		                                    </ul>
		                                </div>
		                                <div class="product__item__text">
		                                    <h6>${product.product_name}</h6>
		                                    <a href="ShopDetail?product_num=${product.product_num}" class="add-cart">상세보기</a>
											<p>${product.trading_location } <span> / ${product.productRelease}</span></p>
		                                    <h5>${product.product_price}</h5>
		                                </div>
		                            </div>
		                        </div>
							</c:forEach>
				        </div>
                    </div>
			    </div>
			</div>
        </div>
    </section>
    <footer class="footer">
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
    </footer>
</body>
</html>