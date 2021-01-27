<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style type="text/css">
        div{border: 1px solid gray}
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
      <button type="button" onclick="fn_board()">게시판 바로가기</button>
	
      <!-- 효경 -->
      <input type=button value="저장된" id=temporaryBtn><br>
        <input type=button value="상신한" id=raiseBtn><br>
        <input type=button value="승인된" id=approvalBtn><br>
        <input type=button value="반려된" id=rejectBtn><br>
        <input type=button value="회수한" id=returnBtn><br>
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
         /*지영 부분*/
	   function fn_board() {
			location.href = "/noBoard/notificationBoardList.no"
		}
   	
   </script>
        
      </div>
   </div>
</body>
</html>