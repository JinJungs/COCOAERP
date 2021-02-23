<%@ page language="java" contentType="text/html; charset=UTF-8"
<<<<<<< HEAD
	pageEncoding="UTF-8"%>
=======
   pageEncoding="UTF-8"%>
>>>>>>> 07a9f540299ea61a8d581a58faa36dea32ca22fb
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<link href='/lib/main.css' rel='stylesheet' />
<script src='/lib/main.js'></script>
<link rel="stylesheet"
<<<<<<< HEAD
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>
<style type="text/css">
div {
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}

#manageBtn {
	float: right;
}

.box {
	padding: 5px;
	border-top: 0.5px solid lightgray;
	border-left: 0.5px solid lightgray;
	border-right: 0.5px solid lightgray;
	border-bottom: 0.5px solid lightgray;
}

.comunity {
	height: 100%;
}

.email {
	background-color: #fbf6db;
}

.on, #on {
	text-align: center;
}

.top {
	padding: 10px;
	padding-top: 20px;
}

</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<button id=manageBtn>관리자로 가기</button>
			<script>
=======
   href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
   integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
   crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
   integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
   crossorigin="anonymous"></script>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
   crossorigin="anonymous"></script>
<style type="text/css">
div {
   text-overflow: ellipsis;
   white-space: nowrap;
   overflow: hidden;
}

#manageBtn {
   float: right;
}

.box {
   padding: 5px;
   border-top: 0.5px solid lightgray;
   border-left: 0.5px solid lightgray;
   border-right: 0.5px solid lightgray;
   border-bottom: 0.5px solid lightgray;
}

.comunity {
   height: 100%;
}

.email {
   background-color: #fbf6db;
}

.on, #on {
   text-align: center;
}

.top {
   padding: 10px;
   padding-top: 20px;
}

</style>
</head>
<body>
   <div class="wrapper d-flex align-items-stretch">
      <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
      <!-- Page Content  -->
      <div id="content" class="p-4 p-md-5 pt-5">
         <button id=manageBtn>관리자로 가기</button>
         <script>
>>>>>>> 07a9f540299ea61a8d581a58faa36dea32ca22fb
         let manageBtn = document.getElementById("manageBtn");
         manageBtn.onclick = function () {
            location.href = "/toNex";
         }
      </script>
