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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<style type="text/css">
*{
	font-size: 1rem;
}
div{
	text-overflow: ellipsis; white-space:nowrap; overflow:hidden;
}
#manageBtn{
	float: right;
}
.box{
	height: 300px;
	max-height: 300px;
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
            location.href = "/toNex";
         }
      </script>
      	<h2 class="mb-4">COCOAWORK</h2>
      		<div class="row">
	      		<div class="box col-12 col-md-6 p-2">
	      			<div>
	      				<div class="scheduleContainer">
							<ul class="nav nav-tabs">
								<li class="nav-item"><a class="nav-link active" data-toggle="tab"
									href="#draft" id="tab-all">기안함</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab"
									href="#pay" id="tab-com">결재함</a></li>
							</ul>
							<div class="col-12">
								<div class="tab-content">
									<div class="tab-pane fade show active pt-3" id="draft">
										<div class="row p-1">
											<div class="col-8 col-lg-5"><b>제목</b></div>
											<div class="d-none d-lg-block col-lg-4"><b>날짜</b></div>
											<div class="col-4 col-lg-3"><b>상태</b></div>
										</div>
										<c:forEach var="i" items="${docList }" begin="0" end="3">
											<div class="row p-1">
												<div class="col-8 col-lg-5"><a href="/document/toReadPage.document?seq=${i.seq }">${i.title }</a></div>
												<div class="d-none d-lg-block col-lg-4">${i.write_date }</div>
												<div class="col-4 col-lg-3">${i.status }</div>
											</div>
										</c:forEach>
									</div>
									<div class="tab-pane fade pt-3" id="pay">
										<div class="row p-1">
											<div class="col-8 col-lg-5"><b><a href="/document/toReadPage.document?seq=${i.seq }">제목</a></b></div>
											<div class="d-none d-lg-block col-lg-4"><b>날짜</b></div>
											<div class="col-4 col-lg-3"><b>상태</b></div>
										</div>
										<c:forEach var="i" items="${clist }" begin="0" end="3">
											<div class="row p-1">
												<div class="col-8 col-lg-5">${i.title }</div>
												<div class="d-none d-lg-block col-lg-4">${i.write_date }</div>
												<div class="col-4 col-lg-3">${i.status }</div>
											</div>
										</c:forEach>
									</div>
								</div>
								<div class="col-12 p-1 text-right pr-3 mt-2"><a href="/document/allDocument.document"><b>>>전체문서 이동하기</b> </a></div>
							</div>
						</div>
	      			</div>
	      		</div>
	      		<div class="box col-12 col-md-6 p-2">
	      			<h4 class="p-2 m-0">근태관리</h4>
					<body onload="printClock()">
						<div style="border:1px solid #dedede; width:300px; height:70px; line-height:70px; color:#666;font-size:50px; text-align:center;" id="clock"></div>
						<form action="/attendance/startWork" method="post">
							<button type="submit" onclick="fn_startWork()">출근</button>
							<button type="button" onclick="fn_endWork()">퇴근</button>
							<label> <input type="checkbox" name="outSide" id="outSide" value="out"> 외근 </label>
						</form>
						<div class="col-12 p-1 text-right pr-3 mt-2"><a href="/attendance/toAttendanceView"><b>>>근태관리 이동하기</b> </a></div>
					</body>
	      		</div>
	      		<div class="box col-12 col-md-6 p-2"><!-- 일정관리 -->
	      			<div class="text-center">
	      				<div class="col-12 p-3 " style="background-color: #ffedbd;">
	      					<b>${todayString}</b>
	      				</div>
	      				<div>
	      					<div class="row">
	      						<c:forEach var="i" items="${scheduleList}">
	      							<c:choose>
		      							<c:when test="${i.rownumber != 5}">
		      								<div class="col-12 p-1" onclick="fn_scheduleInfo(${i.seq})">${i.title }</div>
		      							</c:when>
		      							<c:otherwise>
		      								<div class="col-12 p-1">...</div>
		      							</c:otherwise>
	      							</c:choose>
	      						</c:forEach>
		      					<div class="col-12 p-1 text-right pr-3 mt-2"><a href="/schedule/toScheduleMain.schedule"><b>>>일정관리 이동하기</b> </a></div>

	      					</div>
	      				</div>
	      				<script>
	      				function fn_scheduleInfo(seq){
	      					var url = "/schedule/getSchedule.schedule?seq=${i.seq}" + seq + "&status=main";
	      					window.open(url,"PopupWin", "width=465,height=540;");
	      				}
	      				</script>
      				</div>
	      		</div>
	      		<div class="box col-12 col-md-6 p-2">
	      			<h4 class="p-2 m-0">회사 전체 공지</h4>
	      		</div>
      		</div>
      </div>
   </div>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
			// 	currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
			// }
			clock.innerHTML = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size:50px;'>"+ amPm+"</span>"; //날짜를 출력해 줌

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

		function fn_startWork() {	// 출근
			location.href = "/attendance/startWork";
		}
		function fn_endWork() {	// 퇴근
			location.href = "/attendance/endWork"
		}
	</script>
</body>
</html>