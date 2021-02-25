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
div{
	font-size: 16px;
}
select {
	min-width: 90px;
}

.row {
	margin-top: 10px;
}
.textBox{
	overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
}
.item{
	background-color : #6749b930;
}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-5 pt-5">
			<div class="container w-80 p-0" style="min-width: 800px;">
				<h2 class="mb-4">문서대장</h2>
				<form action="/document/allConfirmDoc.document">
				<div class="search pb-2">
					<div class="row mt-3">
						<div class="col-2 col-md-2">저장일</div>
						<div class="col-9">
							<input type=date class="date ml-1 mr-1" name=startDate value=${startDate } max=${today }> 
							~ 
							<input type=date class="date ml-1 mr-1" name=endDate value=${endDate } max=${today }>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-2 mb-2">기안양식</div>
						<div class="col-3 pl-3">
							<select class="selectTemplate" name=template id="templateSelect">
								<option value=0>전체</option>
								<c:forEach var="list" items="${tempList}">
									<option value=${list.code }>${list.name }</option>
								</c:forEach>
							</select>
						</div>
						<div class="selectSearch col-2 mb-3">
							<select name=searchOption id="searchOption">
								<option value=title>제목</option>
								<option value=dept_code>부서</option>
								<option value=writer_code>작성자</option>
							</select>
						</div>
						<script>
							$('#templateSelect').val("${template}").prop("selected",true);
							$('#searchOption').val("${searchOption}").prop("selected",true);
						</script>
						<div class="col-3 col-sm-2 mb-3 pl-3">
							<input type=text name=searchText value=${searchText }>
						</div>
					</div>
					<div class="row">
						<div class="col-12 text-center">
							<input type=submit class="btn btn-primary" value=조회 >
						</div>
					</div>
				</div>
				</form>
				<div>
					<div class="row item p-2" style="border-bottom: 1px solid #c9c9c9">
						<div class="col p-1 text-center textBox"><b>문서번호</b></div>
						<div class="col p-1 text-center textBox"><b>양식</b></div>
						<div class="col-4 p-1 pl-2 text-center textBox"><b>제목</b></div>
						<div class="col-3 p-1 text-center textBox"><b>작성자</b></div>
						<div class="col-2 p-1 text-center textBox"><b>작성날짜</b></div>
					</div>
					<div class=notice-list id=myboard>
						<c:forEach var="list" items="${docList }">
							<div class="row p-2" style="border-bottom: 1px solid #c9c9c9">
								<div class="col p-2 text-center textBox">
									<a href="/document/toReadPage.document?seq=${list.seq }">${list.seq }</a></div>
								<div class="col p-2 text-center textBox"><a href="/document/toReadPage.document?seq=${list.seq }">${list.temp_name }</a></div>
								<div class="col-4 p-2 textBox text-left pl-4"><a href="/document/toReadPage.document?seq=${list.seq }">${list.title }</a></div>
								<div class="col-3 p-2 text-center textBox"><a href="/document/toReadPage.document?seq=${list.seq }">${list.emp_name } | ${list.dept_name }</a></div>
								<div class="col-2 p-2 text-center textBox"><a href="/document/toReadPage.document?seq=${list.seq }">${list.write_date }</a></div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class=pagenation>
					<div class="row">
						<div class="col-12 text-center">${navi }</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="/js/jquery-ui.js"></script>
</body>
</html>