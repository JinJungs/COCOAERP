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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="/js/bootstrap.min.js"></script>
<style type="text/css">
.addBtn {
	height: 80%;
}

#calendar-all #calendar-company #calendar-dept #calendar-team #calendar-private
	{
	width: 100%;
}

select {
	width: 100%;
	height: 100%;
}

textarea {
	width: 90%;
	min-height: 100px;
	max-height: 100px;
}

.dataGroup {
	margin-top: 20px;
}
</style>
</head>
<body onunload="fn_popUpClosed()">
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
		<div id="content" class="p-4 p-md-5 pt-5" style="min-width: 500px;">
			<h2 class="">일정</h2>
			<div class="scheduleContainer">
				<div class="text-right addBtn">
					<button type="button" class="btn btn-primary" data-toggle="modal"
						data-target="#addModal" data-whatever="@mdo">일정 추가</button>
				</div>
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active" data-toggle="tab"
						href="#all" id="tab-all">전체</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#company" id="tab-com">회사</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#dept" id="tab-dept">부서</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#team" id="tab-team">팀</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#personal" id="tab-personal">개인</a></li>
				</ul>
				<script>
					function fn_resize(){
					  	window.dispatchEvent(new Event('resize'));
					  }
					  
//					$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
//					  e.target // newly activated tab
//					  e.relatedTarget // previous active tab
//					  fn_resize();
//					});
					
					$(".nav-item").click(function(){
						setTimeout("fn_resize()",90);
					})
				</script>
				<div class="col-12">
					<div class="tab-content">
						<div class="tab-pane fade show active pt-3" id="all">
							<div id='calendar-all'></div>
						</div>
						<div class="tab-pane fade pt-3" id="company">
							<div id='calendar-company'></div>
						</div>
						<div class="tab-pane fade pt-3" id="dept">
							<div id='calendar-dept'></div>
						</div>
						<div class="tab-pane fade pt-3" id="team">
							<div id='calendar-team'></div>
						</div>
						<div class="tab-pane fade pt-3" id="personal">
							<div id='calendar-personal'></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	  document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar-all');
		
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      eventClick: function(info) {
	        var eventObj = info.event;
	            if (eventObj.start) {
	                alert(eventObj.title);
	            }
	        },
	      headerToolbar: {
	        left: 'dayGridMonth,dayGridWeek,dayGridDay',
	        center: 'title',
	        right: 'prev,next'
	      },
	      navLinks: true, // can click day/week names to navigate views
	      businessHours: true, // display business hours
	      editable: false,
	      selectable: true,
	      dayMaxEvents: true, // allow "more" link when too many events
	      events: [
		      <c:forEach var="i" items="${allSchedule}" varStatus="status">
			      		{
					      	title: '${i.title}',
					      	start: '${i.start_time}',
					      	end: '${i.end_time}',
					      	color: '${i.color}',
					      	url: '/schedule/getSchedule.schedule?seq=${i.seq}'
				      	}
			      	<c:choose>
			      		<c:when test="${status.last}">
			      		</c:when>
			      		<c:otherwise> 	
			      			,
			      		</c:otherwise>
			      	</c:choose>
		      </c:forEach>
	      ],
	      eventClick:function(arg) {
	      		arg.jsEvent.preventDefault();
	      		
                if(arg.event.url) {
                    window.open(arg.event.url,"PopupWin", "width=465,height=540;");
                    return false;
                }
            }
	    });
	    calendar.render();
	  });
	  
	   document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar-company');

	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      headerToolbar: {
	        left: 'dayGridMonth,dayGridWeek,dayGridDay',
	        center: 'title',
	        right: 'prev,next'
	      },
	      navLinks: true, // can click day/week names to navigate views
	      businessHours: true, // display business hours
	      editable: false,
	      selectable: true,
	      dayMaxEvents: true, // allow "more" link when too many events
	      events: [
		      <c:forEach var="i" items="${companySchedule}" varStatus="status">
			      		{
			      	title: '${i.title}',
			      	start: '${i.start_time}',
			      	end: '${i.end_time}',
			      	color: '${i.color}',
					url: '/schedule/getSchedule.schedule?seq=${i.seq}'
				      	}
			      	<c:choose>
			      		<c:when test="${status.last}">
			      		</c:when>
			      		<c:otherwise>
				      			,
			      		</c:otherwise>
			      	</c:choose>
		      </c:forEach>
	      ],
	      eventClick:function(arg) {
	      		arg.jsEvent.preventDefault();
	      		
                if(arg.event.url) {
                    window.open(arg.event.url,"PopupWin", "width=465,height=540;");
                    return false;
                }
            }
    }); 
	    calendar.render(); 
	  }); 
	  
	  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar-dept');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'dayGridMonth,dayGridWeek,dayGridDay',
        center: 'title',
        right: 'prev,next'
      },
      navLinks: true, // can click day/week names to navigate views
      businessHours: true, // display business hours
      editable: false,
      selectable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
      <c:forEach var="i" items="${deptSchedule}" varStatus="status">
      		{
	      	title: '${i.title}',
	      	start: '${i.start_time}',
	      	end: '${i.end_time}',
	      	color: '${i.color}',
			url: '/schedule/getSchedule.schedule?seq=${i.seq}'
	      	}
	      	<c:choose>
	      		<c:when test="${status.last}">
	      		</c:when>
	      		<c:otherwise>
	      			,
	      		</c:otherwise>
	      	</c:choose>
      </c:forEach>
      ],
	      eventClick:function(arg) {
	      		arg.jsEvent.preventDefault();
	      		
                if(arg.event.url) {
                    window.open(arg.event.url,"PopupWin", "width=465,height=540;");
                    return false;
                }
            }
    });
    calendar.render();
  });
  
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar-team');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'dayGridMonth,dayGridWeek,dayGridDay',
        center: 'title',
        right: 'prev,next'
      },
      navLinks: true, // can click day/week names to navigate views
      businessHours: true, // display business hours
      editable: false,
      selectable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
      <c:forEach var="i" items="${teamSchedule}" varStatus="status">
      		{
	      	title: '${i.title}',
	      	start: '${i.start_time}',
	      	end: '${i.end_time}',
	      	color: '${i.color}',
			url: '/schedule/getSchedule.schedule?seq=${i.seq}'
	      	}
	      	<c:choose>
	      		<c:when test="${status.last}">
	      		</c:when>
	      		<c:otherwise>
	      			,
	      		</c:otherwise>
	      	</c:choose>
      </c:forEach>
      ],
	      eventClick:function(arg) {
	      		arg.jsEvent.preventDefault();
	      		
                if(arg.event.url) {
                    window.open(arg.event.url,"PopupWin", "width=465,height=540;");
                    return false;
                }
            }
    });
    calendar.render();
  });
  
	  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar-personal');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'dayGridMonth,dayGridWeek,dayGridDay',
        center: 'title',
        right: 'prev,next'
      },
      navLinks: true, // can click day/week names to navigate views
      businessHours: true, // display business hours
      editable: false,
      selectable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
      <c:forEach var="i" items="${personalSchedule}" varStatus="status">
      		{
	      	title: '${i.title}',
	      	start: '${i.start_time}',
	      	end: '${i.end_time}',
	      	color: '${i.color}',
			url: '/schedule/getSchedule.schedule?seq=${i.seq}'
	      	}
	      	<c:choose>
	      		<c:when test="${status.last}">
	      		</c:when>
	      		<c:otherwise> 
	      			,
	      		</c:otherwise>
	      	</c:choose>
      </c:forEach>
      ],
	      eventClick:function(arg) {
	      		arg.jsEvent.preventDefault();
	      		
                if(arg.event.url) {
                    window.open(arg.event.url,"PopupWin", "width=465,height=540;");
                    return false;
                }
            }
    });
    calendar.render();
	  });
 	</script>

	<div class="modal fade" id="addModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" style="min-width: 500px">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정 추가</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/schedule/addSchedule.schedule" method=post>
					<div class="modal-body">
						<div class="row dataGroup">
							<div class="col-3 text-right">분류</div>
							<div class="col-3">
								<select name=openTarget>
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
								<input type=date name=startDate value="${today }" id=startDate onchange="fn_dateControll()" required>
							</div>
							<div class="col-3">
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
						<div class="row dataGroup">
							<div class="col-3 text-right">마감 날짜</div>
							<div class="col-4">
								<input type=date name=endDate value="${today }" id=endDate onchange="fn_dateControll()" required>
							</div>
							<div class="col-3">
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
						<div class="row dataGroup">
							<div class="col-3 text-right">내용</div>
							<div class="col-9">
								<textarea name=contents maxlength=50></textarea>
							</div>
						</div>
						<div class="row dataGroup">
							<div class="col-3 text-right">색</div>
							<div class="col-4">
								<select name="color" required>
									<option value="#a4a6a5" id="#a4a6a5" class="#a4a6a5" style="background:#a4a6a5;color: white;">gray</option>
									<option value="#fc9a8d" id="#fc9a8d" class="#fc9a8d" style="background:#fc9a8d;color: white;">red</option>
									<option value="#f7cc54" id="#f7cc54" class="#f7cc54" style="background:#f7cc54;color: white;">yellow</option>
									<option value="#8cdba4" id="#8cdba4" class="#8cdba4" style="background:#8cdba4;color: white;">green</option>
									<option value="#8cd4db" id="#8cd4db" class="#8cd4db"  style="background:#8cd4db;color: white;" selected>blue</option>
									<option value="#e1c9ff" id="#e1c9ff" class="#e1c9ff" style="background:#e1c9ff;color: white;">purple</option>
								</select>
							</div>
						</div>
						<script>
							function fn_timeControll(obj){
								var startDate = document.getElementById("startDate");
								var endDate = document.getElementById("endDate");
								
								var startTime = document.getElementById("startTime");
								var endTime = document.getElementById("endTime");
								
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