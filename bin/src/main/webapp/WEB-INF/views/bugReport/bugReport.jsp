<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bug Report</title>
<style type="text/css">
div {border-bottom: 1px solid pink}
input{width:100%;height:90%;border:none;background-color:transparent;}
input:focus{outline:1px solid pink;}
#contents {height: 100%;width: 100%;}
.title_text,.sender_text,.receiver_text{font-size:17px;color:#866EC7;}
.body {height: 400px;}
.footer {text-align: right}
textarea{width:100%; border:1px solid pink;}
textarea:focus{outline:none;}
.home_btn{text-align:left;}
button{height:90%;}
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
					<div class="col-4 sender_text"><b>보내는 사람</b></div>
					<div class="col-8 sender_input"><input type="text" id="email" name="email"
							placeholder="이메일 주소를 입력하세요."></div>
					<div class="col-4 receiver_text"><b>받는 사람</b></div>
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
					<div class="col-2 home_btn">
						<button type="button" class="btn btn-primary">HOME</button>
					</div>
					<div class="col-10 button">
						<button type="reset" class="btn btn-primary">취소</button>
						<button type="submit" class="btn btn-primary">전송</button>
					</div>
				</div>
				
			</form>
		</div>
	</div>
</body>
</html>