<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Read Page</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css"
	media="screen" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<style>
.row{border-bottom: 1px solid pink}
.select{text-align:right;}
.date_box>input{width:58%;}
.box{height:400px;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 읽기</h2>
			
				<c:forEach var="l" items="${lr}">
				<div class="row">
					<div class="col-sm-2 head_box">제목</div>
					<div class="col-sm-10">${l.title}</div>
				</div>
				
				<div class="row">
					<div class="col-2 head_box">업무기한</div>
					<div class="col-2">${l.report_start}</div>
					<div class="col-3">${l.report_end}</div>
					<div class="col-2 head_box">작성일</div>
					<div class="col-3">${l.write_date}</div>
				</div>
				
				<div class="row">
					<div class="col-2 head_box">승인</div>
					<div class="col-5">(영업부)김지영 부장 (0)</div>
					<div class="col-2 head_box">작성자</div>
					<div class="col-3">${l.name}</div>
				</div>
				<div class="row">
					<div class="col head_box">내용</div>
				</div>
				<div class="row box">${l.contents}</div>
				</c:forEach>
			<!--첨부파일  -->
			<div class="row">
				<!-- 해당 게시글에 저장된 파일 갯수 확인 -->
				<div class="col-md-12 head_box" id="only">
					<b><span class="files" id="files">첨부파일 : ${fileCount}개</span></b>
					<ul>
						<c:forEach var="i" items="${fileList}">
						<li class="fileLi"><a
							href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">${i.oriname}</a>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="row">
				<!--홈으로 이동  -->
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary" onclick="fn_home()">HOME</button>
				</div>

				<div class="col-sm-7 d-none d-sm-block"></div>

				<!--작성자에게만 보이는 버튼  -->
				<div class="button_box col-sm-3">
					<button type="submit" class="btn btn-primary"
						onclick="fn_modify(${cpage},${dto.seq})">수정</button>
					<button type="button" class="btn btn-primary"
						onclick="fn_delete(${cpage},${dto.seq})">삭제</button>
				</div>

			</div>
		</div>
	</div>
	<script>
		/*제목부분 누르면 기존에 있던 내용 없애기*/
	 	function title_box(){
	 		if($('#title').val() != null){
			    $('#title').val("");
			}
	 	}
	 	/*홈으로*/
		function fn_home(cpage) {
			location.href = "";
		}
</script>
</body>
</html>