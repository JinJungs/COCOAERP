<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyBoard</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css" media="screen" />
<style type="text/css">
.footer{border-top:1px solid pink;text-align:right;}
.title{cursor:pointer;}
.title:hover{color:#866EC7;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">내가 쓴 글</h2>

			<div class="row head_box" style="border-bottom: 1px solid pink;
				text-align:center;">
				<div class="col-md-1 d-none d-md-block">
					<b>#</b>
				</div>
				<div class="col-sm-12 col-md-7">
					<b>제목</b>
				</div>
				<div class="col-md-2 d-none d-md-block">
					<b>작성일</b>
				</div>
				<div class="col-md-2 d-none d-md-block">
					<b>조회수</b>
				</div>
			</div>
			
			<c:forEach var="i" items="${list}">
				<div class="row">
					<div class="col-md-1 d-none d-md-block" style="text-align: center;">${i.seq}</div>
					<div class="title col-sm-12 col-md-7" 
					onclick="notificationBoardRead(${i.menu_seq},${i.seq})">${i.title}</div>
					<div class="col-md-2 d-none d-md-block" style="text-align: center;">${i.write_date}</div>
					<div class="col-md-2 d-none d-md-block" style="text-align: center;">${i.view_count}</div>
				</div>
			</c:forEach>
			
			<div class="row">
				<div class="col-12  footer">
					<button type="button" class="btn btn-primary"
						onclick="fn_home(${cpage})">홈으로</button>
				</div>
			</div>
			
		</div>
	</div>
	<script>
		/*홈으로*/
		function fn_home(cpage) {
			location.href = "/";
		}
		/* 리스트에서 글 읽기*/
		function notificationBoardRead(menu_seq,seq){
			location.href="/noBoard/notificationBoardRead.no?menu_seq="+menu_seq+"&seq="+seq;
		}
	</script>
</body>
</html>