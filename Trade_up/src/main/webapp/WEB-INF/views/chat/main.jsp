<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html style="background: rgba(105, 108, 255, 0.16) !important;">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일(css/default.css) 불러오기 --%>
<%-- <link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css"> --%>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
    rel="stylesheet"
  />
<style type="text/css">
	#chatArea {
		width: 480px;
		height: 300px;
/* 		border: 1px solid rgba(0, 0, 0, 0.45); */
		margin-top: 20px;
		margin-bottom: 20px;
		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */
		overflow-y: auto;
	}
	
	#btnQuit{
	    display: inline-block;
	    font-size: 13px;
	    font-weight: 700;
	    text-transform: uppercase;
	    padding: 5px;
	    color: #ffffff;
	    background: #5F12D3;
	    letter-spacing: 4px;
	}
	
	 #btnSend{
	    display: inline-block;
	    font-size: 13px;
	    font-weight: 700;
	    text-transform: uppercase;
	    padding: 5px;
	    color: #ffffff;
	    background: #5F12D3;
	    letter-spacing: 4px;
	    float: right;
	    
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	nickname = $("#nickname").val();
	let ws_base_url = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
	
	ws = new WebSocket(ws_base_url + "/echo2"); // 웹소켓 요청
	
	ws.onopen = onOpen;
	ws.onmessage = onMessage;
	ws.onclose = onClose;
	ws.onerror = onError;
	
	});


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
		
// 		$("#btnJoin").click(function() {
// 			connect();
// 		});
		
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
		
		// 채팅 페이지 접속 시 초기화 메세지 전송에 필요한 정보 보내기
		// => 메세지타입(INIT), 사용자아이디, 나머지 널스트링
		ws.send(getJsonString("INIT", userId, "", "", ""));
		
		ws.send(getJsonString("START", userId, $("#receiverId").val(), "", ""));
		
		// 채팅방 입장 버튼 비활성화, 채팅방 나가기 버튼 활성화
// 		$("#btnJoin").prop("disabled", true);
// 		$("#btnQuit").prop("disabled", false);
	}
	//=================================================
	// 서버로부터 메세지 수신(함수 파라미터로 MessageEvent 객체가 전달됨) 
// 	function onMessage(event) {
		
		// 전달받은 데이터(event.data)가 JSON 타입 문자열이 전달되므로 
		// JSON.parse() 메서드로 JSON 객체 형태로 변환하여 객체 형식으로 접근
// 		let data = JSON.parse(event.data);
		
		// 메세지타입 판별(ENTER or LEAVE vs TALK)
// 		if(data.type == "ENTER" || data.type == "LEAVE"){
			// 입장&퇴장은 메세지만 출력
// 			appendMessage(data.message);
// 		}else if(data.type == "TALK"){
			// 닉네임 : 메세지 형식으로 출력	
