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
	background-color : #6749b930;
}
.dataGroup {
	margin-top: 20px;
}
.left {
	width: 100px;
}

.row {
	padding: 20px;
	width: 100%;
	margin-left: 10px;
}

.contentsBox{
	min-height: 100px;
	height: 150px;
	overflow: y-scroll;
}
input{
	height: 100%;
}
select{
	width: 100px;
	height: 25px;
}
select[name=startTime], select[name=endTime]{
	margin-left: 10px;
}
textarea{
	min-width: 100%;
	max-width: 100%;
	min-height: 100%;
	max-height: 100%;
}
.buttonGroup{
	text-align: center;
}
.buttonGroup input{
	margin: 5px;
	margin-left: 10px;
}
.btn{
	background-color : #6749b930;
	padding: 3px 8px 3px 8px;
	border: 1px solid lightgray;
}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<div id="contents">
			<h2>세부일정</h2>
			<div class="container-fluid pt-3">
				<form action="/schedule/update.schedule?seq=${dto.seq }" method=post>
					<div class="row">
						<div class="left"><b>분류</b></div>
						<div class="col">
							<select name=openTarget id=openTarget>
								<option value=dept>부서</option>
								<option value=team>팀</option>
								<option value=personal selected>개인</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="left"><b>일정명</b></div>
						<div class="col"><input type=text name=title value="${dto.title }" maxlength=10 required></div>
					</div>
					<div class="row">
						<div class="left"><b>시작 날짜</b></div>
						<div class="col">
							<input type=date name=startDate value="${startDate }" id=startDate onchange="fn_dateControll()" required>
							<select name=startTime id=startTime onchange="fn_timeControll('start')" required>
								<option value="06">6시</option>
								<option value="07">7시</option>
								<option value="08">8시</option>
								<option value="09">9시</option>
								<option value="10">10시</option>
								<option value="11">11시</option>
								<option value="12" selected>12시</option>
								<option value="13">13시</option>
								<option value="14">14시</option>
								<option value="15">15시</option>
								<option value="16">16시</option>
								<option value="17">17시</option>
								<option value="18">18시</option>
								<option value="19">19시</option>
								<option value="20">20시</option>
								<option value="21">21시</option>
								<option value="22">22시</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="left"><b>마감 날짜</b></div>
						<div class="col">
							<input type=date name=endDate value="${endDate }" id=endDate onchange="fn_dateControll()" required>
							<select name=endTime id=endTime onchange="fn_timeControll('end')" required>
								<option value="06">6시</option>
								<option value="07">7시</option>
								<option value="08">8시</option>
								<option value="09">9시</option>
								<option value="10">10시</option>
								<option value="11">11시</option>
								<option value="12" selected>12시</option>
								<option value="13">13시</option>
								<option value="14">14시</option>
								<option value="15">15시</option>
								<option value="16">16시</option>
								<option value="17">17시</option>
								<option value="18">18시</option>
								<option value="19">19시</option>
								<option value="20">20시</option>
								<option value="21">21시</option>
								<option value="22">22시</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="left"><b>내용</b></div>
						<div class="col contentsBox">
							<textarea name=contents>${dto.contents }</textarea>
						</div>
					</div>
					<div class="row">
						<div class="left"><b>색</b></div>
						<div class="col">
							<select name="color" id=color required>
									<option value="#a4a6a5" id="#a4a6a5" class="#a4a6a5" style="background:#a4a6a5;color: white;">gray</option>
									<option value="#fc9a8d" id="#fc9a8d" class="#fc9a8d" style="background:#fc9a8d;color: white;">red</option>
									<option value="#f7cc54" id="#f7cc54" class="#f7cc54" style="background:#f7cc54;color: white;">yellow</option>
									<option value="#8cdba4" id="#8cdba4" class="#8cdba4" style="background:#8cdba4;color: white;">green</option>
									<option value="#8cd4db" id="#8cd4db" class="#8cd4db" style="background:#8cd4db;color: white;" selected>blue</option>
									<option value="#e1c9ff" id="#e1c9ff" class="#e1c9ff" style="background:#e1c9ff;color: white;">purple</option>
								</select>
						</div>
					</div>
					<script>
						//시작날짜, 마감날짜 입력
						$('#openTarget').val('${openTarget}').prop("selected",true)
						$('#startTime').val('${startTime}').prop("selected",true);
						$('#endTime').val('${endTime}').prop("selected",true);
						$('#color').val('${dto.color}').prop("selected",true);
						
						
						function fn_timeControll(obj){
							var startDate = document.getElementById("startDate");
							var endDate = document.getElementById("endDate");
							
							console.log("startDate : " + startDate.value);
							console.log("endDate : " + endDate.value);
							
							var startTime = document.getElementById("startTime");
							var endTime = document.getElementById("endTime");
							
							console.log("startTime : " + startTime.value);
							console.log("endTime : " + endTime.value);
							
							if(startDate.value == endDate.value && startTime.value > endTime.value){
								if(obj == "start"){
									$('#endTime').val(startTime.value).prop("selected",true);
								}else if(obj == "end"){
									alert("마감시간이 시작시간보다 빠르게 설정할 수 없습니다.");
									$('#endTime').val(startTime.value).prop("selected",true);
								}
							}
						}
						
						function fn_dateControll(){
							var startDate = document.getElementById("startDate");
							var endDate = document.getElementById("endDate");
							
							endDate.min = startDate.value;
								
							if(startDate.value > endDate.value){
								endDate.value = startDate.value;
							}
							
							fn_timeControll("start");
						}
					</script>
					<div class="buttonGroup">
						<input type="submit" class=btn value="수정" id="revise">
						<button type="button" class=btn id="cancel">취소</button>
					</div>
					<script>
			            var cancelBtn = document.getElementById("cancel");
						cancelBtn.onclick = function() {
			               location.href="/schedule/getSchedule.schedule?seq=${dto.seq}";
			            }
			            
					</script>
				</form>
			</div>
		</div>
	</div>
</body>
</html>