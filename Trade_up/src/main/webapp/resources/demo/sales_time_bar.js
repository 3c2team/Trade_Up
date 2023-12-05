// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Bar Chart Example
var ctx = document.getElementById("myBarChart");
$.ajax({
		type: "POST",
		url: "AdminSelectHourDate",
		async: false,
		data: {
			day : 0
		},
		success: function(AdminSelectMonthDate) {
			hours = AdminSelectMonthDate.map(row => row.rnum);
			sales = AdminSelectMonthDate.map(row => row.sales);
			max = sales.reduce((max, curr) => max < curr ? curr : max );
		},
		error:function(){
			alert("실패");
		}
	});
var myBarChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: hours,
    datasets: [{
      label: "Revenue",
      backgroundColor: "rgba(2,117,216,1)",
      borderColor: "rgba(2,117,216,1)",
      data:sales,
    }],
  },
  options: {
    scales: {
      xAxes: [{
        time: {
          unit: 'time'
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
          display: true
        }
      }],
    },
    legend: {
      display: false
    }
  }
});
