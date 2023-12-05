// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Area Chart Example
var ctx = document.getElementById("myAreaChart");
//$.ajax({
//	type: "POST",
//	url: "AdminSelectYearDate",
//	async: false,
//	data: {},
//	success: function(AdminSelectOutDate) {
//		years = AdminSelectOutDate.map(row => row.rnum);
//		sales = AdminSelectOutDate.map(row => row.salary);
//		max = sales.reduce((max, curr) => max < curr ? curr : max );
//	},
//	error:function(){
//		alert("실패");
//	}
//});
var myLineChart = new Chart(ctx, {
  type: 'line',
  data: {
	labels:["3개월전","2개월전","1개월전","오늘"],
    datasets: [{
	pointHitRadius: 2000,
	 pointBorderWidth: 1,
	 pointRadius:3,
	 pointStyle:'circle',
      label: [],
      data: [1000,1000,1000,1500],
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
          max: 2000,
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

