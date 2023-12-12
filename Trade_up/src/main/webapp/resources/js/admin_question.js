$(function(){
	
	$(".delete_dangerous").on("click",function(){
		let qnaNum = $(this).val();
		window.open('AdminQuestionRegist?qnaNum='+qnaNum,'문의사항 답변', "top=500,left=500,width=777, height=660");
	});

});
	function isSubmit() {
		if(!confirm("등록하시겠습니까?")){
			return false;
		}
	}

