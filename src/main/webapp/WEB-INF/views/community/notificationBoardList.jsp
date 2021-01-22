<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style type="text/css">
div {border: 1px solid gray}
input{width:50%;} 
.select{text-align:right;}
.navi_box{text-align:center;}
.title{cursor:pointer;}
.title:hover{color:#6749B9;}
</style>
</head>
<body>
	<input type="hidden" id="getcpage" value="${cpage}" />
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">회사 소식</h2>

            <form action=/noBoard/notificationBoardSearch.no?cpage=1 method="get">
			
			<div class="row search_box">
				<!--검색어 & 버튼입력  -->
				<div class="select col-12">
					<select name="searchBy" id="searchBy">
							<option value="title">제목</option>
							<option value="contents">내용</option>
							<option value="writer">작성자</option>
							<option value="tc">제목과 내용</option>
						</select> 
					<input type="text"  name="search" id="search" 
					placeholder="검색하실 글 제목 또는 글 내용을 입력하세요" onclick="search_box()">
					<button type=submit>검색</button>
				</div>
			</div>
				</form>

			<div class="row">
				<div class="col-md-1 d-none d-md-block">글 번호</div>
				<div class="col-sm-12 col-md-7">제목</div>
				<div class="col-md-1 d-none d-md-block">작성자</div>
				<div class="col-md-2 d-none d-md-block">작성날짜</div>
				<div class="col-md-1 d-none d-md-block">조회수</div>
			</div>

			<c:forEach var="i" items="${list}">
				<div class="row">
						<div class="col-md-1 d-none d-md-block">${i.seq}</div>
						<div class="title col-sm-12 col-md-7" onclick ="notificationBoardRead(${i.seq},${cpage})"><b>${i.title}</b></div>
						<div class="col-md-1 d-none d-md-block">${i.writer_code}</div>
						<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
						<div class="col-md-1 d-none d-md-block">${i.view_count}</div>
				</div>
			</c:forEach>

			<div class="row">
				<div class="col-md-2 d-none d-md-block">
					<button type="button" onclick="fn_home(${cpage})">홈으로</button>
				</div>

				<!--네비게이션  -->
				<div class="navi_box col-md-7"><ul class="pagination justify-content-center mb-0">${navi}</ul></div>

				<!--버튼 //관리자만 보여야함-->
				<div class="col-md-3 ">
					<button type="button" onclick="fn_create(${cpage})">글 등록</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		/*검색창 누르면 placeholder 없애기*/
		function search_box(){
	 		if($('#search').val() != null){
			    $('#search').val("");
			}
 		}
		/*글 등록*/
		function fn_create(cpage) {
			location.href = "/noBoard/notificationBoardCreate.no?cpage="+cpage;
		}
		/* 리스트에서 글 읽기*/
		function notificationBoardRead(seq,cpage){
			location.href="/noBoard/notificationBoardRead.no?seq="+seq+"&cpage="+cpage;
		}
		/*홈으로*/
		function fn_home(cpage) {
			location.href = "/noBoard/notificationBoardList.no?cpage="+cpage;
		}
	</script>
</body>
</html>