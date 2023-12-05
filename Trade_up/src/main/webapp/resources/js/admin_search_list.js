
//$("#search_btn").click(function(){
//	var start = $("input[name=startDate]").val();
//	var end = $("input[name=endDate]").val();
//	alert("start : " + start + ", end :" + end);
//	console.log("start : " + start + "end" + "end");
//});

$("#search_btn").click(function(){
	var start = $("input[name=startDate]").val();
	var end = $("input[name=endDate]").val();
//	alert("start : " + start + ", end :" + end + " : 확인용!");
	console.log("start : " + start + "end" + "end");
	
	if(start > end){
		alert("시작 날짜보다 이후 날짜가 더 빠를 수 없습니다. ");
		return false;
	}
});



// function search(){
//	
//	var start = $("input[name=startDate]").val();
//	var end = $("input[name=endDate]").val();
////	alert("start : " + start + ", end :" + end + " : 확인용!");
//	console.log("start : " + start + "end" + "end");
//	
//	if(start > end){
//		alert("시작 날짜보다 이후 날짜가 더 빠를 수 없습니다. ");
//		return false;
//	}
//	
//};
	
//	$("#search_btn").click(function(){
//	var start = $("input[name=startDate]").val();
//	var end = $("input[name=endDate]").val();
//
//	alert("start : " + start + ", end :" + end);
	
//	if(start > end){
//		alert("날짜 지정이 잘못 됐습니다.");
//		return false;
//	}
	
//	console.log("start : " + start + "end" + "end");
//	});
	


//$("#search_btn").click(function(){
//	var start = $("input[name=startDate]").val();
//	var end = $("input[name=endDate]").val();
//	
//	if(start > end){
//		alert("날짜 지정이 잘못 됐습니다.");
//		return false;
//	}
//	
////	alert("start : " + start + ", end :" + end);
//	console.log("start : " + start + "end" + "end");
//});