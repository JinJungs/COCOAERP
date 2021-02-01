<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style type="text/css">
#contents{
	height:100%;
	width:100%;
}
.body{height: 50%;}
.footer{text-align: right}
input{width:100%}

</style>
</head>
<body>

   <div class="wrapper d-flex align-items-stretch">
      <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
      <div id="content" class="p-4 p-md-5 pt-5" style="min-width: 400px;">
      	<h2 class="mb-4">내가 쓴 메일함</h2>
      	<div class="listContainer">
      		<div class="row p-3" style="border-bottom: 1px solid gray">
      			<div class="col-1">seq</div>
      			<div class="col-3">발신자</div>
      			<div class="col-5">제목</div>
      			<div class="col-3">날짜</div>
      		</div>
      	</div>
      </div>
   </div>
</body>
</html>