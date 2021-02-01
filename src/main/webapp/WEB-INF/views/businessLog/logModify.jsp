<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Modify Page</title>
<link rel="stylesheet" href="/resources/css/noBoard.css" type="text/css"
	media="screen" />
<style>
.row{border-bottom: 1px solid pink}
.date_box>input{width:58%;}
#contents_box{margin:1px;height:400px;border:none;}
</style>
</head>
<body>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 수정</h2>
			
			<div class="row">
				<div class="col-sm-2 d-none d-sm-block head_box">제목</div>
				<div class="col-12 col-sm-10">
					<input type="text" id="title" name="title" 
					onclick="title_box()" value="${dto.title}">
				</div>
			</div>
			
			<div class="row">
				<div class="col-2 head_box">업무기한</div>
				<div class="col-10">
					<div class="row" style="border:none;">
						<div class="col date_box">
						<b>시작일 :</b> 
						<input type="date" class="date ml-1 mr-1" name=startDate>
					</div>
					<div class="col date_box">
						<b>마감일 :</b>
						<input type="date" class="date ml-1 mr-1" name=endDate>
					</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-2 head_box">승인</div>
				<div class="col-5">(영업부)김지영 부장 (0)</div>
				<div class="col-2 head_box">작성자</div>
				<div class="col-3">김지영</div>
			</div>
			
			<div class="row">
				<div class="col head_box">내용</div>
			</div>
			<div class="row" id="contents_box">
					<textarea class=" col-xs-12" id="contents" name="contents"
						onclick="contents_box()">${dto.contents}</textarea>
				</div>

			<!--첨부파일  -->
			<div class="row">
				<!-- 해당 게시글에 저장된 파일 갯수 확인 -->
				<div class="col-md-12 head_box" id="only">
					<b><span class="files" id="files">첨부파일 : ${fileCount}개</span></b>
					<ul>
						<%-- <c:forEach var="i" items="${fileList}"> --%>
						<li class="fileLi"><a
							href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">${i.oriname}</a>
						</li>
						<!-- </c:forEach> -->
					</ul>
				</div>
			</div>
			<div class="row">
				<!--홈으로 이동  -->
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary" onclick="fn_home()">HOME</button>
				</div>

				<div class="col-sm-5 d-none d-sm-block"></div>

				<!--작성자에게만 보이는 버튼  -->
				<div class="button_box col-sm-5">
					<button type="reset" class="btn btn-primary">취소</button>
					<button type="button" class="btn btn-primary" id="btn_write">임시저장</button>
					<button type="submit" class="btn btn-primary"
						onclick="fn_modify()">수정</button>
					<button type="button" class="btn btn-primary"
						onclick="fn_delete()">삭제</button>
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
</script>
</body>
</html>