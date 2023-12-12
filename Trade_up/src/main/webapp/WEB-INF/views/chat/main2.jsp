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
<style type="text/css">
	/* 채팅방 전체 영역 */
/* 	#chatRoomArea { */
/* 		width: 1024px; */
/* 		height: 600px; */
/* 		border: 1px solid black; */
/* 		margin-top: 20px; */
/* 		margin-bottom: 20px; */
/* 		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */ */
/* 		overflow-y: auto; */
/* 	} */
	
	/* 채팅방 1개 */
	.chatRoom {
		/* 각 채팅방은 옆으로 나란히 배열 */
/* 		border: 1px solid black; */
		display: inline-block;
		margin-right: 10px;
		margin-bottom: 20px;
	}
	
	/* 채팅 메세지 표시 영역 */
	.chatMessageArea {
		width: 485px;
		height: 200px;
/* 		border: 1px solid blue; */
		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */
		overflow-y: auto;
		background: rgba(105, 108, 255, 0.16) !important;
	}
	
	/* 채팅 메세지 하단 입력 영역 */
	.commandArea {
		width: 500px;
		position: relative;
	}
	
	.btnSend {
	    background: #5F12D3;
	    color: #ffffff;
	    border-color: #5F12D3;
	    float: right;
	}
	
	#btnQuit{
		background: #5F12D3;
	    color: #ffffff;
	    border-color: #5F12D3;
	    float: right;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	$(function() {
		// 채팅 페이지 접속 시 웹소켓 연결 수행(새로고침 시에도 새 웹소켓 연결됨)
		connect();
		
		// 채팅 시작 버튼 클릭
		$("#btnJoin").click(function() {
			// 상대방 아이디 미입력 시 오류메세지 출력 및 입력창 포커스
// 			if($("#receiverId").val() == "") {
// 				alert("상대방 아이디 입력 필수!");
// 				$("#receiverId").focus();
// 				return;
// 			}
			
			// 상대방과의 채팅방 연결을 위해 startChat() 함수 호출
// 			startChat();			
		});
		
		// 채팅방 나가기 버튼 클릭
		$("#btnQuit").click(function() {
			disconnect();
		});
		
	});
	
	function checkEnter(target) {
		// 누른 키의 코드값 가져오기
		let keyCode = event.keyCode;
		
		if(keyCode == '13') {
			sendMessage(target);
		}
	}
	
	// -------------------------------------------------
	let ws;
	let userId;
	
	// 채팅 시작
// 	function startChat() {
		// 채팅 시작을 위한 웹소켓 메세지 전송
		// => 타입(START), 사용자아이디, 상대방아이디, 나머지 2개 널스트링
