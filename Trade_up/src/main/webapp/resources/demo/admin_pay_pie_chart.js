// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

$("#search_btn").click(function(){
	var start = $("input[name=startDate]").val();
	var end = $("input[name=endDate]").val();
//	alert("start : " + start + ", end :" + end + " : 확인용!");
	console.log("start : " + start + "end" + "end");
	
	if(start > end){
		alert("이후 날짜보다 시작 날짜가 더 빠를 수 없습니다. ");
		return false;
	}
});

// Pie Chart Example
var ctx = document.getElementById("myPieChart");
	$.ajax({
		type: "POST",
		url: "TransactionMethod",
		async: false,
		data: {},
		success: function(TransactionCount) {
//			alert(TransactionCount);
			kakaopayCount = TransactionCount.kakaopayCount;
			uppayCount = TransactionCount.uppayCount;
			bankCount = TransactionCount.bankCount;
			
//			bankCount = TransactionCount.map(row => row.bankCount);
//			kakaopayCount = TransactionCount.map(row => row.kakaopayCount);
//			uppayCount = TransactionCount.map(row => row.uppayCount);
		},
		error:function(){
			alert("들고오기 실패");
		}
	});
	
var myPieChart = new Chart(ctx, {
  type: 'pie',
  data: {
    labels: ["업페이","카카오페이","무통장입금"],
    datasets: [{
      data: [uppayCount,kakaopayCount,bankCount],
      backgroundColor: ['#5F12D3', '#2113D4', '#D4134D'],
//      backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745','#000'],
    }],
  },
});
