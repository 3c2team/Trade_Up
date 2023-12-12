$(function(){
	$(".qnaDetail").on("click",function(){
		let qnaDetailNum = $(this).val();
		window.open('AdminNoticeDetail?qnaDetailNum='+qnaDetailNum,'상세보기', "top=500,left=500,width=770, height=500");
	});

});