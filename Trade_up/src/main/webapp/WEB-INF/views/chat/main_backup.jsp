<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일(css/default.css) 불러오기 --%>
<%-- <link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css"> --%>
<style type="text/css">
	#chatArea {
		width: 300px;
		height: 200px;
		border: 1px solid rgba(0, 0, 0, 0.45);
		margin-top: 20px;
		margin-bottom: 20px;
		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */
		overflow-y: auto;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/chatting.js"></script> --%>
<script type="text/javascript">
	$(function() {
		// 채팅 입력창 키 누를때마다 이벤트 처리
		// => 엔터키 입력 시(keyCode 값이 '13') 메세지 전송 기능 동작
		$("#chatMsg").keypress(function(event) {
			// 누른 키의 코드값 가져오기
			let keyCode = event.keyCode;
			
			if(keyCode == '13') {
				sendMessage();
			}
		});
		
		$("#btnSend").click(function() {
			sendMessage();
		});
		
		$("#btnJoin").click(function() {
			connect();
		});
		
		$("#btnQuit").click(function() {
			disconnect();
		});
		
		// 채팅방 입장 버튼 활성화, 채팅방 나가기 버튼 비활성화
		$("#btnJoin").prop("disabled", false);
		$("#btnQuit").prop("disabled", true);
		
	});
	// -------------------------------------------------
	let ws;
	let nickname;
	
	function connect() {
		nickname = $("#nickname").val();
		
	//	let ws_base_url = "ws://localhost:8081/tradeup";
		let ws_base_url = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
		
		ws = new WebSocket(ws_base_url + "/echo"); // 웹소켓 요청
		
		ws.onopen = onOpen;
		ws.onmessage = onMessage;
		ws.onclose = onClose;
		ws.onerror = onError;
	}
	//=================================================
	// 웹소켓 연결 완료 시 자동으로 호출되는 메서드
	function onOpen(event) {
		appendMessage("채팅방에 입장하였습니다.");
		
		// 입장 메세지 전송에 필요한 정보 보내기(메세지타입 : ENTER, 닉네임, 메세지 불필요)
		ws.send(getJsonString("ENTER", nickname, ""));
		
		// 채팅방 입장 버튼 비활성화, 채팅방 나가기 버튼 활성화
		$("#btnJoin").prop("disabled", true);
		$("#btnQuit").prop("disabled", false);
	}
	//=================================================
	// 서버로부터 메세지 수신(함수 파라미터로 MessageEvent 객체가 전달됨) 
	function onMessage(event) {
		
		// 전달받은 데이터(event.data)가 JSON 타입 문자열이 전달되므로 
		// JSON.parse() 메서드로 JSON 객체 형태로 변환하여 객체 형식으로 접근
		let data = JSON.parse(event.data);
		
		// 메세지타입 판별(ENTER or LEAVE vs TALK)
		if(data.type == "ENTER" || data.type == "LEAVE"){
			// 입장&퇴장은 메세지만 출력
			appendMessage(data.message);
		}else if(data.type == "TALK"){
			// 닉네임 : 메세지 형식으로 출력	
			appendMessage(data.nickname + " : " + data.message);
		}
	}
	//=================================================
	// 웹소켓 연결이 종료되면 자동으로 호출되는 메서드
	function onClose(event) {
		appendMessage("채팅을 종료 합니다.");
		
		// 채팅방 입장 버튼 활성화, 채팅방 나가기 버튼 비활성화
		$("#btnJoin").prop("disabled", false);
		$("#btnQuit").prop("disabled", true);
		
	}
	//=================================================
	// 웹소켓 에러 발생 시 자동으로 호출되는 메서드
	function onError(event){
		appendMessage("onError");
		console.log(event);
	}
	
	
	
	
	
	//=================================================
	// 자신의 채팅창에 메세지를 표시(추가)하는 appendMessage() 함수 정의
	// => 파라미터 : 출력할 메세지(msg)
	function appendMessage(msg){
		$("#chatMessageArea").append(msg + "<br>");
		
		// 채팅 메세지 출력창 스크롤바를 항상 맨 밑으로 유지
		$("#chatArea").scrollTop($("#chatMessageArea").height() - $("#chatArea").height());
		
	}
	
	//=================================================
	// 웹소켓 서버로 메세지를 전송하는 메서드
	function sendMessage() {
		
		let msg = $("#chatMsg").val();
		
		if(msg == ""){
			alert("메세지 입력 필수!");
			$("#chatMsg").focus();
			return;
		}
		
		// 웹소켓 객체의 send() 메서드를 호출하여 메세지 전송
		// => 스프링 핸들러의 handlerTextMessage() 메서드가 자동으로 호출 됨
		ws.send(getJsonString("TALK", nickname, msg));
		
		//자신의 채팅창에 입력한 메세지 출력 
		appendMessage(msg);
		
		// 채팅 입력창 초기화
		$("#chatMsg").val("");
		$("#chatMsg").focus();
		
	}
	
	//=================================================
	
	// 전송할 데이터들을 전달받아 JSON 타입의 문자열로 리턴하는 getJsonString() 함수 정의
	// => 파라미터 : 메세지타입, 닉네임, 메세지
	function getJsonString(type, nickname, message){
		
		// 전달받은 파라미터들을 하나의 객체로 묶은 후 JSON 타입 문자열로 변환하여 리턴 
		let data = {
			type : type,
			nickname : nickname,
			message : message
		};
		
		// JSON.stringify() 메세더를 통해 객체 -> JSON 문자열로 변환
		return JSON.stringify(data);
	}
	//=================================================
	
	// 접속 종료를 요청하는 메서드
	function disconnect(){
		
		// 퇴장 메세지 전송에 필요한 정보 보내기(메세지타입 : LEAVE, 닉네임, 메세지 불필요)
		ws.send(getJsonString("LEAVE", nickname, "")); // close() 메서드 호출 전에 수행
		
		// 웹소켓 객체의 close() 메서드 호출하여 소켓 연결 종료
		ws.close(); // 소켓 연결 종료 시 onClose() 함수 자동 호출됨
		
		
	}

</script>

</head>
<body>
	<header>
		<%-- Login, Join 등의 링크 표시 메뉴 영역 --%>
		<%-- 주의! JSP 파일은 WEB-INF/views 디렉토리 내에 위치 --%>
<%-- 		<jsp:include page="../inc/top.jsp"></jsp:include> --%>
	</header>
	<article>
		<%-- 본문 표시 영역 --%>
		<c:if test="${empty sessionScope.sId}">
			<script type="text/javascript">
				alert("로그인 후 사용 가능합니다!");
				location.href = "MemberLoginForm";
 			</script> 
		</c:if>
		<h1>채팅 페이지</h1>
		<hr>
		닉네임 : <input type="text" value="${sessionScope.sId}" id="nickname">
<!-- 		<input type="button" value="채팅방 입장" id="btnJoin" onclick="openChat()"> -->
		<input type="button" value="채팅방 입장" id="btnJoin">
		<input type="button" value="채팅방 나가기" id="btnQuit">
		<hr>
		<div id="chatArea">
			<span id="chatMessageArea"></span>
		</div>
		<input type="text" id="chatMsg">
		<input type="button" value="전송" id="btnSend">
	</article>
	<hr>
	<footer>
		<!-- bottom.jsp 페이지를 현재 페이지에 삽입 -->
<%-- 		<jsp:include page="../inc/bottom.jsp"></jsp:include> --%>
	</footer>
	<script type="text/javascript">
        	function openChat() {
        		window.open("MyChat", "MyChat","top=200,left=700,width=500, height=500");
			}
    </script>
    
</body>
</html>














