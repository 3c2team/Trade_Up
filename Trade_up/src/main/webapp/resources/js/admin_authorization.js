$(function(){
	
//	var member_id;
	var member_id = new Array();
	
	//관리자 권한 회수
	$("#revoke").on("click",function(){
		if($("input[name=checkbox]:checked").each(function(){
			member_id.push($(this).val());
			location.href="MemberRevoke?member_id="+member_id;
		})){
		}else{
			member_id = [];
		}
	});
	
	//관리자 권한 부여
	$("#authorization").on("click",function(){
		if($("input[name=checkbox]:checked").each(function(){
			member_id.push($(this).val());
			location.href="MemberAuth?auth_id="+member_id;
		})){
		}else{
			member_id = [];
		}
	});

});

