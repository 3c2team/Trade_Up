// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

$("#search_btn").click(function(){
	var start = $("input[name=startDate]").val();
	var end = $("input[name=endDate]").val();
	alert("start : " + start + ", end :" + end + " : 확인용!");
	console.log("start : " + start + "end" + "end");
});


// Pie Chart Example
var ctx = document.getElementById("myPieChart");
	$.ajax({
		type: "POST",
		url: "",
		async: false,
		data: {
			start, end
		},
		success: function(adminSelectProductSales) {
//			product_category = adminSelectProductSales.map(row => row.category);
//			sales = adminSelectProductSales.map(row => row.sales);
			
		},
		error:function(){
			alert("들고오기 실패");
		}
	});
	
var myPieChart = new Chart(ctx, {
  type: 'pie',
  data: {
    labels: ["업페이", "직접거래","카카오페이","무통장입금"],
    datasets: [{
      data: [40,30,20,10],
      backgroundColor: ['#5F12D3', '#2113D4', '#D4134D', '#13BCD4','#000'],
//      backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745','#000'],
    }],
  },
});
