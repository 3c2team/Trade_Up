// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Area Chart Example
var ctx = document.getElementById("myAreaChart");

$.ajax({
		type: "POST",
		url: "AdminSelectHourDate",
		async: false,
		data: {
			day : 0
		},
		success: function(adminSelectHourDate) {
			hours = adminSelectHourDate.map(row => row.rnum);
			sales = adminSelectHourDate.map(row => row.sales);
			max = sales.reduce((max, curr) => max < curr ? curr : max );
		},
		error:function(){
			alert("실패");
		}
	});
	$("#sales_btn").on("click",function(){
	$.ajax({
		type: "POST",
		url: "AdminSelectHourDate",
		async: false,
		data: {
			day : $("#day").val()
		},
		success: function(adminSelectHourDate) {
			sales = adminSelectHourDate.map(row => row.sales);
			max = sales.reduce((max, curr) => max < curr ? curr : max );
			myLineChart.data.datasets[0].data = sales
			myBarChart.data.datasets[0].data = sales
			myLineChart.options.scales.yAxes[0].ticks.max = max
			myBarChart.options.scales.yAxes[0].ticks.max = max
			myLineChart.update();
			myBarChart.update();
		},
		error:function(){
			alert("실패");
		}
	});
	
});
var myLineChart = new Chart(ctx, {
  type: 'line',
  data: {
   labels: hours,
    datasets: [{
      label: "Sessions",
      lineTension: 0.3,
      backgroundColor: "rgba(2,117,216,0.2)",
      borderColor: "rgba(2,117,216,1)",
      pointRadius: 5,
      pointBackgroundColor: "rgba(2,117,216,1)",
      pointBorderColor: "rgba(255,255,255,0.8)",
      pointHoverRadius: 5,
      pointHoverBackgroundColor: "rgba(2,117,216,1)",
      pointHitRadius: 50,
      pointBorderWidth: 2,
      data:sales,
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
          maxTicksLimit: 10
        }
      }],
      yAxes: [{
        ticks: {
          min: 0,
          max: max,
          maxTicksLimit: 10
        },
        gridLines: {
          color: "rgba(0, 0, 0, .125)",
        }
      }],
    },
    legend: {
      display: false
    }
  }
});