// 			appendMessage(data.nickname + " : " + data.message); //받는 메세지
// 		}
// 	}
	
	//=================================================
	// 서버로부터 메세지 수신(함수 파라미터로 MessageEvent 객체가 전달됨)
	function onMessage(event) {
		console.log("전달받은 메세지 데이터 : " + event.data);
		
		// 전달받은 데이터(event.data)가 JSON 타입 문자열이 전달되므로 
		// JSON.parse() 메서드로 JSON 객체 형태로 변환하여 객체 형식으로 접근
		let data = JSON.parse(event.data);
		console.log(data.type + ", " + data.userId + ", " + data.receiverId + ", " + data.roomId + ", " + data.message);

		// 메세지타입 판별(ENTER or LEAVE vs TALK)
		if(data.type == "ENTER" || data.type == "LEAVE") { // 채팅방 입장 & 퇴장
			// 입장&퇴장은 메세지만 출력
			appendMessageToTargetRoom(data.roomId, "", data.message);
		} else if(data.type == "TALK") { // 대화 메세지 전송
			// 상대방으로부터 채팅 메세지가 수신되었을 때
			// 현재 화면에서 상대방과의 채팅방이 열려있지 않으면 새 채팅방 표시
			if(!$(".chatRoom").hasClass(data.roomId)) {
				createRoom(data.roomId, data.receiverId);
			}
		
			// 닉네임 : 메세지 형식으로 출력
			appendMessageToTargetRoom(data.roomId, data.userId, data.message);
		} else if(data.type == "START") { // 채팅방 열기
			// 현재 화면에서 상대방과의 채팅방이 열려있지 않으면 새 채팅방 표시
			// => 채팅방(.chatRoom)들의 class 중에 일치하는 roomId 가 없을 경우 채팅방 표시(hasClass() 활용)
			if(!$(".chatRoom").hasClass(data.roomId)) {
				createRoom(data.roomId, data.receiverId);
			}
			
			appendMessageToTargetRoom(data.roomId, "", data.message);
		} else if(data.type == "REMOVE" && data.userId == userId) { // 채팅방 삭제
			// 단, 자신의 아이디와 전송받은 메세제의 userId 값이 같을 경우(자신의 채팅방만) 삭제
			$("#chatArea").find("." + data.roomId).remove();
			appendMessageToTargetRoom(data.roomId, "", data.message);
		} 
		
	}
	//=================================================
	function createRoom(roomId, receiverId) {
	// 생성할 채팅방의 hidden 태그에 채팅방의 룸ID 값을 value 속성값으로 저장
	// 생성할 채팅방을 묶는 div 태그(".chatRoom")에 룸ID 를 클래스로 추가
	let room = 
// 				'<div class="chatRoom ' + roomId + '">'
// 				+ '	<div class="chatMessageArea"></div>'
// 				+ '	<div class="commandArea">'
// 				+ '		<input type="text" class="chatMsg" onkeypress="checkEnter(this)">'
				 '		<input type="hidden" class="roomId" value="' + roomId + '">'
				+ '		<input type="hidden" class="receiverId" value="' + receiverId + '">'
// 				+ '		<input type="button" class="btnSend" value="전송" onclick="sendMessage(this)">'
// 				+ '		<input type="button" class="btnQuitRoom" value="대화종료" onclick="quitRoom(this)">'
// 				+ '	</div>'
// 				+ '</div>';
	
	$("#chatArea").append(room);
}	
		
	//=================================================
	function appendMessageToTargetRoom(roomId, userId, message) {
		// 메세지에 포함된 roomId 값과 일치하는 채팅방 찾아서 메세지 표시
		// => 단, userId 가 널스트링이면 메세지만 표시하고, 아니면 아이디와 메세지 함께 표시
		let chatRoom = $("#chatArea").find("." + roomId);
		if(userId == "") {
			$(chatRoom).find(".chatRoom").append(message + "<br>");
		} else {
			$(chatRoom).find(".chatRoom").append(userId + " : " + message + "<br>");
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
// 		$("#chatMessageArea").append(msg + "<br>"); // 메세지 표시
		
		// 채팅 메세지 출력창 스크롤바를 항상 맨 밑으로 유지
		$("#chatArea").scrollTop($("#chatMessageArea").height() - $("#chatArea").height());
		
	}
	
	//=================================================
	// 웹소켓 서버로 메세지를 전송하는 메서드
// 	function sendMessage() {
		
// 		let msg = $("#chatMsg").val();
		
// 		if(msg == ""){
// 			alert("메세지 입력 필수!");
// 			$("#chatMsg").focus();
// 			return;
// 		}
		
		// 웹소켓 객체의 send() 메서드를 호출하여 메세지 전송
		// => 스프링 핸들러의 handlerTextMessage() 메서드가 자동으로 호출 됨
// 		ws.send(getJsonString("TALK", nickname, msg));
		
		//자신의 채팅창에 입력한 메세지 출력 
// 		appendMessage(msg); // 보내는 메세지
		
		// 채팅 입력창 초기화
// 		$("#chatMsg").val("");
// 		$("#chatMsg").focus();
		
// 	}
	//=================================================
		
		// 웹소켓 서버로 메세지를 전송하는 메서드
	function sendMessage(target) {
		// 메세지가 입력된 채팅방 구분
		// 전송 버튼의 부모(<div id="commandArea"></div>) 탐색
		let btnSendParent = $(target).parent(); 
		
		// 입력창의 채팅 메세지 가져오기
		// 전송 버튼의 부모가 갖는 자식들 중 클래스 선택자(".chatMsg") 를 갖는 요소 탐색
		let msg = $(btnSendParent).find(".chatMsg").val();
// 		console.log("msg : " + msg);
		
		// 해당 채팅방의 룸ID 가져오기
		// 전송 버튼의 부모가 갖는 자식들 중 클래스 선택자(".roomId") 를 갖는 요소 탐색
		let roomId = $(btnSendParent).find(".roomId").val();
// 		console.log("roomId : " + roomId);

		// 상대방 아이디 가져오기
		// 전송 버튼의 부모가 갖는 자식들 중 클래스 선택자(".receiverId") 를 갖는 요소 탐색
		let receiverId = $(btnSendParent).find(".receiverId").val();
		
		// 입력된 메세지가 없을 경우 "메세지 입력 필수!" 출력(alert) 후 입력창 포커스 요청
		if(msg == "") {
			alert("메세지 입력 필수!");
			$(btnSendParent).find(".chatMsg").focus();
			return;
		}
		
		// 웹소켓 객체의 send() 메서드를 호출하여 메세지 전송
		// => 스프링 핸들러의 handleTextMessage() 메서드가 자동으로 호출됨
		//    이 때, msg 값이 TextMessage 타입 파라미터로 전달됨
		// => 타입(TALK), 사용자아이디, 상대방아이디, 룸아이디, 메세지
		ws.send(getJsonString("TALK", userId, receiverId, roomId, msg));
		
		// 자신의 채팅창에 입력한 메세지 출력
// 		appendMessage(msg); // 자신의 메세지 출력이므로 아이디 출력 불필요(메세지만 출력)
		appendMessageToTargetRoom(roomId, "", msg);
		
		// 채팅 입력창 초기화
		$(btnSendParent).find(".chatMsg").val("");
		$(btnSendParent).find(".chatMsg").focus();
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
	<article>
		<%-- 본문 표시 영역 --%>
		<c:if test="${empty sessionScope.sId}">
			<script type="text/javascript">
				alert("로그인 후 사용 가능합니다!");
				location.href = "MemberLoginForm";
 			</script> 
		</c:if>
<!-- 		<hr> -->
<%-- 		닉네임 : <input type="text" value="${sessionScope.sId}" id="nickname"> --%>
		판매자 아이디 : <input type="text" id="receiverId" value="${receiverId }"><br>
		<input type="hidden" id="nickname" value="${sessionScope.sId}">
		<span><strong>${sessionScope.sId}</strong>님 반갑습니다.</span>
		<input type="button" value="채팅방 나가기" id="btnQuit" style="float: right;">
		<div id="chatArea" class="chatRoom" style="background: rgba(105, 108, 255, 0.16) !important;">
			<strong><span class="textbox" id="chatMessageArea"></span></strong> <!-- 현재 하나의 span id로 다 받아옴 -->
		</div>
		<hr>
<!-- 		<input type="text" id="chatMsg"> -->
		 	
	</article>
	
    
</body>
</html>














