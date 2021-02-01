<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Request Log Read Page</title>
<link rel="stylesheet" href="/resources/css/noBoard.css" type="text/css"
	media="screen" />
<style>

div{border: 1px solid pink;}
.contents_box{border: 1px solid pink;}
.left,.right{margin:10px;}
.fix>textarea{height:200px;}
.btn,.title{text-align:center;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">확인요청 업무일지</h2>
			
			<div class="row main">
				<div class="col left">
					
					<div class="row">
						<div class="col title">제목</div>
					</div>
					
					<div class="row">
						<div class="col">업무시작일 :</div>
						<div class="col">2021-01-28</div>
					</div>
					
					<div class="row">
						<div class="col">업무마감일 :</div>
						<div class="col">2021-01-28</div>
					</div>
					
					<div class="row">
						<div class="col">작성날짜 :</div>
						<div class="col">2021-01-28</div>
					</div>
					<div class="row">
						<div class="col">작성자 :</div>
						<div class="col">김지영</div>
					</div>
					<div class="row">
						<div class="col">승인 :</div>
						<div class="col">권용국</div>
					</div>
					<div class="row">
						<div class="col">Comment</div>
					</div>
					
					<div class="row">
						<div class="col fix">
							<textarea></textarea>
						</div>
					</div>
					
					<div class="row">
						<div class="col btn">
							<button class="btn btn-primary">승인</button>
							<button class="btn btn-primary">거절</button>
							<button class="btn btn-primary">취소</button>
						</div>
					</div>
				</div>
				
				<div class="col right">
					<div class="row contents_box"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>