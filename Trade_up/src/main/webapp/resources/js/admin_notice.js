$(function(){
	$("#open_notice_insert").on("click",function(){
		window.open('AdminNoticeRegist','공지등록', "top=500,left=500,width=750, height=500");
	});

});
	function isSubmit() {
		if(!confirm("등록하시겠습니까?")){
			return false;
		}
	}

