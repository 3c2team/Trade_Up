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
	/* 채팅방 목록 영역 */
/* 	#chatRoomListArea { */
/* 		width: 300px; */
/* 		height: 600px; */
/* 		border: 1px solid black; */
/* 		margin-top: 20px; */
/* 		margin-bottom: 20px; */
/* 		display: inline-block; */
/* 		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */ */
/* 		overflow-y: auto; */ 	
/* 	} */
	
	.chatRoomTitle {
		font-size: 18px;
		margin-bottom: 10px;
	}
	
	.chatRoomTitle:hover {
		background-color: pink;
	}

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
 	 	width: 370px; */
 		height: 200px;
/*  		border: 1px solid blue;  */
 		/* 지정한 영역 크기 컨텐츠보다 많은 양이 표시될 경우 수직 방향 스크롤바 추가 */ */
 		overflow-y: auto; 
 		background: rgba(105, 108, 255, 0.16) !important;
		margin-bottom: 20px;
		padding:13px;
 	} 


	
	/* 채팅 메세지 */
	.message {
		height: 30px;
	}
	
 	.send_time { 
 		font-size: 10px; 
	} 
	
/* 	.chat_text { */
/* 		font-size: 18px; */
/* 	} */
	
	.message_align_left .chat_text {
/* 		background-color: skyblue; */
		text-align: left;
		position: relative;
	    margin: 5px;
	     background: aliceblue;
	    border-radius: 5px 20px 30px 40px;
	    font-weight:bold;
	    padding: 7px;
/*     	width: fit-content; */
    	margin-bottom:10px;
	}
	
	.message_align_right .chat_text {
/* 		background-color: yellow; */
		text-align: right;
		position: relative;
	    margin: 5px;
	    background: blueviolet;
	    border-radius: 20px 5px 40px 30px;
	    font-weight:bold;
	    padding:7px;
	    margin-bottom:10px;
	}
	
	/* 채팅 메세지 정렬 */
	.message_align_center {
		text-align: center;
	}
	
	.message_align_left {
		text-align: left;
		margin-bottom: 15px;
	}
	
	.message_align_right {
		text-align: right;
		margin-bottom: 15px;
	}
	
	/* 채팅 메세지 하단 입력 영역 */
	.commandArea {
		width: 370px;
		position: relative;
	}
	
	.btnSend {
	    background: #5F12D3;
	    color: #ffffff;
	    border-color: #5F12D3;
/* 	    float: right; */
	}
	
	.btnQuitRoom {
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
	
	.chatUserInfo {
		width: 370px;
		display: inline-block;
		margin-bottom: 10px;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	$(function() {
		// 채팅 페이지 접속 시 웹소켓 연결 수행(새로고침 시에도 새 웹소켓 연결됨)
		connect();
		
		// 채팅 시작 버튼 클릭
		$("#btnJoin").click(function() {
// 			// 상대방 아이디 미입력 시 오류메세지 출력 및 입력창 포커스
// 			if($("#receiver_id").val() == "") {
// 				alert("상대방 아이디 입력 필수!");
// 				$("#receiver_id").focus();
// 				return;
// 			}
			
			// 상대방과의 채팅방 연결을 위해 startChat() 함수 호출
// 			startChat();			
		});
		
		// 채팅방 나가기 버튼 클릭
		$("#btnQuit").click(function() {
// 			disconnect();
			console.log("채팅방 나가기");
			window.close();
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
	function startChat() {
		// 채팅 시작을 위한 웹소켓 메세지 전송
		// => 타입(START), 사용자아이디, 상대방아이디, 나머지 2개 널스트링
		ws.send(getJsonString("START", current_user_id, $("#receiver_id").val(), "", ""));
	}
	
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
		
		ws.send(getJsonString("START", current_user_id, $("#receiver_id").val(), "", ""));
	}
	
	// =====================================================================================
	// 서버로부터 메세지 수신(함수 파라미터로 MessageEvent 객체가 전달됨)
	function onMessage(event) {
		console.log(event.data);
		
		// 전달받은 데이터(event.data)가 JSON 타입 문자열이 전달되므로 
		// JSON.parse() 메서드로 JSON 객체 형태로 변환하여 객체 형식으로 접근
		let data = JSON.parse(event.data);
// 		console.log(data.type + ", " + data.sender_id + ", " + data.receiver_id + ", " + data.room_id + ", " + data.message);
		console.log(JSON.stringify(data));
	
		// 메세지타입 판별(ENTER or LEAVE vs TALK)
		if(data.type == "ENTER" || data.type == "LEAVE") { // 채팅방 입장 & 퇴장
			// 입장&퇴장은 메세지만 출력
// 			appendMessageToTargetRoom(data.room_id, "", data.message);
			appendMessageToTargetRoom(data.room_id, data.sender_id, data.receiver_id, data.message, data.type, data.send_time);
		
			// 상대방이 퇴장한 채팅방 대화창 및 버튼 잠금 처리
			if(data.type == "LEAVE") {
				appendMessageToTargetRoom(data.room_id, data.sender_id, data.receiver_id, "대화가 종료되었습니다", data.type, data.send_time);
				
				// 채팅방 잠금 함수 호출
				lockToFinishChatRoom(data.room_id);
				
				// 단, 자신의 아이디와 전송받은 메세지의 sender_id 값이 같을 경우(자신의 채팅방만) 삭제
				if(data.sender_id == current_user_id) {
					$("#chatRoomArea").find("." + data.room_id).remove(); // 채팅방 삭제
					$("#chatRoomListArea").find("." + data.room_id).remove(); // 목록에서도 삭제
	
					appendMessageToTargetRoom(data.room_id, data.sender_id, data.receiver_id, data.message, data.type, data.send_time);
				}
			}
		} else if(data.type == "TALK") { // 대화 메세지 전송
			// 상대방으로부터 채팅 메세지가 수신되었을 때
			// createRoom() 함수 호출하여 채팅방 표시
			// ------------------------------------------------------------------------------
			// 메세지 발신자가 자신의 아이디와 동일할 경우 룸 아이디와 수신자 아이디 전달하고,
			// 아니면, 룸 아이디와 발신자 아이디를 전달
			// (메세지 수신한 사람은 상대방(발신자)이 수신자로 설정되어야 하기 때문)
			// 또한, 채팅 목록에 해당 채팅방이 없을 경우 표시(목록 추가)
			
			if(data.sender_id == current_user_id) {
				createRoom(data.room_id, data.receiver_id);
				appendChatRoomToRoomList(data.room_id, data.receiver_id);
			} else {
				createRoom(data.room_id, data.sender_id);
				appendChatRoomToRoomList(data.room_id, data.sender_id);
			}
			// ------------------------------------------------------------------------------
			// 닉네임 : 메세지 형식으로 출력
// 			appendMessageToTargetRoom(data.room_id, data.sender_id, data.message);
			appendMessageToTargetRoom(data.room_id, data.sender_id, data.receiver_id, data.message, data.type, data.send_time);
		} else if(data.type == "START") { // 채팅방 열기
			// 현재 화면에서 상대방과의 채팅방이 열려있지 않으면 새 채팅방 표시
			// => 채팅방(.chatRoom)들의 class 중에 일치하는 room_id 가 없을 경우 채팅방 표시(hasClass() 활용)
			createRoom(data.room_id, data.receiver_id);
			appendMessageToTargetRoom(data.room_id, data.sender_id, data.receiver_id, data.message, data.type, data.send_time);
		} else if(data.type == "LIST") {
			// 채팅방 목록 표시 영역 초기화
			$("#chatRoomListArea").empty();
			// 전달받은 메세지를 JSON 객체로 파싱하여 반복문을 통해 채팅방 목록 생성하여 표시
			// => 파싱 결과는 배열 내의 객체 형식이 되므로 반복문을 통해 객체 접근
			for(let room of JSON.parse(data.message)) {
// 				console.log(room);
				appendChatRoomToRoomList(room.room_id, room.receiver_id, room.status);
			}
		} else if(data.type == "LIST_ADD") {
			// 기존 채팅방 목록에 새 채팅방 추가(추가적인 파싱 불필요)
			appendChatRoomToRoomList(data.room_id, data.receiver_id, room.status);
		} 
		
	}
	
	// ---------------- 상대방이 퇴장한 채팅방 잠금 처리 ----------------
	function lockToFinishChatRoom(room_id) {
		let chatRoom = $("#chatRoomArea").find("." + room_id); // 해당 채팅방 찾기
		// 해당 채팅방의 입력창과 전송 버튼 disabled 처리(true 값으로 속성 변경)
		$(chatRoom).find(".chatMsg").prop("disabled", true);
		$(chatRoom).find(".btnSend").prop("disabled", true);
	}
	
	// ---------------- 채팅방 목록에 방 추가 ------------------
	function appendChatRoomToRoomList(room_id, receiver_id, status) {
		// 해당 채팅방 목록이 존재하지 않을 경우에만 목록 추가
		if(!$(".chatRoomList").hasClass(room_id)) {
			let title = receiver_id + "님과의 채팅방";
// 			console.log("status : " + status);
			// 채팅이 종료된 방 표시
			// status 값이 존재할 경우 상대방 아이디를 status 값으로 변경 후 
			// 채팅방 제목 뒤에 (종료) 추가
			if(status) {
				title = status + "님과의 채팅방(종료)";
			}
			
			let room = '<div class="chatRoomList ' + room_id + '">'
						+ '<div class="chatRoomTitle" ondblclick="createRoom(\'' + room_id + '\', \'' + receiver_id + '\')">' + title + '</div>'
						+ '</div>';
			$("#chatRoomListArea").append(room);
			
		}
		
	}
	
	
	function createRoom(room_id, receiver_id) {
		// AJAX 를 활용하여 room_id 에 해당하는 채팅방의 모든 채팅목록 조회 요청
		// => 단, 해당 채팅방이 열려있지 않을 경우에만 작업 요청 및 수행
		// 현재 화면에서 상대방과의 채팅방이 열려있지 않으면 새 채팅방 표시
		if(!$(".chatRoom").hasClass(room_id)) {
			$.ajax({
				url: "requestChatList", // ChatController 에서 매핑
				data: {room_id : room_id}, // 룸ID 전달
				dataType: "json", // 리턴데이터타입 JSON
				success: function(chatList) {
// 					console.log(JSON.stringify(chatList));
					
					
					if(chatList != "") {
						for(let chat of chatList) {
// 							console.log(current_user_id + ", " + chat.sender_id + ", " + chat.receiver_id + ", " + chat.message + ", " + chat.type + ", " + chat.send_time);
							appendMessageToTargetRoom(room_id, chat.sender_id, chat.receiver_id, chat.message, chat.type, chat.send_time);
						}
					}
				}
			});
			
					console.log("채팅방 생성!");
					// 생성할 채팅방의 hidden 태그에 채팅방의 룸ID 값을 value 속성값으로 저장
					// 생성할 채팅방을 묶는 div 태그(".chatRoom")에 룸ID 를 클래스로 추가
					let room = '<div class="chatRoom ' + room_id + '">'
								+ '	<div class="chatMessageArea"></div>'
								+ '	<div class="commandArea">'
								+ '		<input type="text" class="chatMsg" onkeypress="checkEnter(this)">'
								+ '		<input type="hidden" class="room_id" value="' + room_id + '">'
								+ '		<input type="hidden" class="receiver_id" value="' + receiver_id + '">'
								+ '		<input type="button" class="btnSend" value="전송" onclick="sendMessage(this)">'
								+ '		<input type="button" class="btnQuitRoom" value="대화종료" onclick="quitRoom(this)">'
								+ '	</div>'
								+ '</div>';
					
					$("#chatRoomArea").append(room);
			
			
		}
	}
	
	function appendMessageToTargetRoom(room_id, sender_id, receiver_id, message, type, send_time) {
		// 메세지에 포함된 room_id 값과 일치하는 채팅방 찾아서 메세지 표시
		// -------------------------------------------------------------------------------
		// 전달받은 메세지 발신 시각(send_time) 포맷 변경
// 		console.log(send_time);
		
		// 오늘 날짜 가져오기
		let today = new Date();
		// 날짜만 계산해야하므로 모든 시각은 0으로 재설정
		today.setHours(0);
		today.setMinutes(0);
		today.setSeconds(0);
		today.setMilliseconds(0); // 밀리초까지 0으로 조정
// 		console.log("오늘 날짜 : " + today);
		
		// 메세지의 발신 날짜 가져오기(send_time 에서 날짜만 추출)
		// => send_time 을 공백으로 분리하여 첫번째 배열(날짜)만 생성자에 전달
		//    이 때, 대한민국 표준시 기준 0시0분0초 설정을 위해 문자열로 시각 정보 직접 전달
		let send_date = new Date(send_time.split(" ")[0] + " 00:00:00");
// 		console.log("대상 날짜 : " + send_date); // Fri Dec 15 2023 09:00:00 GMT+0900 (한국 표준시)
		
		let print_date = send_time.substring(0, 16); // 초 제거
		console.log(message + print_date);
		
		// 대상 날짜가 오늘인지 판별을 위해 getTime() 메서드를 호출하여 두 값 동등비교
		// yyyy-MM-dd hh:mm:ss
		if(send_date.getTime() == today.getTime()) { // 날짜 및 시각 전체 비교
			// 오늘 전송되는 메세지는 날짜 제거(공백 기준 분리하여 1번 배열 활용)
			print_date = print_date.split(" ")[1];
		} else if(send_date.getFullYear() == today.getFullYear()) { // 연도만 비교
			// 오늘이 아닌 날짜 중에서 올해 전송되는 메세지는 연도 제거
			print_date = print_date.substring(5);
		}
		
		// -------------------------------------------------------------------------------
		let message_div = "";
		let chat_text = "";
		
// 		// 메세지 종류에 따라 정렬 위치 다르게 표시
		if(type != "TALK") { // 시스템 메세지
			// 메세지만 표시
			chat_text = "- " + message  + " -";
			message_div = '<div class="message message_align_center"><span class="chat_text">' + chat_text + '</span></div>';
		} else if(sender_id == current_user_id) { // 자신의 메세지(자신이 발신자일 경우)
			// 메세지만 표시
			chat_text = message;
			message_div = '<div class="message message_align_right"><span class="send_time">' + print_date + '</span><span class="chat_text">' + chat_text + '</span></div>';
		} else if(receiver_id == current_user_id) { // 다른 사용자의 메세지(자신이 수신자일 경우)
			// 발신자의 아이디와 메세지를 함께 표시
			chat_text = sender_id + ' : ' + message;
			message_div = '<div class="message message_align_left"><span class="chat_text">' + chat_text + '</span><span class="send_time">' + print_date + '</span></div>';
		}
		
		let chatRoom = $("#chatRoomArea").find("." + room_id);
		$(chatRoom).find(".chatMessageArea").append(message_div);
		$(chatRoom).scrollTop($(chatRoom).find(".chatMessageArea").height() - $(chatRoom).height());
		// ==================================================================
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
// 		ws.send(getJsonString("LEAVE", nickname, "")); // close() 메서드 호출 전에 수행
		
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
	<article>
		<h3>TRADE-UP CHAT</h3>
		<hr>
		<div class="chatUserInfo">
		판매자 아이디 : ${receiverId }
		<input type="hidden" id="receiver_id" value="${receiverId }"><br>
		<strong>${sessionScope.sId}</strong>님 반갑습니다.
<!-- 		상대방 아이디 : <input type="text" id="receiver_id"> -->
<!-- 		<input type="button" value="채팅 시작" id="btnJoin"> -->
		<input type="button" value="채팅방 나가기" id="btnQuit">
		</div>
		<hr>
		<div id="chatRoomArea"><%-- 채팅방 추가될 위치 --%></div>
<%-- 		<div id="chatRoomListArea">채팅방 목록 추가될 위치</div> --%>
	</article>
	<hr>
</body>
</html>














