<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Temporary Saved Board</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css" media="screen" />
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
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 임시보관함</h2>
			
			<div class="row">
				<!-- <ul class="tabs">
					<li class="tab current" id="all" value="all" data-tab="tab-1">전체</li>
					<li class="tab" id="daily" value="daily" data-tab="tab-2">일일</li>
					<li class="tab" id="weekly" value="weekly" data-tab="tab-3">주간</li>
					<li class="tab" id="monthly" value="monthly" data-tab="tab-4">월별</li>
				</ul> -->
				<ul class="tabs">
					<li class="tab current" id="all" value="all" data-tab="tab-1">전체</li>
				</ul>
				<ul class="tabs">
					<li class="tab" id="daily" value="daily" data-tab="tab-2">일일</li>
				</ul>
				<ul class="tabs">
					<li class="tab" id="weekly" value="weekly" data-tab="tab-3">주간</li>
				</ul>
				<ul class="tabs">
					<li class="tab" id="monthly" value="monthly" data-tab="tab-4">월별</li>
				</ul>
			</div>
			<script>
				 $(document).ready(function() {
               		$('ul.tabs li').click(function() {
               		console.log('눌림?');
	                  var tab_id = $(this).attr('data-tab');
	                  console.log("tab_id는?"+tab_id);
	                  $('ul.tabs li').removeClass('current');
	                  console.log("여까지 옴?1");
	                  $('.tab-content').removeClass('current');
	                  console.log("여까지 옴?2");
	                  $(this).addClass('current');
	                  console.log("여까지 옴?3");
	                  $("#" + tab_id).addClass('current');
	                  console.log("여까지 옴?4");
	               })
            	})
			</script>
				<div class="row head_box" style="border-bottom: 1px solid pink;">
					<div class="col-md-1 d-none d-md-block"><b>#</b></div>
					<div class="col-sm-12 col-md-3"><b>제목</b></div>
					<div class="col-md-2 d-none d-md-block"><b>작성자</b></div>
					<div class="col-md-2 d-none d-md-block"><b>업무 시작일</b></div>
					<div class="col-md-2 d-none d-md-block"><b>업무 마감일</b></div>
					<div class="col-md-2 d-none d-md-block"><b>작성일</b></div>
				</div>
			
			<!-- 전체 -->
			<div class="row tab-content current" id="tab-1" style="border-bottom: 1px solid pink;">
				<c:forEach var="i" items="${logAllList}">
					<div class="col-md-1 d-none d-md-block">${i.seq}</div>
					<div class="col-sm-12 col-md-3">${i.title}</div>
					<div class="col-md-2 d-none d-md-block">${i.writer_code}</div>
					<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
					<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
					<div class="col-md-2 d-none d-md-block">${i.write_date}</div>		
				</c:forEach>
			</div>
			
			<!-- 일일 -->
			<div class="row tab-content" id="tab-2" style="border-bottom: 1px solid pink;">
				<c:forEach var="i" items="${dailyList}">
					<div class="col-md-1 d-none d-md-block">${i.seq}</div>
					<div class="col-sm-12 col-md-3">${i.title}</div>
					<div class="col-md-2 d-none d-md-block">${i.writer_code}</div>
					<div class="col-md-2 d-none d-md-block">${i.report_start}</div>
					<div class="col-md-2 d-none d-md-block">${i.report_end}</div>
					<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
				</c:forEach>
			</div>
			<!-- 주간 -->
			<div class="row tab-content" id="tab-3" style="border-bottom: 1px solid pink;">
				<div class="col-md-1 d-none d-md-block"></div>
				<div class="col-sm-12 col-md-3"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
			</div>
			<!-- 월별 -->
			<div class="row tab-content" id="tab-4" style="border-bottom: 1px solid pink;">
				<div class="col-md-1 d-none d-md-block"></div>
				<div class="col-sm-12 col-md-3"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
			</div>
			
			<div class="row" style="border-top: 1px solid pink;">
				<div class="col-md-2  footer">
					<button type="button" class="btn btn-primary"
						onclick="fn_home(${cpage})">홈으로</button>
				</div>

				<!--네비게이션  -->
				<div class="col-md-8 navi_box">
					<ul class="pagination justify-content-center mb-0">${navi}</ul>
				</div>
				<div class="col-md-2  footer"></div>
			</div>
		</div>
	</div>
</body>
</html>