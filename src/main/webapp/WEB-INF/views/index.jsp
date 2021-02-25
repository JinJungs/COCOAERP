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
   <script src="/js/bootstrap.min.js"></script>
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
         background-image: url("/icon/cute4.gif");
         background-repeat:no-repeat;
         background-position: center;
         background-color: #FDEEEA;
         object-fit: cover;


     /*    background-image: url("/icon/cinemagraphs.gif");
         background-repeat: no-repeat;
         background-size: 100% 100%;
*/

        /* background: #000000;
          background: -webkit-linear-gradient(to right, #434343, #000000);
          background: linear-gradient(to right, #434343, #000000);*/

        /*  background: -webkit-radial-gradient(rgb(0, 0, 0), rgb(3, 129, 255));
             background: radial-gradient(rgb(0, 0, 0), rgb(3, 129, 255));*/



         /*background-size: 400% 400%;*/
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
      <div class="flex-container" id="login-container" >
         <div class="row d-flex justify-content-center login-Container" style="min-width: 450px;">
            <form class="form-signin w-100" method="post" action="/membership/login">
               <div class="col-12 p-5">
                  <div class="row w-100">
                     <div class= "col-12 p-3">
                        <h3 class="form-signin-heading" style="font-weight: bold">COCOAWORK</h3>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-12 p-3">
                        <input type="text" id="code" name="code" class="form-control w-100" placeholder="사원번호를 입력해주세요."
                               required="required"
                               value="${id}" autocomplete="off">
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
                           <label class="custom-control-label" for="rememberId" style="font-weight: bold;cursor: pointer">아이디 저장하기</label>
                        </div>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-6 p-3 " ><span class="find-id" onclick="fn_toFindId()">아이디 찾기</span></div>
                     <div class="col-6 p-3 text-right" ><span class="find-pw" onclick="fn_toFindPw()">비밀번호 찾기</span></div>
                  </div>
                  <div class="row">
                     <div class="col-12 p-3 text-center">
                        <button class="btn btn-lg btn-login w-100" type="submit">로그인</button>
                     </div>
                  </div>
               </div>

            </form>
         </div>
      </div>
      <div class="flex-container d-none" id="find-id-container">
         <div class="row d-flex justify-content-center login-Container" style="min-width: 450px;">
            <form id="find-id-resetform">
               <div class="col-12 p-5">
                  <div class="row w-100">
                     <div class= "col-12 p-3">
                        <h4 class="form-signin-heading" style="font-weight: bold">아이디 찾기</h4>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-12 p-3">
                        <label for="email" class="sr-only">Username</label>
                        <input type="text" id="email" name="code" class="form-control w-100" placeholder="이메일을 입력해주세요."
                               required="required"
                               autofocus="" autocomplete="off">
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-12 p-3 idContainer">

                     </div>
                  </div>

                  <div class="row">
                     <div class="col-4 p-3">
                        <button class="btn btn-login" type="button" onclick="toLogin()">로그인 하기</button>
                     </div>
                     <div class="col-5 p-3">
                        <button class="btn btn-login" type="button" onclick="fn_toFindPwbyFindId()">비밀번호 찾기</button>
                     </div>
                     <div class="col-3 p-0 pt-3">
                        <button class="btn btn-login" type="button" onclick="findId()">찾기</button>
                     </div>
                  </div>
                  <!--input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /-->
               </div>
            </form>
         </div>
      </div>

      <div class="flex-container d-none" id="findPw-container">
         <div class="row d-flex justify-content-center login-Container" style="min-width: 450px;">
            <form id="find-pw-resetform">
               <div class="col-12 p-5">
                  <div class="row w-100">
                     <div class= "col-12 p-3">
                        <h4 class="form-signin-heading" style="font-weight: bold">비밀번호 찾기</h4>
                     </div>
                  </div>
                  <form id=pwForm>
                     <div class="row">
                        <div class="col-12 p-3">
                           <label for="email_pw" class="sr-only">UserEmail</label>
                           <input type="text" id="email_pw" name="email" class="form-control w-100" placeholder="이메일을 입력해주세요."
                                  required="required"
                                  autofocus="" autocomplete="off" value="${email}">
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-12 emailmsg"></div>
                     </div>
                     <div class="row">
                        <div class="col-12 p-3">
                           <label for="code_id" class="sr-only">Username</label>
                           <input type="text" id="code_id" name="code" class="form-control w-100" placeholder="아이디를 입력해주세요."
                                  required="required"
                                  autofocus="" autocomplete="off" value="${id}">
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-12 idmsg"></div>
                     </div>
                     <div class="row d-none inputEmailNum">
                        <div class="col-6">
                           <input type="text" id="EmailNum" name="EmailNum" class="form-control w-100" placeholder="인증번호 입력">
                        </div>
                        <div class="col-6">
                           <button type="button" class="btn btn-login w-100" onclick="fn_authEmail()">인증하기</button>
                        </div>
                     </div>
                     <div class="row">
                        <div class="col-12 authmsg"></div>
                     </div>
                     <div class="row sendAuth">
                        <div class="col-12 p-3">
                           <button type="button" class="btn btn-login w-100" onclick="fn_checkEmail()">인증번호 전송</button>
                        </div>
                     </div>

                     <div class="row">
                        <div class="col-4 p-3">
                           <button class="btn btn-login" type="button" onclick="toLogin()">로그인 하기</button>
                        </div>
                        <div class="col-4 pt-3 pr-0">
                           <button class="btn btn-login" type="button" onclick="fn_toFindId()">아이디 찾기</button>
                        </div>
                        <div class="col-3 p-3 btn-changePw">
                           <button class="btn btn-login" type="button" id="btn-changePw" disabled=true onclick="fn_changePw()">변경하기</button>
                        </div>
                     </div>
                  </form>
                  <!--input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /-->
               </div>
            </form>
         </div>
      </div>
      <c:if test="${result == 'F'}">
         <script>
            alert("로그인 실패");
         </script>
      </c:if>
      <!-- 로그인 스크립트 -->
      <!-- 아이디값 쿠키에 저장하기 -->

      <script>

         var getSeq="";
         var getId=0;
         var isConfirm="false";
         var tempEmail ="";

         function fn_toFindId(){
            getSeq="";
            getId=0;
            isConfirm="false";
            $(".inputEmailNum").attr("class","row d-none inputEmailNum");
            $("#afterAuth").remove();
            $("#find-pw-resetform")[0].reset();
            $(".emailmsg").text("");
            $(".idmsg").text("");
            $(".authmsg").text("");
            $(".checkmsg").text("");
            $("#confirmmsg").remove();
            $("#checkmsgbox").remove();
            $("#find-id-container").attr("class","flex-container");
            $("#login-container").attr("class","flex-container d-none");
            $("#findPw-container").attr("class","flex-container d-none");
         }

         function fn_toFindPw(){
            tempEmail="";
            $("#idlist").empty();
            $("#findidmsg").text("");
            $("#find-id-resetform")[0].reset();
            $("#find-id-container").attr("class","flex-container d-none");
            $("#login-container").attr("class","flex-container d-none");
            $("#findPw-container").attr("class","flex-container");
         }

         function fn_toFindPwbyFindId() {
            tempEmail="";
            var getRadio = $("input[name=code]:checked").val();
            if (tempEmail != "" || getRadio != undefined) {
               $("#email_pw").val(tempEmail);
               $("#code_id").val(getRadio);
            }
            $("#idlist").empty();
            $("#findidmsg").text("");
            $("#find-id-resetform")[0].reset();
            $("#find-id-container").attr("class","flex-container  d-none");
            $("#login-container").attr("class","flex-container d-none");
            $("#findPw-container").attr("class","flex-container");
         }


         function toLogin() {

            var getRadio=$("input[name=code]:checked").val();
            if(getRadio!=undefined){
               $("#code").val(getRadio);
            }
            //닫아주기 패스워드
            getSeq="";
            getId=0;
            isConfirm="false";
            $(".inputEmailNum").attr("class","row d-none inputEmailNum");
            $("#confirmmsg").remove();
            $("#afterAuth").remove();
            $("#checkmsgbox").remove();
            $("#find-pw-resetform")[0].reset();
            $(".emailmsg").text("");
            $(".idmsg").text("");
            $(".authmsg").text("");
            $(".checkmsg").text("");
            //닫아주기 아이디
            tempEmail="";
            $("#idlist").empty();
            $("#findidmsg").text("");
            $("#find-id-resetform")[0].reset();
            $("#find-id-container").attr("class","flex-container  d-none");
            $("#login-container").attr("class","flex-container");
            $("#findPw-container").attr("class","flex-container d-none");

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
                  }findId()
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



         function findId() {
            var email= $("#email").val();
            if(email==""){
               var html="";
               $(".idContainer").empty();
               html+="<div class=row>";
               html+="<div class='col-12 p-3'>";
               html+="이메일을 입력해주세요.";
               html+="</div>";
               html+="</div>";
               $(".idContainer").append(html);
               $("#email").focus();
               return;
            }
            $.ajax({
               url: "/membership/findIdByEmail",
               type: "post",
               data: {email: $("#email").val()},
               dataType: "json",
               success: function (data) {
                  console.log(data);
                  tempEmail=$("#email").val();
                  var html="";
                  $(".idContainer").empty();
                  if(data!="") {
                     html+="<div class=row>";
                     html+="<div class='col-12 p-3' id=findidmsg>";
                     html+="고객님의 정보와 일치하는 아이디 목록입니다.";
                     html+="</div>";
                     html+="</div>";
                     for (var i = 0; i < data.length; i++) {
                        html += "<div class=row id=idlist>";
                        html += "<div class='col-12 p-3'>";
                        html += "<div class='custom-control custom-radio'>"
                        html += "<input type=radio name=code id=code"+i+" class=custom-control-input value="+data[i].code+">";
                        html += "<label class='custom-control-label' for=code"+i+">"+data[i].code+"</label>";
                        html += "</div>";
                        html += "</div>";
                        html += "</div>";
                     }
                     $(".idContainer").append(html);
                  }else{
                     html+="<div class=row id=idlist>";
                     html+="<div class='col-12 p-3' id=findidmsg>";
                     html+="고객님의 정보와 일치하는 정보가 없습니다.";
                     html+="</div>";
                     html+="</div>";
                     $(".idContainer").append(html);
                  }
               }
            })
         }





         function fn_checkEmail(){
            $(".emailmsg").text("");
            $(".idmsg").text("");
            var email = $("#email_pw").val();
            var id = $("#code_id").val();
            if(id=="" && email==""){
               $(".inputEmailNum").attr("class","row d-none inputEmailNum");
               $(".emailmsg").text("이메일을 입력해주세요.");
               $(".idmsg").text("아이디를 입력해주세요.");
               return;
            }
            if(email==""){
               $(".inputEmailNum").attr("class","row d-none inputEmailNum");
               $(".emailmsg").text("이메일을 입력해주세요.");
               $("#email_pw").focus();
               return;
            }else if(id==""){
               $(".inputEmailNum").attr("class","row d-none inputEmailNum");
               $(".idmsg").text("아이디를 입력해주세요.");
               $("#code_id").focus();
               return;
            }

            var code=$("#code_id").val();
            $.ajax({
               type : "post",
               url : "/membership/checkUserEmail",
               data : {email:email,code:code},
               success : function(data) {
                  if(data==1){
                     $(".inputEmailNum").attr("class","row inputEmailNum");
                     fn_sendEmail();
                  }else{
                     $(".idmsg").text("해당 정보와 일치하는 데이터가 없습니다.");
                  }
               }
            });
         }

         function fn_sendEmail(){
            var email=$("#email_pw").val();
            var code=$("#code_id").val();
            $.ajax({
               type : "post",
               url : "/email/pwfind.email",
               data : {email:email,code:code},
               dataType : "json",
               success : function(data) {
                  $(".emailmsg").css("color", "white");
                  $(".emailmsg").text('이메일 전송 성공! 이메일을 확인해 주세요');
                  getSeq=data.pwcomf;
                  getId=code;
               },
               error : function(e) {
                  $(".emailmsg").css("color", "red");
                  $(".emailmsg").text('존재하지 않은 이메일 입니다.');
               }
            });
         }

         function fn_authEmail(){
            if(isConfirm!="false"){
               return;
            }
            var emailNum=$("#EmailNum").val();
            if(getSeq==emailNum){
               isConfirm=getSeq;
               $(".authmsg").text("인증이 완료되었습니다.");
               html="";
               html+="<div class=row id=afterAuth>";
               html+="<div class='col-12 p-3'>";
               html+="<input type=password id=pw name=password class='form-control w-100' placeholder='새로운 비밀번호를 입력하세요.' required autocomplete=off>";
               html+="</div></div>";
               html+="<div class=row id=confirmmsg>";
               html+="<div class='col-12 p-3'>";
               html+="<input type=password id=checkPw class='form-control w-100' placeholder='비밀번호를 한번 더 입력하세요.' required autocomplete=off oninput=fn_checkPw()>";
               html+="</div></div>";
               html+="<div class=row id=checkmsgbox>";
               html+="<div class='col-12 p-3 checkmsg'>";
               html+="</div></div>";
               $(".sendAuth").after(html);

            }else{
               $(".authmsg").text("인증에 실패하였습니다.");
               return;
            }
         }

         function fn_changePw() {
            var pw = $("#pw").val();
            var check= $("#checkPw").val();
            var code= getId;
            if(pw==check){
               $.ajax({
                  type : "post",
                  url : "/membership/changePw",
                  data : {password:pw,code:code},
                  dataType : "json",
                  success : function(data) {
                     if(data==1){
                        $("#find-id-container").attr("class","flex-container  d-none");
                        $("#login-container").attr("class","flex-container");
                        $("#findPw-container").attr("class","flex-container d-none");
                        $("#find-pw-resetform")[0].reset();
                     }else{
                        alert("변경에 실패하였습니다.");
                        return;
                     }
                  }
               });
            }else{
               $(".checkmsg").text("비밀번호가 일치하지않습니다.");
               $("#btn-changePw").attr("disabled",true);
               $("#checkPw").focus();
            }
         }

         function fn_checkPw() {
            var setTime =setTimeout(function () {
               var pw = $("#pw").val();
               var check = $("#checkPw").val();
               if(pw==check){
                  $(".checkmsg").text("비밀번호가 일치합니다.");
                  $("#btn-changePw").attr("disabled",false);
                  return;
               }else{
                  $(".checkmsg").text("비밀번호가 일치하지않습니다.");
                  $("#btn-changePw").attr("disabled",true);
                  $("#checkPw").focus();
                  return;
               }
               if(check==""){
                  $("checkmsg").text("");
                  return;
               }
            },300)

         }

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
            <input type=button value="대사우 서비스" id=leaveBtn><br>
            <input type=button value="메인페이지 테스트" id=mainBtn><br>

               <%--용국--%>
            <button type="button" onclick="fn_toBD()">결재전</button>
            <button type="button" onclick="fn_toNFD()">진행중</button>
            <button type="button" onclick="fn_toFD()">완료된</button>
            <button type="button" onclick="fn_toRD()">반려한</button>
            <button type="button" onclick="fn_toNex()">넥사크로</button>
            <a href="#" onclick="fn_logout()">로그아웃</a>
            <button type="button" onclick="fn_managerMode()" style="display: none">관리자 모드</button>
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
         let leaveBtn = document.getElementById("leaveBtn");
         leaveBtn.onclick = function () {
            location.href = "/leave/toLeaveMain.leave";
         }

         let mainBtn = document.getElementById("mainBtn");
         mainBtn.onclick = function () {
            location.href = "/main";
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

         /*메신저 팝업 : messsenger*/
         function fn_messenger() {
            var popup = window.open('/messenger/contactList', 'messenger', 'width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
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

         function fn_toNex() {
            location.href ="/toNex";
         }

         function fn_logout() {
            localStorage.clear();
            location.href="/membership/logout";


         }
      </script>
   </c:otherwise>
</c:choose>
</body>
</html>