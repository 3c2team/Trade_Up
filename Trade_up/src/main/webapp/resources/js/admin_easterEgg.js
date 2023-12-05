function easterEgg()  {
  
  	console.log("확인용");
  	var count = 1;
  	
  	$("#easterEgg").bind("click", function(){
		count++;
		if(count == 5){
//			location.href="AdminMain";
			location.href="AdminLogin";
		}
	});
}
