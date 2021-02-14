<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href='/lib/main.css' rel='stylesheet' />
<script src='/lib/main.js'></script>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<style type="text/css">
div{
	//border: 1px solid pink;
}
.container{
	border-top: 1px solid lightgray;
	padding-top: 20px;
	margin: center;
}
#contents {
	border: 1px solid black;
	width: 500px;
	max-width: 500px;
	min-height: 580px;
	max-height: 580px;
	mrgin-left: center;
}

.body {
	height: 50%;
}

.footer {
	text-align: right
}
h2 {
	margin-left: 20px;
}
.dataGroup {
	margin-top: 20px;
}
.row {
	padding: 20px;
	float: left;
}
.left{
	text-align: right;
	width: 80px;
	float: left;
}
.right{
	text-align: left;
	width: 350px;
	float: left;
	margin-left: 20px;
}
.contentsBox{
	height: 200px;
	border: 1px solid lightgray;
	overflow: y-scroll;
}
.buttonGroup{
	margin-left: 185px;
}
.buttonGroup input{
	margin: 5px;
	margin-left: 10px;
}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<div id="contents" class="p-4 p-md-5 pt-5">
			<h2>세부일정</h2>
			<div class="container">
				<div class="row">
					<div class="left"><b>일정명</b></div>
					<div class="right">${dto.title }</div>
				</div>
				<div class="row">
					<div class="left"><b>시작 날짜</b></div>
					<div class="right">${dto.start_time }</div>
				</div>
				<div class="row">
					<div class="left"><b>마감 날짜</b></div>
					<div class="right">${dto.end_time }</div>
				</div>
				<div class="row">
					<div class="left"><b>내용</b></div>
					<div class="right contentsBox">${dto.contents }</div>
				</div>
				<c:if test="${empCode eq dto.writer }">
					<div class="buttonGroup">
						<input type="button" value="수정" id="revise">
						<input type="button" value="삭제" id="delete">
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
	</div>
</body>
</html>