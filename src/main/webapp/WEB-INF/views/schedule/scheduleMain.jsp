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
<style type="text/css">
.container {
	width: 100%;
}

#contents {
	height: 100%;
	width: 100%;
}

.body {
	height: 50%;
}

.footer {
	text-align: right
}
.addBtn{
	height: 80%;
}
#calendar{
	height: 100%;
	width: 100%;
	margin-top: 20px;
}
select{
	width: 100%;
	height: 100%;
}
textarea{
	width: 90%;
	min-height: 100px;
	max-height: 100px;
}
.dataGroup{
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<script>
		   $("#sidebarCollapse").on("click",function(){
		      $(".fc-col-header ").css({
		         "width": "100%"
		       });
		      $(".fc-daygrid-body").css({
		         "width": "100%"
		       });
		      $(".fc-scrollgrid-sync-table").css({
		         "width": "100%"
		       });
		   });
		</script>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5" style="min-width: 600px;">
			<h2 class="">일정</h2>
			<div class="scheduleContainer">
				<div class="text-right addBtn">
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal" data-whatever="@mdo">일정 추가</button>
				</div>
				<div class="row calendar">
					<div class="col-12 calendar">
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#total">전체</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#company">회사</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#dept">부서</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#team">팀</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#private">개인</a></li>
						</ul>
						
						<div class="tab-content">
							<div class="tab-pane fade show active" id="total">
								<div id='calendar'></div>
								<script>
									  document.addEventListener('DOMContentLoaded', function() {
									    var calendarEl = document.getElementById('calendar');
									
									    var calendar = new FullCalendar.Calendar(calendarEl, {
									      headerToolbar: {
									        left: 'dayGridMonth,dayGridWeek,dayGridDay',
									        center: 'title',
									        right: 'prevYear,prev,next,nextYear'
									      },
									      initialDate: '2020-09-12',
									      navLinks: true, // can click day/week names to navigate views
									      businessHours: true, // display business hours
									      editable: false,
									      selectable: true,
									      dayMaxEvents: true, // allow "more" link when too many events
									      events: []
									    });
									
									    calendar.render();
									  });
									</script>
							</div>
							<div class="tab-pane fade" id="company">회사일정</div>
							<div class="tab-pane fade" id="dept">부서일정</div>
							<div class="tab-pane fade" id="team">팀일정</div>
							<div class="tab-pane fade" id="private">개인일정</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
     	</div>
			<form action="/schedule/addSchedule.schedule" method=post>
				<div class="modal-body">

					<div class="row dataGroup">
						<div class="col-3 text-right">분류</div>
						<div class="col-3">
							<select name=openTarget>
								<option value=company>회사전체</option>
								<option value=dept>부서</option>
								<option value=team>팀</option>
								<option value=personal selected>개인</option>
							</select>
						</div>
					</div>
					<div class="row dataGroup">
						<div class="col-3 text-right">일정명</div>
						<div class="col-9">
							<input type=text name=title maxlength=10 required>
						</div>
					</div>
					<div class="row dataGroup">
						<div class="col-3 text-right">시작 날짜</div>
						<div class="col-4">
							<input type=date name=startDate value="2021-02-05" required>
						</div>
						<div class="col-3">
							<select name=startTime>
								<option value="6">6시</option>
								<option value="7">7시</option>
								<option value="8">8시</option>
								<option value="9">9시</option>
								<option value="10">10시</option>
								<option value="11">11시</option>
								<option value="12">12시</option>
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
					<div class="row dataGroup">
						<div class="col-3 text-right">마감 날짜</div>
						<div class="col-4">
							<input type=date name=endDate value="2021-02-06" required>
						</div>
						<div class="col-3">
							<select name=endTime>
								<option value="6">6시</option>
								<option value="7">7시</option>
								<option value="8">8시</option>
								<option value="9">9시</option>
								<option value="10">10시</option>
								<option value="11">11시</option>
								<option value="12">12시</option>
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
					<div class="row dataGroup">
						<div class="col-3 text-right">내용</div>
						<div class="col-9">
							<textarea name=contents maxlength=50></textarea>
						</div>
					</div>
					<div class="row dataGroup">
						<div class="col-3 text-right">색</div>
						<div class="col-4">
							<select name="color">
								<option value="#ffffff" id="#ffffff" class="#000000">흰배경
									검정글씨</option>
								<option value="#e34b4b" id="#e34b4b" class="#ffffff">붉은배경
									흰글씨</option>
								<option value="#bbeb91" id="#bbeb91" class="#000000">녹색배경
									검정글씨</option>
								<option value="#66cade" id="#66cade" class="#000000" selected>하늘색
									배경 검정글씨</option>
								<option value="#8383e6" id="#8383e6" class="#000000">보라색
									배경 검정글씨</option>
							</select>
						</div>
					</div>


				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button class="btn btn-primary">추가</button>
				</div>
			</form>
		</div>
  </div>
</div>
</body>
</html>