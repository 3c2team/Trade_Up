// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Bar Chart Example
var ctx = document.getElementById("myBarChart");
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
  type: 'bar',
  data: {
    labels: years,
    datasets: [{
      label: "Revenue",
      backgroundColor: "rgba(2,117,216,1)",
      borderColor: "rgba(2,117,216,1)",
      data: sales,
    }],
  },
  options: {
    scales: {
      xAxes: [{
        time: {
          unit: 'year'
        },
        gridLines: {
          display: false
        },
        ticks: {
          maxTicksLimit: 6
        }
      }],
      yAxes: [{
        ticks: {
          min: 0,
          max: max,
          maxTicksLimit: 5
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
