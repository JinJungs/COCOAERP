<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <title>Sidebar 02</title>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link
            href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900"
            rel="stylesheet">
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <link rel="stylesheet" href="/css/sidebar.css">
    <style>
        /*스크롤바 제거*/
        ::-webkit-scrollbar {
            display: none;
        }
    </style>
</head>
<body>
<nav id="sidebar" >
    <a href="/membership/logout" style="color:white"><b>로그아웃(임시)</b></a>
    <a href="/attendance/toMain" style="color:white"><b>근태메인(임시)</b></a>
    <div class="custom-menu">
        <button type="button" id="sidebarCollapse" class="btn btn-primary" >
            <i class="fa fa-bars"></i> <span class="sr-only">Toggle Menu</span>
        </button>
    </div>
    <div class="p-4 pt-5">
        <h3 class="mb-3">
            <a href="#" class="logo" style="color:#6749B9" onclick="to_indexPage()">COCOAWORK</a>
        </h3>
        <!-- 프로필 -->
        <div class="side-profile">
            <div class="side-user-pic">
                <img class="side-img" style="user-select: auto;">
            </div>
            <div class="side-user-info">
                <span class="side-user-name"></span>
                <span class="side-user-role"></span>
                <p class="mt-1 mb-0 p-0">
                    <button class="btn btn-primary side-chat p-0" onclick="fn_messenger()">
                        <img src="/icon/chat-full-white.svg">채팅하기
                    </button>
                </p>
            </div>
        </div>
        <ul class="list-unstyled components mb-5" id="sidebarBox">
            <!-- 여기에 사이드바의 내용이 추가된다.-->
        </ul>
    </div>
