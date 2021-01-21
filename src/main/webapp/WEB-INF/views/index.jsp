<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
</head>
<body>
   <div class="wrapper d-flex align-items-stretch">
      <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%></%@>
      <div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">버그리포팅</h2>
			
			<button type="button" onclick="fn_board()">게시판 바로가기</button>
			
      </div>
   </div>
   <script>
   function fn_board() {
		location.href = "/noBoard/notificationBoardList.no"
	}
   	
   </script>
</body>
</html>