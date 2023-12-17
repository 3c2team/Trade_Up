$(function(){
	
//	var qna_num;
	var qna_num = new Array();
	
	// 공지사항 삭제
	$("#delete_btn").on("click",function(){
		if($("input[name=checkbox]:checked").each(function(){
			qna_num.push($(this).val());
//			alert(qna_num);
			location.href="NoticeDelete?qnaNum="+qna_num;
		})){
		}else{
			qna_num = [];
		}
	});
	
});

