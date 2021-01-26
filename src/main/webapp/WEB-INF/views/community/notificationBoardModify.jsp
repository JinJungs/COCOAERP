<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board Modify</title>
<link rel="stylesheet" href="/resources/css/noBoard.css" type="text/css"
	media="screen" />
<style type="text/css">
.row{border-bottom: 1px solid pink}
#contents_box{margin:1px;height:400px;border:none;}
#only{border-top: 1px solid pink;}
.btn_deleteFile{width:10%;color:#866EC7;}
.fileLi{font-size:13px;}
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

			<form
				action="/noBoard/notificationBoardModifyDone.no?cpage=${cpage}&seq=${dto.seq}"
				method="post" id="submitForm" enctype="multipart/form-data">
				<!--제목  -->
				<div class="row ">
					<div class="col-sm-12 head_box">
						<input type="text" id="title" name="title" onclick="title_box()"
							value="${dto.title}">
					</div>
				</div>
				<!--작성자 / 날짜  -->
				<div class="row">
					<div class="col-sm-9 d-none d-sm-block head_box">${dto.name}</div>
					<div class="col-sm-3 d-none d-sm-block head_box">${dto.write_date}</div>
				</div>

				<!--내용  -->
				<div class="row ">
					<div class="col-md-9 head_box">
						<b>내용</b>
					</div>
					<div class="col-md-3 head_box">
						<b>조회수 : ${dto.view_count}</b>
					</div>
				</div>
				<div class="row" id="contents_box">
					<textarea class=" col-xs-12" id="contents" name="contents"
						onclick="contents_box()">${dto.contents}</textarea>
				</div>
				<!--첨부파일  -->
				<div class="row">
					<!-- 해당 게시글에 저장된 파일 갯수 확인 -->
					<div class="col-md-12 head_box" id="only">
						<b><span class="files" id="files">첨부파일</span></b>
						<ul>
							<c:forEach var="i" items="${fileList}">
								<li class="fileLi"><a
									href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">
										${i.oriname}</a><input type=button class="btn_deleteFile"
									value="X" data-seq="${i.seq}"></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 head_box">
						<b><span class="files" id="files">추가파일</span></b>
					</div>
					<div class="col-12 file_input">
						<label>+ File Attach <input type="file" id="myFile"
							name="file" multiple
							onchange="javascript:document.getElementById('file_route').value=this.value">
						</label> <input type="text" readonly="readonly" title="File Route">
					</div>
				</div>

				<div class="row ">
					<!--홈으로 이동  -->
					<div class="col-sm-2 button_box" id="btn_left">
						<button type="button" class="btn btn-primary"
							onclick="fn_home(${cpage})">HOME</button>
					</div>
					<div class="col-sm-10 button_box">
						<button type="button" class="btn btn-primary" id="btn_write">수정</button>
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
     /*파일 추가시 몇 개가 추가 되었는지 보여주는 것*/
        $('.file_input input[type=file]').change(function() {
		    var fileName = $(this).val();
		    var fileCount = $(this).get(0).files.length;
		    if($(this).get(0).files.length == 1){
		        $('.file_input input[type=text]').val(fileName);
		    }
		    else {
		        $('.file_input input[type=text]').val('파일 '+fileCount+'개');
		    }
		});
</script>
</html>