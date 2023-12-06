// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Area Chart Example
function drawChart(){
	var ctx = document.getElementById("myAreaChart");
	$.ajax({
		type: "POST",
		url: "SelectProductPrice",
		async: false,
		data: {
			product_name : $("#select_product").val()
		},
		success: function(data) {
			month = data.map(row => row.month);
			product_avg = data.map(row => row.product_avg);
			max = product_avg.reduce((max, curr) => max < curr ? curr : max )
			$("#product_avg").html(product_avg[product_avg.length-1]+' 원');
			console.log(product_avg);
			
//			debugger;
		},
		error:function(){
			alert("실패");
		}
	});
	var myLineChart = new Chart(ctx, {
	  type: 'line',
	  data: {
		labels: month,
	    datasets: [{
		pointHitRadius: 2000,
		 pointBorderWidth: 1,
		 pointRadius:3,
		 pointStyle:'circle',
	      label: [],
	      data: product_avg,
	      fill: false,
	      borderColor: '#6feb8b',
	      tension: 0.6,
	      borderWidth: 10
	    }],
	  },
	 options: {
	    scales: {
	      xAxes: [{
	        time: {
	          unit: 'date'
	        },
	        gridLines: {
	          display: false
	        },
	        ticks: {
	          maxTicksLimit: 3
	        }
	      }],
	      yAxes: [{
			 ticks: {
	          min: 0,
	          max: max*2,
	          maxTicksLimit: 5
	        },
	        display: false, //y축 텍스트 삭제
	        beginAtZero: 200, //y축값이 0부터 시작
	        gridLines: {
	          color: "rgba(0, 0, 0, .125)"
	        },
	      }],	
	    },
	      responsive: true,
	    
	    legend: {
	      display: false
	    }
	  }
	});
}
