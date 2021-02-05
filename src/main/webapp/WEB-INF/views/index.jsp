<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
   <meta charset="UTF-8">

   <title>Insert title here</title>
   <!-- 로그인 관련 -->
   <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet"
         integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">

<style type="text/css">
   #contents{height:100%;width:100%;}
   .body{height: 50%;}
   .footer{text-align: right}
   input{width:100%}
</style>

</head>
<body>
   <c:choose>
      <c:when test="${empty loginDTO}">
         <!-- 로그인 start -->
         <div class="container" id="loginDiv">
            <form class="form-signin" method="post" action="/membership/login">
               <h2 class="form-signin-heading">코코아 워크 로그인</h2>
               <p>
                  <label for="code" class="sr-only">Username</label>
                  <input type="text" id="code" name="code" class="form-control" placeholder="사번 입력" required="required"
                         autofocus="">
               </p>
               <p>
                  <label for="password" class="sr-only">Password</label>
                  <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호 입력"
                         required="required">
               </p>
               <p>
               <div class="chk_box">
                  <div class="cb">
                     <input type="checkbox" id="rememberId" name="rememberId"
                            value="아이디 기억">
                     <label for="rememberId"> <b>아이디 기억하기</b> </label>
                  </div>
                  <div class="find">
                     <a href="/membership/findId">아이디</a> / <a href="/membership/findPw">비밀번호 찾기</a>
                  </div>
               </div>
               </p>
               <!--input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /-->
               <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
            </form>
         </div>
         <c:if test="${result == 'F'}">
            <script>
               alert("로그인 실패");
            </script>
         </c:if>
         <!-- 로그인 스크립트 -->
         <!-- 아이디값 쿠키에 저장하기 -->
         <script>
            $(document).ready(function () {
               // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
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
            <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
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
            temporaryBtn.onclick = function() {
               location.href = "/document/d_searchTemporary.document?&searchText=";
            }
            let raiseBtn = document.getElementById("raiseBtn");
            raiseBtn.onclick = function() {
               location.href = "/document/d_searchRaise.document?&searchText=";
            }
            let approvalBtn = document.getElementById("approvalBtn");
            approvalBtn.onclick = function() {
               location.href = "/document/d_searchApproval.document?&searchText=";
            }
            let rejectBtn = document.getElementById("rejectBtn");
            rejectBtn.onclick = function() {
               location.href = "/document/d_searchReject.document?&searchText=";
            }
            let returnBtn = document.getElementById("returnBtn");
            returnBtn.onclick = function() {
               location.href = "/document/d_searchReturn.document?&searchText=";
            }
            let allDocBtn = document.getElementById("allDocBtn");
            allDocBtn.onclick = function() {
               location.href = "/document/allDocument.document";
            }
            let allConfirmDocBtn = document.getElementById("allConfirmDocBtn");
            allConfirmDocBtn.onclick = function() {
               location.href = "/document/allConfirmDoc.document";
            }

            let sendEmailBtn = document.getElementById("sendEmailBtn");
            sendEmailBtn.onclick = function() {
               location.href = "/email/sendPage.email";
            }

            /*지영 부분*/
            //회사소식
            function fn_board() {
               location.href = "/noBoard/notificationBoardList.no?menu_seq=1"
            }
            //자유게시판
            function fn_cocoaBoard(){
               location.href = "/noBoard/notificationBoardList.no?menu_seq=2"
            }
            //앨범게시판
            function fn_albumBoard(){
               location.href = "/noBoard/notificationBoardList.no?menu_seq=3"
            }
            //업무일지 작성
            function fn_logCreate(){
               location.href = "/log/logCreate.log"
            }

            /*내정보보기*/
            function fn_to_myInfo(){
               location.href = "/membership/myInfo";
            }

            /*근태현황*/
            function fn_to_TA(){
               location.href = "/attendance/toAttendanceView";
            }

            /*의진 부분*/
            function fn_messenger() {
               var popup = window.open('/messenger/contactList','','width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
            }

            function fn_totemplate() {
               location.href = "/document/toTemplateList.document";

            }

            function fn_toBD(){location.href="/document/toBDocument.document?cpage=1"}
            function fn_toNFD(){location.href="/document/toNFDocument.document?cpage=1"}
            function fn_toFD(){location.href="/document/toFDocument.document?cpage=1"}
            function fn_toRD(){location.href="/document/toRDocument.document?cpage=1"}
         </script>
      </c:otherwise>
   </c:choose>
</body>
</html>