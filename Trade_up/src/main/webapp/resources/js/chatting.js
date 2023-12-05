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
		
//		let ws_base_url = "ws://localhost:8081/tradeup";
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
	}
	//=================================================
	function onMessage() {
		
	}
	//=================================================
	function onClose() {
		
	}
	//=================================================
	function onError(){
		
	}
	//=================================================
	function appendMessage(){
		
	}
	
	//=================================================
	
	function sendMessage() {
		ws.send("aaaaaaaaaa");
	}
	//=================================================
//	function getJsonString(type, nickname, message){
//		
//	}
	//=================================================
	
	function disconnect(){
		
	}