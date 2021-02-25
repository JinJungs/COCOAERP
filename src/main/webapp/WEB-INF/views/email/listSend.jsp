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
.title{
	overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
}
.delBtn{
	width: 50px;
	margin-left: 90%;
	margin-top: 10px;
}
input[type=checkbox]{
	width: 15px;
}
</style>
</head>
<body>
   <div class="wrapper d-flex align-items-stretch">
      <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
      <div id="content" class="p-4 p-md-5 pt-5" style="min-width: 450px;">
      	<h2 class="mb-4">내가 쓴 메일함</h2>
      	<div class="listContainer">
      		<div class="row p-3" style="border-bottom: 1px solid gray">
      			<div class="col-1"><b><input type=checkbox id="all" value=0></b></div>
      			<div class="col-1"><b>seq</b></div>
      			<div class="col-6 col-sm-4"><b>제목</b></div>
      			<div class="col-4 col-sm-3"><b>수신자</b></div>
      			<div class="d-none d-sm-block col-sm-3"><b>날짜</b></div>
      		</div>
      		<div class="list">
	      		<c:forEach var="list" items="${emailList }">
	      			<div class="row p-3" style="border-bottom: 1px solid gray">
      					<div class="col-1"><input type=checkbox name=delBox value="${list.seq }"></div>
      					<div class="col-1"><a href="/email/readPage.email?seq=${list.seq }">${list.rownumber }</a></div>
		      			<div class="col-6 col-sm-4 title"><a href="/email/readPage.email?seq=${list.seq }"><c:out value="${list.title }"></c:out></a></div>
		      			<div class="col-4 col-sm-3"><a href="/email/readPage.email?seq=${list.seq }">${list.receiver }</a></div>
		      			<div class="d-none d-sm-block col-sm-3 pl-4"><a href="/email/readPage.email?seq=${list.seq }">${list.write_date }</a></div>
		      		</div>
	      		</c:forEach>
      		</div>
      		<button type=button class="delBtn">삭제</button>
      		<script>
      			$(".delBtn").click(function(){
      				var checkedList = "";
      				$("input[type='checkbox']:checked").each(function(index){
      					if(index != 0 && index != 1){
      						checkedList+=",";
      					}
      					if($(this).val() != 0){
	      					checkedList += $(this).val();
	      				}
      				});
      				location.href="/email/deleteSendChecked.email?checkedList="+checkedList+"&status=send";
      			})
      			
      			$("#all").click(function(){
      				if($("input:checkbox[id=all]").prop("checked")){
      					$("input[type=checkbox]").prop("checked", true);
      				}else{
      					$("input[type=checkbox]").prop("checked", false);
      				}
      			});
      		</script>
      	</div>
      	<div class="navi text-center">${navi }</div>
      </div>
   </div>
</body>
</html>