<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(".btn-modal").click(function(){
		let idx = $(this).data('id');
		
		let address_name = $("#address_name_" + idx).text();
		let recipient_name = $("#recipient_name_" + idx).text();
		let recipient_phone = $("#recipient_phone_" + idx).text();
		let address1 = $("#address1_" + idx).text();
		let address2 = $("#address2_" + idx).text();
		let postcode = $("#postcode_" + idx).text();
		
		$("#modal_address_name").val(address_name);
		$("#modal_recipient_name").val(recipient_name);
		$("#modal_phone_num").val(recipient_phone);
		$("#modal_address1").val(address1);
		$("#modal_address2").val(address2);
		$("#modal_address_idx").val(idx);
		$("#modal_postcode").val(postcode);
	});
	
	
	function searchAddress() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            let address = data.address; // 기본 주소 저장
	            let postcode = data.zonecode;
	            if(data.buildingName != '') { // 건물명이 있을 경우
	            	address += " (" + data.buildingName + ")";
	            }
	            
	            debugger;
	            $("#modal_address1").val(address);
	            $("#modal_postcode").val(postcode);
	            $("#modal_address2").focus();
	        }
	    }).open();
	}
	
</script>

<div class="modal fade" id="addressModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel1">배송지 수정</h5>
				<button
				type="button"
				class="btn-close"
				data-bs-dismiss="modal"
				aria-label="Close"
				></button>
			</div>
			
			<form action="ModifyAddress" method="post">
				
				<div class="modal-body">
					<div class="card-body demo-vertical-spacing demo-only-element">
					
						<label class="form-label" for="address_name">배송지명</label>
						<div class="input-group">
							<input
								type="text"
								id="modal_address_name"
								class="form-control"
								name="address_name"
							/>
						</div>
						
						<label class="form-label" for="recipient_name">받으시는 분</label>
						<div class="input-group">
							<input
								type="text"
								id="modal_recipient_name"
								class="form-control"
								name="recipient_name"
							/>
						</div>
						
						<label class="form-label" for="phone_num">전화번호</label>
						<div class="input-group">
							<input
								type="text"
								id="modal_phone_num"
								class="form-control"
								name="phone_num"
							/>
						</div>
						
						<label class="form-label" for="address1">주소</label>
						<div class="input-group">
							<input
								type="text"
								id="modal_address1"
								class="form-control"
								onclick="searchAddress()"
								name="address1"
							/>
						</div>
						
						<label class="form-label" for="address2">상세주소</label>
						<div class="input-group">
							<input
								type="text"
								id="modal_address2"
								class="form-control"
								name="address2"
							/>
						</div>
						<input type="hidden" id="modal_postcode" name="postcode">
						<input type="hidden" id="modal_address_idx" name="address_idx">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary">저장</button>
				</div>
				
			</form>
			
		</div>
	</div>
</div>


