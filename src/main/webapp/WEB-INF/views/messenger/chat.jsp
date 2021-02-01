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
        <div class="card-header msg_head chatBgMain">
            <div class="d-flex bd-highlight">
                <div class="img_cont">
                    <img src="/img/run.png"
                         class="rounded-circle user_img">
                </div>
                <div class="user_info">
                    <!--여기는 LoginDTO가 아니라 클릭한 사람의 DTO필요-->
                    <span>${partyDTO.empname}</span>
                    <p>${partyDTO.deptname} / ${partyDTO.teamname}</p>
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
            <input type="hidden" id="roomNumber" value="${seq}">
            <input type="hidden" id="loginID" value="${loginDTO.code}">
        </div>
        <div class="card-footer">
            <div class="input-group m-h-90" id="sendToolBox">
                <!-- onclick="fileSend()" id="fileUpload" -->
                <div class="input-group-append">
                    <span class="input-group-text attach_btn"><i class="fas fa-paperclip"></i></span>
                </div>
                <textarea name="" class="form-control type_msg" id="yourMsg"
                          placeholder="Type your message..."></textarea>
                <div class="input-group-append" id="sendBtn">
                    <!-- <div class="input-group-append" onclick="sendMessage" id="sendBtn"> -->
                    <span class="input-group-text send_btn"><i class="fas fa-location-arrow"></i></span>
                </div>
            </div>
        </div>
        <div class="fileTest">
            <input type="file" id="fileUpload">
            <button id="sendFileBtn">파일올리기테스트</button>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
<script
        src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<!-- sockjs, stomp CDN 폼에 넣었기 때문에 필요 없음 /근데 없애면 안됨... 폼 디펜던시 다시 받아봐야할 듯-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- 날짜 변경 라이브러리-->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<!-------------------------------------- 리스트 불러오기 --------------------------------------->
