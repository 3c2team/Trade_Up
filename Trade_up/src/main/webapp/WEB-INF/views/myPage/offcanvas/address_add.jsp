<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div
	class="offcanvas offcanvas-end"
	tabindex="-1"
	id="offcanvasEnd"
	aria-labelledby="offcanvasEndLabel"
>
	<div class="offcanvas-header">
		<h5 id="offcanvasEndLabel" class="offcanvas-title">배송지 추가</h5>
		<button
			type="button"
			class="btn-close text-reset"
			data-bs-dismiss="offcanvas"
			aria-label="Close"
		></button>
	</div>
	<div class="offcanvas-body my-auto mx-0 flex-grow-0">
	<form action="">
			
				<div class="modal-body">
					<div class="card-body demo-vertical-spacing demo-only-element">
					
						<label class="form-label" for="address_name">배송지명</label>
						<div class="input-group">
							<input
								type="text"
								id="address_name"
								class="form-control"
							/>
						</div>
						
						<label class="form-label" for="recipient_name">받으시는 분</label>
						<div class="input-group">
							<input
								type="text"
								id="recipient_name"
								class="form-control"
							/>
						</div>
						
						<label class="form-label" for="phone_num">전화번호</label>
						<div class="input-group">
							<input
								type="tel"
								id="phone_num"
								class="form-control"
								required
							/>
						</div>
						
						<label class="form-label" for="address1">주소</label>
						<div class="input-group">
							<input
								type="text"
								id="address1"
								class="form-control"
								readonly
								onfocus="searchAddress()"
							/>
						</div>
						
						<label class="form-label" for="address2">상세주소</label>
						<div class="input-group">
							<input
								type="text"
								id="address2"
								class="form-control"
							/>
						</div>
					</div>
				</div>
	<button type="button" class="btn btn-primary mb-2 d-grid w-100">저장</button>
	<button
		type="button"
		class="btn btn-outline-secondary d-grid w-100"
		data-bs-dismiss="offcanvas"
	>
		취소
	</button>
	</form>
	</div>
</div>