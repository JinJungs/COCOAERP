<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>휴가 신청서</title>
	<link rel="stylesheet"
		  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
	<style>
		.contents {
			min-height: 400px;
			word-break:break-all;
		}
		.box{
			width: 140px;
			border: 1px solid lightgray;
			margin-right: 20px;
		}
		.status_d{
			background-color: #e3f6ff;
			z-index: -1;
			width: 100%;
			left: 13.5px;
		}
		.status_a{
			background-color: #ffe6e3;
			z-index: -1;
			width: 100%;
			left: 13.5px;
		}
		@media print {
			#sidebar {display:none;}
			#printer {display:none;}
			#btnModal {display:none;}
            #footer {display: none;}
		}
		#printer{
			cursor: pointer;
			border: 1px solid #c9c9c9;
			padding: 7px;
			border-radius: 5px;
		}
		#printer:hover{
			background-color: whitesmoke;
		}
	</style>
</head>
<body>
<div class="wrapper d-flex align-items-stretch">
	<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
	<!-- Page Content  -->
	<div id="content" class="p-4 p-5 pt-5">
		<div class="container w-80 p-0" style="min-width: 900px;">
			<div class="row w-100">
				<div class="col-4 p-0">
					<h5>${dto.temp_name }</h5>
				</div>
				<div class="col-8 pr-3 text-right">
					<img src="/icon/printer-icon.svg" id="printer" onclick="fn_print()">
				</div>
			</div>
			<div class="row w-100"
				 style="border-top: 1px solid #c9c9c9; border-bottom: 1px solid #c9c9c9;">
				<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">문서번호</div>
				<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${dto.seq }</div>
				<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">작성 날짜</div>
				<div class="col-4 p-3">${dto.write_date }</div>
			</div>
			<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
				<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안자</div>
				<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${dto.emp_name }</div>
				<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안
					부서</div>
				<div class="col-4 p-3">${dto.dept_name }</div>
			</div>
			<div class="row w-100 pt-5" style="border-bottom: 1px solid #c9c9c9;">
				<div class="col-10 p-0 pb-2">
					<b>결재선</b>
				</div>
				<div class="col-2 p-0 text-right"></div>
			</div>
			<div class="row w-100 pt-4 pb-4 pl-3 pr-3"
				 style="border-bottom: 1px solid #c9c9c9;">

				<div class="box">
					<div class="row">
						<div class="col-10 p-2 text-center status_d">기안자</div>
					</div>
					<div class="row p-2">
						<div class="col-12 text-center">${dto.emp_name }</div>
						<div class="col-12 text-center">(${dto.pos_name })</div>
						<div class="col-12 text-center">${dto.dept_name }</div>
					</div>
				</div>

				<c:forEach var="list" items="${confirmList}">
					<div class="box">
						<div class="row">
							<div class="col-10 p-2 text-center status_a">
								<c:choose>
									<c:when test="${list.isConfirm eq 'N'}">
										미결재
									</c:when>
									<c:when test="${list.isConfirm eq 'Y'}">
										결재
									</c:when>
									<c:when test="${list.isConfirm eq 'R'}">
										반려
									</c:when>
								</c:choose>
							</div>
						</div>
						<div class="row p-2">
							<div class="col-12 text-center">${list.emp_name }</div>
							<div class="col-12 text-center">(${list.pos_name })</div>
							<div class="col-12 text-center">${list.dept_name }</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="row w-100 pt-5 pb-2"
				 style="border-bottom: 1px solid #c9c9c9;">
				<b>기안 내용</b>
			</div>
			<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
				<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">기안
					제목</div>
				<div class="col-10 p-3"><c:out value="${dto.title }"></c:out></div>
			</div>
			<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
				<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">시작일</div>
				<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9;"
					 id="filecontainer">${dto.leave_start }</div>
				<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">종료일</div>
				<div class="col-4 p-3" id="filecontainer">${dto.leave_end }</div>
			</div>
			<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
				<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">휴가 종류</div>
				<div class="col-3 p-3">${dto.leave_type }</div>
			</div>
			<c:if test="${!empty fileList}">
				<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">첨부 파일</div>
					<div class="col-3 p-3">
						<c:forEach var="i" items="${fileList }">
							<a href="/document/fileDownload.document?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">${i.oriname }</a><br>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<div class="row w-100 pt-3">
				<div class="col-12 contents mb-6" style="border-bottom: 1px solid #c9c9c9"><c:out value="${dto.contents }"></c:out></div>
			</div>
			<div class="row w-100 pt-5 pb-2">
				<b>결재 의견</b>
			</div>
			<div class="confirm Table">
				<div class="row w-100 text-center" style="border-top: 1px solid #c9c9c9; border-bottom: 1px solid #c9c9c9">
					<div class="col-1 p-3" style="border-right: 1px solid #c9c9c9"><b>순서</b></div>
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9"><b>결재자</b></div>
					<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9"><b>결재의견</b></div>
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9"><b>상태</b></div>
					<div class="col-3 p-3">결재일</div>
				</div>
				<c:forEach var="list" items="${confirmList}">
					<div class="row w-100 text-center" style="border-bottom: 1px solid #c9c9c9">
						<div class="col-1 p-3" style="border-right: 1px solid #c9c9c9">${list.approver_order }</div>
						<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">${list.emp_name } | ${list.dept_name }</div>
						<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${list.comments }</div>
						<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">
							<c:choose>
								<c:when test="${list.isConfirm eq 'N'}">
									미결재
								</c:when>
								<c:when test="${list.isConfirm eq 'Y'}">
									결재
								</c:when>
								<c:when test="${list.isConfirm eq 'R'}">
									반려
								</c:when>
							</c:choose>
						</div>
						<div class="col-3 p-3">${list.confirm_date }</div>
					</div>
				</c:forEach>
			</div>
			<div class="row w-100 pt-3">
				<c:if test="${auth==1}">
					<div class="col-12 p-3 text-right">
						<button class="btn btn-dark" id="btnModal" data-toggle="modal" data-target="#myModal">반려/결재</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>

