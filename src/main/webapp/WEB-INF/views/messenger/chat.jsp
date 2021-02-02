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
        
        <div class="fileBox">
	        <form id="mainForm" enctype="multipart/form-data">
	            <!-- accept=".gif, .jpg, .png" 등 나중에 조건 추가해주기 -->
	            <label for="file"><i class="fas fa-paperclip"></i></label>
		    	<input type="file" id="file" name=file>
	        </form>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (data) {
            	// 추가 전 msgBox의 길이를 저장
                let beforeMsgBoxHeight = msgBox.height();
                console.log("추가되기 전 msgBox의 길이 : "+ beforeMsgBoxHeight);
                for (var i = 0; i < data.length; i++) {
                	console.log(data[i].type+" : "+data[i].contents +" : "+data[i].savedname);
                    var existMsg = "";
                    //console.log("시간 : " +moment(data[i].write_date).format('YYYY MM DD HH:mm:ss'))
                    if(data[i].emp_code == ${loginDTO.code}){
                        existMsg += "<div class='d-flex justify-content-end mb-4'>";
                        existMsg += msgForm(data[i].type, "msg_cotainer_send", data[i].contents, data[i].savedname);
                        //existMsg += "<div class='msg_cotainer_send'>"+data[i] .emp_code+" : "+data[i].contents;
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
                        existMsg += msgForm(data[i].type, "msg_cotainer", data[i].contents, data[i].savedname);
                        //existMsg += "<div class='msg_cotainer'>"+data[i].emp_code+" : "+data[i].contents;
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

            scrollUpdate();
        };

        /* 파일 전송 */
        document.getElementById("file").addEventListener('change', uploadMsgFile);
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
              //파일 관련 메세지 구분 위해 타입추가*****
                var type = JSON.parse(e.body).type;
              	var savedname = JSON.parse(e.body).savedname;
                
                //파일관련 메세지일 경우*****
                //컨텐츠에 담아둔 파일 이름을 전송하고 a태그를 걸어준다.
                
                // 내가 메세지를 보냈을 때
                if(sender == ${loginDTO.code}){
                    newMsg += "<div class='d-flex justify-content-end mb-4'>";
                    newMsg += msgForm(type, "msg_cotainer_send", msg, savedname);
                    /* if(type == "FILE"){
                    	newMsg += fileTag("msg_cotainer_send",savedname, msg);
                    	//newMsg += "<div class='msg_cotainer_send'><a href='/files/downloadMessengerFile.files?savedname="+savedname+"&oriname="+msg+"'>" + msg + "</a>";
                    }else if(type == "IMAGE"){
                    	newMsg += "<div class='msg_cotainer_send'><a href='/files/downloadMessengerFile.files?savedname="+savedname+"&oriname="+msg+"'>" + msg + "</a>";
                    }else{
                    	newMsg += "<div class='msg_cotainer_send'>" +msg;
                    } */
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
                    newMsg += msgForm(type, "msg_cotainer", msg, savedname);
                    /* if(type == "FILE"){
                    	newMsg += fileTag("msg_cotainer",savedname, msg);
                    }else{
                    	newMsg += "<div class='msg_cotainer'>" +msg;
                    } */
                    newMsg += "<span class='msg_time'>"+moment(current_date).format('MM-DD HH:mm')+"</span>";
                    newMsg += "</div></div>";
                    msgBox.append(newMsg);
                }
            });
        });
    }
    	
  //***************************************************************************

  /* 파일 전송 */ 
  	function uploadMsgFile(evt) {
        evt.preventDefault();
        if (!isStomp && socket.readyState !== 1) return;
        
        if (isStomp){
        	event.preventDefault();
        	var resultF = 0;
        	var savedName = "";
        	//00. 파일 선택
        	var fileInfo = document.querySelector("#file").files[0]; //form 안의 input type=file의 아이디
        	console.log("fileInfo", fileInfo);
        	
        	var mainForm = $("#mainForm")[0]; //form의 아이디
        	console.log("mainForm : ",mainForm);
			//멀티타입 파일
        	var formData = new FormData(mainForm);
        	console.log("formData : ", formData)

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
                    	if(parseInt(result.resultF)>0){
                    		//타입 구하기 (fileType 함수 이용)
                            var type = fileType(fileInfo.name);
                            console.log(type)
                            //02. 메세지 전송 : contents = 파일 원본 이름으로 보낸다.
                            socket.send('/getChat/fileMessage/' +${seq}, {}, JSON.stringify({
                                            seq: result.msg_seq
                                            , contents: fileInfo.name
                                            , write_date: new Date()
                                            , emp_code: ${loginDTO.code}
                                            , m_seq: ${seq}
                                            , type: type
                                            , savedname: result.savedname
                                        }));
                    	}
                    }
             });
            scrollUpdate(); 
        }
        else//이건 왜하는거람
            socket.send(file);
    };
    
    //=======모듈 함수들===============================================
  //[타입별 내용부분 태그]
  function msgForm(type, classname, msg, savedname){
	  let result;
	  let msgOriname = encodeURIComponent(msg);
	  savedname = encodeURIComponent(savedname);
	  if(type=="FILE"){
		  result = "<div class='"+classname+"'><a href='/files/downloadMessengerFile.files?savedname="+savedname+"&oriname="+msgOriname+"'>" + msg + "</a>";
	  }else if(type=="IMAGE"){
		  result = "<div class='"+classname+"'><a href='/files/downloadMessengerFile.files?savedname="+savedname+"&oriname="+msgOriname+"'><img src='/messengerFile/"+savedname+"' width='150' height='150' style='object-fit:cover;'></a>";
	  }else{
		  result = "<div class='"+classname+"'>" +msg;
	  }
	  return result;
  }
  //[파일 받기용 함수] 타입구하기******
    function fileType(filename){
    	//01. 파일 확장자 구하고 소문자로 변환
    	let type;
    	var _fileLen = filename.length;
		var _lastDot = filename.lastIndexOf('.');
	    var _fileExt = filename.substring(_lastDot, _fileLen).toLowerCase();
	    console.log("filename , 확장자명 : ");
	    console.log(filename + " : " + _fileExt);
	    if(_fileExt==".png"||_fileExt==".jpg"){
	    	type = "IMAGE";
	    }else{
	    	type = "FILE";
	    }
	    return type;
    } 

</script>
</body>
</html>