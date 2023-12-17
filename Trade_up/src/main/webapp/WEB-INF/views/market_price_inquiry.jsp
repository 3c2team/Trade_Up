<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	.custom_price_inquiry{
		width: 70%;
	    margin: auto;
	    margin-top: 2%;
	    margin-bottom: 2%;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	}
	.custom_box2{
		width: 100%;
		height: 7em;
		margin-bottom: 5%; 
		display: flex;
		background: #a6ebb6!important;
	    overflow: auto;
	}
	.custom_price{
	    width: 33%;
    	height: 100%;
	}
	.custom_font{
		margin: 10px;
	}
	.custom_color{
		color: #62f784;
	}
	#registrationProduct{
	    display: flex;
	    overflow: visible;
	    flex-direction: row;
	    flex-wrap: wrap;
	}
</style>
	<jsp:include page="inc/style.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
	<div class="custom_price_inquiry">
		<div class="fs-3 fw-semibold text-secondary">시세조회</div>
		<div class="fs-6">원하시는 상품이 얼마에 거래되고 있는지 알아보세요</div>
		<div style="width: 60%;" class="shop__sidebar__search" >
			<form onsubmit="return selectProduct()">
				<input type="text" id="select_product"style="font-weight: bold;font-size: large;color: black;background-color: gainsboro;border-radius: 5rem;height: 3rem;margin-top:7%;" placeholder="상품 이름을 검색해주세요">
				<button style="margin-top:4%;" type="submit"><span class="icon_search"></span></button>
			</form> 
		</div>
		<div id="product_chart" class='col-xl-6'></div>
	</div>
	<div style="width: 70%; margin: auto; " >
		<div class="fs-4 fw-semibold text-secondary">최근 등록된 상품</div><br>
		<div id="success_box"></div>
		<div id="registrationProduct"></div>
		<hr style="margin-bottom: 5%;" class="custom_border_grove">
	</div>
	
	<jsp:include page="inc/bottom.jsp"></jsp:include>
	<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
	crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/demo/market_price_chart.js"></script>
	<script type="text/javascript">
		$(function() {

			$.ajax({
				type: "POST",
				url: "SelectProduct",
				data: {
					product_name : $("#select_product").val()
				},
				dataType: 'json',
				success: function(data) {


					$("#registrationProduct").html("");
					data.forEach( product =>{
						let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
						$("#registrationProduct").append( 
							"<div class='col-lg-4 col-md-6 col-sm-6 productList' >"
							+ 	"<div class='product__item'>"
							+ 		"<div class='product__item__pic set-bg' data-setbg='${pageContext.request.contextPath}"+ product.product_main_img +"' onclick="+goProductDetail+">"
							+ 			"<ul class='product__hover'>"
							+ 				"<li><img src='${pageContext.request.contextPath}/resources/img/icon/search.png' alt='자세히보기'></li>"
							+ 			"</ul>"
							+ 		"</div>"
							+ 		"<div class='product__item__text'>"
							+ 			"<h6>" + product.product_name + "</h6>"
							+ 			"<a href='ShopDetail?product_num=" + product.product_num + "' class='add-cart'>상세보기</a>"
							+ 			"<p>" + product.trading_location + "</p>"
							+ 			"<h5>" + product.product_price + "</h5>"
							+ 		"</div>"
							+	 "</div>"
							+ "</div>"
						);
					});
				},erorr: function() {
					alert("실패");
				}
			});
		});
		function selectProduct() {
			$.ajax({
				type: "POST",
				url: "SelectProduct",
				data: {
					product_name : $("#select_product").val()
				},
				dataType: 'json',
				success: function(data) {
					if(data[0] == null){
						$("#product_chart").html(                                                         
								"<div style='text-align: center;'> "
								+	"<img style='width: 18%;'src='${pageContext.request.contextPath }/resources/img/mascote.jpg'/>"
								+	"<div style='font-size: larger;padding: 3%;'>검색한 상품 시세는 준비중입니다.<br>"
								+   "빠르게 확인 드릴 수 있도록 노력하겠습니다!</div> "
								+"</div>"
						)
						return;
					}
					let sum = 0;
					data.forEach(e => {
					    sum+=Number(e.product_price.replaceAll(',','').replace('원','').trim());
					debugger;
					});
					max = data.reduce((max, curr) => max < curr ? curr : max );
					min = data.reduce((min, curr) => min < curr ? min : curr );
					avg = sum/data.length;
					$("#registrationProduct").html("");
					data.forEach( product =>{
						
						let goProductDetail = "location.href='ShopDetail?product_num="+ product.product_num + '\'';
						$("#registrationProduct").append( 
							"<div class='col-lg-4 col-md-6 col-sm-6 productList' >"
							+ 	"<div class='product__item'>"
							+ 		"<div class='product__item__pic set-bg' data-setbg='${pageContext.request.contextPath}"+ product.product_main_img +"' onclick="+goProductDetail+">"
							+ 			"<ul class='product__hover'>"
							+ 				"<li><img src='${pageContext.request.contextPath}/resources/img/icon/search.png' alt='자세히보기'></li>"
							+ 			"</ul>"
							+ 		"</div>"
							+ 		"<div class='product__item__text'>"
							+ 			"<h6>" + product.product_name + "</h6>"
							+ 			"<a href='ShopDetail?product_num=" + product.product_num + "' class='add-cart'>상세보기</a>"
							+ 			"<p>" + product.trading_location + "</p>"
							+ 			"<h5>" + product.product_price + "</h5>"
							+ 		"</div>"
							+	 "</div>"
							+ "</div>"
						);
					});
// 						debugger;
					$("#product_chart").html(
// 								"<div class='col-xl-6'>"
									"<div class='card mb-4'>"
						+				"<div class='card-body'>"
						+					"<div class='fs-6 fw-semibold text-secondary'>"
						+						"시세 금액"
						+					"</div>"
						+					"<div class='fs-4 fw-semibold custom_color' id='product_avg'>"
						+					"</div>	"
						+					"<canvas id='myAreaChart' width='70%' height='40'></canvas>"
						+				"</div>"
						+			"</div>"
// 						+		"</div>"
					);
					debugger;
					$("#success_box").html(
							"<div style='margin-bottom: 3%;' class='fs-5 fw-semibold text-secondary'>최근 등록 상품 가격을 비교해봤어요!</div>"
							+"		<div style='margin-bottom: 0%;height: 8rem;' class='custom_box2 border border-success'>"
							+"			<div class='custom_price'>"
							+"				<div class='fs-5 fw-semibold text-secondary custom_font'>평균 가격이에요</div>"
							+"				<div style='margin-top: 10%;'>"
							+"					<span class='fs-4 fw-semibold text-secondary'>"+Math.floor(avg)+"</span> "
							+"					<span class='fw-semibold text-secondary'>원</span> "
							+"				</div>"
							+"			</div>"
							+"			<div class='custom_price'>"
							+"				<div class='fs-5 fw-semibold text-secondary custom_font'>가장 높은 가격이에요</div>"
							+"				<div style='margin-top: 10%;'>"
							+"					<span class='fs-4 fw-semibold text-secondary'>"+max.product_price.replace('원','')+"</span> "
							+"					<span class='fw-semibold text-secondary'>원</span> "
							+"				</div>"
							+"			</div>"
							+"			<div class='custom_price'>"
							+"				<div class='fs-5 fw-semibold text-secondary custom_font'>가장 낮은 가격이에요</div>"
							+"				<div style='margin-top: 10%;'>"
							+"					<span class='fs-4 fw-semibold text-secondary'>"+min.product_price.replace('원','')+"</span> "
							+"					<span class='fw-semibold text-secondary'>원</span> "
							+"				</div>"
							+"			</div>"
							+"		</div>"		
					
					)
					drawChart();
					
						
				},erorr: function() {
					alert("실패");
				}
			});
			return false;
		}
	</script>
</body>
</html>