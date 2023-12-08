<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<script type="text/javascript">
	function checks() {
		let amount = $("#account_num").val();
		let result = true;			
		if(amount == null || amount == ""){
			$("#account_num").css({'border-color':'#ff3e1d'});
			$("#danger").css({'color':'#ff3e1d'});
			$("#danger").text("계좌번호를 입력해주세요.");
			result = false;
		}
		
		return result;  
	}
</script>

<div class="modal fade" id="accountModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel2">계좌등록</h5>
				<button
					type="button"
					class="btn-close"
					data-bs-dismiss="modal"
					aria-label="Close"
				></button>
			</div>
			<form action="AddAccount" method="post" onsubmit="return checks()">
				<div class="modal-body">
					<div class="row">
						<div class="col mb-3">
							<label for="nameSmall" class="form-label">은행명</label>
							<select name="account_bank" class="form-select" required>
								<option>KDB산업은행</option>
								<option>IBK기업은행</option>
								<option>KB국민은행</option>
								<option>수협은행</option>
								<option>NH농협은행</option>
								<option>우리은행</option>
								<option>SC제일은행</option>
								<option>한국씨티은행</option>
								<option>대구은행</option>
								<option>부산은행</option>
								<option>광주은행</option>
								<option>제주은행</option>
								<option>전북은행</option>
								<option>경남은행</option>
								<option>하나은행</option>
								<option>신한은행</option>
								<option>케이뱅크</option>
								<option>카카오뱅크</option>
								<option>토스뱅크</option>
								<option>오픈은행</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col mb-3">
							<label class="form-label" for="emailSmall">계좌번호</label>
							<input type="number" name="account_num" id="account_num" class="form-control"/>
							<label class="form-label" id="danger" for="emailSmall"></label>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
						취소
					</button>
					<button type="submit" id="submit" class="btn btn-primary">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>