<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board Modify</title>
<style type="text/css">
div {border: 1px solid gray}
input{width:100%;height:90%;}
.contents_box{height:400px;}
.width{height:50px;}
.button_box{text-align:right;}
textarea{width:100%; height:100%;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">회사공지(글수정)</h2>

			<input type="hidden" name="cpage" value="${cpage}"> <input
				type="hidden" name="seq" value="${bdto.seq}" />

			<form action="/noBoard/notificationBoardModifyDone.no?cpage=${cpage}&seq=${bdto.seq}" method="post">
				<div class="row">
					<div class="col-sm-3 d-none d-sm-block">${bdto.writer_code}</div>
					<div class="col-sm-6"></div>
					<div class="col-sm-3 d-none d-sm-block">${bdto.write_date}</div>
				</div>

				<div class="row">
					<div class="col-sm-3">제목</div>
					<div class="col-sm-9">
						<input type="text" id="title" name="title" onclick="title_box()"
							value="${bdto.title}">
					</div>
				</div>

				<div class="row">
					<div class="col">내용</div>
				</div>
				<div class="row">
					<textarea class="contents_box col-xs-12" id="contents"
						name="contents" onclick="contents_box()">${bdto.contents}</textarea>
				</div>

				<div class="row">
					<div class="col-md-9">파일첨부</div>
					<div class="col-md-3"></div>
				</div>

				<div class="row">
					<!--홈으로 이동  -->
					<div class="col-sm-2">
						<button type="button" onclick="fn_home(${cpage})">HOME</button>
					</div>

					<div class="col-sm-7 d-none d-sm-block"></div>

					<div class="button_box col-sm-3">
						<button type="submit">수정</button>
						<button type="reset">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	/*제목부분 누르면 기존에 있던 내용 없애기*/
 	function title_box(){
 		if($('#title').val() != null){
		    $('#title').val(" ");
		}
 	}
 	/*내용부분 누르면 기존에 있던 내용 없애기*/
 	function contents_box(){
 		if($('#contents').val() != null){
		    $('#contents').val(" ");
		}
 	}
 	/*홈으로*/
	function fn_home(cpage) {
		location.href = "/noBoard/notificationBoardList.no?cpage="+cpage;
	}
</script>
</html>