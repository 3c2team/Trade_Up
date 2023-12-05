// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Pie Chart Example
var ctx = document.getElementById("myPieChart");
var selectOut = null;
$.ajax({
	type: "POST",
	url: "AdminSelectReson",
	async: false,
	data: {},
	success: function(selectMemberOut) {
		selectOut = selectMemberOut;
	},
	error:function(){
		alert("실패");
	}
});

var myPieChart = new Chart(ctx, {
  type: 'pie',
  data: {
    labels: ["아이디 변경을위한 탈퇴 후 재 가입","상품 가격 불만","교환/환불/반품 불만","개인정보 누출 우려","상품의 다양성/품질 불만","배송 불만"],
    datasets: [{
      data: [selectOut.reson1 , selectOut.reson2, selectOut.reson3, selectOut.reson4, selectOut.reson5,selectOut.reson6],
      backgroundColor: ['#0d6efd', '#ffc107', '#198754', '#6c757d','#6610f2','#212529'],
    }],
  },
});

	