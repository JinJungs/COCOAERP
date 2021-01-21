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
div {
	border: 1px solid gray
}
input{width:100%;height:90%;}
.navi_box{text-align:center;}
</style>
</head>
<body>
	<input type="hidden" id="getcpage" value="${cpage}" />
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">회사 소식</h2>

			<div class="row search_box">
				<!--검색 select box  -->
				<div class="col-2 ">
					<select>
						<option value="">검색</option>
						<option value="">ㅇㅇ</option>
					</select>
				</div>

				<!--검색어 입력  -->
				<div class="col-7 ">
					<input type="text">
				</div>

				<!--검색 버튼  -->
				<div class="col-3">
					<button>검색</button>
				</div>
			</div>

			<div class="row">
				<div class="col-md-2 d-none d-md-block">글 번호</div>
				<div class="col-sm-12 col-md-4">제목</div>
				<div class="col-md-2 d-none d-md-block">작성자</div>
				<div class="col-md-2 d-none d-md-block">작성날짜</div>
				<div class="col-md-2 d-none d-md-block">조회수</div>
			</div>

			<c:forEach var="i" items="${list}">
				<div class="row">
						<div class="col-md-2 d-none d-md-block">${i.seq}</div>
						<div class="col-sm-12 col-md-4" onclick ="notificationBoardRead(${i.seq},${cpage})">${i.title}</div>
						<div class="col-md-2 d-none d-md-block">${i.contents}</div>
						<div class="col-md-2 d-none d-md-block">${i.write_date}</div>
						<div class="col-md-2 d-none d-md-block">${i.view_count}</div>
				</div>
			</c:forEach>

			<div class="row">
				<div class="col-md-2 d-none d-md-block">
					<button>홈으로</button>
				</div>

				<!--네비게이션  -->
				<div class="navi_box col-md-7"><ul class="pagination justify-content-center mb-0">${navi}</ul></div>

				<!--버튼 //관리자만 보여야함-->
				<div class="col-md-3 ">
					<button type="button" onclick="fn_modify()">수정</button>
					<button type="button" onclick="fn_delete()">삭제</button>
					<button type="button" onclick="fn_create(${cpage})">글 등록</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		/*글 수정*/
		/* function fn_modify(){
			location.href="/noBoard/notificationBoardModify.no"
		}  */
		/*글 삭제*/
		function fn_delete() {
			location.href = "/noBoard/notificationBoardDelete.no"
		}
		/*글 등록*/
		function fn_create(cpage) {
			location.href = "/noBoard/notificationBoardCreate.no?cpage="+cpage;
		}
		/* 리스트에서 글 읽기*/
		function notificationBoardRead(seq,cpage){
			location.href="/noBoard/notificationBoardRead.no?seq="+seq+"&cpage="+cpage;
		}
	</script>
</body>
</html>