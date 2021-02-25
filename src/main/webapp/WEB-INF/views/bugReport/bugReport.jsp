<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bug Report</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css" media="screen" />
<style type="text/css">
input{width:100%;}
.row,.title_text,.title_input{border-bottom:1px solid pink;}
.title_text,.sender_text,.receiver_text{font-size:17px;color:#866EC7;}
.footer {text-align: right}
.home_btn{text-align:left;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 ">버그리포팅</h2>
			
			<form action="/email/emailSend.email" method="post">
				<div class="row mainContent">
					<div class="col-4 title_text"><b>제목</b></div>
					<div class="col-8 title_input">
						<input type="text" id="title" name="title"
							placeholder="제목을 입력하세요.">
					</div>
						<input type="hidden" id="sender_email" name="sender_email" value="${sender_email.b_email}" >
					<div class="col-4 receiver_text"><b>받는 사람</b></div>
					<div class="col-8 receiver_input">
						<input type="text" id="receiver_email" name="receiver_email" value="${receiver_email}">
					</div>
				</div>

				<div class="row contents_box">
						<textarea class="col " id="contents" name="contents">
안녕하세요 개발자님,
코코아 웍스 00팀 000입니다.
프로그램 이용시 하기와 같은 에러 및 버그가 발생되어 확인 부탁드리고자 이메일 드립니다.
* 문제점 
1) ~~~~~
2) ~~~~~
3) ~~~~

혹시 위의 내용에서 부가설명이 더 필요하시거나 이해하기 어려운 부분이 있다면 말씀해주세요.
감사합니다.
000 드림
						</textarea>
					</div>

				<div class="row footer">
					<div class="col-2 home_btn">
						<button type="button" class="btn btn-primary"
						onclick="fn_home()">홈으로</button>
					</div>
					<div class="col-10 button">
						<button type="reset" class="btn btn-primary">취소</button>
						<button type="submit" class="btn btn-primary">전송</button>
					</div>
				</div>
				
			</form>
		</div>
	</div>
   	<script src="/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	/*홈으로*/
		function fn_home() {
			location.href = "/";
		}
	</script>
	
</body>
</html>