</nav>
<script >
    var openDropBox =[];
    function fn_messenger() {
        var popup = window.open('/messenger/contactList','','width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
    }

    $(document).ready(function() {

        var sidebarStatus =JSON.parse(localStorage.getItem("sidebarStatus"));

        $.ajax({
            data: {test : "test"},
            type: "POST",
            url: "/sidebar/getSidebarList",
            dataType: "json",
            success: function (data){

                // -------- 사용자의 정보를 띄워줌 --------
                console.log("code: "+data[9].code);
                let user_code = data[9].code;
                let user_name = data[9].name;
                let user_deptname = data[9].deptname;
                let user_teamname = data[9].teamname;
                let user_posname = data[9].posname;
                let user_profile = data[9].profile;
                let countSidebarMenu = 9;
                $(".side-user-name").html(user_name);
                $(".side-user-role").html(user_deptname+" | "+user_posname);
                $(".side-img").attr("src",user_profile);

                // -------- 사이드바의 목록을 띄워줌 --------
                let html = "";

                // 업무일지, 전자결재, 일정관리, 근태현황, 전자우편, 커뮤니티, 개인정보, 조직도, 버그리포팅
                for(let j=0; j<9; j++){
                    if(data[j].length==0){
                        console.log("없음!!: "+j);
                        countSidebarMenu -=1;
                    }else{
                        if(!data[j][0].mid_name){ //mid_name이 없는 경우 - 조직도, 버그리포팅
                            html += "<li><a href='javascript:side_findLocation("+data[j][0].code+");' onclick=fn_clickDropBox(this)>"+data[j][0].menu_name+"</a></li>";
                        }else if(j==1) { // 전자결재 - 기안함, 결재함
                            // 기안함, 결재함으로 바뀌는 index 번호 확인
                            let draftIndex = 0; // 기안함이 시작되는 index
                            let approveIndex = 0; // 결재함이 시작되는 index
                            let isDraftBoxExist = false; // 기안함의 존재여부
                            let isApproveBoxExist = false; // 결재함의 존재여부
                            let isAllDocExist = false; // 문서대장 존재여부

                            html += "<li>";
                            html += "<a id=sidebarmenu"+j+" href='#sidebarMenuNum_"+j+"' data-toggle='collapse' aria-expanded='false' class='dropdown-toggle' onclick=fn_clickDropBox(this)>";
                            html += data[j][0].menu_name+"</a>";
                            html += "<ul class='collapse list-unstyled' id='sidebarMenuNum_"+j+"'>";
                            for(let i=0; i<data[j].length; i++){
                                if(data[j][i].mid_code == 6 || data[j][i].mid_code == 7 || data[j][i].mid_code == 8){
                                    approveIndex += 1;
                                }
                                <!-- 결재문서 작성 & 전체보기-->
                                if(!data[j][i].sub_name && data[j][i].code!=17){
                                    draftIndex += 1;
                                    html += "<li><a href='javascript:side_findLocation("+data[j][i].code+");'>"+data[j][i].mid_name+"</a></li>";
                                }
                                <!-- 기안함의 존재 여부-->
                                if(data[j][i].mid_code == 8){
                                    isDraftBoxExist = true;
                                }
                                <!-- 결재함의 존재 여부-->
                                if(data[j][i].mid_code == 9){
                                    isApproveBoxExist = true;
                                }
                                <!-- 문서대장 존재 여부-->
                                if(data[j][i].code == 17){
                                    isAllDocExist = true;
                                }
                            }
                            console.log("기안함 인덱스 : "+draftIndex);
                            console.log("결재함 인덱스 : "+approveIndex);
                            <!-- 기안함 -->
                            if(isDraftBoxExist){
                                html += "<li><a id=Docu2 href='#Document2' data-toggle='collapse' aria-expanded='false' class='dropdown-toggle'  onclick=fn_clickDropBox(this)>";
                                html += data[j][draftIndex].mid_name+"</a>";
                                html += "<ul class='collapse list-unstyled' id='Document2'>";
                                for(let i= draftIndex; i<approveIndex; i++){ // 하위메뉴 출력
                                    if(data[j][i].mid_code == 8){ // 방어코드
                                        html += "<li><a href='javascript:side_findLocation("+data[j][i].code+");'>"+data[j][i].sub_name+"</a></li>";
                                    }
                                }
                                html += "</ul>";
                                html += "</li>";
                            }

                            <!-- 결재함 -->
                            if(isApproveBoxExist){
                                html += "<li><a id=docu3 href='#Document3' data-toggle='collapse' aria-expanded='false' class='dropdown-toggle'  onclick=fn_clickDropBox(this)>";
                                html += data[j][approveIndex].mid_name+"</a>";
                                html += "<ul class='collapse list-unstyled' id='Document3'>";
                                for(let i=approveIndex; i<data[j].length; i++){ // 하위메뉴 출력
                                    if(data[j][i].mid_code == 9){ // 방어코드
                                        html += "<li><a href='javascript:side_findLocation("+data[j][i].code+");'>"+data[j][i].sub_name+"</a></li>";
                                    }
                                }
                                html += "</ul>";
                                html += "</li>";
                            }
                            <!-- 문서대장 -->
                            if(isAllDocExist){
                                html += "<li><a href='javascript:side_findLocation("+data[j][data[j].length-1].code+");'>"+data[j][data[j].length-1].mid_name+"</a></li>";
                            }
                            html += "</ul>";
                            html += "</li>";
                        }else{
                            html += "<li>";
                            html += "<a id=sidebarMenu"+j+" href='#sidebarMenuNum_"+j+"' data-toggle='collapse' aria-expanded='false' class='dropdown-toggle'  onclick=fn_clickDropBox(this)>";
                            //html += "<i class='bi bi-journal-text mr-2'></i>";
                            html += data[j][0].menu_name+"</a>";
                            html += "<ul class='collapse list-unstyled' id='sidebarMenuNum_"+j+"'>";
                            for(let i=0; i<data[j].length; i++){
                                //console.log("보드메뉴 : " +data[j][i].board_menu_seq);
                                html += "<li><a href='javascript:side_findLocation("+data[j][i].code+","+data[j][i].board_menu_seq+",\""+data[j][i].type+"\",\""+data[j][i].mid_name+"\");'>"+data[j][i].mid_name+"</a></li>";
                            }
                            html += "</ul>";
                            html += "</li>";
                        }
                    }
                }
                if(countSidebarMenu==0){
                    html+="<span class='side-no-sidebar-menu' style='user-select: auto;'>메뉴가 없습니다.</span>";
                }
                // 받은 사이드바의 값을 뿌려주기
                $("#sidebarBox").append(html);
                console.log(sidebarStatus);

                if(sidebarStatus!=null){
                    for(var i=0;i<sidebarStatus.length;i++){
                        var getItem =sidebarStatus[i];
                        openDropBox.push(getItem);
                        $("#"+getItem+"").attr("aria-expanded","true");
                        $("#"+getItem+"").attr("class","dropdown-toggle");
                        $("#"+getItem+"").siblings('ul').attr("class","list-unstyled collapse show");

                    }
                }
            }
        })

    });

    /*메신저 팝업 : messsenger*/
    function fn_messenger() {
        var popup = window.open('/messenger/contactList', 'messenger', 'width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
    }

    function to_indexPage(){

        localStorage.setItem("sidebarStatus",JSON.stringify(openDropBox));
        location.href="/";
    }

    // 1~33까지 code번호를 받아서 location.href= 각 페이지로 이동한다.
    function side_findLocation(code, board_menu_seq, type,mid_name){
        console.log("코드 : " +code);
        console.log("보드 메뉴 시퀀스 : " +board_menu_seq);
        console.log("보드 타입 : " +type);
        console.log("이름 : " +mid_name);
        localStorage.setItem("sidebarStatus",JSON.stringify(openDropBox));
        // 1. 업무일지
        if(code==1){
            location.href = "/log/logCreate.log";
        }else if(code==2){
            location.href = "/log/logBoard.log?status=CONFIRM";
        }else if(code==3){
            location.href = "/log/logBoard.log?status=RAISE";
        }else if(code==4){
            location.href = "/log/logBoard.log?status=TEMP";
        }else if(code==5) {
            location.href = "/log/logSentBoard.log";
            // 2. 전자결재
        }else if(code==6) { // 결재문서 작성
            location.href = "/document/toTemplateList.document";
        }else if(code==7) { // 전체보기
            location.href = "/document/allDocument.document";
        }else if(code==8) { // 저장된 문서
            location.href = "/document/d_searchTemporary.document?&searchText=";
        }else if(code==9) { // 상신한 문서
            location.href = "/document/d_searchRaise.document?&searchText=";
        }else if(code==10) { // 승인된 문서
            location.href = "/document/d_searchApproval.document?&searchText=";
        }else if(code==11) { // 반려된 문서
            location.href = "/document/d_searchReject.document?&searchText=";
        }else if(code==12) { // 회수한 문서
            location.href = "/document/d_searchReturn.document?&searchText=";
        }else if(code==13) { // 결재 전 문서
            location.href = "/document/toBDocument.document?cpage=1";
        }else if(code==14) { // 진행 중 문서
            location.href = "/document/toNFDocument.document?cpage=1";
        }else if(code==15) { // 완료된 문서
            location.href = "/document/toFDocument.document?cpage=1";
        }else if(code==16) { // 반려한 문서
            location.href = "/document/toRDocument.document?cpage=1";
        }else if(code==17) { // 문서대장
            location.href = "/document/allConfirmDoc.document";
            // 3. 일정관리
        }else if(code==18) {
            location.href = "/schedule/toScheduleMain.schedule";
        }else if(code==19) {
            location.href = "/leave/toLeaveMain.leave";
            // 4. 근태현황
        }else if(code==20) {
            location.href = "/attendance/toAttendanceView";
        }else if(code==21) {
            location.href = "/attendance/toMain";
        }else if(code==22) {
            location.href = "/attendance/toAtdReq";
            // 5. 전자우편
        }else if(code==23) {
            location.href = "/email/sendPage.email";
        }else if(code==24) {
            location.href = "/email/receiveList.email?cpage=1";
        }else if(code==25) {
            location.href = "/email/sendToMeList.email?cpage=1";
        }else if(code==26) {
            location.href = "/email/sendList.email?cpage=1";
        }else if(code==27) {
            location.href = "/email/deleteList.email?cpage=1";
            // 6. 커뮤니티
        }else if(code==28) {
            location.href = "/myBoard/myBoard.mb";
        }else if(code==29) {
            location.href = "/noBoard/notificationBoardList.no?menu_seq=1";
        }else if(code==30) {
            location.href = "/noBoard/notificationBoardList.no?menu_seq="+board_menu_seq+"&type="+type+"&mid_name="+mid_name;
        }else if(code==31) {
            location.href = "/noBoard/notificationBoardList.no?menu_seq="+board_menu_seq+"&type="+type+"&mid_name="+mid_name;
            // 7. 개인정보
        }else if(code==32) {
            location.href = "/membership/myInfo";
            // 8. 조직도
        }else if(code==33) {
            location.href = "/organ/toOrganChart.organ";
            // 9. 버그리포트
        }else if(code==34) {
            location.href = "/bug";
        }else{ // 게시판이 추가되는 경우
            location.href = "/noBoard/notificationBoardList.no?menu_seq="+board_menu_seq+"&type="+type+"&mid_name="+mid_name;
        }
    }

    function fn_clickDropBox(obj){
        var close ="dropdown-toggle collapsed";
        var open ="dropdown-toggle";
        var id = $(obj).attr("id");
        var tid = setTimeout(function () {
            if($(obj).attr("class")==open){
                if(openDropBox.indexOf(id)==-1) {
                    openDropBox.push($(obj).attr("id"));
                }
            }
            if($(obj).attr("class")==close){
                if(openDropBox.indexOf(id)>=0) {
                    openDropBox.splice(openDropBox.indexOf(id),1);
                }
            }
        },50);
    }

</script>
<script src="/js/popper.js"></script>
<script src="/js/main.js"></script>
</body>
</html>