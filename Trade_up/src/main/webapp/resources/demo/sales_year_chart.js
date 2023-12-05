// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Area Chart Example
var ctx = document.getElementById("myAreaChart");
$.ajax({
	type: "POST",
	url: "AdminSelectYearDate",
	async: false,
	data: {},
	success: function(AdminSelectOutDate) {
		years = AdminSelectOutDate.map(row => row.rnum);
		sales = AdminSelectOutDate.map(row => row.salary);
		max = sales.reduce((max, curr) => max < curr ? curr : max );
	},
	error:function(){
		alert("실패");
	}
});
var myLineChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: years,
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
      data: sales,
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
          max: max,
          maxTicksLimit: 5
        },
        gridLines: {
          color: "rgba(0, 0, 0, .125)",
        }
      }],
    },
      responsive: true,
    
    legend: {
      display: false
    }
  }
});
