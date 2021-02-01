<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Create</title>
<link rel="stylesheet" href="/resources/css/noBoard.css" type="text/css"
   media="screen" />
<style>
.row{border-bottom: 1px solid pink}
.select{text-align:right;}
.date_box>input{width:58%;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 작성</h2>
			
			<div class="row search_box">
				<div class="select col-12">
						<select name="searchBy" id="searchBy">
							<option value="title">일일</option>
							<option value="contents">주간</option>
							<option value="writer">월별</option>
						</select> 
					</div>
			</div>
			<div class="row">
					<div class="col-sm-3 head_box">제목</div>
					<div class="col-sm-9">
					<input type="text" id="title" name="title" value="제목을 입력하세요."
							onclick="title_box()">
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
						<b><span class="files" id="files">일정</span></b>
					</div>
					<div class="col-6 date_box">
						<b>시작일 :</b> 
						<input type="date" class="date ml-1 mr-1" name=startDate>
					</div>
					<div class="col-6 date_box">
						<b>마감일 :</b>
						<input type="date" class="date ml-1 mr-1" name=endDate>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12 head_box">
						<b><span class="files" id="files">첨부파일</span></b>
					</div>
					<div class="col-12 file_input">
						<label>+ File Attach <input type="file" id="myFile"
							name="file" multiple
							onchange="javascript:document.getElementById('file_route').value=this.value">
						</label> <input type="text" readonly="readonly" title="File Route">
					</div>
				</div>
				
				
				<div class="row">
					<!--홈으로 이동  -->
					<div class="col-sm-2">
						<button type="button" class="btn btn-primary" onclick="fn_home()">HOME</button>
					</div>

					<div class="col-sm-5 d-none d-sm-block"></div>

					<div class="button_box col-sm-5">
						<button type="button" class="btn btn-primary" id="btn_write">임시저장</button>
						<button type="button" class="btn btn-primary" id="btn_write">작성</button>
						<button type="reset" class="btn btn-primary">취소</button>
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