<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Board</title>
<style type="text/css">
div {border: 1px solid gray}
input{width:100%;height:90%;}
.contents_box{height:400px;}
.navi_box{text-align:center;}
.button_box{text-align:right;}

</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">자유게시판</h2>
			
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

			<div class="row">
				<div class="contents_box col-xs-12"></div>
			</div>
			
			<div class="row">
				<div class="col-md-2 d-none d-md-block">
					<button>홈으로</button>
				</div>
				
				<!--네비게이션  -->
				<div class="navi_box col-md-7">네비게이션바</div>
				<div class="button_box col-md-3 ">
						<button>글 등록</button>
				</div>
			</div>
		</div>

	</div>
</body>
</html>