// 		ws.send(getJsonString("START", userId, $("#receiverId").val(), "", ""));
// 	}
	
	function connect() {
		userId= "${sessionScope.sId}"; // 사용자 세션 아이디 저장
		
		let ws_base_url = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
		// => 주의! contextPath 의 경우 "/mvc_board" 형식으로 리턴되므로 문자열 결합 시 / 사용 안함!
		
		ws = new WebSocket(ws_base_url + "/echo2"); // 웹소켓 요청(Handshake)
		// => 스프링 WebSocketHandler 구현체의 afterConnectionEstablished() 메서드 자동 호출됨
		
		// 웹소켓 객체의 onxxx 이벤트에 각 함수 연결
		ws.onopen = onOpen; // 웹소켓 요청에 대한 연결 성공 시
		ws.onmessage = onMessage; // 웹소켓 서버로부터 메세지 수신 시
		ws.onclose = onClose; // 웹소켓 요청 종료 시
		ws.onerror = onError; // 웹소켓 처리 과정 오류 발생 시
	}
	
	// =====================================================================================
	// 웹소켓 연결 완료 시 자동으로 호출되는 메서드
	function onOpen(event) {
// 		appendMessage("onOpen");
		
		// 채팅 페이지 접속 시 초기화 메세지 전송에 필요한 정보 보내기
		// => 메세지타입(INIT), 사용자아이디, 나머지 널스트링
		ws.send(getJsonString("INIT", userId, "", "", ""));
		
		ws.send(getJsonString("START", userId, $("#receiverId").val(), "", ""));
	}
	
	// =====================================================================================
	// 서버로부터 메세지 수신(함수 파라미터로 MessageEvent 객체가 전달됨)
	function onMessage(event) {
		console.log("전달받은 메세지 데이터 : " + event.data);
		
		// 전달받은 데이터(event.data)가 JSON 타입 문자열이 전달되므로 
		// JSON.parse() 메서드로 JSON 객체 형태로 변환하여 객체 형식으로 접근
		let data = JSON.parse(event.data);
		console.log("[onMessage] ==> " + data.type + ", " + data.userId + ", " + data.receiverId + ", " + data.roomId + ", " + data.message);

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
			console.log("여기는 왔니?");
			// 닉네임 : 메세지 형식으로 출력
			appendMessageToTargetRoom(data.roomId, data.userId, data.message);
			console.log("[onMessage - TALK이후] ==> " + data.type + ", " + data.userId + ", " + data.receiverId + ", " + data.roomId + ", " + data.message);
		} else if(data.type == "START") { // 채팅방 열기
			// 현재 화면에서 상대방과의 채팅방이 열려있지 않으면 새 채팅방 표시
			// => 채팅방(.chatRoom)들의 class 중에 일치하는 roomId 가 없을 경우 채팅방 표시(hasClass() 활용)
			if(!$(".chatRoom").hasClass(data.roomId)) {
				createRoom(data.roomId, data.receiverId);
			}
			
			appendMessageToTargetRoom(data.roomId, "", data.message);
		} else if(data.type == "REMOVE" && data.userId == userId) { // 채팅방 삭제
			// 단, 자신의 아이디와 전송받은 메세제의 userId 값이 같을 경우(자신의 채팅방만) 삭제
			$("#chatRoomArea").find("." + data.roomId).remove();
			appendMessageToTargetRoom(data.roomId, "", data.message);
		} 
		
	}
	
	function createRoom(roomId, receiverId) {
		// 생성할 채팅방의 hidden 태그에 채팅방의 룸ID 값을 value 속성값으로 저장
		// 생성할 채팅방을 묶는 div 태그(".chatRoom")에 룸ID 를 클래스로 추가
// 		let room = 
// 				'<div class="chatRoom ' + roomId + '">'
// 					+ '	<div class="chatMessageArea"></div>'
// 					+ '	<div class="commandArea">'
// 					+ '		<input type="text" class="chatMsg" onkeypress="checkEnter(this)">'
// 					+ '		<input type="hidden" class="roomId" value="' + roomId + '">'
// 					+ '     <input type="hidden" class="receiverId" value="' + receiverId + '">'
// 					+ '		<input type="button" class="btnSend" value="전송" onclick="sendMessage(this)">'
// 					+ '		<input type="button" class="btnQuitRoom" value="대화종료" onclick="quitRoom(this)">'
// 					+ '	</div>'
// 					+ '</div>';
		
// 		$("#chatRoomArea").append(room);
		$(".commandArea").append('<input type="hidden" class="roomId" value="' + roomId + '">');
		$(".commandArea").append('<input type="hidden" class="receiverId" value="' + receiverId + '">');
		console.log(roomId + ", " + receiverId + "들어감");
	}
	
	function appendMessageToTargetRoom(roomId, userId, message) {
		// 메세지에 포함된 roomId 값과 일치하는 채팅방 찾아서 메세지 표시
		// => 단, userId 가 널스트링이면 메세지만 표시하고, 아니면 아이디와 메세지 함께 표시
		let chatRoom = $("#chatRoomArea").find("." + roomId);
		console.log("[appendMessageToTargetRoom]=>> " + roomId + ", " + userId +", " + message);
		if(userId == "") {
			console.log("여기 옴??");
// 			$(chatRoom).find(".chatMessageArea").append(message + "<br>");
			$(".chatMessageArea").append(message + "<br>");
			console.log("여기 옴2??" + message);
		} else {
// 			$(chatRoom).find(".chatMessageArea").append(userId + " : " + message + "<br>");
			console.log("받은 메세지 옴?");
			$(".chatMessageArea").append(userId + " : " + message + "<br>");
			console.log("받은 메세지 옴?222");
		}
	}

	// =====================================================================================
	// 웹소켓 연결이 종료되면 자동으로 호출되는 메서드
	function onClose(event) {
// 		appendMessage("onClose");
		appendMessage("채팅을 종료합니다.");
		
		// 채팅방 입장 버튼 활성화, 채팅방 나가기 버튼 비활성화
		$("#btnJoin").prop("disabled", false);
		$("#btnQuit").prop("disabled", true);
	}
	
	// =====================================================================================
	// 웹소켓 에러 발생 시 자동으로 호출되는 메서드
	function onError(event) {
		appendMessage("onError");
		console.log(event);
	}
	
	// =====================================================================================
	// 자신의 채팅창에 메세지를 표시(추가)하는 appendMessage() 함수 정의
	// => 파라미터 : 출력할 메세지(msg)
	function appendMessage(msg) {
// 		$(".chatMessageArea").append(msg + "<br>");
		
		
		// 채팅 메세지 출력창 스크롤바를 항상 맨 밑으로 유지
		$(".chatRoom").scrollTop($(".chatMessageArea").height() - $(".chatRoom").height());
	}
	
	// =====================================================================================
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
	
	// =====================================================================================
	// 전송할 데이터들을 전달받아 JSON 타입의 문자열로 리턴하는 getJsonString() 함수 정의
	// => 파라미터 : 메세지타입, 사용자아이디, 상대방아이디, 방번호, 메세지
	function getJsonString(type, userId, receiverId, roomId, message) {
		// 전달받은 파라미터들을 하나의 객체로 묶은 후 JSON 타입 문자열로 변환하여 리턴
		let data = {
			type : type,
			userId : userId,
			receiverId : receiverId,
			roomId : roomId,
			message : message
		};
		
		// JSON.stringify() 메서드를 통해 객체 -> JSON 문자열로 변환
		return JSON.stringify(data);
	}
	
	// =====================================================================================
	// 채팅 페이지를 빠져나가는 함수
	function disconnect() {
// 		appendMessage("disconnect")

		// 퇴장 메세지 전송에 필요한 정보 보내기(메세지타입 : LEAVE, 닉네임, 메세지 불필요)
		ws.send(getJsonString("LEAVE", nickname, "")); // close() 메서드 호출 전에 수행
		
		// 웹소켓 객체의 close() 메서드 호출하여 소켓 연결 종료
		ws.close(); // 소켓 연결 종료 시 onClose() 함수 자동 호출됨
	}
	
	// 1개 채팅방 채팅을 종료하는 함수
	function quitRoom(target) {
		let btnSendParent = $(target).parent(); 
		let roomId = $(btnSendParent).find(".roomId").val();
		
		ws.send(getJsonString("LEAVE", userId, "", roomId, ""));
		window.close();
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
		<h1>채팅 페이지(상품 문의 1:1)</h1>
		<hr>
		판매자 아이디 : ${receiverId }
		<input type="hidden" id="receiverId" value="${receiverId }"><br>
		<strong>${sessionScope.sId}</strong>님 반갑습니다.
<%-- 		<input type="hidden" id="receiverId" value="${receiverId }"> --%>
<!-- 		<input type="button" value="채팅 시작" id="btnJoin"> -->
		<input type="button" value="채팅방 나가기" id="btnQuit" onclick="quitRoom(this)">
		<hr>
		<div id="chatRoomArea">
			<%-- 채팅방 추가될 위치 --%>
			<div class="chatRoom">
				<div class="chatMessageArea"></div>
				<div class="commandArea">
					<input type="text" size="57" class="chatMsg" onkeypress="checkEnter(this)">
<!-- 					<textarea rows="2" cols="40"class="chatMsg" onkeypress="checkEnter(this)"></textarea> -->
					<input type="button" class="btnSend" value="전송" onclick="sendMessage(this)">
<!-- 					<input type="button" class="btnQuitRoom" value="대화종료" > -->
				</div>
			</div>
		</div>
	</article>
	<hr>
	<footer>
		<!-- bottom.jsp 페이지를 현재 페이지에 삽입 -->
<%-- 		<jsp:include page="../inc/bottom.jsp"></jsp:include> --%>
	</footer>
</body>
</html>














