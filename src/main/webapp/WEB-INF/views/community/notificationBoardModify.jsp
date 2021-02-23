<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board Modify</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css" media="screen" />
<style type="text/css">
.row{border-bottom: 1px solid pink}
#contents_box{margin:1px;height:400px;border:none;}
#only{border-top: 1px solid pink;}
.btn_deleteFile{width:10%;color:#866EC7;}
#btn_left{text-align:left;}
#myFile{font-size:13px;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">회사공지(글수정)</h2>

			<input type="hidden" name="cpage" value="${cpage}"> 
			<input type="hidden" name="seq" value="${dto.seq}">

			<form
				action="/noBoard/notificationBoardModifyDone.no?menu_seq=${menu_seq}&cpage=${cpage}&seq=${dto.seq}"
				method="post" id="submitForm" enctype="multipart/form-data">
				<input type="hidden" name="menu_seq" value="${menu_seq}">
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
					<input type="file" class="fileList"  id="file"
							name="file" accept="image/*"  multiple>
							<div id="listBox"></div><br>
					</div>
				</div>

				<div class="row ">
					<!--홈으로 이동  -->
					<div class="col-sm-2 button_box" id="btn_left">
						<button type="button" class="btn btn-primary"
							onclick="fn_home()">HOME</button>
					</div>
					<div class="col-sm-10 button_box">
						<button type="button" class="btn btn-primary" id="btn_write">수정</button>
						<button type="reset" class="btn btn-primary">되돌리기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/jquery.MultiFile.min.js"></script>
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
	function fn_home() {
		location.href = "/"
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
         //유효성 검사
         if (!$('#contents').val()){
	           alert('내용을 입력해주세요');
           	   $("#contents").focus();
	           return;
	         }else if (!$('#title').val()){
	           alert('제목을 입력해주세요');
           	   $("#title").focus();
	           return;
	         }
         
         $('#submitForm').submit();
        })
    $("input.fileList").MultiFile({
        max: 10, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
        accept: 'jpg|png|gif|jfif', //허용할 확장자(지정하지 않으면 모든 확장자 허용)
        maxfile: 10240, //각 파일 최대 업로드 크기
        maxsize: 20480,  //전체 파일 최대 업로드 크기
        STRING: { //Multi-lingual support : 메시지 수정 가능
            remove : "<img src='/icon/close-x.svg'>", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
            duplicate : "$file 은 이미 선택된 파일입니다.",
            toomuch: "업로드할 수 있는 최대크기를 초과하였습니다.($size)",
            toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
            toobig: "$file 은 크기가 매우 큽니다. (max $size)"
	        },
	        list:"#listBox"
	    });
</script>
</html>