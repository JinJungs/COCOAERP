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
                    Hi Euijin how are you?
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
                <!-- onclick="fileSend()" id="fileUpload" -->
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
        <div class="fileTest">
            <input type="file" id="fileUpload">
            <button type="button" onclick="newWSOpen()" id="testBtn">소켓오픈</button>
            <button type="button" id="sendFileBtn">파일올리기테스트</button>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>

<!-------------------------------------- 리스트 불러오기 --------------------------------------->
<script>
    var cpage = 1;

    // 스크롤 아래로 내리기
    function updateScroll() {
        let msgBox = document.getElementById("msgBox");
        msgBox.scrollTop = msgBox.scrollHeight - $(window).height();
        console.log("scorllTop 동작중...scrollHeight: " + msgBox.scrollHeight);
    }

    // 페이지 로딩시 리스트 불러오기
    $(document).ready(function () {
        moreList(cpage);
    })

    // 스크롤이 제일 상단에 닿을 때 다음 cpage의 리스트 불러오기 함수 호출
    $('#msgBox').scroll(function () {
        var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
        var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
        if (scrollT == 0) {
            cpage += 1;
            console.log("새로 리스트 불러오기!" + cpage);
            moreList(cpage);
        }
    });

    // 리스트 더 불러오기
    function moreList(cpage) {
        $.ajax({
            url: "/message/getMessageListByCpage",
            type: "post",
            data: {
                msg_seq: ${seq},
                cpage: cpage
            },
            dataType: "json",
            success: function (data) {
                let newMsgBox = $("<div>");
                for (var i = 0; i < data.length; i++) {
                    var existMsg = "";
                    existMsg += "<div class='d-flex justify-content-end mb-4'>";
                    existMsg += "<div class='msg_cotainer_send'>나 : " + data[i].contents;
                    existMsg += "<span class='msg_time_send'>9:05 AM, Today</span>";
                    existMsg += "</div>";
                    existMsg += "<div class='img_cont_msg'>";
                    existMsg += "<img src='/img/cocoa.png' class='rounded-circle user_img_msg'>";
                    existMsg += "</div></div>";
                    newMsgBox.append(existMsg);
                }
                $("#msgBox").prepend(newMsgBox);
                if (cpage == 1) {
                    updateScroll();
                }
            }
        })
    }

    //<------------------------------------- 웹소켓 --------------------------------------->
    var ws;
    var newWS;

    // 사용자 이름 입력 후 이름 등록 버튼 클릭시 - 웹소켓 OPEN
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
        ws = new WebSocket("ws://" + location.host + "/chatting/" + $("#roomNumber").val());
        wsEvt();
    }

    // 소켓이 열리면 동작
    function wsEvt() {
        ws.onopen = function (data) {
            //소켓이 열리면 초기화 세팅하기
        }

        // 소켓에 메세지를 받으면 동작
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
                updateScroll();
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
        // (1) 웹소켓에 send
        ws.send(JSON.stringify(option))
        // (2) db에 저장
        $.ajax({
            url: "/message/insertMessage",
            type: "post",
            data: {
                contents: $("#yourMsg").val(),
                emp_code: 1001,
                msg_seq: ${seq}
            },
            dataType: "json",
            success: function (resp) {
                if (resp.result = 1) {
                    console.log("메세지 저장 성공!");
                }
            }
        })

        // (3) 채팅입력창 다시 지워주기
        $('#yourMsg').val("");

    }

    //-------------------------------------- 파일 --------------------------------------
    function newWSOpen() {
        newWS = new WebSocket("ws://" + location.host + "/binary/" + $("#roomNumber").val());
        newWSEvt();
    }

    // 소켓이 열리면 동작
    function newWSEvt() {
        newWS.onopen = function (data) {
            //소켓이 열리면 초기화 세팅하기
            fileSend();
        }
        newWS.onmessage = function (e) {
            console.log(e.data);
        };

        $("#sendFileBtn").onclick = function () {
            fileSend();
        }
    }

    // 웹소켓으로 파일 전송
    function fileSend() {
        var file = document.querySelector("#fileUpload").files[0];
        var fileReader = new FileReader();
        //var rawData = new ArrayBuffer();
        //ws.binaryType="arraybuffer";
        var fileName = file.name;
        console.log("파일이름 : " + fileName);
        fileReader.onload = function (e) {
            var param = {
                type: "fileUpload",
                file: file,
                roomNumber: $("#roomNumber").val(),
                sessionId: $("#sessionId").val(),
                msg: $("#yourMsg").val(),
                userName: $("#userName").val()
            }
            ws.send(JSON.stringify(param)); //파일 보내기전 메시지를 보내서 파일을 보냄을 명시한다.
            arrayBuffer = this.result;
            //var dataURL = this.result;
            if(newWS.readyState ===1){
            console.log("readyState?")
            newWS.send(arrayBuffer); //파일 소켓 전송
            alert("파일전송이 완료 되었습니다.");
            }
        };
        fileReader.readAsArrayBuffer(file);
        //fileReader.readAsDataURL(file);
    }

    /*// Blob 를 파일에 저장
    function saveData(blob, fileName) {
        var a = document.createElement("a");
        document.body.appendChild(a);
        a.style = "display: none";

        url = window.URL.createObjectURL(blob);
        a.href = url;
        a.download = fileName;
        a.click();
        window.URL.revokeObjectURL(url);
    };

    // ArrayBuffer 를 파일에 저장
    function saveData2(arrayBuffer, fileName) {
        var a = document.createElement("a");
        document.body.appendChild(a);
        a.style = "display: none";
        var parts = [];
        parts.push(arrayBuffer);
        url = window.URL.createObjectURL(new Blob(parts));
        a.href = url;
        a.download = fileName;
        a.click();
        window.URL.revokeObjectURL(url);
    };*/

    /*    //파일을 Blob를 서버로 전송함
        function sendFileBlob() {
            // Sending file as Blob
            var file = document.querySelector('input[type="file"]').files[0];
            var receiver = $('#receiver').val();
            var msg = {sender:clientId, receiver:receiver};
            msg.fname = file.name;
            //파일 데이터에 앞서 송,수신자, 파일명을 텍스트로 전송한다
            Chat.socket.send(JSON.stringify(msg));
            //파일 데이터를 전송한다
            Chat.socket.send(file);
        }

        //파일을 ArrayBuffer를 서버로 전송함
        function sendFileArrayBuffer() {
            var file = document.querySelector('input[type="file"]').files[0];
            var fileReader = new FileReader();
            fileReader.onload = function() {
                arrayBuffer = this.result;
                Chat.socket.send(arrayBuffer);
            };
            fileReader.readAsArrayBuffer(file);
        }*/


</script>
</body>
</html>