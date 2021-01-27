<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<style>
.contents {
	min-height: 600px;
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
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->

		<div id="content" class="p-4 p-5 pt-5">
			<div class="container w-80 p-0" style="min-width: 900px;">
				<div class="row w-100">
					<h5>${dto.temp_name }</h5>
				</div>
				<div class="row w-100"
					style="border-top: 1px solid #c9c9c9; border-bottom: 1px solid #c9c9c9;">
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">문서번호</div>
					<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${dto.seq }</div>
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">작성
						날짜</div>
					<div class="col-4 p-3">${dto.write_date }</div>
				</div>
				<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안자</div>
					<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${dto.emp_name }</div>
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안
						부서</div>
					<div class="col-4 p-3">${dto.dept_name }</div>
				</div>
				<div class="row w-100 pt-5"
					style="border-bottom: 1px solid #c9c9c9;">
					<div class="col-10 p-0 pb-2">
						<b>결재선</b>
					</div>
					<div class="p-0 text-right"></div>
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
					<div class="col-10 p-3">${dto.title }</div>
				</div>
				<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">시작일</div>
					<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9;"
						id="filecontainer">${dto.report_start }</div>
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">종료일</div>
					<div class="col-4 p-3" id="filecontainer">${dto.report_end }</div>
				</div>
				<c:if test="${fileList != null}">
					<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
						<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">첨부
							파일</div>
						<div class="col-3 p-3">
							<c:forEach var="i" items="${fileList }">
								<a
									href="/document/fileDownload.document?seq=${i.seq }&docSeq=${dto.seq}">${i.oriname }</a>
								<br>
							</c:forEach>
						</div>
					</div>
				</c:if>

				<div class="row w-100 pt-3">
					<div class="col-12 contents mb-6">${dto.report_contents }</div>
				</div>
			</div>
		</div>
	</div>
	<c:choose>
		<c:when test="${dto.status eq 'TEMP'}">
			<div class="container-fluid p-0"
				style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow: 0 -2px 7px rgba(0, 0, 0, .15); min-height: 80px;">
				<div class="row">
					<div class="col-12 p-3 text-center">
						<button class="btn btn-secondary">수정하기</button>
					</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dto.status eq 'RAISE'}">
			<div class="container-fluid p-0"
				style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow: 0 -2px 7px rgba(0, 0, 0, .15); min-height: 80px;">
				<div class="row">
					<div class="col-12 p-3 text-center">
						<button class="btn btn-secondary">회수하기</button>
					</div>
				</div>
			</div>
		</c:when>
		<c:when test="${dto.status eq 'REJECT'|| dto.status eq 'RETURN'}">
			<div class="container-fluid p-0"
				style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow: 0 -2px 7px rgba(0, 0, 0, .15); min-height: 80px;">
				<div class="row">
					<div class="col-12 p-3 text-center">
						<button class="btn btn-secondary">재상신</button>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose>

	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="/js/jquery-ui.js"></script>
</body>
</html>