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
<title>Trade up</title>
<jsp:include page="../inc/style.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">


const dataTransfer = new DataTransfer();
let fileCheck = "";
	
const autoHyphen = (target) => {
	target.value = target.value
	.replace(/[^0-9]/g, '')
	.replace(/\B(?=(\d{3})+(?!\d))/g,",");
}

// const autoEnter = (target) => {
// 	target.value = target.value.replace(/\r\n|\n/ , "<br>");
// }

$(function () {
	// li 선택값 넘기기, css
	$("[value='${product.category_idx}']").css("backgroundColor","#5F12D3");
	$("[value='${product.category_idx}']").css("color","white");
	$(".nice-scroll li").click(function() {
		$(".nice-scroll li").css("background-color" , "white");
		$(".nice-scroll li").css("color" , "#6c757d");
		$("#hidCategory").val($(this).val());
		$(this).css("background-color" , "#5F12D3");
		$(this).css("color" , "white");
	
// 		debugger;
		

	});
	let method1 = "<label class='delivery_method' for='xxlx'><input type='radio' id='xxlx' name='delivery_method' value='배송비 별도' checked style='accent-color:#5F12D3;'>배송비 별도</label>";
	let method2 = "<label class='delivery_method' for='xxlxx'><input type='radio' id='xxlxx' name='delivery_method' value='배송비 포함' style='accent-color:#5F12D3;'>배송비 포함</label>"
	
	$(".trading_method1").on("click",function(){
		if($(".trading_method1").is(":checked")){
			$('.product__details__option__delivery').append(method1 + method2);
		} 
		if(!$(".trading_method1").is(":checked")){
			$(".product__details__option__delivery").empty();
		}
	});
	if("${product.trading_method}" != 'direct'){
		$('.product__details__option__delivery').append(method1 + method2);
	}
	
	let mapView = '<input type="text" name="trading_location" class="input-name" id="trading_location" value="${trading_location }" placeholder="직거래 희망장소" style="margin-right: 10px;">'
				  + '<input type="button" class="site-btn" id="address" value="검색" onclick="tradingLocation()">';
	$(".trading_method2").on("click",function(){
// 		debugger;
		if($(".trading_method2").is(":checked")){
			$(".address").append(mapView);
			$("#trading_location").on("click",function(){
// 				debugger;
				$("#trading_location").attr("disabled", true);
				alert("주소를 검색해주세요.");
			});
		} 
		if(!$(".trading_method2").is(":checked")){
			$(".address").empty();
		}
	});
	if("${product.trading_method}" != 'delivery'){
		$(".address").append(mapView);
		$("#trading_location").on("click",function(){
// 				debugger;
			$("#trading_location").attr("disabled", true);
			alert("주소를 검색해주세요.");
		});
	}
	
	$("#fileTrigger").on("click", function() {
		$("#file").trigger("click");
	});
	
	$("#file").on("change", uploadImageHandler);
	
});

let idx = 0;
function uploadImageHandler(e) {	
	let files = e.target.files;
	console.log(files);
	let filesArr = Array.prototype.slice.call(files);
	console.log(filesArr);

	filesArr.forEach(function(file) {
		if(dataTransfer.files.length > 4) {
			alert("첨부파일은 최대 5개까지 첨부 가능합니다.");
			return;	
		}
		
		let reader = new FileReader();
		
		reader.onload = function(e) {
			let html = "<a href = \"javascript:void(0);\" id=\"img_" + idx + "\"><img src=\"" + e.target.result + "\" data-file='" + file.name + "' class='custom_img custom_btn' title='클릭 시 제거'></a>";
			$("#imgArea").append(html);
			console.log(idx);
			const deleteImg = $("#img_" + idx);
			$(deleteImg).on('click', (delete_img) => {
				let check = confirm("삭제하시겠습니까?");
				if(!check){
					return;
				}
				console.log(delete_img.currentTarget.id);
				let delete_img_num = delete_img.currentTarget.id.split('_')[1]
				$("#img_"+ delete_img_num)[0].remove();
				dataTransfer.items.remove(delete_img_num);
				$("#file")[0].files = dataTransfer.files;
				$("#count").text($("#file")[0].files.length);
			});
			idx++;
			
		};
		reader.readAsDataURL(file);
		dataTransfer.items.add(file);
	});
	e.target.files = dataTransfer.files;
	$("#count").text($("#file")[0].files.length);
	
}

function tradingLocation(){
    new daum.Postcode({
        oncomplete: function(data) {
            let address = data.address; // 기본 주소 저장
            if(data.buildingName != '') { // 건물명이 있을 경우
            	address += " (" + data.buildingName + ")";
            }
            $("#trading_location").val(address);
        }
    }).open();
}

