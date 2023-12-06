<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="padding-top: 10px;">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath }/resources/js/chatting.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<style>
* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

a {
    text-decoration: none;
}

.wrap {
    padding: 40px 0;
    background-color: #A8C0D6;
}

.wrap .chat {
    display: flex;
    align-items: flex-start;
    padding: 20px;
}

.wrap .chat .icon {
    position: relative;
    overflow: hidden;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: #eee;
}

.wrap .chat .icon i {
    position: absolute;
    top: 10px;
    left: 50%;
    font-size: 2.5rem;
    color: #aaa;
    transform: translateX(-50%);
}

.wrap .chat .textbox {
    position: relative;
    display: inline-block;
    max-width: calc(100% - 70px);
    padding: 10px;
    margin-top: 7px;
    font-size: 13px;
    border-radius: 10px;
}

.wrap .chat .textbox::before {
    position: absolute;
    display: block;
    top: 0;
    font-size: 1.5rem;
}

.wrap .ch1 .textbox {
    margin-left: 20px;
    background-color: #ddd;
}

.wrap .ch1 .textbox::before {
    left: -15px;
    content: "◀";
    color: #ddd;
}

.wrap .ch2 {
    flex-direction: row-reverse;
}

.wrap .ch2 .textbox {
    margin-right: 20px;
    background-color: #F9EB54;
}

.wrap .ch2 .textbox::before {
    right: -15px;
    content: "▶";
    color: #F9EB54;
}
</style>
</head>
<body>
<h3>채팅방 자리</h3>
아이디:
	<input type="text" id="chatId" value="${ sessionScope.sId }" readonly />
	<button id="closeBtn" onclick="disconnect();">채팅 종료</button>
    <div class="wrap">
        <div class="chat ch1">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="textbox">안녕하세요. 반갑습니다.</div>
        </div>
        <div class="chat ch2">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="textbox">네 안녕하세요. </div>
        </div>
        <div class="chat ch1">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="textbox">네고 되나요?</div>
        </div>
        <div class="chat ch2">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="textbox">아니요(단호)</div>
        </div>
    </div>
    <div>
<!-- 		<input type="text" id="chatMessage" style="margin-left: 25px;" onkeyup="enterKey();"> -->
<!-- 		<button id="sendBtn" onclick="sendMessage();">전송</button> -->
		<input type="text" id="chatMsg">
		<input type="button" value="전송" id="btnSend">
<!-- 		<button id="sendBtn" onclick="sendMessage();">전송</button> -->
	</div>
</body>
</html>