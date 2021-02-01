<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Temporary Saved Board</title>
<link rel="stylesheet" href="/resources/css/noBoard.css" type="text/css"
	media="screen" />
<style>
div{border:1px solid gray;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 임시보관함</h2>
			
			<div class="row head_box" style="border-bottom: 1px solid pink;">
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
			</div>
			
			<div class="row" style="border-bottom: 1px solid pink;">
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