function insertCheck(){
	
    if( $("#file").val() == ''){
		alert("첨부파일 1개 이상 첨부해주세요.");
		return false;
	}
    if( $("#hidCategory").val() == ''){
		alert("카테고리를 선택해주세요.");
		return false;
	}
    if (!$(".trading_method1").is(':checked')) {
    	if(!$(".trading_method2").is(':checked')){
			$("#check").css("color", "red");
			$('#check').append("<span style='color: red;'>을 선택해주세요.</span>");
			return false;
    	}
    }
    if ($(".trading_method2").is(":checked")) {
    	if($("#trading_location").val() == ""){
		      alert("직거래 희망 장소를 입력해주세요.");
		      return false;
    	}
    }
	
	var result = confirm("판매등록 하시겠습니까?");
	
	if(!result){
		return false;
	}
// 		$("form").submit();
	
}

</script>
</head>
<body>
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>

    <!-- 본문 시작 -->
    <form action="ShopUpdate" method="POST" enctype="multipart/form-data" name="insertForm" onsubmit="return insertCheck()">
    	<section class="contact shop_spad">
			<div class="section-title">
			    <h2>판매하기</h2>
			</div>
	        <div class="container d-flex justify-content-end" >
                <div class="col-6" style="min-width:35%; margin-bottom: 30px">
<!-- 	                    <div class="contact__text"> -->
<!-- 	                    </div> -->
					<div style="display: flex; margin: 3%">
						<button id="fileTrigger" type="button" class="site-btn" style="width: 66px;"><i class="bi bi-camera"><br>(<span id="count">0</span>/5)</i></button>		
						<div id="imgArea" style="display: flex; height: 100px;">
							<c:forEach var="productImg" items="${productImg }" varStatus="status">
									<input type="file" multiple accept="audio/*, video/*, image/*" name="file" id="file" style="display:none;"/>
							</c:forEach>
						</div>
					</div>
                    <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
						<div class="card">
							<div class="card-heading">
<!-- 								    <a data-toggle="collapse" data-target="#collapseOne">카테고리</a> -->
							    <h3 style="margin: 5%">카테고리</h3>
							</div>
							<div id="collapseTwo" class="collapse show" data-parent="#accordionExample">
							    <div class="card-body">
							        <div class="card-main">
								        <div class="shop__sidebar__categories">
								        <input type="hidden" name="category_idx" id="hidCategory" value="${category_idx }"/>
								        <input type="hidden" name="sales_status" id="sales_status" value="판매중"/>
								            <ul class="nice-scroll">
								            	<c:forEach var="selectCategory" items="${selectCategory }" varStatus="status">
													<li class="list" id="liCategory" value="${status.count }" style="cursor: pointer;">${selectCategory.category_name }</li>
							                    </c:forEach>
							                </ul>
							            </div>
						            </div>
						        </div>
						    </div>
						</div>
					</div>
            	</div>
                <div class="col-6">
                    <div class="contact__form">
						<div style="display: grid;">
						    <input type="text" name="product_name" class="input-name" placeholder="글제목" required value="${product.product_name }">
						</div>
						<div style="display: grid;">
							<input type="text" name="product_price" class="input-name" id="product_price" placeholder="판매가격" min="0" oninput="autoHyphen(this)" maxlength="10" required value="${product.product_price}">
							<textarea rows="2" name="product_info" cols="50" wrap="hard" maxlength="1000" spellcheck="false" required >${product.product_info}</textarea>
						</div>
						<div class="product__details__option">
							<div class="product__details__option__size">
								<fieldset id="product_status">
									<span style="color: #111111; font-weight: 700;">상품상태</span>
									<label class="active" for="xxl">
										<input type="radio" id="xxl" name="product_status" value="중고" style="accent-color:#5F12D3;"<c:if test="${product.product_status eq '중고' }">checked</c:if>>중고
									</label>
									<label for="xl">
										<input type="radio" id="xl" name="product_status" value="새상품" style="accent-color:#5F12D3;"<c:if test="${product.product_status eq '새상품' }">checked</c:if>>새상품
									</label>
								</fieldset>
                           	</div>
                        </div>
						<div class="product__details__option">
							<div class="product__details__option">
								<span style="color: #111111; font-weight: 700;" id="check">거래방법</span>
								<label class="checkout__input__checkbox"><input type="checkbox" name="trading_method1" class="trading_method1" value="delivery" style="accent-color:#5F12D3;"<c:if test="${product.trading_method ne 'direct' }">checked</c:if>>택배거래</label>
								<label class="checkout__input__checkbox"><input type="checkbox" name="trading_method2" class="trading_method2" value="direct" style="accent-color:#5F12D3;"<c:if test="${product.trading_method ne 'delivery' }">checked</c:if>>직거래</label>
							</div>
                        </div>
						<div class="product__details__option__delivery d-flex justify-content-center"></div>
						<div class="address d-flex justify-content-center" style="display: contents; margin-top: 30px;"></div>
						<div class="product__form__submit">
							<button class="site-btn" onclick="history.back()">돌아가기</button>
							<button type="submit" class="site-btn" >판매등록</button>
						</div>
					</div>
				</div>
			</div>
    	</section>
    </form>
    
    <!-- 바텀 시작 -->
	<footer>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>