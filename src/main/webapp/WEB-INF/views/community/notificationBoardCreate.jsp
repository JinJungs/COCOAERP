<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board Create</title>
<style type="text/css">
div {border: 1px solid gray}
input{width:100%;}
#fileinsert{width:20%;}
.contents_box{height:400px;}
.width{height:50px;}
.button_box{text-align:right;}
textarea{width:100%; height:100%;}
</style>

<script
   src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
</head>

<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">회사공지(글작성)</h2>

			<form action="/noBoard/notificationBoardCreateDone.no" method="post">
				<div class="row">
					<div class="col-sm-3">제목</div>
					<div class="col-sm-9">
						<input type="text" id="title" name="title">
					</div>
				</div>

				<div class="row">
					<div class="col">내용</div>
				</div>
				<div class="row">
					<textarea class="contents_box col-xs-12" id="contents"
						name="contents"></textarea>
				</div>

				<div class="row">
					<div class="col-12 board_file">
                  		<input type="button" value="파일첨부" id="fileinsert">
					</div>
				</div>

				<div class="row">
					<!--홈으로 이동  -->
					<div class="col-sm-2">
						<button type="button" onclick="fn_home()">HOME</button>
					</div>

					<div class="col-sm-7 d-none d-sm-block"></div>

					<div class="button_box col-sm-3">
						<button type="submit">작성</button>
						<button type="reset">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>
		/*홈으로*/
		function fn_home() {
			location.href = "/noBoard/notificationBoardList.no"
		}
		/*파일첨부*/
			let fileCount = document.getElementsByClassName("addfile");
	        console.log(fileCount.length);
			$("#fileinsert").click(function() {
				if(fileCount.length<10){
					let fileBox = $("<input type=file name=file>");
					fileBox.addClass("addfile");
					fileBox.append("<br>");
					$(".board_file").append(fileBox);
				}else{
					alert("파일은 최대 열개까지만 저장 가능합니다.");
				}
			});
		
	</script>
</body>
</html>