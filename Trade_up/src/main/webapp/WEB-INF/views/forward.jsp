<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	//요청 작업 성공/실패 시 
	// 전달받은 오류메세지(msg)를 출력하고, 지정된 페이지(targetURL)로 이동 처리
	alert("${msg}");
	if("${isClose}" == "true") { // 주의! true 형식으로 지정 시 문자열이 존재하기만 하면 무조건 true
		window.close();
		location.href = "${targetURL}";
	} else {
		location.href = "${targetURL}";
	}
</script>
</body>
</html>