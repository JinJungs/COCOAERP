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
	<link rel="stylesheet"
		  href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
		  integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
		  crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
			integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
			crossorigin="anonymous"></script>

	<style type="text/css">
		div {
			text-overflow: ellipsis;
			white-space: nowrap;
			overflow: hidden;
		}
		#clock{
			width: 400px;
			height: 70px;
			line-height: 70px;
			color: #666;
			font-size: 36px;
		}
		#manageBtn {
			float: right;
		}

		.box {
			padding: 5px;
			border-top: 1px solid rgba(0, 0, 0, 0.125);
			border-left: 1px solid rgba(0, 0, 0, 0.125);
			border-right: 1px solid rgba(0, 0, 0, 0.125);
			border-bottom: 1px solid rgba(0, 0, 0, 0.125);
		}

		.comunity {
			height: 100%;
		}

		.email {
			background-color: #fbf6db;
		}


		.toB_LogBtn {
			text-align: center;
			padding: 10px;
			border: 0.5px solid lightgray;
			margin: 10px 0px 10px 0px;
		}
		#btnStart, #btnEnd{
			height: 30px;
			padding: 2px 5px 2px 5px;
		}
	</style>
</head>
<body onload="printClock()" style="min-width: 450px;">
<div class="wrapper d-flex align-items-stretch">
	<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
	<!-- Page Content  -->
	<div id="content" class="p-4 p-md-5 pt-5">
		<c:if test="${deptCode != 0 }"><!-- 행정부코드로 지정하면 되는데 테스트시 불편할까봐 임시로 넣어놓음 -->
		<button id=manageBtn class="btn btn-primary">관리자로 가기</button>
		<script>
			let manageBtn = document.getElementById("manageBtn");
			manageBtn.onclick = function () {
				location.href = "/toNex";
			}
		</script>
		</c:if>
		<h2 class="mb-2">COCOAWORK</h2>
		<div class="row">
			<div class="box attendance col-12 mb-3">
				<div class="row">
					<div class="col-12 col-sm-7" id="clock"></div>
					<div class="col text-left text-sm-right p-sm-3">
						<button type="button" class="mr-1 btn btn-outline-dark" id=btnStart onclick="fn_openInModal()">출근하기</button>
						<button type="button" class="mr-1 btn btn-outline-dark" id=btnEnd onclick="fn_openOutModal()">퇴근하기</button>
						<input type="checkbox" name="outSide" id="outSide" value="out"> 외근
					</div>
				</div>
				<div class="col-12 p-1 text-right pr-3 mt-2">
					<a href="/attendance/toAttendanceView"><b>>>근태관리 이동하기</b> </a>
				</div>
			</div>
			<script>
				function fn_startWork() {   // 출근
					location.href = "/attendance/startWork";
				}
				function fn_endWork() {   // 퇴근
					location.href = "/attendance/endWork"
				}
			</script>
		</div>
		<div class="row">
			<div class="col-12 col-md-5 box mr-3 mb-3">
				<div class="row">
					<div class="comunity col-12 pt-1 pb-3" style="min-height: 200px;">
						<div class="row">
							<div class="col-12 pb-1" style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);">
								<h5 class="p-2 m-0">
									<b>회사 전체 공지</b>
								</h5>
							</div>
						</div>
						<input type="hidden" name="writer_code" value="${writer_code}">
						<div class="row pt-2">
							<div class="col-8 pl-4">
								<b>제목</b>
							</div>
							<div class="on col-4">
								<b>부서</b>
							</div>
						</div>
						<div class="top row">
							<c:forEach var="n" items="${noBoardList}" begin="0" end="3">
								<div class="col-8 p-1 pl-4">
									<a
											href="/noBoard/notificationBoardRead.no?menu_seq=1&seq=${n.seq }&writer_code=${n.writer_code}">${n.title }</a>
								</div>
								<div class="on col-4 p-1">${n.name }</div>
							</c:forEach>
							<div class="col-12 p-1 text-right pr-3 mt-2">
								<a
										href="/noBoard/notificationBoardList.no?menu_seq=1&writer_code=${writer_code }"><b>>>회사소식
									이동하기</b> </a>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="email col-12 pt-3 pb-3" style="min-height: 200px;">
						<div class="row">
							<div class="col-12 pb-1" style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);">
								<h5 class="p-2 m-0">
									<b>받은 메일함</b>
								</h5>
							</div>
						</div>
						<div class="row pt-2">
							<div class="col-4 col-md-6 col-xl-4 pl-4">
								<b>제목</b>
							</div>
							<div class="col-4 d-md-none d-xl-block col-xl-4 pl-4">
								<b>날짜</b>
							</div>
							<div class="col-4 col-md-6 col-xl-4 pl-4">
								<b>발신자</b>
							</div>
						</div>
						<c:forEach var="i" items="${emailList }" begin="0" end="3">
							<div class="row p-1">
								<div class="col-4 col-md-6 col-xl-4">
									<a href="/email/readPage.email?seq=${i.seq }">${i.title }</a>
								</div>
								<div class="col-4 d-md-none d-xl-block col-xl-4">${i.write_date }</div>
								<div class="col-4 col-md-6 col-xl-4">${i.sender }</div>
							</div>
						</c:forEach>
						<div class="col-12 p-1 text-right pr-3 mt-2">
							<a href="/email/receiveList.email?cpage=1"><b>>>메일함 이동하기</b></a>
						</div>
					</div>

				</div>


				<!-- 보낸 업무일지 -->
				<!-- 내용보이기 - 보낸이,제목, 날짜, 상태-->
				<div class="top row">
					<div class="col-12 pt-3 pb-3" style="min-height: 200px;">
						<div class="row">
							<div class="col-12 pb-1" style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);">
								<h5 class="p-2 m-0">
									<b>보낸 업무일지함</b>
								</h5>
							</div>
						</div>

						<div class="toB_LogBtn" id="toBusinessLog">
							<b>업무일지 작성</b>
						</div>
						<script>
							let toBusinessLog = document.getElementById("toBusinessLog");
							toBusinessLog.onclick = function () {
								location.href = "/log/logCreate.log";
							}
						</script>
						<div class="row">
							<div class="on col-5 col-md-6 col-xl-5 pl-4">
								<b>제목</b>
							</div>
							<div class="on col-4 d-md-none d-xl-block col-xl-4 pl-4">
								<b>날짜</b>
							</div>
							<div class="on col-3 col-md-6 col-xl-3 pl-4">
								<b>상태</b>
							</div>
						</div>
						<c:forEach var="n" items="${logAllList}" begin="0" end="3">
							<div class="row">
								<div class="col-5 col-md-6 col-xl-5 pl-4">
									<a
											href="/log/logRead.log?menu_seq=1&seq=${n.seq }&writer_code=${n.writer_code}">${n.title }</a>
								</div>
								<div class="on col-4 d-md-none d-xl-block col-xl-4 pl-4">${n.write_date }</div>
								<div class="on col-3 col-md-6 col-xl-3 pl-4">
									<c:choose>
										<c:when test="${n.status eq 'CONFIRM'}">
											<div class="on">승인</div>
										</c:when>
										<c:when test="${n.status eq 'RAISE'}">
											<div class="on">대기</div>
										</c:when>
										<c:when test="${n.status eq 'REJECT'}">
											<div class="on">거절</div>
										</c:when>
									</c:choose>
								</div>
							</div>
						</c:forEach>
						<div class="col-12 p-1 text-right pr-3 mt-2">
							<a href="/log/logSentBoard.log"><b>>>보낸 업무일지함 이동하기</b></a>
						</div>
					</div>
				</div>
			</div>

			<div class="col">
				<div class="row mb-3">
					<div class="box col-12">
						<!-- 일정관리 -->
						<div class="text-center">
							<div class="tab-pane fade show active pt-3" id="all">
								<div id='calendar-all'></div>
							</div>
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
											left: '',
											center: 'title',
											right: ''
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
												url: '/schedule/getSchedule.schedule?seq=${i.seq}&status=main'
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
							<div class="col-12 p-1 text-right pr-3 mt-2">
								<a href="/schedule/toScheduleMain.schedule"><b>>>일정관리
									이동하기</b> </a>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="box col-12 pt-3">
						<div class="scheduleContainer">
							<ul class="nav nav-tabs">
								<li class="nav-item"><a class="nav-link active"
														data-toggle="tab" href="#draft" id="tab-all">기안함</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab"
														href="#pay" id="tab-com">결재함</a></li>
							</ul>
							<div class="col-12">
								<div class="tab-content">
									<div class="tab-pane fade show active pt-3" id="draft">
										<div class="row p-1">
											<div class="col-8 col-lg-5 pl-4">
												<b>제목</b>
											</div>
											<div class="d-none d-lg-block col-lg-4 pl-4">
												<b>날짜</b>
											</div>
											<div class="col-4 col-lg-3">
												<b>상태</b>
											</div>
										</div>
										<c:forEach var="i" items="${docList }" begin="0" end="3">
											<div class="row p-1">
												<div class="col-8 col-lg-5">
													<a href="/document/toReadPage.document?seq=${i.seq }">${i.title }</a>
												</div>
												<div class="d-none d-lg-block col-lg-4">${i.write_date }</div>
												<div class="col-4 col-lg-3">${i.status }</div>
											</div>
										</c:forEach>
									</div>
									<div class="tab-pane fade pt-3" id="pay">
										<div class="row p-1">
											<div class="col-8 col-lg-5">
												<b><a
														href="/document/toReadPage.document?seq=${i.seq }">제목</a></b>
											</div>
											<div class="d-none d-lg-block col-lg-4">
												<b>날짜</b>
											</div>
											<div class="col-4 col-lg-3">
												<b>상태</b>
											</div>
										</div>
										<c:forEach var="i" items="${clist }" begin="0" end="4">
											<div class="row p-1">
												<div class="col-8 col-lg-5"><a href="/document/toReadPage.document?seq=${i.seq }">${i.title }</a></div>
												<div class="d-none d-lg-block col-lg-4">${i.write_date }</div>
												<div class="col-4 col-lg-3">${i.status }</div>
											</div>
										</c:forEach>
									</div>
								</div>
								<div class="col-12 p-1 text-right pr-3 mt-2">
									<a href="/document/allDocument.document"><b>>>전체문서
										이동하기</b> </a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal" tabindex="-1" role="dialog" data-backdrop="false" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<b id="workMsg" style="white-space:normal;"></b>
			</div>
			<div class="modal-footer border-top-0">
				<button type="button" class="btn btn-primary btn-sm" id="btn_ok" data-dismiss="modal" onclick="fn_in()">네</button>
				<button type="button" class="btn btn-dark btn-sm" data-dismiss="modal" >아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade " id="resultModal" data-backdrop="false" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-sm" role="document" >
		<div class="modal-content">
			<div class="modal-body d-flex justify-content-center h-100 pt-5" style="min-height: 120px;">
				<b id="atdResultMsg">출근이 처리가 완료 되었습니다.</b>
			</div>
		</div>
	</div>
