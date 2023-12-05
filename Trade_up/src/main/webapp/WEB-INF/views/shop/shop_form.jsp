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
<script src="https://dapi.kakao.com/v2/local/geo/coord2regioncode.${FORMAT}"></script>
</head>
<body>
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>

    <!-- 본문 시작 -->
    <form action="ShopSuccess" method="POST" enctype="multipart/form-data" name="insertForm" onsubmit="return confirm('등록하시겠습니까?')">
    	<section class="contact shop_spad">
	        <div class="container">
				<div class="section-title">
				    <h2>판매하기</h2>
				</div>
	            <div class="row">
	                <div class="col-lg-6 col-md-6" style="min-width:35%;">
	                    <div class="contact__text">
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
									            <ul class="nice-scroll">
									            	<c:forEach var="selectCategory" items="${selectCategory }" varStatus="status">
														<li class="list" id="liCategory" value="${status.count }">${selectCategory.category_name }</li>
								                    </c:forEach>
								                </ul>
								            </div>
							            </div>
							        </div>
							    </div>
							</div>
							<div class="fs-6 fw-semibold">
								사진 동영상 첨부( <span id="count">0</span>/5)
							</div>
							<div id="imgArea" style="display: flex;">
								<button id="fileTrigger" type="button" class="custom_btn">
									<i class="bi bi-camera"></i>
								</button>		
								<input type="file" multiple accept=" audio/*, video/*, image/*" name="file" id="file" style="display:none"/>
							</div>
						</div>
	<!--                         	</div> -->
	                </div>
	                <div class="col-lg-6 col-md-6">
	                    <div class="contact__form">
                            <div class="row">
                                <div class="col-lg-6">
                                    <input type="text" name="product_name" class="input-name" placeholder="글제목">
                                </div>
                                <div class="col-lg-7">
                                    <input type="text" name="product_price" class="input-price" id="product_price" placeholder="판매가격" min="0" oninput="autoHyphen(this)" maxlength="10">
<!--                                     <input type="checkbox" name="free_sharing" class="active" value="무료나눔"> -->
<!--                                     <label class="active" > -->
                                    <input type="checkbox" name="free_sharing" id="free_sharing" value="무료나눔">무료나눔
<!--                                     </label> -->
                                </div>
                                <div class="col-lg-8">
	                                <div class="address" style="display: flex;">
	                                    <input type="text" name="trading_location" class="input-price" id="trading_location" value="${trading_location }" placeholder="직거래 희망장소" style="margin-right: 10px;">
										<input type="button" id="btnSearchAddress" class="site-btn" value="검색"><br>
	                                </div>
                                </div>
                                <div class="col-lg-12">
                                    <textarea rows="2" name="product_info" cols="20" wrap="hard" maxlength="1000" placeholder="- 상품명(브랜드) >
- 구매 시기
- 사용 기간
- 하자 여부
* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.
* 카카오톡 아이디 첨부 시 게시물 삭제 및 이용제재 처리될 수 있어요.
 안전하고 건전한 거래환경을 위해 과학기술정보통신부, 한국인터넷진흥원, 가지나라가 함께합니다."></textarea>
                                    <div class="product__details__option">
		                                <div class="product__details__option__size">
		                                    <span style="color: #111111; font-weight: 700;">상품상태</span>
		                                    <label class="active" for="xxl">중고상품
		                                        <input type="radio" id="xxl" name="product_status" value="중고" checked>
		                                    </label>
		                                    <label for="xl">새상품
		                                        <input type="radio" id="xl" name="product_status" value="새상품">
		                                    </label>
		                                </div>
		                            </div>
                                    <div class="product__details__option">
		                                <div class="product__details__option__size">
		                                    <span style="color: #111111; font-weight: 700;">거래방법</span>
		                                    <input type="checkbox" name="trading_method1" class="active" value="delivery">택배거래
		                                    <input type="checkbox" name="delivery1" class="active" value="delivery">배송비 별도
		                                    <input type="checkbox" name="delivery2" class="active" value="">배송비 포함
		                                    <input type="checkbox" name="trading_method2" class="active" value="direct">직거래
		                                </div>
		                            </div>
	                                <div class="product__details__option__size">
	                                    <input type="checkbox" name="uppay" class="active" value="사용">업페이
	                                </div>
		                            <div class="product__form__submit">
	                                    <button type="reset" class="site-btn" >리셋</button>
<!-- 	                                    <button class="site-btn" onclick="insertCheck()">판매등록</button> -->
	                                    <button type="submit" class="site-btn" >판매등록</button>
		                            </div>
                                </div>
                            </div>
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
<script type="text/javascript">

const dataTransfer = new DataTransfer();
	
const autoHyphen = (target) => {
	target.value = target.value
	.replace(/[^0-9]/g, '')
	.replace(/\B(?=(\d{3})+(?!\d))/g,",");
}

$(function () {
	
	// 
	$('#product_info').val().replace(/\r\n|\n/ , "<br>");
	
	// li 선택값 넘기기, css
	$(".nice-scroll li").click(function() {
		$("#hidCategory").val($(this).val());
		$(this).css("background-color" , "#5F12D3");
		$(this).css("color" , "white");
// 		alert($("#hidCategory").val());
	});
	
	$("#trading_location").click(function(){
		$("#trading_location").attr("disabled", true);
		alert("주소를 검색해주세요.");
// 		debugger;
	});
	

// 	$("#free_sharing").click(function(){
		
// 		$("#product_price").attr("disabled", false);
// 		$("#product_price").attr("disabled", true);
		
// 	});
	
	$("#btnSearchAddress").click(function() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            let address = data.address; // 기본 주소 저장
	            if(data.buildingName != '') { // 건물명이 있을 경우
	            	address += " (" + data.buildingName + ")";
	            }
	            $("#trading_location").val(address);
	        }
	    }).open();
	    
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
				$("#img_"+ delete_img_num)[0].remove()
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
	
	
</script>
</html>