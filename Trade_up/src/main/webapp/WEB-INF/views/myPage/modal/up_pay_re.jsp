<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<script type="text/javascript">
// 	function checks() {
// 		let amount = $("#amount").val();
// 		let result = true;			
// 		if(amount < 10000){
// 			$("#amount").css({'border-color':'#ff3e1d'});
// 			$("#danger").css({'color':'#ff3e1d'});
// 			$("#danger").text("10000원 이상부터 충전 가능");
// 			result = false;
// 		}
		
// 		return result;  
// 	}
</script>

<div class="modal fade" id="up_pay_re" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel2">UP Pay 송금</h5>
				<button
					type="button"
					class="btn-close"
					data-bs-dismiss="modal"
					aria-label="Close"
				></button>
			</div>
			<form action="UpPayRefund" method="post">
				<div class="modal-body">
					<div class="row">
						<div class="col mb-3">
							<label for="nameSmall" class="form-label">송금계좌</label>
							<select class="form-select" required>
								<c:forEach var="account" items="${accountList }" varStatus="status">
									<option id="account_${status.count }" >
										${account.account_bank }  ${account.account_num }
									</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col mb-3">
							<label class="form-label" for="emailSmall">송금금액</label>
							<input type="number" class="form-control" id="amount" name="refund_price"/>
							<label class="form-label" id="danger" for="emailSmall"></label>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
						취소
					</button>
					<button type="submit" id="submit" class="btn btn-primary">송금하기</button>
				</div>
			</form>
		</div>
	</div>
</div>