<<<<<<< HEAD
			<h2 class="mb-2">COCOAWORK</h2>
			<div class="row">
				<div class="box attendance col-12 mb-3">
					<body onload="printClock()">
						<div
							style="border: 1px solid #dedede; width: 300px; height: 70px; line-height: 70px; color: #666; font-size: 50px; text-align: center;"
							id="clock"></div>
						<form action="/attendance/startWork" method="post">
							<button type="submit" onclick="fn_startWork()">출근</button>
							<button type="button" onclick="fn_endWork()">퇴근</button>
							<label> <input type="checkbox" name="outSide"
								id="outSide" value="out"> 외근
							</label>
						</form>
						<div class="col-12 p-1 text-right pr-3 mt-2">
							<a href="/attendance/toAttendanceView"><b>>>근태관리 이동하기</b> </a>
						</div>
					</body>
				</div>
			</div>
			<div class="row">
				<div class="col-5 box mr-3">
					<div class="row">
						<div class="comunity col-12" class="min-height: 200px;">
							<h4 class="p-2 m-0">
								<b>회사 전체 공지</b>
							</h4>
							<input type="hidden" name="writer_code" value="${writer_code}">
							<div class="row">
								<div class="on col-4">
									<b>부서명</b>
								</div>
								<div class="col-8">
									<b>제목</b>
								</div>
							</div>
							<div class="top row">
								<c:forEach var="n" items="${noBoardList}">
									<div class="on col-4 p-1">(${n.name })</div>
									<div class="col-8 p-1">
										<a
											href="/noBoard/notificationBoardRead.no?menu_seq=1&seq=${n.seq }&writer_code=${n.writer_code}">${n.title }</a>
									</div>
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
						<div class="email col-12 pt-3 pb-3" class="min-height: 200px;">
							<h4 class="p-2 m-0">
								<b>받은 메일함</b>
							</h4>
							<div class="row p-1">
								<div class="col-6 col-xl-4 pl-4">
									<b>제목</b>
								</div>
								<div class="d-none d-xl-block col-xl-4 pl-4">
									<b>날짜</b>
								</div>
								<div class="col-6 col-xl-4 pl-4">
									<b>발신자</b>
								</div>
							</div>
							<c:forEach var="i" items="${emailList }" begin="0" end="4">
								<div class="row p-1">
									<div class="col-6 col-xl-4">
										<a href="/document/toReadPage.document?seq=${i.seq }">${i.title }</a>
									</div>
									<div class="d-none d-xl-block col-xl-4">${i.write_date }</div>
									<div class="col-6 col-xl-4">${i.sender }</div>
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
						<div class="col-12" class="min-height: 200px;">
							<h4 class="p-2 m-0">
								<b>보낸 업무일지함</b>
							</h4>
							<c:forEach var="n" items="${logAllList}">
								<div class="row">
									<div class="on col-3 p-1">${n.name }</div>
									<div class="col-3 p-1">
										<a
											href="/log/logRead.log?menu_seq=1&seq=${n.seq }&writer_code=${n.writer_code}">${n.title }</a>
									</div>
									<div class="on col-3 p-1">${n.write_date }</div>
									<div class="on col-3 p-1">
										<c:choose>
											<c:when test="${n.status eq 'CONFIRM'}">
												<div class="on col d-none d-md-block">승인</div>
											</c:when>
											<c:when test="${n.status eq 'RAISE'}">
												<div class="on col d-none d-md-block">대기</div>
											</c:when>
											<c:when test="${n.status eq 'REJECT'}">
												<div class="on col d-none d-md-block">거절</div>
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
					<a href="/log/logCreate.log">
						<div class="top row" >
							<div class="top col" id="groove">
								<h4 class="p-2 m-0"  id="on">
									<b>업무일지 작성</b>
								</h4>
							</div>
						</div>
					</a>
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
=======
         <h2 class="mb-2">COCOAWORK</h2>
         <div class="row">
            <div class="box attendance col-12 mb-3">
               <body onload="printClock()">
                  <div
                     style="border: 1px solid #dedede; width: 300px; height: 70px; line-height: 70px; color: #666; font-size: 50px; text-align: center;"
                     id="clock"></div>
                  <form action="/attendance/startWork" method="post">
                     <button type="submit" onclick="fn_startWork()">출근</button>
                     <button type="button" onclick="fn_endWork()">퇴근</button>
                     <label> <input type="checkbox" name="outSide"
                        id="outSide" value="out"> 외근
                     </label>
                  </form>
                  <div class="col-12 p-1 text-right pr-3 mt-2">
                     <a href="/attendance/toAttendanceView"><b>>>근태관리 이동하기</b> </a>
                  </div>
               </body>
            </div>
         </div>
         <div class="row">
            <div class="col-5 box mr-3">
               <div class="row">
                  <div class="comunity col-12" class="min-height: 200px;">
                     <h4 class="p-2 m-0">
                        <b>회사 전체 공지</b>
                     </h4>
                     <input type="hidden" name="writer_code" value="${writer_code}">
                     <div class="row">
                        <div class="on col-4">
                           <b>부서명</b>
                        </div>
                        <div class="col-8">
                           <b>제목</b>
                        </div>
                     </div>
                     <div class="top row">
                        <c:forEach var="n" items="${noBoardList}">
                           <div class="on col-4 p-1">(${n.name })</div>
                           <div class="col-8 p-1">
                              <a
                                 href="/noBoard/notificationBoardRead.no?menu_seq=1&seq=${n.seq }&writer_code=${n.writer_code}">${n.title }</a>
                           </div>
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
                  <div class="email col-12 pt-3 pb-3" class="min-height: 200px;">
                     <h4 class="p-2 m-0">
                        <b>받은 메일함</b>
                     </h4>
                     <div class="row p-1">
                        <div class="col-6 col-xl-4 pl-4">
                           <b>제목</b>
                        </div>
                        <div class="d-none d-xl-block col-xl-4 pl-4">
                           <b>날짜</b>
                        </div>
                        <div class="col-6 col-xl-4 pl-4">
                           <b>발신자</b>
                        </div>
                     </div>
                     <c:forEach var="i" items="${emailList }" begin="0" end="4">
                        <div class="row p-1">
                           <div class="col-6 col-xl-4">
                              <a href="/document/toReadPage.document?seq=${i.seq }">${i.title }</a>
                           </div>
                           <div class="d-none d-xl-block col-xl-4">${i.write_date }</div>
                           <div class="col-6 col-xl-4">${i.sender }</div>
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
                  <div class="col-12" class="min-height: 200px;">
                     <h4 class="p-2 m-0">
                        <b>보낸 업무일지함</b>
                     </h4>
                     <c:forEach var="n" items="${logAllList}" begin="0" end="4">
                        <div class="row">
                           <div class="on col-3 p-1">${n.name }</div>
                           <div class="col-3 p-1">
                              <a
                                 href="/log/logRead.log?menu_seq=1&seq=${n.seq }&writer_code=${n.writer_code}">${n.title }</a>
                           </div>
                           <div class="on col-3 p-1">${n.write_date }</div>
                           <div class="on col-3 p-1">
                              <c:choose>
                                 <c:when test="${n.status eq 'CONFIRM'}">
                                    <div class="on col d-none d-md-block">승인</div>
                                 </c:when>
                                 <c:when test="${n.status eq 'RAISE'}">
                                    <div class="on col d-none d-md-block">대기</div>
                                 </c:when>
                                 <c:when test="${n.status eq 'REJECT'}">
                                    <div class="on col d-none d-md-block">거절</div>
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
               <a href="/log/logCreate.log">
                  <div class="top row" >
                     <div class="top col" id="groove">
                        <h4 class="p-2 m-0"  id="on">
                           <b>업무일지 작성</b>
                        </h4>
                     </div>
                  </div>
               </a>
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
>>>>>>> 07a9f540299ea61a8d581a58faa36dea32ca22fb
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
<<<<<<< HEAD
								<div class="col-12 p-1 text-right pr-3 mt-2">
									<a href="/schedule/toScheduleMain.schedule"><b>>>일정관리
											이동하기</b> </a>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="box col-12">
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
													<div class="col-8 col-lg-5">${i.title }</div>
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
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script>
=======
                        <div class="col-12 p-1 text-right pr-3 mt-2">
                           <a href="/schedule/toScheduleMain.schedule"><b>>>일정관리
                                 이동하기</b> </a>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="box col-12">
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
                                       <div class="col-8 col-lg-5">${i.title }</div>
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
   <script
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
   <script>
>>>>>>> 07a9f540299ea61a8d581a58faa36dea32ca22fb
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

      function fn_startWork() {   // 출근
         location.href = "/attendance/startWork";
      }
      function fn_endWork() {   // 퇴근
         location.href = "/attendance/endWork"
      }
   </script>
</body>
</html>