<div class="modal" id="myModal" tabindex="-1" >
	<div class="modal-dialog modal-dialog-centered" style="min-width: 600px;">
		<div class="modal-content">
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row w-100" style="border-bottom: 1px solid #c9c9c9">
						<div class="col-12 p-2">
							<h5>결재</h5>
						</div>
					</div>
					<div class="row w-100">
						<div class="col-3 p-2">결재 상태</div>
						<div class="col-2 p-2" ><input type="radio" name="confirm" value="승인" checked><span class="p-1">승인</span></div>
						<div class="col-2 p-2"><input type="radio" name="confirm" value="반려"><span class="p-1">반려</span></div>
					</div>
					<div class="row w-100">
						<div class="col-3 p-2">결재 의견</div>
						<div class="col-9 p-2"><textarea class="w-100" id="comments" style="min-height: 200px"></textarea></div>
					</div>

				</div>
			</div>
			<div class="modal-footer d-flex justify-content-center">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-dark" onclick="fn_confirm(${dto.seq})" data-dismiss="modal">적용</button>
			</div>
		</div>
	</div>
</div>

<c:if test="${dto.writer_code == empCode }">
	<c:choose>
		<c:when test="${dto.status eq 'TEMP'}">
			<div class="container-fluid p-0"
				 style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow: 0 -2px 7px rgba(0, 0, 0, .15); min-height: 80px;" id="footer">
				<div class="row">
					<div class="col-12 p-3 text-center">
						<button class="btn btn-secondary" id="reviseBtn">수정/상신하기</button>
						<script>
							let reviseBtn = document.getElementById("reviseBtn");
							reviseBtn.onclick = function() {
								location.href = "/document/reWrite.document?seq=${dto.seq}";
							}
						</script>
					</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dto.status eq 'RAISE' && confirmStatus ne 'Y'}">
			<div class="container-fluid p-0"
				 style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow: 0 -2px 7px rgba(0, 0, 0, .15); min-height: 80px;" id="footer">
				<div class="row">
					<div class="col-12 p-3 text-center">
						<button class="btn btn-secondary" id="returnBtn">회수하기</button>
						<script>
							let returnBtn = document.getElementById("returnBtn");
							returnBtn.onclick = function() {
								location.href = "/document/returnDocument.document?seq=${dto.seq}";
							}
						</script>
					</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dto.status eq 'REJECT'|| dto.status eq 'RETURN'}">
			<div class="container-fluid p-0"
				 style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow: 0 -2px 7px rgba(0, 0, 0, .15); min-height: 80px;">
				<div class="row">
					<div class="col-12 p-3 text-center">
						<button class="btn btn-secondary" onclick="fn_reWrite(${dto.seq})">재상신</button>
					</div>
				</div>
			</div>
		</c:when>

	</c:choose>
</c:if>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery-ui.js"></script>
<script>
	function fn_reWrite(seq){
		location.href="/document/reWrite.document?seq="+seq;
	}
	function fn_confirm(seq){
		var radioval = $("input:radio[name='confirm']:checked").val();
		var comments = $("#comments").val();
		if(radioval=="승인") {
			location.href = "/document/confirm.document?seq="+seq+"&comments="+comments;
		}else{
			location.href = "/document/return.document?seq="+seq+"&comments="+comments;
		}
	}
	
	function fn_print() {
		window.print();
	}


</script>
</body>
</html>