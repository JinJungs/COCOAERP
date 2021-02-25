<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Album Board</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css"
	media="screen" />
<style type="text/css">
.card{margin:10px;}
input{width:50%;border-bottom:1px solid pink;}
#search,select{height:70%;border:none;border-bottom:1px solid pink;background-color:transparent;}
.select{text-align:right;}
.navi_box{text-align:center;margin-top:5px;}
.head_box{text-align:center;}
.title{cursor:pointer;}
.title:hover{color:#866EC7;}
#btn_footer{text-align:right;}
.card:hover{transform:scale(1.1);}
#notice{border-top:1px solid pink;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
   	<script src="/js/bootstrap.min.js"></script>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">${mid_name}</h2>

			<form action="/noBoard/notificationBoardSearch.no" method="get">
				<input type="hidden" id="getmenu_seq" name="menu_seq"
					value="${menu_seq}" /> <input type="hidden" id="mid_name"
					name="mid_name" value="${mid_name}" />
				<div class="row search_box">
					<!--검색어 & 버튼입력  -->
					<div class="select col-12">
						<select name="searchBy" id="searchBy">
							<option value="title">제목</option>
							<option value="contents">내용</option>
							<option value="writer">작성자</option>
						</select> <input type="text" name="search" id="search"
							placeholder="검색하실 글 제목 또는 글 내용을 입력하세요" onclick="search_box()">
						<button type=submit class="btn btn-primary">검색</button>
					</div>
				</div>
			</form>
			<c:choose>
				<c:when test="${empty albumList}">
					<div class="row" id="notice">
						<div class="col">작성된 글이 없습니다.</div>
					</div>
				</c:when>
				<c:otherwise>
						<div class="row">
					<c:forEach var="i" items="${albumList}">
							<div class="card" style="width: 11rem;"
								onclick="notificationBoardRead(${i.menu_seq},${i.seq},${cpage})">
								<img id="img" src="/boardRepository/${i.savedname}"
									class="card-img-top" style="HEIGHT: 150px;">
								<div class="col-12">
									<b>${i.title}</b><br>
									<b>${i.name}</b><b>${i.write_date}</b>
								</div>
							</div>
					</c:forEach>
						</div>
				</c:otherwise>
			</c:choose>

			<div class="row" style="border-top: 1px solid pink;">
				<div class="col-md-2  footer">
					<button type="button" class="btn btn-primary"
						onclick="fn_home(${cpage})">홈으로</button>
				</div>

				<!--네비게이션  -->
				<div class="col-md-7"></div>

				<!--버튼 -->
				<div class="col-md-3  footer" id="btn_footer">
					<button type="button" class="btn btn-primary"
						onclick="fn_create(${menu_seq},${cpage})">글 등록</button>
				</div>
			</div>
		</div>
	</div>
</body>
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
</html>