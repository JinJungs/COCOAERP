<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Board</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css" media="screen" />
<style type="text/css">
input{width:50%;border-bottom:1px solid pink;}
#search,select{height:70%;border:none;border-bottom:1px solid pink;background-color:transparent;}
.select{text-align:right;}
.navi_box{text-align:center;margin-top:5px;}
.head_box{text-align:center;}
.title{cursor:pointer;}
.title:hover{color:#866EC7;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">자유게시판</h2>

			<input type="hidden" id="cpage" name="cpage" value="${cpage}" />
			<form action="/noBoard/notificationBoardSearch.no" method="get">
				<input type="hidden" id="getmenu_seq" name="menu_seq" value="${menu_seq}" />
				
				<div class="row search_box">
					<!--검색어 & 버튼입력  -->
					<div class="select col-12">
						<select name="searchBy" id="searchBy">
							<option value="title">제목</option>
							<option value="contents">내용</option>
							<option value="writer">작성자</option>
							<!-- <option value="tc">제목과 내용</option> -->
						</select> <input type="text" name="search" id="search"
							placeholder="검색하실 글 제목 또는 글 내용을 입력하세요" onclick="search_box()">
						<button type=submit class="btn btn-primary">검색</button>
					</div>
				</div>
			</form>

			<div class="row head_box" style="border-bottom: 1px solid pink;">
				<div class="col-md-1 d-none d-md-block">
					<b>#</b>
				</div>
				<div class="col-sm-12 col-md-5">
					<b>제목</b>
				</div>
				<div class="col-md-2 d-none d-md-block">
					<b>작성자</b>
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
					<div class="title col-sm-12 col-md-5"
						onclick="notificationBoardRead(${menu_seq},${i.seq},${cpage})">${i.title}</div>
					<div class="col-md-2 d-none d-md-block" style="text-align: center;">${i.name}</div>
					<div class="col-md-2 d-none d-md-block" style="text-align: center;">${i.write_date}</div>
					<div class="col-md-2 d-none d-md-block" style="text-align: center;">${i.view_count}</div>
				</div>
			</c:forEach>

			<div class="row" style="border-top: 1px solid pink;">
				<div class="col-md-2  footer">
					<button type="button" class="btn btn-primary"
						onclick="fn_home(${cpage})">홈으로</button>
				</div>

				<!--네비게이션  -->
				<div class="col-md-7 navi_box">
					<ul class="pagination justify-content-center mb-0">${navi}</ul>
				</div>

				<!--버튼 -->
				<div class="col-md-3  footer">
					<button type="button" class="btn btn-primary"
						onclick="fn_create(${menu_seq},${cpage})">글 등록</button>
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
		function fn_create(menu_seq,cpage) {
			location.href = "/noBoard/notificationBoardCreate.no?menu_seq="+menu_seq+"&cpage="+cpage;
		}
		/* 리스트에서 글 읽기*/
		function notificationBoardRead(menu_seq,seq,cpage){
			location.href="/noBoard/notificationBoardRead.no?menu_seq="+menu_seq+"&seq="+seq+"&cpage="+cpage;
		}
		/*홈으로*/
		function fn_home(cpage) {
			location.href = "/";
		}
	</script>
</body>
</html>