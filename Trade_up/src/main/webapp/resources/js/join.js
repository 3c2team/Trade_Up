$(function() {
	// 1. 아이디 입력창 체크
	$("#member_id").blur(function() {
		let id = $("#member_id").val();
		let regex = /^[A-Za-z0-9]{4,16}$/;
		
		if(id == "") {
			$("#checkIdResult").html("아이디를 입력해주세요.");
			$("#checkIdResult").css("color", "red");
			return;
		}
		
		if(!regex.exec(id)) { // 아이디 입력값 검증 실패 시 
			$("#checkIdResult").html("아이디는 영문소문자 또는 숫자 4~16자로 입력해 주세요.");
			$("#checkIdResult").css("color", "red");
			return;
		}
		
		if(id.indexOf("admin") != -1) {
			$("#checkIdResult").html(id + "는 사용할 수 없는 아이디입니다.");
			$("#checkIdResult").css("color", "red");
			$("#member_id").val("");
			return;
		}
		
		$.ajax({
			url: "MemberCheckDupId",
			data: {
				id: id
			},
			success: function(result) {
				if($.trim(result) == "true") { // 아이디 중복
					$("#checkIdResult").html(id + "는 이미 사용중인 아이디입니다.");
					$("#checkIdResult").css("color", "red");
					$("#member_id").val("");
					return;
				}
				$("#checkIdResult").html(id + "는 사용 가능한 아이디입니다.");
				$("#checkIdResult").css("color", "gray");
			}
		});
	});
	
	// 비밀번호 입력창 체크
	$("#member_passwd").blur(function() {
		let passwd = $("#member_passwd").val();
		let lengthRegex = /^[A-Za-z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]{8,16}$/;
			
		if(passwd == "") { // 비밀번호 미입력
			$("#checkPasswdResult").html("비밀번호를 입력해주세요.");
			$("#checkPasswdResult").css("color", "red");
			return;
		}
		
		if(!lengthRegex.exec(passwd)) { // 비밀번호 길이 체크 위반
			$("#checkPasswdResult").html("영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자");
			$("#checkPasswdResult").css("color", "red");
			return;
		}
		
		let engUpperRegex = /[A-Z]/;
		let engLowerRegex = /[a-z]/;
		let numbRegex = /[\d]/;
		let specRegex = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/;
		
		let count = 0;
		
		if(engUpperRegex.exec(passwd)) count++; // 대문자가 포함되어 있을 경우
		if(engLowerRegex.exec(passwd)) count++; // 소문자가 포함되어 있을 경우
		if(numbRegex.exec(passwd)) count++; // 숫자가 포함되어 있을 경우
		if(specRegex.exec(passwd)) count++; // 특수문자가 포함되어 있을 경우
		
		// 복잡도 검사 결과 판별
		// 4점 : 안전, 3점 : 보통, 2점 : 위험, 1점 이하 : 사용 불가능한 패스워드!
		switch(count) {
			case 4 : 
				msg = "안전도가 높은 비밀번호입니다.";
				color = "green";
				break;
			case 3 :
				msg = "안전도가 보통인 비밀번호입니다.";
				color = "gray";
				break;
			case 2 :
				msg = "안전도가 낮은 비밀번호입니다.";
				color = "orange";
				break;
			case 1 :
			case 0 :
				msg = "영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자";
				color = "red";
		}
		// 텍스트와 글자색상 변수를 활용하여 상태 변경
		$("#checkPasswdResult").html(msg);
		$("#checkPasswdResult").css("color", color);
	});
	
	// 비밀번호 확인
	$("#member_passwd2").blur(function() {
		let passwd = $("#member_passwd").val();
		let passwd2 = $("#member_passwd2").val();
		
		if(passwd2 == "") {
			$("#checkPasswd2Result").html("비밀번호를 입력해주세요.");
			$("#checkPasswd2Result").css("color", "red");
			return;
		}
		
		if(passwd != passwd2) {
			$("#checkPasswd2Result").html("비밀번호가 일치하지 않습니다.");
			$("#checkPasswd2Result").css("color", "red");
			return;
		}
		
		$("#checkPasswd2Result").html("비밀번호가 일치합니다.");
		$("#checkPasswd2Result").css("color", "gray");
	});
	
	$("#member_emailDomain").change(function() {
		$("#member_email2").val($("#member_emailDomain").val());
		
		if($("#member_emailDomain").val() == "") { // 직접입력 선택 시
			$("#member_email2").focus(); // 커서 요청
			$("#member_email2").css("background", ""); // 배경색 초기화
			$("#member_email2").removeAttr("readonly"); // 읽기 전용 속성 제거(결과 동일)
			return;
		}
		$("#member_email2").css("background", "lightgray"); // 배경색 초기화
		$("#member_email2").attr("readonly", true); // 읽기 전용으로 변경
	});
	
	$("#member_phone_num").blur(function() {
		let phone_num = $("#member_phone_num").val();
			
		if(phone_num == "") {
			$("#checkPhoneResult").html("전화번호를 입력해주세요.");
			$("#checkPhoneResult").css("color", "red");
			return;
		}
		
		$.ajax({
			url: "MemberCheckDupPhone",
			data: {
				phone_num: phone_num
			},
			success: function(result) {
				if($.trim(result) == "true") {
					$("#checkPhoneResult").html(phone_num + "는 이미 사용중인 전화번호입니다.");
					$("#checkPhoneResult").css("color", "red");
					$("#member_phone_num").focus();
					return;
				}
				$("#checkPhoneResult").html(phone_num + "는 사용 가능한 전화번호입니다.");
				$("#checkPhoneResult").css("color", "gray");
			}
		});
	});
	
	// 인증번호 확인
	$("#member_auth_code").blur(function() {
		let authCode = $("#member_auth_code").val();
		let authCode_real = $("#authCode").val();
		
		if(authCode == "") {
			$("#checkSendResult").html("인증코드를 입력해주세요.");
			$("#checkSendResult").css("color", "red");
			return;
		}
		
		if(authCode != authCode_real) {
			$("#checkSendResult").html("인증코드가 일치하지 않습니다.");
			$("#checkSendResult").css("color", "red");
			return;
		}
		
		$("#checkSendResult").html("인증 완료되었습니다.");
		$("#checkSendResult").css("color", "gray");
	});
	
	// 5. 주소 검색
	$("#btnSearchAddress").click(function() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            let address = data.address; // 기본 주소 저장
	            let zonecode = data.zonecode;
	            if(data.buildingName != '') { // 건물명이 있을 경우
	            	address += " (" + data.buildingName + ")";
	            }
	            $("#member_address1").val(address);
	            $("#zonecode").val(zonecode);
	            $("#member_address2").focus();
	        }
	    }).open();
	});
});

