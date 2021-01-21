<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<<<<<<< HEAD
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
=======
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

		  </div>
		
	</div>


>>>>>>> a2c5e81139bec4d71a1078b22015318a1279e0b3
</body>
</html>