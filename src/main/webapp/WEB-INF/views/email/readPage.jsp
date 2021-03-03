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
.mailContainer{
	border: 1px solid #c9c9c9;
}
.title{
	font-size: 1.3rem;
}
textarea{
	width: 100%;
	height: 400px;
	min-height: 300px;
	max-height: 500px;
	overflow-y: scroll;
	background-color: #fbfbfb;
	border: 0.5px solid lightgray;
}
textarea:focus{
	outline: none;
} 
button{
	margin-left: 90%;
}
</style>
</head>
<body>
   <div class="wrapper d-flex align-items-stretch">
      <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
      <div id="content" class="p-4 p-md-5 pt-5" style="min-width: 400px;">
      	<h2 class="mb-4">메일함</h2>
      	<div class="mailContainer p-5">
      		<div class="row">
      			<div class="col-10 title p-0 mb-2"><b><c:out value="${dto.title }"></c:out></b></div>
      		</div>
      		<div class="row">
      			<div class="col-3 col-sm-2 p-1 ml-1"><b>전송 날짜</b></div>
      			<div class="col-6 p-1 ml-1">${dto.write_dateString }</div>
      		</div>
      		<div class="row">
      			<div class="col-3 col-sm-2 p-1 ml-1"><b>보낸 사람</b></div>
      			<div class="col-6 p-1 ml-1">${dto.sender }</div>
      		</div>
      		<div class="row pb-4" style="border-bottom: 1px solid #c9c9c9">
      			<div class="col-3 col-sm-2 p-1 ml-1"><b>받는 사람</b></div>
      			<div class="col-6 p-1 ml-1"><c:out value="${dto.receiver }"></c:out></div>
      		</div>
      		
      		<div class="row pt-3">
      			<div class="col-5 p-1 ml-1"><b>첨부파일</b></div>
      		</div>
      		<div class="row">
      			<div class="col-12 ml-3 p-1 ml-1">
					<c:forEach var="list" items="${fileList }">
						<div class="row">
							<div class="col-12"><a href="/email/fileDownload.email?seq?seq=${list.seq}&savedname=${list.savedname}&oriname=${list.oriname}">${list.oriname }</a></div>
						</div>
					</c:forEach>
				</div>
      		</div>
      		
      		<div class="row mt-3">
      			<div class="col-12 p-0 ml-1" id="contents">
      				<textarea readonly>${dto.contents }</textarea>
      			</div>
      		</div>
      		
      	</div>
      	<div class="row mt-2 btn">
	      	<c:if test="${dto.receiver eq email && dto.sender ne email && dto.status_receiver eq 'SEND'}">
	      		<button id=reply>답장</button>
		      		<script>
		      			$("#reply").click(function(){
		      				var confirmResult = confirm("메일을 삭제하시겠습니까?");
		      				if(!confirmResult){
		      					return false;
		      				}
		      				location.href = "/email/replyEmail.email?seq=" + ${dto.seq};
		      			})
		      		</script>
	      	</c:if>
      		<c:choose>
				<c:when test="${dto.status_sender eq 'SEND' && dto.sender eq email && dto.receiver eq email}">
		      		<button id=delete>삭제</button>
		      		<script>
		      			$("#delete").click(function(){
		      				var confirmResult = confirm("메일을 삭제하시겠습니까?");
		      				if(!confirmResult){
		      					return false;
		      				}
		      				location.href = "/email/deleteToMeEmail.email?seq=" + ${dto.seq};
		      			})
		      		</script>
	      		</c:when>
	      		<c:when test="${dto.status_sender eq 'SEND' && dto.sender eq email && dto.receiver ne email}">
		      		<button id=delete>삭제</button>
		      		<script>
		      			$("#delete").click(function(){
		      				var confirmResult = confirm("메일을 삭제하시겠습니까?");
		      				if(!confirmResult){
		      					return false;
		      				}
		      				location.href = "/email/deleteSendEmail.email?seq=" + ${dto.seq};
		      			})
		      		</script>
	      		</c:when>
	      		<c:when test="${dto.status_receiver eq 'SEND' && dto.sender ne email && dto.receiver eq email}">
		      		<button id=delete>삭제</button>
		      		<script>
		      			$("#delete").click(function(){
		      				var confirmResult = confirm("메일을 삭제하시겠습니까?");
		      				if(!confirmResult){
		      					return false;
		      				}
		      				location.href = "/email/deleteReceiveEmail.email?seq=" + ${dto.seq};
		      			})
		      		</script>
	      		</c:when>
	      		<c:when test="${dto.status_sender eq 'DEL' && dto.sender eq email && dto.receiver eq email}">
		      		<button id=delete>영구삭제</button>
		      		<script>
		      			$("#delete").click(function(){
		      				var confirmResult = confirm("메일을 영구삭제하시겠습니까?");
		      				if(!confirmResult){
		      					return false;
		      				}
		      				location.href = "/email/deleteToMeNEmail.email?seq=" + ${dto.seq};
		      			})
		      		</script>
	      		</c:when>
	      		<c:when test="${dto.status_sender eq 'DEL' && dto.sender eq email && dto.receiver ne email}">
		      		<button id=delete>영구삭제</button>
		      		<script>
		      			$("#delete").click(function(){
		      				var confirmResult = confirm("메일을 영구삭제하시겠습니까?");
		      				if(!confirmResult){
		      					return false;
		      				}
		      				location.href = "/email/deleteSendNEmail.email?seq=" + ${dto.seq};
		      			})
		      		</script>
	      		</c:when>
	      		<c:when test="${dto.status_receiver eq 'DEL' && dto.sender ne email && dto.receiver eq email}">
		      		<button id=delete>영구삭제</button>
		      		<script>
		      			$("#delete").click(function(){
		      				var confirmResult = confirm("메일을 영구삭제하시겠습니까?");
		      				if(!confirmResult){
		      					return false;
		      				}
		      				location.href = "/email/deleteReceiveNEmail.email?seq=" + ${dto.seq};
		      			})
		      		</script>
	      		</c:when>
      		</c:choose>
      	</div>
      </div>
   </div>
<script src="/js/bootstrap.min.js"></script>
</body>
</html>