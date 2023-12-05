<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
	// function checks() {
	// 	let amount = $("#amount").val();
	// 	let result = true;			
	// 	if(amount < 10000){
	// 		$("#amount").css({'border-color':'#ff3e1d'});
	// 		$("#danger").css({'color':'#ff3e1d'});
	// 		$("#danger").text("10000원 이상부터 충전 가능");
	// 		result = false;
	// 	}
		
	// 	return result;  
	// }		
</script>
<%-- 모달창 --%>
<div class="modal fade" id="delete_account_modal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel2">회원탈퇴</h5>
			</div>
			
			<form action="DeleteMember" method="post" onsubmit="return checks()">
				<div class="modal-body">
					<a>계정을 삭제하면 30일 후 신뢰도, 게시글, 관심, 채팅 등 모든 활동 정보가 삭제됩니다.</a><br><br>
					
					<b>${member.member_nick_name }님이 계정을 삭제하려는 이유가 궁금해요. </b><br><br>
					<div class="row">
						<div class="col mb-3">
							<select class="form-select" required>
	<%-- 							<c:forEach var="account" items="${accountList }" varStatus="status"> --%>
	<%-- 								<option id="account_${status.count }" > --%>
	<%-- 									${account.accout } --%>
	<!-- 								</option> -->
	<%-- 							</c:forEach> --%>
								<option>계정을 삭제하려는 이유를 알려주세요</option>
								<option id="option_1">너무 많이 이용해요</option>
								<option id="option_2">사고 싶은 물품이 없어요</option>
								<option id="option_3">물품이 안팔려요</option>
								<option id="option_4">비매너 사용자를 만났어요</option>
								<option id="option_5">억울하게 이용이 제한됐어요</option>
								<option id="option_6">새 계정을 만들고 싶어요</option>
								<option id="option_7">기타</option>
							</select>
							<small id="tip"></small>
						</div>
					</div>
					
					<div class="row">
						<div class="col mb-3">
							<label for="nameSmall" class="form-label">비밀번호를 입력해주세요.</label>
							<input type="password" name="password" class="form-control" required="required" placeholder="PassWord" />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger">탈퇴하기</button> <!-- btn-danger -->
					<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
						Close
					</button>
				</div>
			</form>
			
		</div>
	</div>
</div>
<%-- 모달창 --%>