<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<form>
<input type="hidden" name="fromPopup" id="fromPopup">
</form>
<div class="chat w-100 p-0 h-100 m-0">
    <div class="card w-100 h-100 p-0 m-0" style="border-radius:2px!important;">
        <div class="card-header msg_head chatBgMain" style="min-height: 90px;">
            <div class="d-flex bd-highlight justify-content-between">
                <div class="m-0 p-0 d-flex">
                    <div class="img_cont_chat">
                        <c:choose>
                            <c:when test="${messenger.type eq 'M'}">
                                <img src="${chatProfile}"
                                     class="rounded-circle user_img_chat">
                            </c:when>
                            <c:otherwise>
                                <img src="${partyDTO.profile}"
                                     class="rounded-circle user_img_chat">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="user_info">
                        <c:choose>
                            <c:when test="${messenger.type eq 'M'}">
                                <span id="partyname">${messenger.name}</span>
                                <p></p>
                            </c:when>
                            <c:when test="${messenger.type eq 'S'}">
                                <!--여기는 LoginDTO가 아니라 클릭한 사람의 DTO필요-->
                                <span id="partyname">${partyDTO.empname}</span>
                                <p>${partyDTO.deptname} | ${partyDTO.teamname}</p>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
                <div class="video_cam d-flex justify-content-end ml-0">
                    <span><i class="fas fa-search m-2"></i></span>
                    <span><i class="fas fa-inbox m-2" id="showFiles"></i></span>
                    <span class="mr-1" id="action_menu_btn"><i class="fas fa-ellipsis-v"></i></span>
                    <div class="action_menu">
                        <ul>
                            <li><i class="fas fa-user-circle"></i> 프로필 보기</li>
                            <li onclick="openMemberListToChat(${seq})"><i class="fas fa-plus"></i> 멤버 추가</li>
                            <c:if test="${messenger.type eq 'M'}">
                                <li data-toggle="modal" data-target="#modalModifChat"><i class="fas fa-users"></i> 채팅방 설정</li>
                                <li onclick="exitRoom(${seq})"><i class="fas fa-ban"></i> 나가기</li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- 검색 창-->
        <div class="searchCon">
            <div class="row w-100 m-0 p-0" id="searchContainer" style="display: none;">
                <div class="d-flex bd-highlight w-100">
                    <input class="flex-grow-1 bd-highlight searchInput mr-2" id="searchContents" type="text" placeholder="검색 내용을 입력해주세요.">
                    <%--<div class="p-1" style="position: absolute; left: 280px; top:90px;"><i class="fas fa-chevron-up"></i>
                    </div>
                    <div class="p-1" style="position: absolute; left: 300px; top:90px;"><i class="fas fa-chevron-down"></i>
                    </div>--%>
                    <button type="button" class="bd-highlight btn btn-secondary btn-sm" id="searchBtn">검색</button>
                    <i class="fas fa-times ml-2 bd-highlight" style="line-height: 30px;"></i>
                </div>
            </div>
        </div>
        <div class="card-body msg_card_body" id="msg_card_body">
            <div id="msgBox">
                <!--여기 부터가 채팅시작-->
                <input type="hidden" id="roomNumber" value="${seq}">
                <input type="hidden" id="loginID" value="${loginDTO.code}">
            </div>
        </div>
        <!-- 새로운 메세지 도착시 알려줌 -->
        <div class="w-100 p-0 m-0" id="alertMessageBox">
            <div class="d-flex bd-hightlight m-2 p-0">
                <div class="bd-hightlight p-2" id="alertMessagePartyname"></div>
                <div class="bd-hightligh p-2" id="alertMessageContents"></div>
                <div class="bd-hightlight ml-auto p-2"><i class="fas fa-chevron-down"></i></div>
            </div>
        </div>
        <div class="card-footer">
            <div class="m-h-90 d-flex flex-column bd-highlight" id="sendToolBox">
                <textarea name="" class="bd-highlight form-control type_msg" id="yourMsg" placeholder="메세지를 입력하세요."></textarea>
                <div class="d-flex bd-highlight m-0 p-0">
                    <button class="btn chat_btn" id="emoji_btn">
                        <img class="chat_icon" src="/icon/emoji-smile.svg">
                    </button>
                    <button class="btn chat_btn" id="attach_btn">
                        <img class="chat_icon" src="/icon/paperclip_rotate.svg">
                    </button>
                    <button class="btn btn_send chat_btn ml-auto" id="send_btn">
                        <img src="/icon/send.svg">
                    </button>
                </div>
            </div>
        </div>
        <div class="fileBox">
            <form id="mainForm" enctype="multipart/form-data">
                <!-- accept=".gif, .jpg, .png" 등 나중에 조건 추가해주기 -->
                <input type="file" id="file" name=file>
            </form>
        </div>
    </div>
