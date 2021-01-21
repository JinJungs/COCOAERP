<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
select{
	width: 60%;
	min-width: 80px;
}
.row {
	margin-top: 8px;
}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">상신한 문서</h2>
			<hr>
			<form action="" method="post">
				<div class="search pb-2">
					<div class="row">
						<div class="col-3 col-md-2">저장일</div>
						<div class="col-9">
							<input type=date class="date ml-1 mr-1"> ~ <input
								type=date class="date ml-1 mr-1">
						</div>
					</div>
					<div class="row">
						<div class="col-3 col-sm-3 col-md-2 mb-2">기안양식</div>
						<div class="col-9 col-sm-2  col-md-2">
							<select class="selectTemplate ml-1 mb-2">
								<option>물품신청</option>
								<option>업무보고</option>
								<option>휴가신청</option>
							</select>
						</div>
						<div class="selectSearch col-3 col-sm-2 col-md-2 mb-3">
							<select>
								<option>제목</option>
								<option>작성자</option>
								<option>부서</option>
							</select>
						</div>
						<div class="col-6 col-sm-2 mb-3 pl-3">
							<input type=text>
						</div>
					</div>
					<div class="row">
						<div class="col-12 text-center">
							<input type=submit value=조회>
						</div>
					</div>
				</div>
			</form>
			<hr>
			<div class="documentList row text-center">
				<div class="col-2 d-none d-sm-block">
					<b>양식</b>
				</div>
				<div class="col-5 col-sm-3">
					<b>제목</b>
				</div>
				<div class="col-3">
					<b>상신일</b>
				</div>
				<div class="col-4">
					<b>결재대기자</b>
				</div>
			</div>

			<!-- 리스트 출력 부분 -->
			<div class="row text-center">
				<div class="col-sm-2 d-none d-sm-block">휴가계획서</div>
				<div class="col-5 col-sm-3">2021-03-08 휴가신청</div>
				<div class="col-3">2021.01.15</div>
				<div class="col-4">임효경|IT개발부</div>
			</div>
			<!-- 리스트 출력 부분 -->
			
			<div class="row">
				<div class="navi col-12 text-center">${navi} 1 2 3 4 5 6 7 8 9</div>
			</div>
		</div>
	</div>
</body>
</html>