<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
          integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/css/messenger.css">
</head>
<body>
<div class="chat w-100 p-0 h-100 m-0">
    <div class="card w-100 h-100 p-0 m-0" style="border-radius:2px!important;">
        <div class="card-header msg_head bgMain">
            <div class="d-flex bd-highlight">
                <div class="img_cont">
                    <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
                         class="rounded-circle user_img_msg">
                </div>
                <div class="user_info">
                    <span>정의진</span>
                    <p>개발부 / 개발1팀</p>
                </div>
                <div class="video_cam">
                    <span><i class="fas fa-search"></i></span>
                    <span><i class="fas fa-inbox"></i></span>
                </div>
            </div>
            <span id="action_menu_btn"><i class="fas fa-ellipsis-v"></i></span>
            <div class="action_menu">
                <ul>
                    <li><i class="fas fa-user-circle"></i> View profile</li>
                    <li><i class="fas fa-users"></i> Add to close friends</li>
                    <li><i class="fas fa-plus"></i> Add to group</li>
                    <li><i class="fas fa-ban"></i> Block</li>
                </ul>
            </div>
        </div>
        <div class="card-body msg_card_body" id="msgBox">
            <!--여기 부터가 채팅시작-->
            <input type="hidden" id="sessionId" value="">
            <input type="hidden" id="roomNumber" value="${seq}">
            <div class="d-flex justify-content-start mb-4">
                <div class="img_cont_msg">
                    <img src="https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg"
                         class="rounded-circle user_img_msg">
                </div>
                <div class="msg_cotainer">
                    Hi, how are you samim?
                    <span class="msg_time">8:40 AM, Today</span>
                </div>
            </div>
            <div class="d-flex justify-content-end mb-4">
                <div class="msg_cotainer_send">
                    Hi Khalid i am good tnx how about you?
                    <span class="msg_time_send">8:55 AM, Today</span>
                </div>
                <div class="img_cont_msg">
                    <img src="/img/cocoa.png" class="rounded-circle user_img_msg">
                </div>
            </div>
        </div>
        <div class="card-footer bgMain">
            <div class="input-group m-h-90">
                <div class="input-group-append">
                    <span class="input-group-text attach_btn"><i class="fas fa-paperclip"></i></span>
                </div>
                <textarea name="" class="form-control type_msg" id="yourMsg"
                          placeholder="Type your message..."></textarea>
                <div class="input-group-append" onclick="send()" id="sendBtn">
                    <span class="input-group-text send_btn"><i class="fas fa-location-arrow"></i></span>
                </div>
            </div>
        </div>
        <div id="yourName">
            이름 : <input type="text" name="userName" id="userName" style="width: 330px;
            height: 25px;">
            <button onclick="chatName()" id="startBtn">이름 등록</button>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>

<%------------------------------ 웹소켓 -------------------------------%>
<script>
    var ws;

    // 사용자 이름 입력 후 이름 등록 버튼 클릭시
    function chatName() {
        var userName = $("#userName").val();
        if (userName == null || userName.trim() == "") {
            alert("사용자 이름을 입력해주세요.");
            $("#userName").focus();
        } else {
            wsOpen();
            $("#yourName").hide();
        }
    }

    function wsOpen() {
        ws = new WebSocket("ws://" + location.host + "/chatting/"+$("#roomNumber").val());
        wsEvt();
    }

    // 소켓이 열리면 동작
    function wsEvt() {
        ws.onopen = function (data) {
            //소켓이 열리면 초기화 세팅하기
        }

        // 메세지를 받으면 동작 - 채팅창에 메세지 띄우기
        ws.onmessage = function (data) {
            var msg = data.data;
            var newMsg = "";
            if (msg != null && msg.trim() != '') {
                var d = JSON.parse(msg);
                if (d.type == "getId") {  // 이름을 받았을 때
                    // 삼항연산자 - data에 있는 sessionId가 있다면 si=d.sessionId 없다면 si = ""
                    // sessionId가 있다면(당연히 있겠지) 그 값을 input type hidden에 저장한다.
                    var si = d.sessionId != null ? d.sessionId : "";
                    if (si != '') {
                        $("#sessionId").val(si);
                    }
                } else if (d.type == "message") { // 메세지를 받았을 때
                    if (d.sessionId == $("#sessionId").val()) { // 내가 보낸 메세지 일 때
                        newMsg += "<div class='d-flex justify-content-end mb-4'>";
                        newMsg += "<div class='msg_cotainer_send'>나 : " + d.msg;
                        newMsg += "<span class='msg_time_send'>9:05 AM, Today</span>";
                        newMsg += "</div>";
                        newMsg += "<div class='img_cont_msg'>";
                        newMsg += "<img src='/img/cocoa.png' class='rounded-circle user_img_msg'>";
                        newMsg += "</div></div>";
                    } else { // 상대방이 보낸 메세지 일 때
                        newMsg += "<div class='d-flex justify-content-start mb-4'>";
                        newMsg += "<div class='img_cont_msg'>";
                        newMsg += "<img src='https://static.turbosquid.com/Preview/001292/481/WV/_D.jpg' class='rounded-circle user_img_msg'>";
                        newMsg += "</div>";
                        newMsg += "<div class='msg_cotainer_send'>" + d.userName + " : " + d.msg;
                        newMsg += "<span class='msg_time'>9:00 AM, Today</span>";
                        newMsg += "</div></div>";
                    }
                    $("#msgBox").append(newMsg);
                }
            }
        }

        document.addEventListener("keypress", function (e) {
            if (e.keyCode == 13) { //enter press
                send();
            }
        });
    }

    // 웹소켓으로 메세지를 전송 (이름 : 메세지) 의 형태로
    function send() {
        var option = {
            type: "message",
            roomNumber: $("#roomNumber").val(),
            sessionId: $("#sessionId").val(),
            userName: $("#userName").val(),
            msg: $("#yourMsg").val()
        }
        ws.send(JSON.stringify(option))
        $('#yourMsg').val("");
    }
</script>
</body>
</html>