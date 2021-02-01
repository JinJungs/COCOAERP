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
            <button onclick="connector()" id="startBtn">이름 등록</button>
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

    let ws = null;

    function connector() {
        ws = new WebSocket("ws://localhost/websocket");
        ws.binaryType = "arraybuffer";
        ws.onopen = function () {
            alert("연결 완료");
        };
        ws.onmessage = function (e) {
            alert(e.msg);
        };
        ws.onclose = function () {
            alert("연결 종료");
        };
        ws.onerror = function (e) {
            alert(e.msg);
        };
    }

    // 1. 메세지 보내기

    // 2. 메세지 받기

    // 3. 파일 보내기

    // 4. 파일 받기

</script>
</body>
</html>