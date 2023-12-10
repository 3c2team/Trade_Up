<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Log in</title>

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
      width: 300px;
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
    
    .login-button, .signup-button {
        margin-right: 15px;
        margin-left: 15px;
    }
  </style>

</head>
<body class="text-center">
  
  <!--  html 전체 영역을 지정하는 container -->
  <div id="container">
    <!--  login 폼 영역을 : loginBox -->
    <div id="loginBox">
    
      <!-- 로그인 페이지 타이틀 -->
      <div id="loginBoxTitle">TRADEUP Login</div>
      <!-- 아이디, 비번, 버튼 박스 -->
      <div id="inputBox">
        <div class="input-form-box"><span>아이디 </span><input type="text" name="uid" class="form-control"></div>
        <div class="input-form-box"><span>비밀번호 </span><input type="password" name="upw" class="form-control"></div>
        <br>
        <div class="button-login-box" >
          <button type="button" id="loginButton" class="btn btn-primary btn-xs login-button" style="width:30%">로그인</button>
          <button type="button" id="joinButton" class="btn btn-primary btn-xs signup-button" style="width:30%">회원가입</button>
        </div>
        <div class="find_password">
            <a href="/forgot-password">아이디 또는 비밀번호를 잊으셨나요?</a>
        </div>
        <br>
        <div class="btn btn-naver btn-xs">
			<a href="https://kauth.kakao.com/oauth/authorize?client_id
					=d860d38c992ca8bf5f07dcc3fd5122b9&redirect_uri=http:
					//localhost:9090/member/auth/kakao/callback&response_type=code" id="kakaoLogin">
	            	KAKAO 로그인
	        </a>
		</div>
		<br>
		<br>
		<div class="btn btn-kakao btn-xs">
			<a href="https://nid.naver.com/oauth2.0/authorize?
					response_type=code
					&client_id=O9St1pC9EAPKQRlsYeWN
					&state=state
					&redirect_uri=http://localhost:8081/c3t2/Naver" id="naverLogin">
            		NAVER 로그인
	        </a>
		</div>
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
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</body>
</html>
