// 날짜를 YYYY-MM-DD 형식의 문자열로 변환하는 함수
function formatDate(date) {
	
	// getFullYear, getMonth, getDate 메소드를 사용하여 연도, 월, 일을 추출
	// 월은 0부터 시작해 1을 더함
	// padStart를 사용하여 한 자리 숫자 앞에 '0'을 붙여 두 자리로 만듭
    return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
}

// 지정된 개월 수만큼 이전의 날짜를 시작 날짜로 설정하고, 종료 날짜는 오늘 날짜로 설정하는 함수
// -> 현재 날짜로부터 지정된 개월 수 만큼 이전 날짜를 계산해 시작날짜와 종료날짜를 설정
function setMonths(event, monthsAgo) {
    const currentDate = new Date();
    const endDate = formatDate(currentDate);	// 오늘 날짜를 문자열로 변환
    
    console.log("1 monthsAgo  :", monthsAgo);
    
    monthsAgo=Number(monthsAgo);
    console.log("2 monthsAgo  :", monthsAgo);
    
    currentDate.setMonth(currentDate.getMonth() + monthsAgo); // 현재 날짜에서 monthsAgo만큼 월을 빼서 과거 날짜를 구함
    const startDate = formatDate(currentDate);				  // 과거 날짜를 문자열로 변환
    console.log(" startDate  :", startDate);
    
    
    // id가 'startDate'와 'endDate'인 요소를 찾아 값을 설정
    document.getElementById('startDate').value = startDate;	  
    document.getElementById('endDate').value = endDate;		
    
    $(".calendarContainer").removeClass("on");
    $(event).addClass("on");
    $("#searchType").val(monthsAgo);
}

// 오늘 날짜를 시작 및 종료 날짜로 설정하는 함수
function setToday(event) {
    const currentDate = formatDate(new Date());					// 오늘 날짜를 문자열로 변환합니다.
    
    //id가 'startDate'와 'endDate'인 요소를 찾아 오늘 날짜로 설정
    document.getElementById('startDate').value = currentDate;
    document.getElementById('endDate').value = currentDate;
    
     $(".calendarContainer").removeClass("on");
    $(event).addClass("on");
    $("#searchType").val(1);
}

// 항목을 날짜별로 필터링하는 함수 (itemClass: 필터링할 항목들의 클래스 이름, dateDataAttribute: 항목의 날짜 데이터가 저장된 data 속성의 이름)
function filterItemsByDate(startDateId, endDateId, itemClass, dateDataAttribute) {
    // 입력 필드에서 시작 및 종료 날짜를 가져와 Date 객체로 변환
    const startDate = new Date(document.getElementById(startDateId).value);
    const endDate = new Date(document.getElementById(endDateId).value);
    
    // 지정된 클래스를 가진 모든 항목을 가져옴
    const rows = document.querySelectorAll(itemClass);
    
    // 각 항목에 대해 반복하여 날짜를 확인하고, 지정된 범위 밖에 있으면 숨김.
    rows.forEach(row => {
        const itemDate = new Date(row.getAttribute(dateDataAttribute));
        
        if (itemDate < startDate || itemDate > endDate) {
            row.style.display = 'none';		// 범위 밖이면 숨김 처리
        } else {
            row.style.display = '';
        }
    });

}

// 전체 기간을 설정하고 모든 데이터를 표시하는 함수
function setAllPeriod(event) {
    // 시작 및 종료 날짜 입력 필드의 값을 비움
    document.getElementById('startDate').value = '';
    document.getElementById('endDate').value = '';

    // 모든 데이터를 표시하는 로직을 여기에 추가
    // 예를 들어, 모든 리뷰, 예약, 포인트 내역 등을 표시
    const allItems = document.querySelectorAll('.review-row, .reservation-row, .point-row, .buy-row');
    allItems.forEach(item => {
        item.style.display = ''; // 모든 항목을 보이게 설정
    });
     
    $(".calendarContainer").removeClass("on");
    $(event).addClass("on");  
}

// 페이지 로드 시 기본값으로 3개월 전의 날짜를 시작 날짜로 설정하는 초기화 로직
//document.addEventListener('DOMContentLoaded', function() {
    //setMonths('',-3);

    // "조회" 버튼 클릭 시 적절한 함수를 호출하는 이벤트 리스너
    var searchButton = document.getElementById('search_btn');
    if (searchButton) {
        searchButton.addEventListener('click', function() {
//	alert("확인");
//	var start = $("input[name=startDate]").val();
//	var end = $("input[name=endDate]").val();
//	
//	alert("시작날짜 : " + start + ", 끝날짜 : " + end);
//	console.log("시작날짜 : " + start + ", 끝날짜 : " + end);
	

	
	
//			// 리뷰 항목이 있는 경우 해당 항목을 날짜별로 필터링
//            if (document.querySelector('.review-row')) {
//                filterItemsByDate('startDate', 'endDate', '.review-row', 'data-review-date');
//            
//            // 예약 항목이 있는 경우 해당 항목을 날짜별로 필터링
//            } else if (document.querySelector('.reservation-row')) {
//                filterItemsByDate('startDate', 'endDate', '.reservation-row', 'data-reservation-date');
//            // 포인트 내역이 있는 경우 해당 항복을 날짜별로 필터링
//            } else if (document.querySelector('.point-row')) {
//		        filterItemsByDate('startDate', 'endDate', '.point-row', 'data-point-date');
//		    } else if (document.querySelector('.buy-row')) {
//		        filterItemsByDate('startDate', 'endDate', '.buy-row', 'data-buy-date');
//		    }
        });
    }
//});