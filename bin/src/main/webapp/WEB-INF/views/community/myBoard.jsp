<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyBoard</title>
<style type="text/css">
div {border: 1px solid gray}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">내가 쓴 글</h2>
			
			<div class="row">
				<div class="col-md-2 d-none d-md-block">글 번호</div>
				<div class="col-sm-12 col-md-6">제목</div>
				<div class="col-md-2 d-none d-md-block">작성날짜</div>
				<div class="col-md-2 d-none d-md-block">조회수</div>
			</div>
			
			<div class="row">
				<div class="contents_box col-xs-12"></div>
			</div>
			
			<div class="row">
				<!--네비게이션  -->
				<div class="navi_box col-md-10">네비게이션바</div>
				<div class="col-md-2">
					<button>홈으로</button>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>