<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="/js/app.js"></script>
    <title>Chatting Page</title>
</head>
<body>
<h1>Chatting Page</h1>
<div>
    <input type="button" id="chattinglistbtn" value="채팅 참여자 리스트" onclick="connect()">
    <input type="button" id="outroom" value="채팅방 나가기">
</div>
<br>
<div>
    <textarea id="chatOutput" name="" class="chatting_history" rows="30" cols="70"></textarea>
    <div class="chatting_input">
        <input id="chatInput" type="text" class="chat">&nbsp
        <input type="button" id="sendBtn" value="전송" onclick="sendMessage()">
    </div>
</div>
<input type="hidden" value="admin" id="sessionuserid">
<script
        src="https://code.jquery.com/jquery-3.5.1.js"
        integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
        crossorigin="anonymous"></script>

<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script>

    document.addEventListener("DOMContentLoaded",function (){
        WebSocket.OPEN;
    });

    var msg = $("#chatInput").val();
    var sessionuserid = $("#sessionuserid").val();

    // 연결
    function connect(){
        // SockJS, STOMP관련 객체 생성
        var socket = new SockJS("/websockethandler");
        stompClient = Stomp.over(socket);

        stompClient.connect({},function (){
            stompClient.subscribe("/topic/roomId",function (msg){
                printMessage(JSON.parse(msg).sendMessage + "/" +JSON.parse(msg).senderName);
            })
        })

        stompClient.subscribe("/topic/out",function (msg){
            printMessage(msg);

        })

        stompClient.subscribe("/topic/in",function (msg){
            printMessage(msg);

        })
        // 입장글 //
        stompClient.send("/app/in",{},sessionuserid.value + 'is in chatroom');

        // 연결해제//
        function disconnect(){
            if(stompClient !== null){
                stompClient.send("/app/out",{},sessionuserid.value + 'is in chatroom');
                stompClient.disconnect();
            }
        }

        // 메세지 전송
        function sendMessage(text){
            stompClient.send("/app/hello",{},JSON.stringify({'sendMessage':text,'senderName':sessionuserid.value}));
        }
    }
</script>
</body>
</html>