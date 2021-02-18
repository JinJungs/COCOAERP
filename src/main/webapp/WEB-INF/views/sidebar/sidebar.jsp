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
</head>
<body>
<nav id="sidebar">
   <div class="custom-menu">
      <button type="button" id="sidebarCollapse" class="btn btn-primary">
         <i class="fa fa-bars"></i> <span class="sr-only">Toggle Menu</span>
      </button>
   </div>
   <div class="p-4 pt-5">
      <h3>
         <a href="/" class="logo">COCOAWORK</a>
      </h3>
      <ul class="list-unstyled components mb-5" id="sidebarBox">
         <!-- 여기에 사이드바의 내용이 추가된다.-->
      </ul>
   </div>
</nav>
<script >
   function fn_messenger() {
      var popup = window.open('/messenger/contactList','','width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
   }

   $(document).ready(function() {
      $.ajax({
         data: {test : "test"},
         type: "POST",
         url: "/sidebar/getSidebarList",
         dataType: "json",
         success: function (data){
            // 리스트가 비어있는 경우에 방어코드가 한줄 있어야 한다.
            let html = "";

            // 업무일지, 전자결재, 일정관리, 근태현황, 전자우편, 커뮤니티, 개인정보, 조직도, 버그리포팅
            for(let j=0; j<9; j++){
               if(data[j].length == 0){ // 하위목록이 없는 경우 - 메뉴자체를 보여주지 않음
                  console.log("하위목록이 없어서 사이드바의 메뉴를 불러오지 않습니다. : " + j);
               }else if(!data[j][0].mid_name){ //mid_name이 없는 경우 - 조직도, 버그리포팅
                  html += "<li><a href='javascript:side_findLocation("+data[j][0].code+","+data[j][0].board_menu_seq+",\""+data[j][0].type+"\");'>"+data[j][0].menu_name+"</a></li>";
               }else if(j==1) { // 전자결재 - 기안함, 결재함
                  // 기안함, 결재함으로 바뀌는 index 번호 확인
                  let draftIndex = 0; // 기안함이 시작되는 index
                  let approveIndex = 0; // 결재함이 시작되는 index
                  for(let i=0; i<data[j].length; i++){
                     if(data[j][i].mid_code == 6 || data[j][i].mid_code == 7){
                        approveIndex += 1;
                     }
                  }
                  html += "<li>";
                  html += "<a href='#sidebarMenuNum_"+j+"' data-toggle='collapse' aria-expanded='false' class='dropdown-toggle'>";
                  html += data[j][0].menu_name+"</a>";
                  html += "<ul class='collapse list-unstyled' id='sidebarMenuNum_"+j+"'>";
                  <!-- 결재문서 작성-->
                  if(!data[j][0].sub_name){ // 결재문서 작성이 있다면 (첫번째 데이터가 sub_name이 없는 경우)
                     draftIndex = 1;
                     html += "<li><a href='javascript:side_findLocation("+data[j][0].code+","+data[j][0].board_menu_seq+",\""+data[j][0].type+"\");'>"+data[j][0].mid_name+"</a></li>";
                  }

                  <!-- 기안함 -->
                  if(draftIndex != approveIndex){
                     html += "<li><a href='#Document2' data-toggle='collapse' aria-expanded='false' class='dropdown-toggle'>";
                     html += data[j][draftIndex].mid_name+"</a>";
                     html += "<ul class='collapse list-unstyled' id='Document2'>";
                     for(let i= draftIndex; i<approveIndex; i++){ // 하위메뉴 출력
                        if(data[j][i].mid_code == 7){
                           html += "<li><a href='javascript:side_findLocation("+data[j][i].code+","+data[j][i].board_menu_seq+",\""+data[j][i].type+"\");'>"+data[j][i].sub_name+"</a></li>";
                        }
                     }
                     html += "</ul>";
                     html += "</li>";
                  }else {
                     console.log("기안함 없음!");
                  }
                  <!-- 결재함 -->
                  if(approveIndex != data[j].length){
                     html += "<li><a href='#Document3' data-toggle='collapse' aria-expanded='false' class='dropdown-toggle'>";
                     html += data[j][approveIndex].mid_name+"</a>";
                     html += "<ul class='collapse list-unstyled' id='Document3'>";
                     for(let i=approveIndex; i<data[j].length; i++){ // 하위메뉴 출력
                        if(data[j][i].mid_code == 8){
                           html += "<li><a href='javascript:side_findLocation("+data[j][i].code+","+data[j][i].board_menu_seq+",\""+data[j][i].type+"\");'>"+data[j][i].sub_name+"</a></li>";
                        }
                     }
                     html += "</ul>";
                     html += "</li>";
                  }else{
                     console.log("결재함 없음!");
                  }
                  html += "</ul>";
                  html += "</li>";
               }else{ // 업무일지, 일정관리, 근태현황, 전자우편, 커뮤니티, 개인정보
                  html += "<li>";
                  html += "<a href='#sidebarMenuNum_"+j+"' data-toggle='collapse' aria-expanded='false' class='dropdown-toggle'>";
                  html += data[j][0].menu_name+"</a>";
                  html += "<ul class='collapse list-unstyled' id='sidebarMenuNum_"+j+"'>";
                  for(let i=0; i<data[j].length; i++){
                     /*console.log("보드메뉴 : " +data[j][i].board_menu_seq);
                     console.log("보드타입 : " +data[j][i].type);
                     console.log("보드명 : " +data[j][i].mid_name);*/
                     html += "<li><a href='javascript:side_findLocation("+data[j][i].code+","+data[j][i].board_menu_seq+",\""+data[j][i].type+"\",\""+data[j][i].mid_name+"\");'>"+data[j][i].mid_name+"</a></li>";
                  }
                  html += "</ul>";
                  html += "</li>";
               }
            }
            // 받은 사이드바의 값을 뿌려주기
            $("#sidebarBox").append(html);
         }
      })
   });

   // 1~33까지 code번호를 받아서 location.href= 각 페이지로 이동한다.
   function side_findLocation(code, board_menu_seq, type,mid_name){
      /*console.log("코드 : " +code);
      console.log("보드 메뉴 시퀀스 : " +board_menu_seq);
      console.log("보드 타입 : " +type);
      console.log("이름 : " +mid_name);*/
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
      }else if(code==6) {
         location.href = "/document/toTemplateList.document";
      }else if(code==7) {
         location.href = "/document/d_searchTemporary.document?&searchText=";
      }else if(code==8) {
         location.href = "/document/d_searchRaise.document?&searchText=";
      }else if(code==9) {
         location.href = "/document/d_searchApproval.document?&searchText=";
      }else if(code==10) {
         location.href = "/document/d_searchReject.document?&searchText=";
      }else if(code==11) {
         location.href = "/document/d_searchReturn.document?&searchText=";
      }else if(code==12) {
         location.href = "/document/allDocument.document";
      }else if(code==13) {
         location.href = "/document/allConfirmDoc.document";
      }else if(code==14) {
         location.href = "/document/toBDocument.document?cpage=1";
      }else if(code==15) {
         location.href = "/document/toNFDocument.document?cpage=1";
      }else if(code==16) {
         location.href = "/document/toFDocument.document?cpage=1";
      }else if(code==17) {
         location.href = "/document/toRDocument.document?cpage=1";
         // 3. 일정관리
      }else if(code==18) {
         location.href = "/schedule/toScheduleMain.schedule";
      }else if(code==19) {
         location.href = "#";
         // 4. 근태현황
      }else if(code==20) {
         location.href = "/attendance/toAttendanceView";
      }else if(code==21) {
         location.href = "#";
         // 5. 전자우편
      }else if(code==22) {
         location.href = "/email/sendPage.email";
      }else if(code==23) {
         location.href = "/email/receiveList.email?cpage=1";
      }else if(code==24) {
         location.href = "/email/sendToMeList.email?cpage=1";
      }else if(code==25) {
         location.href = "/email/sendList.email?cpage=1";
      }else if(code==26) {
         location.href = "/email/deleteList.email?cpage=1";
         // 6. 커뮤니티
      }else if(code==27) {
         location.href = "/myBoard/myBoard.mb";
      }else if(code==28) {
         location.href = "/noBoard/notificationBoardList.no?menu_seq=1";
      }else if(code==29) {
         location.href = "/noBoard/notificationBoardList.no?menu_seq="+board_menu_seq+"&type="+type+"&mid_name="+mid_name;
      }else if(code==30) {
         location.href = "/noBoard/notificationBoardList.no?menu_seq="+board_menu_seq+"&type="+type+"&mid_name="+mid_name;
         // 7. 개인정보
      }else if(code==31) {
         location.href = "/membership/myInfo";
         // 8. 조직도
      }else if(code==32) {
         location.href = "/organ/toOrganChart.organ";
         // 9. 버그리포트
      }else if(code==33) {
         location.href = "/bug";
      }else{ // 게시판이 추가되는 경우
         location.href = "/noBoard/notificationBoardList.no?menu_seq="+board_menu_seq+"&type="+type+"&mid_name="+mid_name;
      }
   }

</script>
<script src="/js/popper.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/main.js"></script>
</body>
</html>