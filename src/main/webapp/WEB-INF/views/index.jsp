<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   response.setHeader("Cache-Control","no-store");
   response.setHeader("Pragma","no-cache");
   response.setDateHeader("Expires",0);
   if (request.getProtocol().equals("HTTP/1.1"))
      response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
   <meta charset="UTF-8">

   <title>Insert title here</title>
   <!-- 로그인 관련 -->
   <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
   <style type="text/css">

      #contents {
         height: 100%;
         width: 100%;
      }

      .body {
         height: 50%;
      }

      .footer {
         text-align: right
      }

      input {
         width: 100%
      }
      .login-Container{
         color: white;
         background-color: #00000080;
      }

      .flex-container{
         background: #000000;  /* fallback for old browsers */
         background: -webkit-linear-gradient(to right, #434343, #000000);  /* Chrome 10-25, Safari 5.1-6 */
         background: linear-gradient(to right, #434343, #000000); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */


         background-size: 400% 400%;
         width: 100%;
         height: 100vh;
         display: -webkit-box;
         display: -ms-flexbox;
         display: flex;
         -webkit-box-align: center;
         -ms-flex-align: center;
         align-items: center;
         -webkit-box-pack: center;
         -ms-flex-pack: center;
         justify-content: center;
      }
      .btn-login{
         font-weight: bold;
         color:white;
         background-color: #00000070;
      }
      .find-id, .find-pw{
         font-weight: bold;
         cursor: pointer;
      }
      .find-id:hover, .find-pw:hover{
         color:#c9c9c9;
      }



   </style>

</head>
<body>
<c:choose>
   <c:when test="${empty loginDTO}">
      <!-- 로그인 start -->
      <div class="flex-container" id="loginDiv">
         <div class="row d-flex justify-content-center login-Container" style="min-width: 450px;">
            <form class="form-signin w-100" method="post" action="/membership/login">
               <div class="col-12 p-5">
                  <div class="row w-100">
                     <div class= "col-12 p-3">
                        <h4 class="form-signin-heading" style="font-weight: bold">코코아 워크 로그인</h4>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-12 p-3">
                        <input type="text" id="code" name="code" class="form-control w-100" placeholder="사원번호를 입력해주세요."
                               required="required"
                               value="${id}" >
                     </div>
                     <input type="hidden" id="getFindId" value="${id}">
                  </div>
                  <div class="row">
                     <div class="col-12 p-3">
                        <label for="password" class="sr-only">Password</label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력해주세요"
                               required="required" autocomplete="off">
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-12 p-3">
                        <div class="custom-control custom-checkbox">
                           <input type="checkbox" id="rememberId" name="rememberId" class="custom-control-input">
                           <label class="custom-control-label" for="rememberId" style="font-weight: bold">아이디 저장하기</label>
                        </div>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-6 p-3 " ><span class="find-id" onclick="fn_toFindId()">아이디 찾기</span></div>
                     <div class="col-6 p-3 text-right" ><span class="find-pw" onclick="fn_toFindPw()">비밀번호 찾기</span></div>
                  </div>
                  <div class="row">
                     <div class="col-6 p-3">

                     </div>
                     <div class="col-6 p-3 text-right">
                        <button class="btn btn-lg btn-login" type="submit">로그인</button>
                     </div>
                  </div>

                  <!--input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /-->
               </div>

            </form>
         </div>

      </div>



      <div id="dropDownSelect1"></div>
      <c:if test="${result == 'F'}">
         <script>
            alert("로그인 실패");
         </script>
      </c:if>
      <!-- 로그인 스크립트 -->
      <!-- 아이디값 쿠키에 저장하기 -->
      <script>
         function fn_toFindId(){
            location.href="/membership/findId";
         }
         function fn_toFindPw(){
            location.href="/membership/findPw";
         }

         $(document).ready(function () {
            // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
            if($("#getFindId").val()=="") {
               var userInputId = getCookie("userInputId");
               $("input[id='code']").val(userInputId);

               if ($("input[id='code']").val() != "") {
                  // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
                  $("#rememberId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
               }

               $("#rememberId").change(function () { // 체크박스에 변화가 있다면,
                  if ($("#rememberId").is(":checked")) { // ID 저장하기 체크했을 때,
                     var userInputId = $("input[id='code']").val();
                     setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
                  } else { // ID 저장하기 체크 해제 시,
                     deleteCookie("userInputId");
                  }
               });

               // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
               $("input[id='code']").keyup(function () { // ID 입력 칸에 ID를 입력할 때,
                  if ($("#rememberId").is(":checked")) { // ID 저장하기를 체크한 상태라면,
                     var userInputId = $("input[id='code']").val();
                     setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
                  }
               });
            }

            //쿠키를 위한 함수
            function setCookie(cookieName, value, exdays) {
               var exdate = new Date();
               exdate.setDate(exdate.getDate() + exdays);
               var cookieValue = escape(value) + ((exdays == null) ? "" : ";expires=" + exdate.toGMTString());
               document.cookie = cookieName + "=" + cookieValue;
            }

            function deleteCookie(cookieName) {
               var expireDate = new Date();
               expireDate.setDate(expireDate.getDate() - 1);
               document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
            }

            function getCookie(cookieName) {
               cookieName = cookieName + '=';
               var cookieData = document.cookie;
               var start = cookieData.indexOf(cookieName);
               var cookieValue = '';
               if (start != -1) {
                  start += cookieName.length;
                  var end = cookieData.indexOf(';', start);
                  if (end == -1) end = cookieData.length;
                  cookieValue = cookieData.substring(start, end);
               }
               return unescape(cookieValue);
            }
         });
      </script>
      <!-- 로그인 end -->
   </c:when>
   <c:otherwise>
      <div class="wrapper d-flex align-items-stretch">
         <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp" %>   <!-- Page Content  -->
         <div id="content" class="p-4 p-md-5 pt-5">
            <!-- 지영 -->

            <button type="button" onclick="fn_board()">회사소식 게시판 바로가기</button>
            <button type="button" onclick="fn_cocoaBoard()">자유 게시판 바로가기</button>
            <button type="button" onclick="fn_albumBoard()">앨범 게시판 바로가기</button>
            <button type="button" onclick="fn_logCreate()">업무일지 작성 바로가기</button>
            <button type="button" onclick="fn_board()">게시판 바로가기</button>

            <!-- 내정보 보기-->
            <button type="button" onclick="fn_to_myInfo()">내 정보</button>
            <!-- 근태현황 -->
            <button type="button" onclick="fn_to_TA()">근태현황</button>
            <!-- 의진: 메신저 연락처-->
            <button type="button" onclick="fn_messenger()">메신저 바로가기</button>
               <%--용국 템플릿 리스트 바로가기--%>
            <button type="button" onclick="fn_totemplate()">기안 작성 바로가기</button>

            <!-- 효경 -->
            <input type=button value="저장된" id=temporaryBtn><br>
            <input type=button value="상신한" id=raiseBtn><br>
            <input type=button value="승인된" id=approvalBtn><br>
            <input type=button value="반려된" id=rejectBtn><br>
            <input type=button value="회수한" id=returnBtn><br>
            <input type=button value="전체보기" id=allDocBtn><br>
            <input type=button value="문서대장" id=allConfirmDocBtn><br>
            <br>
            <input type=button value="메일쓰기" id=sendEmailBtn><br>
            <input type=button value="내게 쓴 메일" id=sendToMeBtn><br>
            <input type=button value="받은 메일함" id=receiveBtn><br>
            <input type=button value="보낸 메일함" id=sendBtn><br>
            <input type=button value="휴지통(메일)" id=deleteBtn><br>
            <br>
            <input type=button value="일정" id=scheduleBtn><br>


               <%--용국--%>
            <button type="button" onclick="fn_toBD()">결재전</button>
            <button type="button" onclick="fn_toNFD()">진행중</button>
            <button type="button" onclick="fn_toFD()">완료된</button>
            <button type="button" onclick="fn_toRD()">반려한</button>
            <a href="/membership/logout">로그아웃</a>
         </div>
      </div>
      <script>
         let temporaryBtn = document.getElementById("temporaryBtn");
         temporaryBtn.onclick = function () {
            location.href = "/document/d_searchTemporary.document?&searchText=";
         }
         let raiseBtn = document.getElementById("raiseBtn");
         raiseBtn.onclick = function () {
            location.href = "/document/d_searchRaise.document?&searchText=";
         }
         let approvalBtn = document.getElementById("approvalBtn");
         approvalBtn.onclick = function () {
            location.href = "/document/d_searchApproval.document?&searchText=";
         }
         let rejectBtn = document.getElementById("rejectBtn");
         rejectBtn.onclick = function () {
            location.href = "/document/d_searchReject.document?&searchText=";
         }
         let returnBtn = document.getElementById("returnBtn");
         returnBtn.onclick = function () {
            location.href = "/document/d_searchReturn.document?&searchText=";
         }
         let allDocBtn = document.getElementById("allDocBtn");
         allDocBtn.onclick = function () {
            location.href = "/document/allDocument.document";
         }
         let allConfirmDocBtn = document.getElementById("allConfirmDocBtn");
         allConfirmDocBtn.onclick = function () {
            location.href = "/document/allConfirmDoc.document";
         }

         let sendEmailBtn = document.getElementById("sendEmailBtn");
         sendEmailBtn.onclick = function () {
            location.href = "/email/sendPage.email";
         }
         let sendToMeBtn = document.getElementById("sendToMeBtn");
         sendToMeBtn.onclick = function () {
            location.href = "/email/sendToMeList.email?cpage=1";
         }
         let receiveBtn = document.getElementById("receiveBtn");
         receiveBtn.onclick = function () {
            location.href = "/email/receiveList.email?cpage=1";
         }
         let sendBtn = document.getElementById("sendBtn");
         sendBtn.onclick = function () {
            location.href = "/email/sendList.email?cpage=1";
         }
         let deleteBtn = document.getElementById("deleteBtn");
         deleteBtn.onclick = function () {
            location.href = "/email/deleteList.email?cpage=1";
         }

         let scheduleBtn = document.getElementById("scheduleBtn");
         scheduleBtn.onclick = function () {
            location.href = "/schedule/toScheduleMain.schedule";
         }

         /*지영 부분*/
         //회사소식
         function fn_board() {
            location.href = "/noBoard/notificationBoardList.no?menu_seq=1"
         }

         //자유게시판
         function fn_cocoaBoard() {
            location.href = "/noBoard/notificationBoardList.no?menu_seq=2"
         }

         //앨범게시판
         function fn_albumBoard() {
            location.href = "/noBoard/notificationBoardList.no?menu_seq=3"
         }

         //업무일지 작성
         function fn_logCreate() {
            location.href = "/log/logCreate.log"
         }

         /*내정보보기*/
         function fn_to_myInfo() {
            location.href = "/membership/myInfo";
         }

         /*근태현황*/
         function fn_to_TA() {
            location.href = "/attendance/toAttendanceView";
         }

         /*의진 부분*/
         function fn_messenger() {
            var popup = window.open('/messenger/contactList', '', 'width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
         }

         function fn_totemplate() {
            location.href = "/document/toTemplateList.document";

         }

         function fn_toBD() {
            location.href = "/document/toBDocument.document?cpage=1"
         }

         function fn_toNFD() {
            location.href = "/document/toNFDocument.document?cpage=1"
         }

         function fn_toFD() {
            location.href = "/document/toFDocument.document?cpage=1"
         }

         function fn_toRD() {
            location.href = "/document/toRDocument.document?cpage=1"
         }
      </script>
   </c:otherwise>
</c:choose>
</body>
</html>