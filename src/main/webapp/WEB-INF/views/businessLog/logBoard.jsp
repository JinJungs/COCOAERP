<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Board</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css"
	media="screen" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<style>
.tab{width:80px;text-align:center;border-radius: 0px 10px 0px 0px;cursor:pointer;border:1px solid pink;border-bottom:none;}
.tab:hover{background:#115acf;color:white;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<input type="hidden" id="status" name="status" value="${status }">
			
			<c:choose>
				<c:when test="${status eq 'TEMP'}">
					<h2 class="mb-4 board_title">업무일지 임시보관함</h2>
				</c:when>
				<c:when test="${status eq 'CONFIRM'}">
					<h2 class="mb-4 board_title">업무일지 보관함</h2>
				</c:when>
				<c:when test="${status eq 'RAISE'}">
					<h2 class="mb-4 board_title">확인요청 업무일지 보관함</h2>
				</c:when>
			</c:choose>

			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active"
					data-toggle="tab" href="#all">전체</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#daily">일일</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#weekly">주간</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#monthly">월별</a></li>
			</ul>
			<!-- 공용 head -->
			<div class="row head_box" style="border-bottom: 1px solid pink;">

				<c:choose>
					<c:when test="${status eq 'RAISE'}">
						<div class="col-md-1 d-none d-md-block">
							<b>#</b>
						</div>
						<div class="col-sm-12 col-md-2">
							<b>제목</b>
						</div>
						<div class="col-md-2 d-none d-md-block">
							<b>작성자</b>
						</div>
						<div class="col-md-2 d-none d-md-block">
							<b>업무 시작일</b>
						</div>
						<div class="col-md-2 d-none d-md-block">
							<b>업무 마감일</b>
						</div>
						<div class="col-md-2 d-none d-md-block">
							<b>작성일</b>
						</div>
						<div class="col-md-1 d-none d-md-block">상태</div>
					</c:when>
					<c:otherwise>
						<div class="col-md-1 d-none d-md-block">
							<b>#</b>
						</div>
						<div class="col-sm-12 col-md-3">
							<b>제목</b>
						</div>
						<div class="col-md-2 d-none d-md-block">
							<b>작성자</b>
						</div>
						<div class="col-md-2 d-none d-md-block">
							<b>업무 시작일</b>
						</div>
						<div class="col-md-2 d-none d-md-block">
							<b>업무 마감일</b>
						</div>
						<div class="col-md-2 d-none d-md-block">
							<b>작성일</b>
						</div>
					</c:otherwise>

				</c:choose>
			</div>
			<!-- 리스트 보이기 -->
			<div class="tab-content">
				<!-- 전체 -->
				<div class="tab-pane fade show active" id="all">
					<div class="row tab-content current" id="tab-1"
						style="border-bottom: 1px solid pink;">
						<c:forEach var="i" items="${logAllList}">
							<c:choose>
								<c:when test="${status eq 'RAISE'}">
									<div class="col-md-1 d-none d-md-block">${i.seq}</div>
									<div class="col-sm-12 col-md-2">
										<a href="/log/logReqRead.log?seq=${i.seq}+&status=${status}">${i.title }</a>
									</div>
									<div class="col-md-2 d-none d-md-block">${i.name}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
									<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
									<div class="col-md-1 d-none d-md-block">${i.status}</div>
								</c:when>
								<c:otherwise>
									<div class="col-md-1 d-none d-md-block">${i.seq}</div>
									<div class="col-sm-12 col-md-3">
										<a href="/log/logRead.log?seq=${i.seq}&tempCode=${i.temp_code}&status=${status}">${i.title }</a>
									</div>
									<div class="col-md-2 d-none d-md-block">${i.name}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
									<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>
				<!-- 일일 -->
				<div class="tab-pane fade" id="daily">
					<div class="row tab-content" id="tab-2"
						style="border-bottom: 1px solid pink;">
						<c:forEach var="i" items="${dailyList}">
							<c:choose>
								<c:when test="${status eq 'RAISE'}">
									<div class="col-md-1 d-none d-md-block">${i.seq}</div>
									<div class="col-sm-12 col-md-2">
										<a href="/log/logReqRead.log?seq=${i.seq}+&status=${status}">${i.title }</a>
									</div>
									<div class="col-md-2 d-none d-md-block">${i.name}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
									<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
									<div class="col-md-1 d-none d-md-block">${i.status}</div>
								</c:when>
								<c:otherwise>
									<div class="col-md-1 d-none d-md-block">${i.seq}</div>
									<div class="col-sm-12 col-md-3">
										<a href="/log/logRead.log?seq=${i.seq}+&status=${status}">${i.title }</a>
									</div>
									<div class="col-md-2 d-none d-md-block">${i.name}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
									<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>
				<!-- 주간 -->
				<div class="tab-pane fade" id="weekly">
					<div class="row tab-content" id="tab-2"
						style="border-bottom: 1px solid pink;">
						<c:forEach var="i" items="${weeklyList}">
							<c:choose>
								<c:when test="${status eq 'RAISE'}">
									<div class="col-md-1 d-none d-md-block">${i.seq}</div>
									<div class="col-sm-12 col-md-2">
										<a href="/log/logReqRead.log?seq=${i.seq}+&status=${status}">${i.title }</a>
									</div>
									<div class="col-md-2 d-none d-md-block">${i.name}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
									<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
									<div class="col-md-1 d-none d-md-block">${i.status}</div>
								</c:when>
								<c:otherwise>
									<div class="col-md-1 d-none d-md-block">${i.seq}</div>
									<div class="col-sm-12 col-md-3">
										<a href="/log/logRead.log?seq=${i.seq}+&status=${status}">${i.title }</a>
									</div>
									<div class="col-md-2 d-none d-md-block">${i.name}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
									<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>
				<!-- 월별 -->
				<div class="tab-pane fade" id="monthly">
					<div class="row tab-content" id="tab-2"
						style="border-bottom: 1px solid pink;">
						<c:forEach var="i" items="${monthlyList}">
							<c:choose>
								<c:when test="${status eq 'RAISE'}">
									<div class="col-md-1 d-none d-md-block">${i.seq}</div>
									<div class="col-sm-12 col-md-2">
										<a href="/log/logReqRead.log?seq=${i.seq}+&status=${status}">${i.title }</a>
									</div>
									<div class="col-md-2 d-none d-md-block">${i.name}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
									<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
									<div class="col-md-1 d-none d-md-block">${i.status}</div>
								</c:when>
								<c:otherwise>
									<div class="col-md-1 d-none d-md-block">${i.seq}</div>
									<div class="col-sm-12 col-md-3">
										<a href="/log/logRead.log?seq=${i.seq}+&status=${status}">${i.title }</a>
									</div>
									<div class="col-md-2 d-none d-md-block">${i.name}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
									<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
									<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>