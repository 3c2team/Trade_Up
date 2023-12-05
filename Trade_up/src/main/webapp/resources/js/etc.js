$("#police").on("click",function(){
	window.open("https://ecrm.cyber.go.kr/sci/pcc_V3_send?rp=r","","");
});
function isSubmit() {
 	if($("input[type=text][name=search]").val() == ''){
 		return false;
 	}
}