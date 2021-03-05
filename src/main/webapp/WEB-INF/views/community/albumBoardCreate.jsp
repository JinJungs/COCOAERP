<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Album Board Create</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css" media="screen" />
<style type="text/css">
input{width:100%;}
#fileinsert{width:20%;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">${mid_name }(글작성)</h2>

			<form action="/noBoard/notificationBoardCreateDone.no" method="post"
				id="submitForm" enctype="multipart/form-data">

				<input type="hidden" id="getmenu_seq" name="menu_seq"
					value="${menu_seq}" />
				<div class="row">
					<div class="col-sm-3 head_box">제목</div>
					<div class="col-sm-9">
						<input type="text" id="title" name="title" placeholder="제목을 입력하세요."
							onclick="title_box()" required>
					</div>
				</div>

				<div class="row">
					<div class="col head_box">내용</div>
				</div>
				<div class="row">
					<textarea class="contents_box col-xs-12" id="contents"
						name="contents" placeholder="내용을 입력하세요."></textarea>
				</div>

				<div class="row">
					<div class="col-md-12 head_box">
						<b><span class="files" id="files">첨부파일</span></b>
					</div>
					<div class="col-12 file_input">
						<input type="file" class="fileList"  id="file" name="file" accept="image/*"  multiple>
							<div id="listBox"></div><br>
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
						<button type="reset" class="btn btn-primary">되돌리기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/jquery.MultiFile.min.js"></script>
   	<script src="/js/bootstrap.min.js"></script>
<script>
		/*파일첨부*/
		 $('#btn_write').on("click", function() {
	         
	         if (!$('#title').val()){
	           alert('제목을 입력해주세요');
           	   $("#title").focus();
	           return;
	         }else if (!$('#contents').val()){
	           alert('내용을 입력해주세요');
           	   $("#contents").focus();
	           return;
	         }else if ($('.fileList').val()==""){
	           alert('파일을 선택해주세요');
	           return;
	         }
	         $('#submitForm').submit();
        })
		$("input.fileList").MultiFile({
        max: 10, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
        accept: "jpg|png|gif|jfif", //허용할 확장자(지정하지 않으면 모든 확장자 허용)
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
	    
		/*제목부분 누르면 기존에 있던 내용 없애기*/
	 	function title_box(){
	 		if($('#title').val() != null){
			    $('#title').val("");
			}
	 	}
		/*홈으로*/
		function fn_home() {
			location.href = "/noBoard/notificationBoardList.no?menu_seq=3"
		}
		
		
</script>
</body>
</html>