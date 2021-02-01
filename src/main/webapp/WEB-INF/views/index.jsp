<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style type="text/css">
        #contents{height:100%;width:100%;}
        .body{height: 50%;}
        .footer{text-align: right}
        input{width:100%}

</style>
</head>
<body>

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
            location.href = "/membership/myInfo"
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
        
      </div>
   </div>
</body>
</html>