<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>Hello2</title>
</head>
<body>
	<h1>Thymeleaf Test Page</h1>
	
	<div class="well">
       <input type="text" id="msg" value="1212" class="form-control" />
       <button id="btnSend" class="btn btn-primary">Send Message</button>
    </div>
	
	
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>	
  
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
$(document).ready(  function() {
	//connectWS();
	//connectSockJS();
	connectStomp();
	
	$('#btnSend').on('click', function(evt) {
        evt.preventDefault();
        if (!isStomp && socket.readyState !== 1) return;
        
        let msg = $('input#msg').val();
        console.log("mmmmmmmmmmmm>>", msg)
        if (isStomp)
        	socket.send('/TTT', {}, JSON.stringify({roomid: 'message', id: 124, msg: msg}));
        else
            socket.send(msg);
    });
});

var socket = null;
var isStomp = false;

function connectStomp() {
	var sock = new SockJS("/stompTest"); // endpoint
    var client = Stomp.over(sock);
	isStomp = true;
	socket = client;
    
    client.connect({}, function () {
        console.log("Connected stompTest!");
        // Controller's MessageMapping, header, message(자유형식)
        client.send('/TTT', {}, "msg: Haha~~~");

        // 해당 토픽을 구독한다!
        client.subscribe('/topic/message', function (event) {
            console.log("!!!!!!!!!!!!event>>", event)
        });
    });

}
</script>
</body>
</html>