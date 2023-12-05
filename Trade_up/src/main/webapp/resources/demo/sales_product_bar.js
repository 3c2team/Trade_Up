// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Bar Chart Example
var ctx = document.getElementById("myBarChart");
//$.ajax({
//		type: "POST",
//		url: "",
//		async: false,
//		data: {
//		},
//		success: function(adminSelectProductSales) {
//			product_category = adminSelectProductSales.map(row => row.category);
//			sales = adminSelectProductSales.map(row => row.sales);
//			max = sales.reduce((max, curr) => max < curr ? curr : max );
//		},
//		error:function(){
//			alert("들고오기 실패");
//		}
//	});
var myLineChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: [1,2,3,4],//밑에 설명
    datasets: [{
      label: "TEST",
      backgroundColor: "rgba(2,117,216,1)",
      borderColor: "rgba(2,117,216,1)",
      data: [60,50,30,50]//데이터 값
    }]
  }
//  options: {
//    scales: {
//      xAxes: [{
//        time: {
//          unit: 'month'
//        },
//        gridLines: {
//          display: false
//        },
//        ticks: {
//          maxTicksLimit: 6
//        }
//      }],
//      yAxes: [{
//        ticks: {
//          min: 0,
//          max: max,
//          maxTicksLimit: 5
//        },
//        gridLines: {
//          display: true
//        }
//      }],
//    },
//    legend: {
//      display: false
//    }
//  }
});