</div>
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	function printClock() {
		var clock = document.getElementById("clock");            // 출력할 장소 선택
		var currentDate = new Date();                                     // 현재시간
		var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
		var amPm = 'AM'; // 초기값 AM
		var currentHours = addZeros(currentDate.getHours(),2);
		var currentMinute = addZeros(currentDate.getMinutes() ,2);
		var currentSeconds =  addZeros(currentDate.getSeconds(),2);

		if(currentHours >= 12){ // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
			amPm = 'PM';
			currentHours = addZeros(currentHours - 12,2);
		}

		// if(currentSeconds >= 50){// 50초 이상일 때 색을 변환해 준다.
		//    currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
		// }
		clock.innerHTML = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size: 24px;'>"+ amPm+"</span>"; //날짜를 출력해 줌

		setTimeout("printClock()",1000);         // 1초마다 printClock() 함수 호출
	}

	function addZeros(num, digit) { // 자릿수 맞춰주기
		var zero = '';
		num = num.toString();
		if (num.length < digit) {
			for (i = 0; i < digit - num.length; i++) {
				zero += '0';
			}
		}
		return zero + num;
	}

	function fn_openInModal() {
		$("#btn_ok").attr("onclick","fn_in()");
		$.ajax({
			type : "POST",
			url : "/restattendance/isInWork",
			success : function(data) {
				if(data==""){
					var time=getHours();
					$("#modal").modal('show');
					$("#workMsg").text("현재 시각:"+time+"입니다. 출근하시겠습니까?");
				}else{
					$("#modal").modal('show');
					$("#workMsg").text("이미 출근 기록이 있습니다. ("+data+") 다시 출근 처리하시겠습니까?");
				}
			}
		});
	}

	function fn_in() {
		var out = $("input[name='out']:checked").val();
		$.ajax({
			type : "POST",
			data : {out:out},
			url : "/restattendance/atdIn",
			success : function(data) {
				if(data=="updateSuccess") {
					$("#resultModal").modal('show');
					$("#atdResultMsg").text("출근 시간 변경이 완료되었습니다.");
					var setTime = setTimeout(function () {
						$("#resultModal").modal('hide');
					},1000)
					fn_getIsWork()
					return;
				}
				if(data=="insertSuccess"){
					$("#resultModal").modal('show');
					$("#atdResultMsg").text("출근 처리가 완료 되었습니다.");
					var setTime = setTimeout(function () {
						$("#resultModal").modal('hide');
					},1000)
					fn_getIsWork();
					return;
				}

			}
		});
	}

	function fn_openOutModal(){
		$("#btn_ok").attr("onclick","fn_out()");
		$.ajax({
			type : "POST",
			url : "/restattendance/isOutWork",
			success : function(data) {
				var date = new Date();
				var hour = date.getHours();
				var min = date.getMinutes();
				var sec = date.getSeconds();
				var time =hour+":"+min+":"+sec;

				if(data=="nyInWork"){
					$("#resultModal").modal('show');
					$("#atdResultMsg").text("출근 기록이 없습니다.");
					var setTime = setTimeout(function () {
						$("#resultModal").modal('hide');
					},1000)
					return;
				}
				if(hour<18){
					var time=getHours();
					$("#modal").modal('show');
					$("#workMsg").text("아직 퇴근 시간이 아닙니다. ("+time+") 퇴근 처리 하시겠습니까?");
					return;
				}
				if(data==""){
					var time=getHours();
					$("#modal").modal('show');
					$("#workMsg").text("현재 시각:"+time+"입니다. 퇴근 처리 하시겠습니까??");
				}else{
					$("#modal").modal('show');
					$("#workMsg").text("이미 퇴근 기록이 있습니다. ("+data+") 다시 퇴근 처리하시겠습니까?");
				}
			}
		});
	}

	function fn_out(){
		$.ajax({
			type : "POST",
			url : "/restattendance/atdOut",
			success : function(data) {
				if(data=="updateSuccess") {
					$("#resultModal").modal('show');
					$("#atdResultMsg").text("퇴근 시간 변경이 완료되었습니다.");
					var setTime = setTimeout(function () {
						$("#resultModal").modal('hide');
					},1000)
					fn_reload();
					return;
				}
				if(data=="insertSuccess"){
					$("#resultModal").modal('show');
					$("#atdResultMsg").text("퇴근 처리가 완료 되었습니다.");
					var setTime = setTimeout(function () {
						$("#resultModal").modal('hide');
					},1000)
					fn_reload();
					return;
				}
			}
		});
	}
</script>
<script src="/js/bootstrap.min.js"></script>
</body>
</html>