<script>
    let cpage = 1;
    let msgBox = $("#msgBox");
    let loginID = $("#loginID");  //${loginDTO.code}
    let current_date = new Date();
    let lastScrollTop = 0;

    // 처음 채팅방 입장시 스크롤 아래로 내리기
    function scrollBottom() {
        let element = document.getElementById("msgBox");
        $(element).scrollTop(element.scrollHeight);
    }

    // 메세지 추가될 때 스크롤 아래로 내리기
    function scrollUpdate(){
        $('#msgBox')
            .stop()
            .animate({ scrollTop: $('#msgBox')[0].scrollHeight},500);
    }

    // 리스트 더 불러올 때 스크롤 위치조절
    function scrollfixed(addedHeight){
        let element = document.getElementById("msgBox");
        $(element).scrollTop(addedHeight);
    }

    // 스크롤이 제일 상단에 닿을 때 다음 cpage의 리스트 불러오기 함수 호출
    msgBox.scroll(function () {
        var currentScrollTop = $(this).scrollTop(); //스크롤바의 상단위치
        if (currentScrollTop==0) {
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
                m_seq: ${seq},
                cpage: cpage
            },
            dataType: "json",
            success: function (data) {
                // 추가 전 msgBox의 길이를 저장
                let beforeMsgBoxHeight = msgBox.height();
                console.log("추가되기 전 msgBox의 길이 : "+ beforeMsgBoxHeight);
                for (var i = 0; i < data.length; i++) {
                    var existMsg = "";
                    //console.log("시간 : " +moment(data[i].write_date).format('YYYY MM DD HH:mm:ss'))
                    if(data[i].emp_code == ${loginDTO.code}){
                        existMsg += "<div class='d-flex justify-content-end mb-4'>";
                        existMsg += "<div class='msg_cotainer_send'>"+data[i].emp_code+" : "+data[i].contents;
                        existMsg += "<span class='msg_time_send'>"+data[i].write_date+"</span>";
                        existMsg += "</div>";
                        existMsg += "<div class='img_cont_msg'>";
                        existMsg += "<img src='/img/cocoa.png' class='rounded-circle user_img_msg'>";
                        existMsg += "</div></div>";
                    }else{
                        existMsg += "<div class='d-flex justify-content-start mb-4'>";
                        existMsg += "<div class='img_cont_msg'>";
                        existMsg += "<img src='/img/run.png' class='rounded-circle user_img_msg'>";
                        existMsg += "</div>";
                        existMsg += "<div class='msg_cotainer'>"+data[i].emp_code+" : "+data[i].contents;
                        existMsg += "<span class='msg_time'>"+data[i].write_date+"</span>";
                        existMsg += "</div></div>";
                    }
                    msgBox.prepend(existMsg);
                }
                // 추가 후 msgBox의 길이를 저장
                let afterMsgBoxHeight = msgBox.height();
                console.log("추가된 후  msgBox의 길이 : "+ afterMsgBoxHeight);
                let addedHeight = afterMsgBoxHeight - beforeMsgBoxHeight;
                if(cpage==1){
                    scrollBottom();
                    console.log("제일처음 스크롤 이벤트 실행");
                }else{
                    scrollfixed(addedHeight);
                    // 맨아래로 내려가기 버튼도 추가하면 좋겠다.
                }
            }
        })
    }
    //<------------------------------------- STOMP --------------------------------------->

    $(document).ready(function () {
        // 리스트 불러오기
        moreList(cpage);
        connectStomp();
        /* 텍스트 전송 */
        // 전송 버튼 클릭시 메세지 전송
        document.getElementById("sendBtn").addEventListener('click', sendMsg);

        // enter키 클릭시 메세지 전송
        $("#sendToolBox").on("keydown", function (e) {
            if (e.keyCode == 13) {
                if(!e.shiftKey) {
                    sendMsg();
                }
            }
        });

        // 메세지 보내기
        function sendMsg(evt){
            // 의진 - 이거 필요는 한 것 같은데 엔터키할 때 동작을 안해서 일단 주석처리 했습니다.
            //evt.preventDefault();

            // 내용이 없을 경우에 방어코드
            let msg = $("#yourMsg").val();
            if(msg ==''){
                return;
            }

            if (!isStomp && socket.readyState !== 1) return;

            // (1) 메세지 소켓으로 전송
            console.log("mmmmmmmmmmmm>>", msg)
            if (isStomp)
                socket.send('/getChat/text/' +${seq}, {}, JSON.stringify({
                    seq: ''
                    , contents: msg
                    , write_date: new Date()
                    , emp_code: ${loginDTO.code} //!수정필요!세션값 작성자 아이디
                    , m_seq: ${seq}
                }));
            else
                socket.send(msg);

            // (2) db에 저장? / 아니면 컨트롤러에서 처리?
            $.ajax({
                url: "/message/insertMessage",
                type: "post",
                data: {
                    contents: $("#yourMsg").val(),
                    emp_code: ${loginDTO.code},
                    m_seq: ${seq},
                    type: "M"
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

            scrollUpdate();
        };


        /* 파일 전송 sendFileBtn*/
        //파일(링크)전송===================== 미완성/ FilesDTO 정보만 넘기기
        $('#sendFileBtn').on('click', function (evt) {
            evt.preventDefault();
            if (!isStomp && socket.readyState !== 1) return;

            console.log("ffffffffffff>>", file)

            if (isStomp) {
                var file = document.querySelector("#fileUpload").files[0];
                console.log(file);

            } else
                socket.send(file);
        });

        let ws = new WebSocket("ws://localhost/websocket");

        //웹소켓으로 찐파일 전송 /jpg, png등 이미지 송수신 용도로 사용 / STOMP로 한 소켓으로 처리되면 좋은데 가능할지 미지수
        $('#sendFileBtn').on('click', function (evt) {
            var file = document.getElementById('fileUpload').files[0];
            ws.send('filename:' + file.name);
            alert('test');

            var reader = new FileReader();
            var rawData = new ArrayBuffer();

            reader.loadend = function () {

            }

            reader.onload = function (e) {
                rawData = e.target.result;
                ws.send(rawData);
                alert("파일 전송이 완료 되었습니다.")
                ws.send('end');
            }

            reader.readAsArrayBuffer(file);
        });
    });

    var socket = null;
    var isStomp = false;

    //스톰프 연결
    function connectStomp() {
        var sock = new SockJS("/stompTest"); // endpoint
        var client = Stomp.over(sock); //소크로 파이프 연결한 스톰프
        isStomp = true;
        socket = client;

        client.connect({}, function () {
            console.log("Connected stompTest!");
            // 해당 토픽을 구독한다!
            client.subscribe('/topic/' +${seq}, function (e) {
                var newMsg = "";
                var msg = JSON.parse(e.body).contents;
                var sender = JSON.parse(e.body).emp_code;
                // 내가 메세지를 보냈을 때
                if(sender == ${loginDTO.code}){
                    newMsg += "<div class='d-flex justify-content-end mb-4'>";
                    newMsg += "<div class='msg_cotainer_send'>"+sender+" : "+ msg;
                    newMsg += "<span class='msg_time_send'>"+moment(current_date).format('MM-DD HH:mm')+"</span>";
                    newMsg += "</div>";
                    newMsg += "<div class='img_cont_msg'>";
                    newMsg += "<img src='/img/cocoa.png' class='rounded-circle user_img_msg'>";
                    newMsg += "</div></div>";
                    msgBox.append(newMsg);
                }else { // 상대방이 보낸 메세지 일 때
                    newMsg += "<div class='d-flex justify-content-start mb-4'>";
                    newMsg += "<div class='img_cont_msg'>";
                    newMsg += "<img src='/img/run.png' class='rounded-circle user_img_msg'>";
                    newMsg += "</div>";
                    newMsg += "<div class='msg_cotainer'>"+sender+" : "+ msg;
                    newMsg += "<span class='msg_time'>"+moment(current_date).format('MM-DD HH:mm')+"</span>";
                    newMsg += "</div></div>";
                    msgBox.append(newMsg);
                }
            });
        });
    }

</script>
</body>
</html>