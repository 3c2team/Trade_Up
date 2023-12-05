<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 약관 동의</title>
    <style>
        body {
		    font-family: '나눔고딕', 'Nanum Gothic', sans-serif;
		    color: #6a5acd; /* 은은한 보라색 글씨 */
		    background-color: #fef9ff; /* 밝은 보라색 배경 */
		    margin: 0;
		    padding: 0;
		}

        html, body {
		    height: 100%; /* 부모 요소의 높이를 100%로 설정 */
		    margin: 0;
		    padding: 0;
		    display: flex; /* Flexbox를 사용 */
		    justify-content: center; /* 가로 방향 중앙 정렬 */
		    align-items: center; /* 세로 방향 중앙 정렬 */
		}
		
        h1 {
            color: #6a5acd;
            font-size: 24px;
            margin-bottom: 20px;
        }
		
		.container {
		    width: 40%;
		    padding: 20px;
		    background-color: #fff; /* 배경은 흰색을 유지 */
		    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
		    max-height: 90%;
		    overflow-y: auto;
		}
		
		.terms-container {
		    border: 1px solid #ddd; /* 경계선 색상 변경 고려 */
		    padding: 15px;
		    margin-bottom: 20px;
		    height: 300px;
		    overflow-y: scroll;
		    color: #333333; /* 내부 글씨 색상도 변경 */
		}

        .checkbox {
            margin-bottom: 10px;
        }

        .checkbox label {
            margin-left: 5px;
            font-size: 14px;
            color: #333333;
        }

        .submit-button {
		    background-color: #8a2be2; /* 버튼 색상을 보라색 계열로 변경 */
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    font-size: 16px;
		    cursor: pointer;
		    transition: background-color 0.3s;
		    text-decoration: none; /* 링크 밑줄 제거 */
		}
		
		.submit-button:hover {
		    background-color: #7b68ee; /* 호버 시 색상 변경 */
		    text-decoration: none; /* 호버 시에도 밑줄 없앰 */
		}
    </style>
</head>
<body>
    <div class="container">
        <h1>회원가입 약관 동의</h1>
     	<div class="terms-container">
        	<h2>이용 약관 동의</h2>
			<p>본 약관은 사용자가 본 웹사이트의 서비스를 이용함에 있어 필요한 권리, 의무 및 책임사항, 이용조건 및 절차 등 기본적인 사항을 규정하고 있습니다.</p>

			<h3>제1조 (목적)</h3>
			<p>이 약관은 회사(이하 "회사"라 합니다)가 제공하는 전자상거래 관련 서비스(이하 "서비스"라 합니다)를 이용함에 있어 회사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.</p>
			
			<h3>제2조 (정의)</h3>
			<p>"이용자"란 "회사"의 사이트에 접속하여 이 약관에 따라 "회사"가 제공하는 "서비스"를 받는 회원 및 비회원을 말합니다.</p>
			
			<h3>제3조 (약관의 명시와 개정)</h3>
			<p>"회사"는 이 약관의 내용과 상호, 영업소 소재지 주소, 전화번호, 모사전송번호, 이메일주소, 사업자등록번호, 통신판매업 신고번호, 개인정보보호책임자 등을 이용자가 쉽게 알 수 있도록 "회사"의 초기 서비스화면(전면)에 게시합니다.</p>
			<p>이 약관은 20XX년 XX월 XX일부터 시행합니다.</p>
		</div>
		<div class="checkbox">
		    <input type="checkbox" id="agree-terms"> <label for="agree-terms">이용 약관 동의 (필수)</label><br>
		</div>
		<a href="Join" class="submit-button">회원가입</a>
	</div>

</body>
</html>