</div>

<!-- 채팅방 이름 바꾸기 모달 -->
<div class="modal fade" id="modalModifChat" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">채팅방 설정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      채팅방 이름 : <br>
      <input type="text" id="modifName" value="${messenger.name}" placeholder="채팅방 이름을 설정해주세요.">
      <div id="msg"></div>
      </div>
      <div class="modal-footer">
        <button type="button" id="modifClose" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="modifSave" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<!-- 채팅방 이름 바꾸기 모달 -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<!-- sockjs, stomp CDN 폼에 넣었기 때문에 필요 없음 /근데 없애면 안됨... 폼 디펜던시 다시 받아봐야할 듯-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- 날짜 변경 라이브러리-->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<!-------------------------------------- 리스트 불러오기 --------------------------------------->
<script>
    let cpage = 1;
    let msgBox = $("#msgBox");
    let loginID = $("#loginID").val();  //${loginDTO.code}
    let m_seq = $("#roomNumber").val();
    let partyname = $("#partyname").html();
    let lastScrollTop = 0;
    let before_date = "";
    let socket_before_date = "";
    let addedHeight = 0;
    let searchContents = "";
    let before_searchContents = "";

    /* 텍스트 전송 */
    // 전송 버튼 클릭시 메세지 전송
    document.getElementById("send_btn").addEventListener('click', sendMsg);
    /* 파일 전송 */
    document.getElementById("file").addEventListener('change', uploadMsgFile);
    /* 파일 모아보기 창 띄우기 */
    document.getElementById("showFiles").addEventListener("click", popShowFiles);
    /* 채팅방 이름변경 (모달창의 확인버튼) */
    document.getElementById("modifSave").addEventListener("click", modifChatName);

    // enter키 클릭시 메세지 전송
    $("#sendToolBox").on("keydown", function (e) {
        if (e.keyCode == 13 && !e.shiftKey) {
            sendMsg();
        }
    });
    // esc 누르면 창닫기
    $(document).keydown(function (e) {
        if (e.keyCode == 27 || e.which == 27) {
            window.close();
        }
    });
    // input type=file 대신 파일첨부 이모티콘을 눌렀을 때 파일선택 기능 실행하기
    $("#attach_btn").click(()=>{
        $("#file").click();
    });

    // 리스트 더 불러오기
    function moreList(cpage) {
        return new Promise((resolve,reject)=>{
            $.ajax({
                url: "/message/getMessageListByCpage",
                type: "post",
                data: {
                    m_seq: ${seq},
                    cpage: cpage
                },
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                success: function (data) {
                    // 추가 전 msgBox의 길이를 저장
                    let beforeMsgBoxHeight = msgBox.height();
                    for (let i = 0; i < data.length; i++) {
                        let existMsg = "";
                        // 날짜 형식 변경하기
                        let formed_write_date = moment(data[i].write_date).format('HH:mm');
                        let dividing_date = moment(data[i].write_date).format('YYYY년 M월 D일');
                        //공지타입 구분
                        let typeArr = (data[i].type).split("_");
                        // 이전날짜와 오늘의 날짜가 다를 때만 날짜 구분 div를 보여줘야한다.
                        if(data[i].emp_code == ${loginDTO.code} && typeArr[0]!="AN") {
                            existMsg += "<div class='d-flex justify-content-end mb-4' id='msgDiv" + data[i].seq + "'>";
                            existMsg += msgForm(data[i].type, "msg_cotainer_send", "msg_container" + data[i].seq, data[i].contents, data[i].savedname);
                            existMsg += "<span class='msg_time_send'>" + formed_write_date + "</span>";
                            existMsg += "</div>";
                            existMsg += "<div class='img_cont_msg'>";
                            existMsg += "<img src='${loginDTO.profile}' class='rounded-circle user_img_msg'>";
                            existMsg += "</div></div>";
                        } else if(typeArr[0]!="AN"){
                            existMsg += "<div class='d-flex justify-content-start mb-4' id='msgDiv" + data[i].seq + "'>";
                            existMsg += "<div class='img_cont_msg'>";
                            existMsg += "<img src='"+data[i].profile+"' class='rounded-circle user_img_msg'>";
                            existMsg += "</div>";
                            // 상대방 이름 추가
                            existMsg += "<div class='msg_cotainer_wrap'>"
                            existMsg += "<div class='ml-2 pb-1'>"+data[i].empname+"</div>"
                            existMsg += msgForm(data[i].type, "msg_cotainer", "msg_container" + data[i].seq, data[i].contents, data[i].savedname);
                            existMsg += "<span class='msg_time'>" + formed_write_date + "</span>";
                            existMsg += "</div></div></div>";
                        }else{
                            existMsg += "<div class='announce text-center font-weight-light'><small>";
                            if(typeArr[1]=="MODIF"){
                                existMsg += data[i].empname + "님이 " + data[i].contents +" (으)로 채팅방 이름을 변경하였습니다.";
                            }else if(typeArr[1]=="EXIT"){
                                existMsg += data[i].contents + "님이 퇴장하였습니다.";
                            }else if(typeArr[1]=="ADD"){
                                existMsg += data[i].empname + "님이 "+ data[i].contents + " 님을 채팅방에 초대하셨습니다.";
                            }else{
                                existMsg += "공지 메세지 등록 오류";
                            }
                            existMsg += "</small></div>";
                        }
                        if (before_date !== dividing_date && before_date !== "") {
                            existMsg += "<div class='msg_date_divider w-100 text-center m-0 pb-4 pt-3'>"
                            existMsg += "<span>" +before_date+ "</span></div>"
                        }
                        before_date = dividing_date;
                        msgBox.prepend(existMsg);
                    }

                    // 추가 후 msgBox의 길이를 저장
                    let afterMsgBoxHeight = msgBox.height();
                    addedHeight = afterMsgBoxHeight - beforeMsgBoxHeight;
                    // Promise로 전달
                    resolve(addedHeight);
                }
            })
        })
    }

    //<------------------------------------- STOMP --------------------------------------->

    $(document).ready(function () {
        // 스톰프 연결
        connectStomp();
        // 채팅입력창에 포커스
        $("#yourMsg").focus();
        // 리스트 불러오기
        moreList(cpage).then(scrollBottom);
    });

    let socket = null;
    let isStomp = false;

    // 메세지 보내기
    function sendMsg(evt) {
        let msg = $("#yourMsg").val();
        // 미입력 또는 공백 입력 방지
        if (msg.replace(/\s|　/gi, "").length == 0) {
            $("#yourMsg").focus();
            return;
        }

        if (!isStomp && socket.readyState !== 1) return;

        // (1) 메세지 소켓으로 전송
        if (isStomp)
            socket.send('/getChat/text/' +${seq}, {}, JSON.stringify({
                seq: ''
                , contents: msg
                , write_date: new Date()
                , emp_code: ${loginDTO.code}
                , m_seq: ${seq}
                , type: "TEXT"
                , empname: "${loginDTO.name}"
                , profile: "${loginDTO.profile}"
            }));
        else
            socket.send(msg);

        // (2) db에 저장
        $.ajax({
            url: "/message/insertMessage",
            type: "post",
            data: {
                contents: $("#yourMsg").val(),
                emp_code: ${loginDTO.code},
                m_seq: ${seq},
                type: "TEXT"
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
        setTimeout(()=>{
            let msgLinebreak = $('#yourMsg').val().replace(/\n/g, ""); //엔터제거
            $('#yourMsg').val(msgLinebreak);
        },50);
    };

    //스톰프 연결
    function connectStomp() {
        var sock = new SockJS("/stompTest"); // endpoint
        var client = Stomp.over(sock); //소크로 파이프 연결한 스톰프
        isStomp = true;
        socket = client;

        client.connect({}, function () {
            // 해당 토픽을 구독한다!
            client.subscribe('/topic/' +${seq}, function (e) {
                let newMsg = "";
                let element = document.getElementById("msg_card_body");
                let msg = JSON.parse(e.body).contents;
                let sender = JSON.parse(e.body).emp_code;
                //파일 관련 메세지 구분 위해 타입추가*****
                let type = JSON.parse(e.body).type;
                let savedname = JSON.parse(e.body).savedname;
                let empname = JSON.parse(e.body).empname;
                let profile = JSON.parse(e.body).profile;
                let roomname = JSON.parse(e.body).roomname;

                // 날짜 형식 변경하기
                let current_date = new Date();
                let formed_write_date = moment(current_date).format('HH:mm');
                let dividing_date = moment(current_date).format('YYYY년 M월 D일');
                // 오늘 처음 쓰는 메세지일 때 날짜 구분을 한다.
                // 즉, 리스트에서 제일 처음에 뿌리는 메세지의 write_date와 비교해서 다를 때만 날짜구분을 한다.
                // 소켓에서 전달한 메세지와도 비교해서 다를 때 날짜 구분을 한다.
                if(socket_before_date !== dividing_date && socket_before_date !== "") {
                    newMsg += "<div class='msg_date_divider w-100 text-center m-0 pb-4 pt-3'>";
                    newMsg += "<span>" +dividing_date+ "</span></div>";
                }
                socket_before_date = dividing_date;

                //공지일 때
                let typeArr = type.split("_")

                // 채팅방 이름 변경시
                if(roomname){
                    $("#partyname").html(roomname);
                }

                // 내가 메세지를 보냈을 때
                if (sender == ${loginDTO.code} && typeArr[0]!="AN") {
                    newMsg += "<div class='d-flex justify-content-end mb-4'>";
                    newMsg += msgForm(type, "msg_cotainer_send", null, msg, savedname);
                    newMsg += "<span class='msg_time_send'>" + formed_write_date + "</span>";
                    newMsg += "</div>";
                    newMsg += "<div class='img_cont_msg'>";
                    newMsg += "<img src='"+profile+"' class='rounded-circle user_img_msg'>";
                    newMsg += "</div></div>";
                    msgBox.append(newMsg);
                    scrollUpdate();
                } else if(typeArr[0]!="AN") { // 상대방이 보낸 메세지 일 때
                    // 나의 스크롤이 제일 하단에 있는지를 변수에 미리 저장
                    let amIAtBottom = (msgBox.height() <= $(element).height() + $(element).scrollTop());
                    newMsg += "<div class='d-flex justify-content-start mb-4'>";
                    newMsg += "<div class='img_cont_msg'>";
                    newMsg += "<img src='"+profile+"' class='rounded-circle user_img_msg'>";
                    newMsg += "</div>";
                    // 상대방 이름 추가
                    newMsg += "<div>"
                    newMsg += "<div class='ml-2 pb-1'>"+ empname +"</div>"
                    newMsg += msgForm(type, "msg_cotainer", null, msg, savedname);
                    newMsg += "<span class='msg_time'>" + formed_write_date + "</span>";
                    newMsg += "</div></div></div>";
                    msgBox.append(newMsg);
                    // 나의 스크롤이 제일 하단에 있는지를 확인하고 아니라면 메세지 알림을 하단에 띄워줌
                    if (amIAtBottom) {
                        scrollUpdate();
                    } else {
                        showAlertMessageOnBottom(empname, msg);
                    }
                }else{
                    newMsg += "<div class='announce text-center font-weight-light'><small>";
                    newMsg += msg;
                    newMsg += "</small></div>";
                    msgBox.append(newMsg);
                    scrollUpdate();
                }
            });
        });
    }

    // alertMessgaeBox를 클릭하면 스크롤 하단 이동 + 다시 display none
    document.getElementById("alertMessageBox").addEventListener("click", scrollUpdate);
    document.getElementById("alertMessageBox").addEventListener("click", hideAlertMessageBox);

    // alertMessgaeBox를 toggle
    function showAlertMessageBox() {
        $("#alertMessageBox").delay(1000).show();
    }

    function hideAlertMessageBox() {
        $("#alertMessageBox").delay(1000).hide();
    }

    // 스크롤이 상단에 있을 때 상대방의 메세지를 div로 띄워줌(alertMessgaeBox)
    function showAlertMessageOnBottom(name, msg) {
        showAlertMessageBox();
        // 글자 초과시 말줄임 표시로 바꾸기
        let length = 15; // 표시할 글자수 기준
        if (msg.length > length) {
            msg = msg.substr(0, length-2) + '...';
        }
        $("#alertMessagePartyname").html(name);
        $("#alertMessageContents").html(msg);
    }

    // <--------------------------------- 스크롤 이벤트 --------------------------------->
    // 처음 채팅방 입장시 스크롤 아래로 내리기
    function scrollBottom() {
        let element = document.getElementById("msg_card_body");
        $(element).scrollTop(element.scrollHeight);
    }

    // 리스트 더 불러올 때 스크롤 위치조절
    function scrollfixed(addedHeight) {
        $("#msg_card_body").scrollTop(addedHeight);
    }

    // 메세지 추가될 때 스크롤 아래로 내리기
    function scrollUpdate() {
        $('#msg_card_body')
            .stop()
            .animate({scrollTop: $('#msg_card_body')[0].scrollHeight}, 500);
    }

    // 스크롤이 제일 상단에 닿을 때 다음 cpage의 리스트 불러오기 함수 호출
    // 스크롤이 제일 하단에 닿을 때 hideAlertMessageBox
    $("#msg_card_body").scroll(function () {
        let currentScrollTop = $(this).scrollTop(); //스크롤바의 상단위치
        let amIAtBottom = (msgBox.height() <= $(this).height() + $(this).scrollTop());
        if (currentScrollTop == 0) {
            cpage += 1;
            moreList(cpage).then(scrollfixed);
        }
        if (amIAtBottom){
            hideAlertMessageBox();
        }
    });

    //***************************************************************************
    /* 파일 전송 */
    function uploadMsgFile(evt) {
        evt.preventDefault();
        if (!isStomp && socket.readyState !== 1) return;

        if (isStomp) {
            event.preventDefault();
            var resultF = 0;
            var savedName = "";
            //00. 파일 선택
            var fileInfo = document.querySelector("#file").files[0]; //form 안의 input type=file의 아이디
            var mainForm = $("#mainForm")[0]; //form의 아이디
            //멀티타입 파일
            var formData = new FormData(mainForm);

            //f1. ajax로 파일 전송(RestMessengerController)
            $.ajax({
                url: "/restMessenger/uploadFile",
                type: "post",
                enctype: 'multipart/form-data',
                data: formData,
                contentType: false,
                processData: false,
                success: function (resp) {
                    result = JSON.parse(resp);
                    resultF = parseInt(result.resultF);
                    //파일 저장에 성공했을 경우
                    //**(보완)따로 예쁘게 빼는 법 용국씨것 참고하기**
                    if (parseInt(result.resultF) > 0) {
                        //타입 구하기 (fileType 함수 이용)
                        var type = fileType(fileInfo.name);
                        //02. 메세지 전송 : contents = 파일 원본 이름으로 보낸다.
                        socket.send('/getChat/fileMessage/' +${seq}, {}, JSON.stringify({
                            seq: result.msg_seq
                            , contents: fileInfo.name
                            , write_date: new Date()
                            , emp_code: ${loginDTO.code}
                            , m_seq: ${seq}
                            , type: type
                            , savedname: result.savedname
                            , empname: "${loginDTO.name}"
                            , profile: "${loginDTO.profile}"
                        }));
                    }
                }
            });
            scrollUpdate();
        } else//이건 왜하는거람
            socket.send(file);
    };

    //=======모듈 함수들===============================================
    //[타입별 내용부분 태그]
    function msgForm(type, classname, idname, msg, savedname) {
        let result;
        let msgOriname = encodeURIComponent(msg);
        savedname = encodeURIComponent(savedname);
        if (type == "FILE") {
            result = "<div class='" + classname + "'><a href='/files/downloadMessengerFile.files?savedname=" + savedname + "&oriname=" + msgOriname + "'><p class='m-0 p-0' id='" + idname + "'>" + msg + "</p></a>";
        } else if (type == "IMAGE") {
            result = "<div class='" + classname + "'><img class='msgImg' src='/messengerFile/" + savedname + "' onclick='click_img(this.src)' width='150' height='150' style='object-fit:cover;'>"
            			+"<div><a href='/files/downloadMessengerFile.files?savedname=" + savedname + "&oriname=" + msgOriname + "'><img class='svg_download' src='/icon/download.svg'></a></div>";
        } else {
            result = "<div class='" + classname + "'><p class='m-0 p-0' id='" + idname + "'>" + msg + "</p>";
        }
        return result;
    }
    
    //이미지 클릭시 팝업
    function click_img(src){
    	window.open(src,'src','width=700,height=500,left=500, top=50, resizable=yes');
    }

    //[파일 받기용 함수] 타입구하기******
    function fileType(filename) {
        //01. 파일 확장자 구하고 소문자로 변환
        let type;
        var _fileLen = filename.length;
        var _lastDot = filename.lastIndexOf('.');
        var _fileExt = filename.substring(_lastDot, _fileLen).toLowerCase();
        if (_fileExt == ".png" || _fileExt == ".jpg" || _fileExt == ".bmp" || _fileExt == ".gif" || _fileExt == ".tiff" || _fileExt == ".jpeg") {
            type = "IMAGE";
        } else {
            type = "FILE";
        }
        return type;
    }

    //[파일 모아보기 팝업]
    let winFeature = 'width=600px,height=660px,location=no,toolbar=no,menubar=no,resizable=no,fullscreen=yes';
    let winFeature2 = 'width=450px,height=660px,location=no,toolbar=no,menubar=no,resizable=no,fullscreen=yes';

    function popShowFiles() {
        window.open('/messenger/showFiles?m_seq=' +${seq}, 'showFiles'+${seq}, winFeature);
    }

    //***************************************************************************
    /* 메세지 검색 */
    /* 0. search 아이콘 클릭시 input 창 생성*/
    $(".fa-search").on("click", showSearchInput);
    $(".fa-times").on("click", () => {
        deHighlightBeforeSearch();
        showSearchInput();
        searchContents = "";
        before_searchContents = "";
    });

    function showSearchInput() {
        $("#searchContainer").toggle(200);
        $("#searchContents").focus();
    }

    // 하이라이트
    let highlightArr = [];
    function highlightSearch(seq) {
        return new Promise((resolve, reject) => {
            let beforeText = document.getElementById("msg_container" + seq).innerHTML;
            let re = new RegExp(searchContents, "g"); // search for all instances
            let newText = beforeText.replace(re, "<mark>" + searchContents + "</mark>");
            document.getElementById("msg_container" + seq).innerHTML = newText;
            highlightArr.push([seq, searchContents, newText]);
            resolve(seq);
        })
    }

    // 검색어가 바뀌면 하이라이트된 내용을 원상복구
    function deHighlightBeforeSearch() {
        if(!highlightArr){return;}
        for (let i = 0; i < highlightArr.length; i++) {
            let goback = new RegExp("<mark>" + highlightArr[i][1] + "</mark>", "g");
            let gobackText = highlightArr[i][2].replace(goback, highlightArr[i][1]);
            document.getElementById("msg_container" + highlightArr[i][0]).innerHTML = gobackText;
        }
        // 초기화
        highlightArr = [];
        searchArr = [];
    }

    // 띠용
    function animateMessage(seq) {
        $("#msgDiv"+seq).animate({
            animation: 'motion 0.3s linear 0s 4 alternate',
        }, 100);
    }

    // 원하는 Div의 위치로 이동하기 (element의 id나 class만 알면된다)
    function scrollMoveToSearch(seq) {
        return new Promise((resolve, reject) => {
            let element = document.getElementById("msg_card_body");
            let location = document.querySelector("#msgDiv" + seq).offsetTop;
            element.scrollTo({top: location - 300, behavior: 'smooth'});
            resolve(seq);
        })
    }

    /* 1.1. 비동기로 메세지 검색*/
    $("#searchBtn").on("click", searchOrFindNext);
    // 1.2. enter키 클릭시 메세지 검색 -> 한번만 그렇고 내용이 바뀔 때 엔터 이벤트가 실행되어야한다.
    $("#searchContents").on("keydown", function (e) {
        if (e.keyCode == 13) {
            searchOrFindNext();
        }
    });

    function searchOrFindNext(){
        searchContents = $("#searchContents").val();
        // 미입력 또는 공백 입력 방지
        if (searchContents.replace(/\s|　/gi, "").length == 0) {
            return;
        }
        // 처음 검색하거나 검색어가 바뀌었을 때 deHighlightBeforeSearch
        if(searchContents!==before_searchContents || (!searchContents && !before_searchContents)){
            deHighlightBeforeSearch(); // 전에 하이라이트 된 내용을 다시 원상복구
            searchInChatRoom(); // 검색결과가 없을 때 isMsgExistInCpage도 실행할 필요없음
        }
        setTimeout(() => {
            isMsgExistInCpage();
        },100);
    }
    let searchArr = []
    function isMsgExistInCpage(){
        if (!searchArr.length){
            return;
        }else{
            let seq = searchArr[0];
            // 해당 seq의 div가 존재하면 seq를 resolve한다.
            if($("#msgDiv"+seq).length){
                scrollMoveToSearch(seq)
                    .then(highlightSearch)
                    .then(delFromSearchArr);
                // 해당 seq의 div가 존재하지 않으면 moreList 후 다시 isMsgExisInCpage호출
            }else{
                cpage +=1;
                moreList(cpage)
                    .then(isMsgExistInCpage);
            }
        }
    };
    function delFromSearchArr(){
        searchArr.splice(0,1); // 0번원소부터 1개를 삭제한다.
    }
    // 검색
    function searchInChatRoom() {
        $.ajax({
            url: "/message/searchMsgInChatRoom",
            type: "post",
            data: {
                m_seq: m_seq,
                contents: searchContents
            },
            dataType: "json",
            success: function (resp) {
                // 검색결과가 하나도 없을 때
                if (resp.length == 0) {
                    alert("검색결과가 없습니다.");
                    return;
                    // 검색결과가 하나라도 있을 때
                } else {
                    searchArr = resp;
                }
                before_searchContents = searchContents;
            }
        });
    }


  //==========채팅방 이름변경==================
    function modifChatName(){
       //(seq,name,emp_code)
       let seq = ${seq};
       let name = document.getElementById("modifName").value;
       let emp_code = ${loginDTO.code};
       let empname = "${loginDTO.name}";
       if(name==""){
          alert("빈 값은 입력할 수 없습니다.");
          return;
       }
       $.ajax({
           url: "/messenger/modifChatName",
           type: "post",
            data: {
               seq: seq
               , name: name
            },
            dataType: "json",
            success: function (resp) {
               if(resp>0){
                  socket.send('/getChat/announce/' +${seq}, {}, JSON.stringify({
                       m_seq: seq
                        , contents: name
                        , write_date: new Date()
                        , emp_code: emp_code
                        , empname: empname
                        , type: "AN_MODIF"
                    }));
                  $('#partyname').text(name);
                  $('#modalModifChat').modal('hide');
               }
            }
        });
    }
   //==========채팅방 이름변경==================

   //==========채팅방 나가기==================
    function exitRoom(){
      let seq = ${seq};
      let code = ${loginDTO.code};
      let empname = "${loginDTO.name}";
      //let contents = ${loginDTO.name}+"("+ ${loginDTO.deptname}+"/"+${loginDTO.teamname}+")";
        let contents = "${loginDTO.name}(${loginDTO.deptname}/${loginDTO.teamname})";
       let exit = confirm("정말 나가시겠습니까?");
       if(exit==true){
    	   socket.send('/getChat/announce/' +${seq}, {}, JSON.stringify({
               m_seq: seq
                , contents: empname
                , write_date: new Date()
                , emp_code: code
                , empname: empname
                , type: "AN_EXIT"
            }));
    	   opener.location.reload();
    	   //부모창 리로드해주고 머물던 항목에 있었으면 좋겠는데...
    	   window.open('chat'+seq,'_self').close();
       }else{
    	   return;
       }
    }
    //==========채팅방 나가기==================
    //====================채팅 멤버 추가=======
    function openMemberListToChat(seq) {
        window.open('/messenger/openMemberList?seq=' + seq, 'memberList'+seq, winFeature2);
    }
    function getReturnValue(returnValue) {
       let seq = ${seq};
       let emp_code = ${loginDTO.code};
       let checkArr = returnValue;
       let empname = "${loginDTO.name}";

       //길이 알아내기 위해
        let checkArrParsed = JSON.parse(returnValue);
       //!!!!!!!!!!요기서부터!!!!!!!!!!!!!!!!!!!
       //소켓에 쏴줄 때 컨텐츠에는 이름이 들어간 배열로 줄까
        $.ajax({
           url: "/messenger/addMemberToChatRoom",
           type: "post",
           traditional :true,
            data: {
               seq: seq
               , partyList: checkArr
            },
            dataType: "json",
            success: function (resp) {
               if(resp==checkArrParsed.length){
                  socket.send('/getChat/announce/' +${seq}, {}, JSON.stringify({
                       m_seq: seq
                        , contents: checkArr
                        , write_date: new Date()
                        , emp_code: emp_code
                        , empname: empname
                        , type: "AN_ADD"
                    }));
               }
            }
        });
   };
     //====================채팅 멤버 추가=======

</script>
</body>
</html>