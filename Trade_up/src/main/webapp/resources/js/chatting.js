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
		
	});
	// -------------------------------------------------
	let ws;
	
	function connect() {
		let ws_base_url = "ws://localhost:8081/tradeup";
		
		ws = new WebSocket(ws_base_url + "/echo"); // 웹소켓 요청
		ws.onopen = onOpen();
		ws.onmessage = onMessage();
		ws.onclose = onClose();
	}
	
	function onOpen() {
		
	}
	
	function onClose() {
		
	}
	
	function onMessage() {
		
	}
	
	function sendMessage() {
		ws.send("aaaaaaaaaa");
	}