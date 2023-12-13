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
<title>Male-Fashion | Template</title>
<jsp:include page="../inc/style.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	.custom_img{
		height: 100%;
		object-fit: scale-down;
		margin: 0 10px 0 10px;
	}
</style>
<script type="text/javascript">


const dataTransfer = new DataTransfer();
	
const autoHyphen = (target) => {
	target.value = target.value
	.replace(/[^0-9]/g, '')
	.replace(/\B(?=(\d{3})+(?!\d))/g,",");
}

const autoEnter = (target) => {
	target.value = target.value.replace(/\r\n|\n/ , "<br>");
}

$(function () {
	
	 $(".product__details__option__size label").on('click', function () {
	        $(".product__details__option__size label").removeClass('active');
	        $(this).addClass('active');
	 });
	
	// li 선택값 넘기기, css
	$(".nice-scroll li").click(function() {
		$(".nice-scroll li").css("background-color" , "white");
		$(".nice-scroll li").css("color" , "#6c757d");
		$("#hidCategory").val($(this).val());
		$(this).css("background-color" , "#5F12D3");
		$(this).css("color" , "white");
// 		alert($("#hidCategory").val());
// 		debugger;
	});
	
	
	$(".trading_method1").on("click",function(){
		if($(".trading_method1").is(":checked")){
			$('.product__details__option__delivery').append(
	            $('<input>').prop({
	                type: 'radio',
	                id: 'xxlx',
	                name: 'delivery_method',
	                value: '배송비 별도'
	            }),
	            $('<label>').prop({
	                for: 'xxlx',
	                class: 'active'
	            }).html('배송비 별도')
	        ).append( 
	            $('<br>')
	        );
			$('.product__details__option__delivery').append(
	            $('<input>').prop({
	                type: 'radio',
	                id: 'xxlxx',
	                name: 'delivery_method',
	                value: '배송비 포함'
	            }),
	            $('<label>').prop({
	                for: 'xxlxx'
	            }).html('배송비 포함')
	        ).append(
	            $('<br>')
	        );
		} 
		if(!$(".trading_method1").is(":checked")){
			$(".product__details__option__delivery").empty();
		}
	});
	
	$(".product__details__option__delivery label").on("click", function () {
		debugger;
		$(".product__details__option__delivery label").removeClass('active');
		$(this).addClass('active');
	});
	
	$(".trading_method2").on("click",function(){
// 		debugger;
		let mapView = '<input type="text" name="trading_location" class="input-name" id="trading_location" value="${trading_location }" placeholder="직거래 희망장소" style="margin-right: 10px;">'
					  + '<input type="button" class="site-btn" id="address" value="검색" onclick="tradingLocation()">';
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
	
	$(".free_sharing").change(function(){
        if($(this).is(":checked")){
//         	debugger;
			$("#product_price").prop("disabled", true);
			$("#product_price").prop("placeholder", "무료나눔");
			$(".nice-scroll li[value=1]").css("color" , "white");
			$(".nice-scroll li[value=1]").css("background-color" , "#5F12D3");
			$("#hidCategory").val('1');
        } else{
//         	debugger;
			$("#product_price").prop("disabled", false);
			$("#product_price").prop("placeholder", "판매가격");
			$("#product_price").css("border-color", "grey");
			$(".nice-scroll li[value=1]").css("color" , "#6c757d");
			$(".nice-scroll li[value=1]").css("background-color" , "white");
			$("#product_price").focus();
        }
    });
	
	
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
	if(insertCheck()){
		if(e.target.files == "" || e.target.files == "undefined" || e.target.files == null){
			return false;
		}
	}
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
	
	if ($(".category_idx").val() == "") {
		alert("카테고리를 선택해주세요.");
		return false;
	}
	if ($("input[name:product_name]").val() == "") {
		alert("상품 이름을 입력해주세요.");
		return false;
	}
	if ($("input[name:product_price]").val() == "") {
		alert("판매가격을 입력해주세요.");
		return false;
	}
	if ($("input[name:product_status]").val() == "") {
		alert("판매정보를 입력해주세요.");
		return false;
	}
	if ($(".category_idx").val() == "") {
		alert("카테고리를 선택해주세요.");
		return false;
	}
	if($('input[name=product_info]').val() == "undefined" || $('input[name=product_info]').val() == "" || $('input[name=product_info]').val() == null){
		alert("판매할 상품정보를 입력해주세요.");
		return false;
	}
	if($('input[name=trading_method1]:checked').val() == "undefined" || $('input[name=trading_method1]:checked').val() == "" || $('input[name=trading_method1]:checked').val() == null){
		alert("거래 방법을 선택해주세요.");
		return false;
	}
// 	const checkboxes = document.querySelectorAll('input');

//     for( let i = 0; i < checkboxes.length; i ++){
//         if(checkboxes[i].checked === true) return false;	
//     }
//     alert('검색할 파일 형태를 선택하세요.'); 
// var result = confirm("판매등록 하시겠습니까?");
// 	if(result){
// 		$("form").submit();
// 	}
	return false;
}

</script>
</head>
<body>
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>

    <!-- 본문 시작 -->
    <form action="ShopSuccess" method="POST" enctype="multipart/form-data" name="insertForm" >
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
								<input type="file" multiple accept=" audio/*, video/*, image/*" name="file" id="file" style="display:none;"/>
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
						    <input type="text" name="product_name" class="input-name" placeholder="글제목">
						</div>
								<div style="display: grid;">
<!--                                 <fieldset>  -->
									<input type="text" name="product_price" class="input-name" id="product_price" placeholder="판매가격" min="0" oninput="autoHyphen(this)" maxlength="10">
									<label for="check">
										<input type="checkbox" name="free_sharing" class="free_sharing" id="check" value="무료나눔">무료나눔
									</label>
<!-- 								</fieldset> -->
<!--                                 <fieldset>  -->
<!--                                 <input type="text" name="product_price" class="input-name" id="product_price" placeholder="판매가격" min="0" oninput="autoHyphen(this)" maxlength="10"> -->
<!-- 								<input id="check" type="checkbox">  -->
<!-- 								<label for="check">무료나눔</label> -->
<!-- 								</fieldset> -->
									<textarea rows="2" name="product_info" cols="50" wrap="hard" maxlength="1000" spellcheck="false" oninput="autoEnter(this)">
- 상품명(브랜드) >
- 구매 시기
- 사용 기간
- 하자 여부
* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.
* 카카오톡 아이디 첨부 시 게시물 삭제 및 이용제재 처리될 수 있어요.
 안전하고 건전한 거래환경을 위해 과학기술정보통신부, 한국인터넷진흥원, 트레이드업이 함께합니다.</textarea>
								</div>
								<div class="product__details__option">
									<div class="product__details__option__size">
										 <fieldset id="product_status">
											<span style="color: #111111; font-weight: 700;">상품상태</span>
											<label class="active" for="중고">중고
												<input type="radio" id="xxl" name="product_status" value="중고" checked>
		                                    </label>
		                                    <label for="새상품">새상품
		                                        <input type="radio" id="xl" name="product_status" value="새상품">
		                                    </label>
										 </fieldset>
                                	</div>
	                            </div>
								<div class="product__details__option">
	                                <div class="product__details__option__size">
	                                    <span style="color: #111111; font-weight: 700;">거래방법</span>
	                                    <input type="checkbox" name="trading_method1" class="trading_method1" value="delivery">택배거래
	                                    <input type="checkbox" name="trading_method2" class="trading_method2" value="direct" >직거래
	                                </div>
	                            </div>
                                <div class="product__details__option__delivery d-flex justify-content-center"></div>
                                <div class="address d-flex justify-content-center" style="display: contents; margin-top: 30px;"></div>
	                            <div class="product__form__submit">
                                    <button type="reset" class="site-btn" >리셋</button>
                                    <button class="site-btn" onclick="insertCheck()">판매등록</button>
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