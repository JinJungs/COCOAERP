<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Read Page</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css"
	media="screen" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<style>
.row{border-bottom: 1px solid pink}
.select{text-align:right;}
.date_box>input{width:58%;}
.box{height:400px;padding-left:15px;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 읽기</h2>
			<input type="hidden" id="status" name="status" value="${status}">
			<input type="hidden" id="seq" name="seq" value="${lr.seq}"> <input
				type="hidden" id="temp_code" name="temp_code"
				value="${lr.temp_code}">


			<div class="row">
				<div class="col-sm-2 head_box">제목</div>
				<div class="col-sm-10">${lr.title}</div>
			</div>

			<div class="row">
				<div class="col-2 head_box">업무기한</div>
				<div class="col-2">${lr.report_start}</div>
				<div class="col-3">${lr.report_end}</div>
				<div class="col-2 head_box">작성일</div>
				<div class="col-3">${lr.write_date}</div>
			</div>

			<div class="row">
				<c:choose>
					<c:when test="${status eq 'CONFIRM'}">
						<div class="col-2 head_box">승인</div>
						<c:forEach var="c" items="${confirmBy}">
							<div class="col-5">(${c.dept_name}) ${c.emp_name}
								${c.pos_name}</div>
						</c:forEach>
					</c:when>
						<c:when test="${status eq 'REJECT'}">
							<div class="col-2 head_box">거절</div>
						<c:forEach var="r" items="${rejectBy}">
							<div class="col-5">(${r.dept_name}) ${r.emp_name}
								${r.pos_name}</div>
						</c:forEach>
						</c:when>
				</c:choose>
				<div class="col-2 head_box">작성자</div>
				<div class="col-3">${lr.name}</div>
			</div>
			<div class="row">
				<div class="col head_box">내용</div>
			</div>
			<div class="row box">${lr.contents}</div>
			<!--첨부파일  -->
			<div class="row">
				<!-- 해당 게시글에 저장된 파일 갯수 확인 -->
				<div class="col-md-12 head_box" id="only">
					<b><span class="files" id="files">첨부파일 : ${fileCount}개</span></b>
					<ul>
						<c:forEach var="i" items="${fileList}">
							<li class="fileLi"><a
								href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">${i.oriname}</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="row">
				<!--보낸편지함으로 이동  -->
				<c:choose>
					<c:when test="${status eq 'RAISE' || status eq 'REJECT'}">

						<div class="col-sm-2">
							<button type="button" class="btn btn-primary"
								onclick="fn_sentHome()">HOME</button>
						</div>
					</c:when>
					<c:otherwise>
						<!--홈으로 이동  -->
						<div class="col-sm-2">
							<button type="button" class="btn btn-primary" onclick="fn_home()">HOME</button>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="col-sm-7 d-none d-sm-block"></div>

				<!--작성자에게만 보이는 버튼  -->
				<div class="button_box col-sm-3">
					<c:choose>
						<c:when test="${status eq 'TEMP' || status eq 'RAISE'}">
							<!-- 수정 버튼 - 작성자와 로그인한 사람이 동일할 경우 보임 -->
							<button type="button" class="btn btn-primary"
								onclick="fn_modify(${lr.seq},${lr.temp_code})">수정</button>
							<!-- 삭제버튼 - 임시보관함에서 온 글인 경우만 보임 -->
							<button type="button" class="btn btn-primary"
								onclick="fn_delete(${lr.seq})">삭제</button>
						</c:when>
					</c:choose>
				</div>
			</div>
			<!-- 확인요청 - 승인 받은 경우 comment 보기 -->
			<div class="row">
				<c:choose>
					<c:when test="${status eq 'CONFIRM'}">
						<c:forEach var="c" items="${confirmBy}">
							<div class="col-5">${c.comments}</div>
						</c:forEach>
					</c:when>
				</c:choose>
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
	 	/*홈으로 - 보낸편지함에서 온 경우 (거절 포함)*/
	 	function fn_sentHome(){
	 		location.href = "/log/logSentBoard.log";
	 	}
	 	/*홈으로 */
		function fn_home() {
			location.href = "/";
		}
		/*수정*/
		function fn_modify(seq,temp_code) {
			console.log(seq);
			location.href = "/log/logModify.log?tempCode="+temp_code+"&status=${status}&seq="+seq;
		}
		/*삭제 - 임시저장일 경우 ONLY*/
		function fn_delete(seq) {
			doubleCheck = confirm("해당 게시글을 정말 삭제 하시겠습니까?");
			if(doubleCheck==true){
				location.href = "/log/logDel.log?status=${status}&seq="+seq;
			}else{
				return;
			}
		}
</script>
</body>
</html>