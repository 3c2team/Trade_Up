<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script type="text/javascript">
	$(document).ready(function() {
		$("#select_feedback").change(function() {
			$(".tip_class").css("display", "none" );
			$("#other_reason").css("display", "none" );
			
			let selectedOptionVal = $('option:selected', this).val();
				
			if(selectedOptionVal == 0) {
				$("#tip_last").css("display", "");
				$("#other_reason").css("display", "");
			}
			
			$("#tip_" + selectedOptionVal).css("display", "");
			
		});
	});
	
	function checks() {
		let password = $("#password").val();
		let result = true;
		
		if(password == ""){
			$("#password").css({'border-color':'#ff3e1d'});
			$("#danger2").css({'color':'#ff3e1d'});
			$("#danger2").text("비밀번호를 입력해주세요.");
			result = false;
		}
		
		$.ajax({
			url: PasswordCheck,
			method: 'POST',
			data: { "password" : password },
			success: function(data) {
				if(data=="false"){
					$("#password").css({'border-color':'#ff3e1d'});
					$("#danger2").css({'color':'#ff3e1d'});
					$("#danger2").text("잘못된 비밀번호 입니다.");
					result = false;					
				}
			},
			error: function(error) {
				$("#password").css({'border-color':'#ff3e1d'});
				$("#danger2").css({'color':'#ff3e1d'});
				$("#danger2").text("문제가 발생했습니다.");
				result = false;	
			}
		});
		
		return result;  
	}
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
							<select class="form-select" id="select_feedback" name="exid_feedback" required>
								<option disabled selected >선택해주세요</option>
								<c:forEach var="feedback" items="${feedback }" varStatus="status">
									<option value="${feedback.exid_feedback_idx }" id="option_${feedback.feedback_idx }">${feedback.exid_feedback }</option>
								</c:forEach>
								<option value="0">기타</option>
							</select>
							<div class="mt-3">
								<input type="text" name="exid_etc_feedback" id="other_reason" class="form-control mb-3" placeholder="계정을 삭제하려는 이유를 알려주세요." style="display: none;"/>
								<label class="form-label" id="danger1" style="display: none;"></label>
								<c:forEach var="feedback" items="${feedback }" varStatus="status">
									<small class="tip_class" id="tip_${feedback.exid_feedback_idx }" style="display: none;">${feedback.exid_feedback_tip }</small>
								</c:forEach>
								<small class="tip_class" id="tip_last" style="display: none;">	
									말씀해주신 소중한 의견을 반영하여 더 따뜻한 서비스를 만들어가도록 노력할게요.<br>	
									언제나 이 자리에서 기다리고 있을게요. 언제든지 돌아와 주세요.<br>	
									지금까지 함께여서 진심으로 행복했어요.	
								</small>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col mb-3">
							<label for="nameSmall" class="form-label" >비밀번호를 입력해주세요.</label>
							<input type="password" id="password" name="password_check" class="form-control" placeholder="비밀번호" />
							<input type="hidden" name="password" value="${member.member_passwd }">
							<label class="form-label" id="danger2"></label>
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
