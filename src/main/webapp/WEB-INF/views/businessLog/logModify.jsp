<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Modify Page</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css"
	media="screen" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<style>
.row{border-bottom: 1px solid pink}
.date_box>input{width:58%;}
.btn_deleteFile{width:10%;color:#866EC7;}
#contents_box{margin:1px;height:400px;border:none;}
.btn{width:85px;}
input{width:100%;}	
</style>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 수정</h2>

			<form method="post" id="submitForm" enctype="multipart/form-data">

				<input type="hidden" id="status" name="status" value="${status }">
				<input type="hidden" id="temp_code" name="temp_code"
					value="${lr.temp_code}">
				<input type="hidden" id="seq" name="seq" value="${lr.seq}">

				<div class="row">
					<div class="col-sm-2 d-none d-sm-block head_box">제목</div>
					<div class="col-12 col-sm-10">
						<input type="text" id="title" name="title" onclick="title_box()"
							value="${lr.title}">
					</div>
				</div>

				<div class="row">
					<div class="col-2 head_box">업무기한</div>
					<div class="col-10">
						<div class="row" style="border: none;">
								<div class="col" id="test">
									<div class="col-6 date_box">
										<b>시작일 :</b> <input type="date" class="date ml-1 mr-1"
											name="report_start" id="report_start">
									</div>
								</div>
								<div class="col" id="test2">
									<div class="col-6 date_box" id="endDate">
										<b>마감일 :</b> <input type="date" class="date ml-1 mr-1"
											name="report_end" id="report_end">
									</div>
								</div>
						</div>
					</div>
				</div>

				<script>
					
				</script>

				<div class="row">
					<div class="col-2 head_box">승인</div>
					<div class="col-5">(영업부)김지영 부장 (0)</div>
					<div class="col-2 head_box">작성자</div>
					<div class="col-3">${lr.name}</div>
				</div>

				<div class="row">
					<div class="col head_box">내용</div>
				</div>
				<div class="row" id="contents_box">
					<textarea class=" col-xs-12" id="contents" name="contents">${lr.contents}</textarea>
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
							name="file" multiple>
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
						<input type="submit" id="btn_confirm" class="btn btn-primary"
							value="임시저장" formaction="/log/logModifyTempSave.log"> 
							
						<input type="submit" id="btn_reject" class="btn btn-primary" 
						value="수정" formaction="/log/logModifyDone.log">
						<!-- <button type="button" class="btn btn-primary" id="btn_tempSaved"
						onclick="fn_temp_Saved()">임시저장</button>
					<button type="button" class="btn btn-primary" id="btn_write"
						onclick="fn_write()">수정</button> -->
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
	 	/*홈으로 */
		function fn_home(status) {
			location.href = "/log/logBoard.log?status=${status}";
		}
</script>

<script> 
	window.onload = function(){
		alert("First READY");
		let temp_code = document.getElementById("temp_code");
		let test = document.getElementById("test");
		let test2 = document.getElementById("test2");
		console.log(temp_code);
		if(temp_code.value==1){
			console.log("왔니?");
			test2.style.display="none";
		}else if(temp_code.value==2||temp_code.value==3){
			est2.style.display="block";
		}
	}
</script>
</body>
</html>