function mail() {
	var flag = true;
	$.ajax({
		url: "MemberCheckDupMail",
		data: {
			mail1: $("#member_email1").val(),
			mail2: $("#member_email2").val(),
			},
		async: false,
		success: function(result) {
			if($.trim(result) == "true") { // 아이디 중복
				alert("이 메일로 회원가입한 정보가 이미 있습니다.");
				$("#member_email1").focus();
				flag = false;	
			}
		}
	});	
	return flag;
}

const autoHyphen = (target) => {
	target.value = target.value
	.replace(/[^0-9]/g, '')
	.replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}

function sendSMS() {
	let phone_num = $("#member_phone_num").val();
	
	if(phone_num == "") {
		$("#checkPhoneResult").html("전화번호를 입력해주세요.");
		$("#checkPhoneResult").css("color", "red");
		return;
	}
	$.ajax({
		url: "MemberCheckDupPhone",
		data: {
			phone_num: phone_num
		},
		success: function(result) {
			if($.trim(result) == "true") {
				$("#checkPhoneResult").html(phone_num + "는 이미 사용중인 전화번호입니다.");
				$("#checkPhoneResult").css("color", "red");
				$("#member_phone_num").focus();
				return;
			}
			
			$("#checkPhoneResult").html(phone_num + "는 사용 가능한 전화번호입니다.");
			$("#checkPhoneResult").css("color", "gray");
			$.ajax({
				url: "SendSMS",
				data: {
					"phone_num" : phone_num
				},
				success: function(data) {
					alert("인증번호를 발송했습니다. 문자 확인 후 번호를 입력해주세요.");
					$("#authCode").val(data.authCode);
				} ,
				error: function (data) {
					alert("인증번호 발송에 실패하였습니다. 전화번호를 다시 한번 확인해 주세요")
				},
			});
		}
	});
}

// '출생 연도' 셀렉트 박스 option 목록 동적 생성--년도
const birthYearEl = document.querySelector('#birth-year');
const now = new Date();	// 현재 날짜 및 시간
const nowYear = now.getFullYear();	// 연도
// option 목록 생성 여부 확인
isYearOptionExisted = false;
	
birthYearEl.addEventListener('focus', function () {
	// year 목록 생성되지 않았을 때 (최초 클릭 시)
	if(!isYearOptionExisted) {
		isYearOptionExisted = true;
		for(let i = 1945; i <= nowYear; i++) {
			// option element 생성
			const YearOption = document.createElement('option');
			YearOption.setAttribute('value', i);
			YearOption.innerText = i;
			// birthYearEl의 자식 요소로 추가
			this.appendChild(YearOption);
		}
	}
});
// '출생 연도' 셀렉트 박스 option 목록 동적 생성--월
const monthEl = document.querySelector('#birth-month');
isMonthOptionExisted = false;

