<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>id forgot</title>

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
      width: 600px;
      text-align: center;
      background-color: #ffffff;
    }
    .input-form-box {
      width: 80%;
      display: flex;
      margin-bottom: 10px;
	  padding: 10px;
	  border: none;
	  border-radius: 20px;
	  background-color: #fff;
	  justify-content: space-between; /* 요소들 사이의 간격을 균등하게 배분 */
    }
    .input-form-box > span {
      display: block;
      text-align: left;
      padding-top: 5px;
      min-width: 65px;
      margin-right: 18px; /* 오른쪽 마진 추가 */
    }
    .button-login-box {
      margin: 10px 0;
    }
    #loginBoxTitle {
      color:#000000;
      font-weight: bold;
      font-size: 28px;
      text-transform: uppercase;
      padding: 5px;
      margin-bottom: 30px;
      background: linear-gradient(to right, #5F12D3, #8ca6ce);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    #inputBox {
      margin: 10px;
      display: flex;
  	  justify-content: center;
    }

    #inputBox button {
      padding: 3px 5px;
    }
    
    .btn-primary {
    width: 200px;
    background-color: #5F12D3; /* 보라색으로 변경 */
    border-color: #5F12D3; /* 테두리도 보라색으로 변경 */
    white-space: nowrap; /* 텍스트가 한 줄로 표시되도록 설정 */
  	}
    
    .login-button, .signup-button {
        margin-right: 15px;
        margin-left: 15px;
    }
    .verification-input-box {
	  width: 50%; /* 원하는 너비로 조정 */
	  margin: auto; /* 중앙 정렬 */
	}
  </style>

</head>
<body class="text-center">
  
  <!--  html 전체 영역을 지정하는 container -->
  <div id="container">
    <!--  login 폼 영역을 : loginBox -->
    <div id="loginBox" class="col-12">
    
      <!-- 로그인 페이지 타이틀 -->
      <div id="loginBoxTitle">Garge 비밀번호 찾기</div>
      <!-- 아이디, 비번, 버튼 박스 -->
	<div id="inputBox">
		  <div class="input-form-box d-flex justify-content-between align-items-center">
		    <span>아이디</span>
		    <input type="text" name="phone" class="form-control flex-grow-1 me-2" placeholder="아이디 입력">
		  </div>
		</div>
	  <div id="inputBox">
		  <div class="input-form-box d-flex justify-content-between align-items-center">
		    <span>전화번호</span>
		    <input type="text" name="phone" class="form-control flex-grow-1 me-2" placeholder="전화번호 입력">
		    <button type="button" class="btn btn-primary">인증문자 받기</button>
		  </div>
		</div>
	  <div class="input-form-box d-flex justify-content-between align-items-center verification-input-box">
	    <input type="text" name="verification" class="form-control flex-grow-1 me-2" placeholder="인증번호 입력">
	</div>
      <div class="button-login-box" >
          <button type="button" id="joinButton" class="btn btn-primary btn-xs signup-button" style="width:40%">다음</button>
      </div>
      
    </div>
  </div>
  <script>
	  document.getElementById('loginButton').addEventListener('click', function() {
	    window.location.href = 'Main'; 
	  });
	  
	  document.getElementById('joinButton').addEventListener('click', function() {
	    window.location.href = 'Join'; // Change this URL to the path of your join.jsp or the URL mapped by your controller
	  });
	  
	  document.getElementById('joinButton').addEventListener('click', function() {
		    window.location.href = 'Join'; // Change this URL to the path of your join.jsp or the URL mapped by your controller
		  });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</body>
</html>
