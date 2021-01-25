<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board Create</title>
<style type="text/css">
.row{border-bottom: 1px solid pink}
input{width:100%; border:none;background-color:transparent;}
input:focus{outline:1px solid pink;}
#myFile{border: 1px solid black;width:50%;}
.board_title{color:#866EC7;}
.board_title:hover{color:blue;}
#fileinsert{width:20%;}
.head_box{font-size:17px;color:#866EC7;}
.contents_box{height:400px;}
.width{height:50px;}
.button_box{text-align:right;}
textarea{width:100%; height:80%; border:none;background-color:transparent;}
textarea:focus{outline:1px solid pink;}
.btn{margin-top:2px;}
button{height:90%;}
</style>

<script
   src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
</head>

<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">회사공지(글작성)</h2>

			<form action="/noBoard/notificationBoardCreateDone.no" method="post" id="submitForm" enctype="multipart/form-data">
				<div class="row">
					<div class="col-sm-3 head_box">제목</div>
					<div class="col-sm-9">
						<input type="text" id="title" name="title" value="제목을 입력하세요." onclick="title_box()">
					</div>
				</div>

				<div class="row">
					<div class="col head_box">내용</div>
				</div>
				<div class="row">
					<textarea class="contents_box col-xs-12" id="contents" name="contents" 
					placeholder="내용을 입력하세요."></textarea>
				</div>

				<div class="row">
					<div class="col-12 head_box">
						<input type="file" id="myFile" name="file"  multiple>
					</div>
				</div>

				<div class="row">
					<!--홈으로 이동  -->
					<div class="col-sm-2">
						<button type="button" class="btn btn-primary" onclick="fn_home()">HOME</button>
					</div>

					<div class="col-sm-7 d-none d-sm-block"></div>

					<div class="button_box col-sm-3">
						<button type="button" class="btn btn-primary" id="btn_write">작성</button>
						<button type="reset" class="btn btn-primary">취소</button>
					</div>
				</div>
			</form>
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
		function fn_home() {
			location.href = "/noBoard/notificationBoardList.no"
		}
		/*파일첨부*/
		 $('#btn_write').on("click", function() {
         var x = document.getElementById("myFile");
         var txt = "";
         if ('file' in x) {
            if (x.file.length > 11) {
               alert("파일은 최대 10개까지 첨부 가능합니다.");
               document.getElementById("myFile").value = "";
               return;
            }
         }
         if (!$('#contents').val()){
           alert('제목 및 내용을 입력해주세요');
           return;
         }
         $('#submitForm').submit();
        })
	</script>
</body>
</html>