<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일(css/default.css) 불러오기 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<style type="text/css">
	/* 채팅방 전체 영역 */
/* 	#chatRoomArea { */
/* 		width: 650px; */
/* 		height: 600px; */
/* 		border: 1px solid black; */
/* 		margin-top: 20px; */
/* 		margin-bottom: 20px; */
/* 		display: inline-block; */
/* 		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */ */
/* 		overflow-y: auto; */
/* 	} */
	
	/* 채팅방 목록 영역 */
	#chatRoomListArea {
		width: 300px;
		height: 600px;
		border: 1px solid black;
		margin-top: 20px;
		margin-bottom: 20px;
		display: inline-block;
		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */
		overflow-y: auto;
	}
	
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
		width: 300px;
		height: 200px;
		border: 1px solid blue;
		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */
		overflow-y: auto;
	}
	
	/* 채팅 메세지 정렬 */
	.message_align_center {
		text-align: center;
	}
	
	.message_align_left {
		text-align: left;
	}
	
	.message_align_right {
		text-align: right;
	}
	
	/* 채팅 메세지 하단 입력 영역 */
	.commandArea {
		width: 300px;
		position: relative;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	$(function() {
		// 채팅 페이지 접속 시 웹소켓 연결 수행(새로고침 시에도 새 웹소켓 연결됨)
		connect();
		
		// 채팅 시작 버튼 클릭
// 		$("#btnJoin").click(function() {
			// 상대방 아이디 미입력 시 오류메세지 출력 및 입력창 포커스
// 			if($("#receiver_id").val() == "") {
// 				alert("상대방 아이디 입력 필수!");
// 				$("#receiver_id").focus();
// 				return;
// 			}
			
			// 상대방과의 채팅방 연결을 위해 startChat() 함수 호출
// 			startChat();			
// 		});
		
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
	let current_user_id;
	
	// 채팅 시작
// 	function startChat() {
		// 채팅 시작을 위한 웹소켓 메세지 전송
		// => 타입(START), 사용자아이디, 상대방아이디, 나머지 2개 널스트링
// 		ws.send(getJsonString("START", current_user_id, $("#receiver_id").val(), "", ""));
// 	}
	
	function connect() {
		current_user_id = "${sessionScope.sId}"; // 사용자 세션 아이디 저장
		
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
		ws.send(getJsonString("INIT", current_user_id, "", "", ""));
		
		ws.send(getJsonString("START", userId, $("#receiverId").val(), "", ""));
	}
	
	// =====================================================================================
	// 서버로부터 메세지 수신(함수 파라미터로 MessageEvent 객체가 전달됨)
	function onMessage(event) {
		console.log(event.data);
		
		// 전달받은 데이터(event.data)가 JSON 타입 문자열이 전달되므로 
		// JSON.parse() 메서드로 JSON 객체 형태로 변환하여 객체 형식으로 접근
		let data = JSON.parse(event.data);
		console.log(data.type + ", " + data.sender_id + ", " + data.receiver_id + ", " + data.room_id + ", " + data.message);

		// 메세지타입 판별(ENTER or LEAVE vs TALK)
		if(data.type == "ENTER" || data.type == "LEAVE") { // 채팅방 입장 & 퇴장
			// 입장&퇴장은 메세지만 출력
// 			appendMessageToTargetRoom(data.room_id, "", data.message);
			appendMessageToTargetRoom(data.room_id, data.sender_id, data.receiver_id, data.message, data.type);
		} else if(data.type == "TALK") { // 대화 메세지 전송
			// 상대방으로부터 채팅 메세지가 수신되었을 때
			// 현재 화면에서 상대방과의 채팅방이 열려있지 않으면 새 채팅방 표시
			if(!$(".chatRoom").hasClass(data.room_id)) {
				// createRoom() 함수 호출하여 채팅방 표시
				// ------------------------------------------------------------------------------
				// 메세지 발신자가 자신의 아이디와 동일할 경우 룸 아이디와 수신자 아이디 전달하고,
				// 아니면, 룸 아이디와 발신자 아이디를 전달
				// (메세지 수신한 사람은 상대방(발신자)이 수신자로 설정되어야 하기 때문)
				if(data.sender_id == current_user_id) {
					createRoom(data.room_id, data.receiver_id);
				} else {
					createRoom(data.room_id, data.sender_id);
				}
				// ------------------------------------------------------------------------------
			}
		
			// 닉네임 : 메세지 형식으로 출력
// 			appendMessageToTargetRoom(data.room_id, data.sender_id, data.message);
			appendMessageToTargetRoom(data.room_id, data.sender_id, data.receiver_id, data.message, data.type);
		} else if(data.type == "START") { // 채팅방 열기
			// 현재 화면에서 상대방과의 채팅방이 열려있지 않으면 새 채팅방 표시
			// => 채팅방(.chatRoom)들의 class 중에 일치하는 room_id 가 없을 경우 채팅방 표시(hasClass() 활용)
			if(!$(".chatRoom").hasClass(data.room_id)) {
				createRoom(data.room_id, data.receiver_id);
			}
			
			appendMessageToTargetRoom(data.room_id, "", data.message);
		} else if(data.type == "REMOVE" && data.sender_id == current_user_id) { // 채팅방 삭제
			// 단, 자신의 아이디와 전송받은 메세제의 sender_id 값이 같을 경우(자신의 채팅방만) 삭제
			$("#chatRoomArea").find("." + data.room_id).remove();
// 			appendMessageToTargetRoom(data.room_id, "", data.message);
			appendMessageToTargetRoom(data.room_id, data.sender_id, data.receiver_id, data.message, data.type);
		} else if(data.type == "LIST") {
			// 채팅방 목록 표시 영역 초기화
			$("#chatRoomListArea").empty();
			// 전달받은 메세지를 JSON 객체로 파싱하여 반복문을 통해 채팅방 목록 생성하여 표시
			// => 파싱 결과는 배열 내의 객체 형식이 되므로 반복문을 통해 객체 접근
			for(let room of JSON.parse(data.message)) {
// 				console.log(room);
				appendChatRoomToRoomList(room.room_id, room.receiver_id);
			}
		} else if(data.type == "LIST_ADD") {
			// 기존 채팅방 목록에 새 채팅방 추가(추가적인 파싱 불필요)
			appendChatRoomToRoomList(data.room_id, data.receiver_id);
		} 
		
	}
	
	// ---------------- 채팅방 목록에 방 추가 ------------------
	function appendChatRoomToRoomList(room_id, receiver_id) {
		let room = '<div class="chatRoomList ' + room_id + '">'
					+ '<div class="chatRoomTitle" ondblclick="createRoom(\'' + room_id + '\', \'' + receiver_id + '\')">' + receiver_id + '님과의 채팅방</div>'
					+ '</div>';
		$("#chatRoomListArea").append(room);
	}
	
	function createRoom(room_id, receiver_id) {
		// AJAX 를 활용하여 room_id 에 해당하는 채팅방의 모든 채팅목록 조회 요청
		$.ajax({
			url: "requestChatList", // ChatController 에서 매핑
			data: {room_id : room_id}, // 룸ID 전달
			dataType: "json", // 리턴데이터타입 JSON
			success: function(chatList) {
// 				console.log(JSON.stringify(chatList));
				
				if(chatList != "") {
					for(let chat of chatList) {
// 						console.log(current_user_id + ", " + chat.sender_id + ", " + chat.receiver_id + ", " + chat.message + ", " + chat.type);
						appendMessageToTargetRoom(room_id, chat.sender_id, chat.receiver_id, chat.message, chat.type);
					}
				}
			}
		});
		
		console.log("채팅방 생성!");
		// 생성할 채팅방의 hidden 태그에 채팅방의 룸ID 값을 value 속성값으로 저장
		// 생성할 채팅방을 묶는 div 태그(".chatRoom")에 룸ID 를 클래스로 추가
// 		let room = '<div class="chatRoom ' + room_id + '">'
// 					+ '	<div class="chatMessageArea"></div>'
// 					+ '	<div class="commandArea">'
// 					+ '		<input type="text" class="chatMsg" onkeypress="checkEnter(this)">'
// 					+ '		<input type="hidden" class="room_id" value="' + room_id + '">'
// 					+ '		<input type="hidden" class="receiver_id" value="' + receiver_id + '">'
// 					+ '		<input type="button" class="btnSend" value="전송" onclick="sendMessage(this)">'
// 					+ '		<input type="button" class="btnQuitRoom" value="대화종료" onclick="quitRoom(this)">'
// 					+ '	</div>'
// 					+ '</div>';
		
// 		$("#chatRoomArea").append(room);
		$(".commandArea").append('<input type="hidden" class="roomId" value="' + roomId + '">');
		$(".commandArea").append('<input type="hidden" class="receiverId" value="' + receiverId + '">');
		console.log(roomId + ", " + receiverId + "들어감");
	}
	
	function appendMessageToTargetRoom(room_id, sender_id, receiver_id, message, type) {
		// 메세지에 포함된 room_id 값과 일치하는 채팅방 찾아서 메세지 표시
		// => 단, sender_id 가 널스트링이면 메세지만 표시하고, 아니면 아이디와 메세지 함께 표시
// 		let chatRoom = $("#chatRoomArea").find("." + room_id);
// 		if(sender_id == "") {
// 			$(chatRoom).find(".chatMessageArea").append(message + "<br>");
// 		} else {
// 			$(chatRoom).find(".chatMessageArea").append(sender_id + " : " + message + "<br>");
// 		}

		let message_div = "";
		
		// 메세지 종류에 따라 정렬 위치 다르게 표시
		if(type != "TALK") { // 시스템 메세지
			// 메세지만 표시
			message_div = '<div class="message message_align_center">- ' + message + ' -</div>';
		} else if(sender_id == current_user_id) { // 자신의 메세지(자신이 발신자일 경우)
			// 메세지만 표시
			message_div = '<div class="message message_align_right">' + message + '</div>';
		} else if(receiver_id == current_user_id) { // 다른 사용자의 메세지(자신이 수신자일 경우)
			// 발신자의 아이디와 메세지를 함께 표시
			message_div = '<div class="message message_align_left">' + sender_id + ' : ' + message + '</div>';
		}
		
		let chatRoom = $("#chatRoomArea").find("." + room_id);
		$(chatRoom).find(".chatMessageArea").append(message_div);
		
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
		// 전송 버튼의 부모가 갖는 자식들 중 클래스 선택자(".room_id") 를 갖는 요소 탐색
		let room_id = $(btnSendParent).find(".room_id").val();
// 		console.log("room_id : " + room_id);

		// 상대방 아이디 가져오기
		// 전송 버튼의 부모가 갖는 자식들 중 클래스 선택자(".receiver_id") 를 갖는 요소 탐색
		let receiver_id = $(btnSendParent).find(".receiver_id").val();
		
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
		ws.send(getJsonString("TALK", current_user_id, receiver_id, room_id, msg));
		
		// 자신의 채팅창에 입력한 메세지 출력
// 		appendMessage(msg); // 자신의 메세지 출력이므로 아이디 출력 불필요(메세지만 출력)
// 		appendMessageToTargetRoom(room_id, "", msg);
		appendMessageToTargetRoom(room_id, current_user_id, receiver_id, msg, "TALK");
		
		// 채팅 입력창 초기화
		$(btnSendParent).find(".chatMsg").val("");
		$(btnSendParent).find(".chatMsg").focus();
	}
	
	// =====================================================================================
	// 전송할 데이터들을 전달받아 JSON 타입의 문자열로 리턴하는 getJsonString() 함수 정의
	// => 파라미터 : 메세지타입, 사용자아이디, 상대방아이디, 방번호, 메세지
	function getJsonString(type, current_user_id, receiver_id, room_id, message) {
		// 전달받은 파라미터들을 하나의 객체로 묶은 후 JSON 타입 문자열로 변환하여 리턴
		let data = {
			type : type,
			sender_id : current_user_id,
			receiver_id : receiver_id,
			room_id : room_id,
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
		let room_id = $(btnSendParent).find(".room_id").val();
		
		ws.send(getJsonString("LEAVE", current_user_id, "", room_id, ""));
	}
	
</script>
</head>
<body>
<!-- 	<article> -->

<!-- 		<h1>채팅 페이지</h1> -->
<!-- 		<hr> -->
<!-- 		상대방 아이디 : <input type="text" id="receiver_id"> -->
<!-- 		<input type="button" value="채팅 시작" id="btnJoin"> -->
<!-- 		<input type="button" value="채팅방 나가기" id="btnQuit"> -->
<!-- 		<hr> -->
<%-- 		<div id="chatRoomArea">채팅방 추가될 위치</div> --%>
<%-- 		<div id="chatRoomListArea">채팅방 목록 추가될 위치</div> --%>
<!-- 	</article> -->

<article>

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
</body>
</html>