monthEl.addEventListener('focus', function () {
	if(!isMonthOptionExisted) {
		isMonthOptionExisted = true
		for(let i = 1; i <= 12; i++) {
			const monthOption = document.createElement('option');
			monthOption.setAttribute('value', i);
			monthOption.innerText = String(i).padStart(2,"0");
			this.appendChild(monthOption);
		}
	}
});

// '출생 연도' 셀렉트 박스 option 목록 동적 생성--날
const dayEl = document.querySelector('#birth-day');
isDayOptionExisted = false;

dayEl.addEventListener('focus', function () {
	if(!isDayOptionExisted) {
		isDayOptionExisted = true
		for(let i = 1; i <= 31; i++) {
			const dayOption = document.createElement('option');
			dayOption.setAttribute('value', i);
			dayOption.innerText = String(i).padStart(2,"0");
			this.appendChild(dayOption);
		}
	}
});

function checks() {
	var getId= RegExp(/^[A-Za-z0-9]{4,16}$/);
	var getPw= RegExp(/^[A-Za-z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]{8,16}$/);
	var getName= RegExp(/^[가-힣]+$/);
	
	// 아이디 공백 확인
	if($("#member_id").val() == "") {
		alert("아이디를 입력해주세요.");
        $("#member_id").focus();
        return false;
    }
    
    if(id.indexOf("admin") != -1){
		alert(id + "는 사용할 수 없는 아이디입니다.");
		$("#member_id").val("");
		$("#member_id").focus();
		return false;
	}
           
	// 아이디 유효성검사
	if(!getId.test($("#member_id").val())) {
		alert("아이디는 영문소문자 또는 숫자 4~16자로 입력해 주세요.");
		$("#member_id").val("");
		$("#member_id").focus();
		return false;
	}
	
	// 비밀번호 공백 확인
    if($("#member_passwd").val() == "") {
		alert("비밀번호를 입력해주세요.");
		$("#member_passwd").focus();
        return false;
    }

	// 아이디 비밀번호 같음 확인
    if($("#member_id").val() == $("#member_passwd").val()) {
        alert("아이디와 비밀번호가 같습니다");
        $("#member_passwd").val("");
        $("#member_passwd").focus();
        return false;
    }
      
	// 비밀번호 유효성검사
    if(!getPw.test($("#member_passwd").val())) {
        alert("비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 혼합해서 8자~16자로 입력해야 됩니다.");
        $("#member_passwd").val("");
        $("#member_passwd").focus();
        return false;
    }
    
    // 비밀번호 확인란 공백 확인
    if($("#member_passwd2").val() == ""){
        alert("비밀번호 확인란을 입력해주세요.");
        $("#member_passwd2").focus();
        return false;
    }
    
	// 비밀번호 확인
    if($("#member_passwd").val() != $("#member_passwd2").val()){
    	alert("비밀번호가 다릅니다. 다시 입력해주세요.");
    	$("#member_passwd").val("");
    	$("#member_passwd2").val("");
    	$("#member_passwd").focus();
    	return false;
    }
    
    // 이름 공백 검사
    if($("#member_name").val() == ""){
        alert("이름을 입력해주세요.");
        $("#member_name").focus();
        return false;
    }

	// 이름 유효성 검사
    if(!getName.test($("#member_name").val())){
        alert("이름은 한글만 입력 가능합니다.")
        $("#member_name").val("");
        $("#member_name").focus();
        return false;
    }
    	
    // 닉네임 공백 검사
    if($("#member_nick_name").val() == ""){
        alert("닉네임을 입력해주세요.");
        $("#member_nick_name").focus();
        return false;
    }
    
    // 전화번호 공백 검사
    if($("#member_phone_num").val() == ""){
        alert("전화번호를 입력해주세요.");
        $("#member_phone_num").focus();
        return false;
    }

    // 인증번호 공백 검사
    if($("#member_auth_code").val() == ""){
        alert("인증번호를 입력해주세요.");
        $("#member_auth_code").focus();
        return false;
    }
    
	// 인증번호 확인
    if($("#authCode").val() != $("#member_auth_code").val()){
          alert("인증번호가 다릅니다. 다시 입력해주세요.");
          $("#member_auth_code").val("");
          $("#member_auth_code").focus();
          return false;
    }
    	
    // 주소1 공백 검사
    if($("#member_address1").val() == ""){
        alert("주소를 입력해주세요.");
        $("#member_address1").focus();
        return false;
    }
	
    // 주소2 공백 검사
    if($("#member_address2").val() == ""){
        alert("주소를 입력해주세요.");
        $("#member_address2").focus();
        return false;
    }
    
    flag = true;
    flag = mail();
    return flag;
}