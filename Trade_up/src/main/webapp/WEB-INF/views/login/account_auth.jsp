<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>account_auth</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin ="anonymous">

  <!-- Inline CSS -->
  <style>
    * { padding: 0; margin: 0; }

    html, body {
      height: 100%;
      background: #ffffff;
    }

    #container {
      display: flex;
      flex-direction: row;
      justify-content: center;
      align-items: center;
      height: 100%;
    }

    #loginBox {
      width: 1000px;
      text-align: center;
      background-color: #ffffff;
    }
    .input-form-box {
      border: 0px solid #ff0000;
      display: flex;
      margin-bottom: 5px;
    }
    .input-form-box > span {
      display: block;
      text-align: left;
      padding-top: 5px;
      min-width: 65px;
    }
    .button-login-box {
      margin: 10px 0;
    }
    #loginBoxTitle {
      color:#000000;
      font-weight: bold;
      font-size: 32px;
      text-transform: uppercase;
      padding: 5px;
      margin-bottom: 20px;
      background: linear-gradient(to right, #5F12D3, #8ca6ce);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    #inputBox {
      margin: 10px;
    }

    #inputBox button {
      padding: 3px 5px;
    }
    
    .btn-primary {
    background-color: #5F12D3; /* 보라색으로 변경 */
    border-color: #5F12D3; /* 테두리도 보라색으로 변경 */
  	}
  	.btn-naver {
    background-color: #FFEB00; /* 보라색으로 변경 */
    border-color: #FFEB00; /* 테두리도 보라색으로 변경 */
    }
    
    .btn-kakao {
    background-color: #03C75A; /* 보라색으로 변경 */
    border-color: #03C75A; /* 테두리도 보라색으로 변경 */
    }
    
    .login-button, .signup-button, .find_password {
        margin-right: 15px;
        margin-left: 15px;
    }
    
    #kakaoLogin {
    font-family: 'Roboto', sans-serif; /* Google Fonts에서 Roboto 글꼴 사용 */
    color: #3C1E1E; /* 텍스트 색상 */
    font-size: 15px; /* 글자 크기 */
    font-weight: bold; /* 글자 굵기 */
    text-shadow: 2px 2px 2px #FFD700; /* 글자에 금색 그림자 추가 */
    transition: all 0.3s ease; /* 부드러운 전환 효과 */
    text-decoration: none; /* 그어진 줄 제거 */
	}
	
	#kakaoLogin:hover {
	    color: #5F12D3; /* 마우스 오버 시 텍스트 색상 변경 */
	    transform: scale(1.1); /* 마우스 오버 시 텍스트 약간 확대 */
	}
	
	#naverLogin {
    font-family: 'Arial', sans-serif; /* 글꼴 변경 */
    color: #FFFFFF; /* NAVER의 특징적인 녹색으로 텍스트 색상 변경 */
    font-size: 15px; /* 글자 크기 조정 */
    font-weight: bold; /* 글자를 굵게 표시 */
    transition: all 0.3s ease; /* 부드러운 전환 효과 */
    text-decoration: none; /* 그어진 줄 제거 */
	}
	
	#naverLogin:hover {
	    color: #5F12D3; /* 마우스 오버 시 색상 변경 */
	}
	.button-container {
	    display: flex;
	    justify-content: space-around; /* 버튼 사이의 간격을 균등하게 조정 */
	    align-items: center;
	}
	.footer{
	    margin:0 auto;
	    text-align:center;
	    bottom:5px;
	    color:gray;
	    display: flex;
		justify-content: center; /* 중앙 정렬 */
		gap: 20px; /* 버튼 사이의 간격 */
	}
	.btn-white {
	    /* 버튼 스타일 */
	    padding: 10px;
	    color: black; /* 텍스트 색상 */
	    background-color: white; /* 배경색 */
	    text-align: center;
	    display: inline-block;
	    border: 1px solid #ccc; /* 테두리 색상 */
	    transition: background-color 0.3s ease;
	}
	
	.btn-white a {
	    color: black; /* 링크 텍스트 색상 */
	    text-decoration: none; /* 밑줄 제거 */
	}
	.btn-white:hover {
	    background-color: #5F12D3; /* 마우스 오버 시 보라색으로 변경 */
	    color: white; /* 텍스트 색상을 흰색으로 변경 (선택적) */
	}
  </style>

</head>
<body class="text-center">
  
  <!--  html 전체 영역을 지정하는 container -->
  <div id="container">
    <!--  login 폼 영역을 : loginBox -->
      <!-- 로그인 페이지 타이틀 -->
      <!-- 아이디, 비번, 버튼 박스 -->
    <div id="loginBox">
    
    <div id="inputBox">
      	<div id="loginBoxTitle">GARGE의 회원이 되신걸 축하드립니다.</div>
	      	<p style="margin-top: 20px; font-size: 18px; color: #000000; font-weight: 500; line-height: 1.6;">
			  안전한 중고거래를 위해 <strong style="color: #5F12D3;">계좌 인증</strong>이 필요합니다. <br>
			  인증 절차를 완료하시면 모든 서비스를 자유롭게 이용하실 수 있습니다.
			</p>
        	<br>
        	<br>
        
	        <div class="button-login-box" >
	          <button type="button" id="loginButton" class="btn btn-primary btn-xs login-button" style="width:30%">계좌 인증</button>
	          <button type="button" id="joinButton" class="btn btn-primary btn-xs signup-button" style="width:30%">다음에 할께요!</button>
	        </div>
	        <br>
        
    		</div>
		</div>
	</div>
<script>
	document.getElementById('loginButton').addEventListener('click', function() {
	  window.location.href = 'JoinAgree'; 
	});
 
	//"다음에 할께요!" 버튼에 대한 클릭 이벤트
	document.getElementById('joinButton').addEventListener('click', function() {
	  window.location.href = 'Main'; // 홈페이지 URL로 변경
	});
 
</script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</body>
</html>


