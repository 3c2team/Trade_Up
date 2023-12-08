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
			startChat();			
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
	function startChat() {
		// 채팅 시작을 위한 웹소켓 메세지 전송
		// => 타입(START), 사용자아이디, 상대방아이디, 나머지 2개 널스트링
		ws.send(getJsonString("START", userId, $("#receiverId").val(), "", ""));
	}
	
	function connect() {
		userId = "${sessionScope.sId}"; // 사용자 세션 아이디 저장
		
		let ws_base_url = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
		// => 주의! contextPath 의 경우 "/mvc_board" 형식으로 리턴되므로 문자열 결합 시 / 사용 안함!
		
		ws = new WebSocket(ws_base_url + "/echo2"); // 웹소켓 요청(Handshake)
		// => 스프링 WebSocketHandler 구현체의 afterConnectionEstablished() 메서드 자동 호출됨
		
		// 웹소켓 객체의 onxxx 이벤트에 각 함수 연결
		ws.onopen = onOpen; // 웹소켓 요청에 대한 연결 성공 시
		ws.onmessage = onMessage; // 웹소켓 서버로부터 메세지 수신 시
		ws.onclose = onClose; // 웹소켓 요청 종료 시
		ws.onerror = onError; // 웹소켓 처리 과정 오류 발생 시
// 		debugger;
	}
	
	// =====================================================================================
	// 웹소켓 연결 완료 시 자동으로 호출되는 메서드
	function onOpen(event) {
// 		appendMessage("onOpen");
		
		// 채팅 페이지 접속 시 초기화 메세지 전송에 필요한 정보 보내기
		// => 메세지타입(INIT), 사용자아이디, 나머지 널스트링
		ws.send(getJsonString("INIT", userId, "", "", ""));
	}
	
	// =====================================================================================
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
			$("#chatRoomArea").find("." + data.roomId).remove();
			appendMessageToTargetRoom(data.roomId, "", data.message);
		} 
		
	}
	
	function createRoom(roomId, receiverId) {
		// 생성할 채팅방의 hidden 태그에 채팅방의 룸ID 값을 value 속성값으로 저장
		// 생성할 채팅방을 묶는 div 태그(".chatRoom")에 룸ID 를 클래스로 추가
		let room = '<div class="chatRoom ' + roomId + '">'
					+ '	<div class="chatMessageArea"></div>'
					+ '	<div class="commandArea">'
					+ '		<input type="text" class="chatMsg" onkeypress="checkEnter(this)">'
					+ '		<input type="hidden" class="roomId" value="' + roomId + '">'
					+ '		<input type="hidden" class="receiverId" value="' + receiverId + '">'
					+ '		<input type="button" class="btnSend" value="전송" onclick="sendMessage(this)">'
					+ '		<input type="button" class="btnQuitRoom" value="대화종료" onclick="quitRoom(this)">'
					+ '	</div>'
					+ '</div>';
		
		$("#chatRoomArea").append(room);
	}
	
	function appendMessageToTargetRoom(roomId, userId, message) {
		// 메세지에 포함된 roomId 값과 일치하는 채팅방 찾아서 메세지 표시
		// => 단, userId 가 널스트링이면 메세지만 표시하고, 아니면 아이디와 메세지 함께 표시
		let chatRoom = $("#chatRoomArea").find("." + roomId);
		if(userId == "") {
			$(chatRoom).find(".chatMessageArea").append(message + "<br>");
		} else {
			$(chatRoom).find(".chatMessageArea").append(userId + " : " + message + "<br>");
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
	}