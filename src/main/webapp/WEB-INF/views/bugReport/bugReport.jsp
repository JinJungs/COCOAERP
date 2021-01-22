<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div {border: 1px solid gray}

#contents {height: 100%;width: 100%;}

.body {height: 400px;}

.footer {text-align: right}

input {width: 100%}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">버그리포팅</h2>
			
			<form action="/email/emailSend.email" method="post">
				<div class="row mainContent">
					<div class="col-4 title_text">제목</div>
					<div class="col-8 title_input">
						<input type="text" id="title" name="title"
							placeholder="제목을 입력하세요.">
					</div>
					<div class="col-4 sender_text">보내는 사람</div>
					<div class="col-8 sender_input"><input type="text" id="email" name="email"
							placeholder="이메일 주소를 입력하세요."></div>
					<div class="col-4 receiver_text">받는 사람</div>
					<div class="col-8 receiver_input">
						<input type="text" id="receiver_email" name="receiver_email"
							placeholder="이메일 주소를 입력하세요.">
					</div>
				</div>

				<div class="row body">
						<textarea class="col contents_box" id="contents" name="contents">
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
					<div class="col button">
						<button>취소</button>
						<button type="submit">전송</button>
					</div>
				</div>
				
			</form>
		</div>
	</div>
</body>
</html>