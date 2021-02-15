<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style type="text/css">
*{
	font-size: 1rem;
}
#manageBtn{
	float: right;
}
.box{
	min-height: 300px;
	border-top: 0.5px solid gray;
	border-left: 0.5px solid gray;
	border-right: 0.5px solid gray;
	border-bottom: 0.5px solid gray;
}
</style>
</head>
<body>

   <div class="wrapper d-flex align-items-stretch">
      <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
      <div id="content" class="p-4 p-md-5 pt-5">
      <button id=manageBtn>관리자로 가기</button>
      <script>
      	let manageBtn = document.getElementById("manageBtn");
         manageBtn.onclick = function () {
            location.href = "";
         }
      </script>
      	<h2 class="mb-4">COCOAWORK</h2>
      		<div class="row">
	      		<div class="box col-12 col-md-6">
	      			<h4 class="p-2 m-0">전자결재</h4>
	      		</div>
	      		<div class="box col-12 col-md-6">
	      			<h4 class="p-2 m-0">근태관리</h4>
	      		</div>
	      		<div class="box col-12 col-md-6">
	      			<h4 class="p-2 m-0">오늘의 일정</h4>
	      			<div class="row">
	      				<div class="col-4"></div>
	      			</div> 
	      		</div>
	      		<div class="box col-12 col-md-6">
	      			<h4 class="p-2 m-0">회사 전체 공지</h4>
	      		</div>
      		</div>
      </div>
   </div>
</body>
</html>