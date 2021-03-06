<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<style type="text/css">
#contents {
	width: 100%;
	min-width: 500px;
	height: 100%;
}

h2 {
	margin: 0;
	padding: 20px;
	background-color: #6749b930;
}

.left {
	width: 100px;
}

.dataGroup {
	margin-top: 20px;
}

.row {
	padding: 20px;
	width: 100%;
	margin-left: 10px;
}

.contentsBox {
	height: 200px;
	border: 1px solid lightgray;
	overflow: y-scroll;
}

.buttonGroup {
	text-align: center;
}

.btn {
	background-color: #6749b930;
	padding: 3px 8px 3px 8px;
	border: 1px solid lightgray;
}
</style>
</head>
<body>
	<div id="contents">
		<h2>세부일정</h2>
		<div class="container-fluid pt-3">
			<div class="row">
				<div class="left">
					<b>일정명</b>
				</div>
				<div class="col">
					<c:out value="${dto.title }"></c:out>
				</div>
			</div>
			<div class="row">
				<div class="left">
					<b>시작 날짜</b>
				</div>
				<div class="right col">${startTime }</div>
			</div>
			<div class="row">
				<div class="left">
					<b>마감 날짜</b>
				</div>
				<div class="right col">${endTime }</div>
			</div>
			<div class="row">
				<div class="left">
					<b>내용</b>
				</div>
				<div class="right col contentsBox">
					<c:out value="${dto.contents }"></c:out>
				</div>
			</div>
			<c:if test="${empCode eq dto.writer }">
				<div class="buttonGroup">
					<input type="button" class=btn value="수정" id="revise"> <input
						type="button" class=btn value="삭제" id="delete">
				</div>
			</c:if>
			<script>
					window.onload = function(){
							if(${didUpdate eq 'true'}){
								opener.document.location.href="/schedule/toScheduleMain.schedule";
							}
						}
					var reviseBtn = document.getElementById("revise");
					reviseBtn.onclick = function() {
		               location.href = "/schedule/toUpdate.schedule?seq=${dto.seq}";
		            }
		            var deleteBtn = document.getElementById("delete");
					deleteBtn.onclick = function() {
						var confirmResult = confirm("일정을 삭제하시겠습니까?");
						if(confirmResult == true){
							$.ajax({
			               		url: "/schedule/deleteSchedule.schedule?seq=${dto.seq}",
			               		type: "post",
			               		success: function(data){
			               			if(data == 1){
					               		alert("삭제되었습니다.");
			               			}else{
			               				alert("삭제를 실패했습니다.");
			               			}
			               			opener.document.location.href="/schedule/toScheduleMain.schedule";
			               			window.close();
					               },
					            error: function(){
					               		alert("에러발생");
					               }
				               })
							}
			            }
				</script>
		</div>
	</div>
</body>
</html>