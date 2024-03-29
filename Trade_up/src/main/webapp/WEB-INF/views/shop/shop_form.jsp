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
<title>Trade Up</title>
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
let fileCheck = "";

// 판매가격 유효성
const autoHyphen = (target) => {
	target.value = target.value
	.replace(/[^0-9]/g, '')
	.replace(/\B(?=(\d{3})+(?!\d))/g,",");
}

// const autoEnter = (target) => {
// 	target.value = target.value.replace(/\r\n|\n/ , "<br>");
// }

$(function () {
	// 카테고리 li 선택값 넘기기, css
	$(".nice-scroll li").click(function() {
		$(".nice-scroll li").css("background-color" , "white");
		$(".nice-scroll li").css("color" , "#6c757d");
		$("#hidCategory").val($(this).val());
		$(this).css("background-color" , "#5F12D3");
		$(this).css("color" , "white");
// 		alert($("#hidCategory").val());
// 		debugger;
		

	});
	
	// 택배거래
	$(".trading_method1").on("click",function(){
		if($(".trading_method1").is(":checked")){
			let method1 = "<label class='delivery_method' for='xxlx'><input type='radio' id='xxlx' name='delivery_method' value='배송비 별도' checked style='accent-color:#5F12D3;'>배송비 별도</label>";
			let method2 = "<label class='delivery_method' for='xxlxx'><input type='radio' id='xxlxx' name='delivery_method' value='배송비 포함' style='accent-color:#5F12D3;'>배송비 포함</label>"
			$('.product__details__option__delivery').append(method1 + method2);
		} 
		if(!$(".trading_method1").is(":checked")){
			$(".product__details__option__delivery").empty();
		}
		
	});
	
	// 택배거래 버튼 css
// 	$(".checkout__input__checkbox").on('click', function () {
// 		if($(".checkout__input__checkbox").is(":checked")){
// 			debugger;
// 			$(this).addClass('active');
// 		} else{
// 	        $(this).removeClass('active');
// 		}
//     });
	
	// 배송방법 css
// 	$(".delivery_method").on('click', function () {
// 		debugger;
//         $(".delivery_method").removeClass('active');
// 		$(this).addClass('active');
//     });
	
	// 직거래 주소
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
	
	// 첨부파일
	$("#fileTrigger").on("click", function() {
		$("#file").trigger("click");
	});
	
	$("#file").on("change", uploadImageHandler);
	
});


// 첨부파일 함수
function uploadImageHandler(e) {
	let idx = 0;
	let maxLength = 5;
	if (this.files.length > maxLength) {
		alert("첨부파일은 최대 5개까지 첨부 가능합니다.");
		return;
		const transfer = new DataTransfer();
	    Array.from(this.files) //새로 배열 만들 그릇
	    	.slice(0, maxLength) //첫번째 인덱스부터 최대개수까지 자르기
	        .forEach(file => {
	        	transfer.items.add(file) //여기서 file 반복 돌려서 추가
// 				console.log(this.files);
	        })
	    this.files = transfer.files; //this.files 안에 다시 넣어주기
// 		console.log(this.files);
// 		return;	
	}
	let files = e.target.files;
	console.log(files);
	let filesArr = Array.prototype.slice.call(files);
	console.log(filesArr);
	
	filesArr.forEach(function(file) {
		
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

// 직거래 주소
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

// submit 함수
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
			alert("거래방법을 선택해주세요.");
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
    <!-- 상단 시작 -->
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>

    <!-- 본문 시작 -->
	<form action="ShopSuccess" method="POST" enctype="multipart/form-data" name="insertForm" onsubmit="return insertCheck()">
		<section class="contact shop_spad">
			<div class="section-title">
				<h2>판매하기</h2>
			</div>
	        <div class="container d-flex justify-content-end" >
                <div class="col-6" style="min-width:35%; margin-bottom: 30px">
					<div style="display: flex; margin: 3%">
						<button id="fileTrigger" type="button" class="site-btn" style="width: 66px;"><i class="bi bi-camera"><br>(<span id="count">0</span>/5)</i></button>		
						<div id="imgArea" style="display: flex; height: 100px;">
							<input type="file" multiple accept=" audio/*, video/*, image/*" name="file" id="file" style="display:none;"/>
						</div>
					</div>
                    <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
						<div class="card">
							<div class="card-heading">
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
                <div class="col-6" style="margin: 3%">
                    <div class="contact__form">
						<div style="display: grid;">
						    <input type="text" name="product_name" class="input-name" spellcheck="false" placeholder="글제목" required>
						</div>
						<div style="display: grid;">
							<input type="text" name="product_price" class="input-name" id="product_price" spellcheck="false" placeholder="판매가격" min="0" oninput="autoHyphen(this)" maxlength="10" required>
							<textarea rows="2" name="product_info" cols="50" wrap="hard" maxlength="1000" spellcheck="false" required placeholder="- 상품명(브랜드) 
- 구매 시기
- 사용 기간
- 하자 여부
* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.
* 카카오톡 아이디 첨부 시 게시물 삭제 및 이용제재 처리될 수 있어요.
 안전하고 건전한 거래환경을 위해 과학기술정보통신부, 한국인터넷진흥원, 트레이드업이 함께합니다."></textarea>
						</div>
						<div class="product__details__option">
							<div class="product__details__option__size">
								<fieldset id="product_status">
									<span style="color: #111111; font-weight: 700;">상품상태</span>
									<label class="active" for="xxl">
										<input type="radio" id="xxl" name="product_status" value="중고" checked style="accent-color:#5F12D3;">중고
									</label>
									<label for="xl">
										<input type="radio" id="xl" name="product_status" value="새상품" style="accent-color:#5F12D3;">새상품
									</label>
								</fieldset>
                           	</div>
                        </div>
						<div class="product__details__option">
							<div class="product__details__option">
								<span style="color: #111111; font-weight: 700;" id="check">거래방법</span>
								<label class="checkout__input__checkbox"><input type="checkbox" name="trading_method1" class="trading_method1" value="delivery" style="accent-color:#5F12D3;">택배거래</label>
								<label class="checkout__input__checkbox"><input type="checkbox" name="trading_method2" class="trading_method2" value="direct" style="accent-color:#5F12D3;">직거래</label>
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