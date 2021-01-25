<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board Modify</title>
<style type="text/css">
.row{border-bottom: 1px solid pink}
input{width:100%;height:90%;border:none;background-color:transparent;}
input:focus{outline:1px solid pink;}
.btn_deleteFile{width:10%;color:#866EC7;}
.board_title{color:#866EC7;}
.board_title:hover{color:blue;}
.contents_box{height:400px;}
.head_box{font-size:17px;color:#866EC7;}
.fileLi{font-size:13px;}
.width{height:50px;}
.button_box{text-align:right;margin-top:5px;}
textarea{width:100%; height:80%; border:none;background-color:transparent;}
textarea:focus{outline:1px solid pink;}
button{height:90%;}
#btn_left{text-align:left;}
#myFile{font-size:13px;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">회사공지(글수정)</h2>

			<input type="hidden" name="cpage" value="${cpage}"> <input
				type="hidden" name="seq" value="${dto.seq}" />

			<form action="/noBoard/notificationBoardModifyDone.no?cpage=${cpage}&seq=${dto.seq}" method="post" id="submitForm" enctype="multipart/form-data">
				<div class="row ">
					<div class="col-sm-12 head_box">
						<input type="text" id="title" name="title" onclick="title_box()"
							value="${dto.title}">
					</div>
				</div>
				
				<div class="row ">
					<div class="col-sm-3 d-none d-sm-block head_box"><b>김지영</b></div>
					<div class="col-sm-6"></div>
					<div class="col-sm-3 d-none d-sm-block head_box"><b>${dto.write_date}</b></div>
				</div>
				<div class="row ">
					<div class="col head_box"><b>내용</b></div>
				</div>
				<div class="row ">
					<textarea class="contents_box col-xs-12" id="contents"
						name="contents" onclick="contents_box()">${dto.contents}</textarea>
				</div>

				<div class="row board_file">
					<!-- 해당 게시글에 저장된 파일 갯수 확인 -->
				<div class="col head_box" >
					<b><span class="files" id="files">첨부파일</span></b>
					<div class="myModal" id="myModal">
						<div class="fileList">
							<ul>
								<c:forEach var="i" items="${fileList}">
									<li class="fileLi"><a href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">
									${i.oriname}</a><input type=button class="btn_deleteFile" value="X" data-seq="${i.seq}">
									</li>
								</c:forEach>
							</ul>
						<b><span class="files" id="files">추가 파일</span></b>
						<input type="file" id="myFile" name="file"  multiple>
						</div>
					</div>
				</div>
				</div>

				<div class="row ">
					<!--홈으로 이동  -->
					<div class="col-sm-2 button_box" id="btn_left">
						<button type="button" class="btn btn-primary" onclick="fn_home(${cpage})">HOME</button>
					</div>
					<div class="col-sm-10 button_box">
						<button type="button" class="btn btn-primary"  id="btn_write">수정</button>
						<button type="reset" class="btn btn-primary">취소</button>
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
		    $('#title').val("");
		}
 	}
 	/*내용부분 누르면 기존에 있던 내용 없애기*/
 	function contents_box(){
 		if($('#contents').val() != null){
		    $('#contents').val("");
		}
 	}
 	/*홈으로*/
	function fn_home(cpage) {
		location.href = "/noBoard/notificationBoardList.no?cpage="+cpage;
	}
	/*파일 삭제*/
	// 화면상에서만 리스트가 사라진 것처럼 보이게 gkrl &제거 전 제거될 파일의 seq값을 리스트에 추가
      var delSeq = ""; // 제거된 파일의 Seq
      var delArr = []; // 제거된 파일의 Seq를 담을 배열
      var submitForm = $('#submitForm');
      $(".btn_deleteFile").on("click",function(e){
         delSeq = $(this).data("seq");   // 제거된 파일의 Seq
         $(this).parent().remove();      // 파일 삭제버튼을 포함하는 parent인 <li>전체를 없앰
         delArr.push(delSeq);         // 제거된 파일의 Seq를 delArr에 추가
      })
     // x누른 파일 삭제
       $('#btn_write').on("click", function() {
       	for(var i=0; i<delArr.length; i++){
            submitForm.append($('<input/>', {type: 'hidden', name: 'delArr', value: delArr[i]}));
         }
         //새로 추가할 파일 최대 갯수 지정
         var x = document.getElementById("myFile");
         var txt = "";
         if ('file' in x) {
            if (x.file.length > 11) {
               alert("파일은 최대 10개까지 첨부 가능합니다.");
               document.getElementById("myFile").value = "";
               return;
            }
         }
         $('#submitForm').submit();
        })
</script>
</html>