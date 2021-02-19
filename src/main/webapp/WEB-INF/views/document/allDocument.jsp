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
div {
	font-size: 16px;
}

.textBox {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

#c-hover:hover {
	background-color: whitesmoke;
}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->

		<div id="content" class="p-4 p-5 pt-5">
			<div class="w-80 p-0" style="min-width: 800px;">
				<h2 class="mb-4">문서함</h2>
				<div class="notice-container">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link active"
							data-toggle="tab" href="#draft" id="tab-all">기안함</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab"
							href="#pay" id="tab-com">결재함</a></li>
					</ul>

					<div class="col-12">
						<div class="tab-content">
							<div class="tab-pane fade show active pt-3" id="draft">
								<div class="row p-3" style="border-bottom: 1px solid #c9c9c9">
									<div class="col-2 p-1 text-center textBox">
										<b>문서번호</b>
									</div>
									<div class="col-5 p-1 pl-2 text-center textBox">
										<b>제목</b>
									</div>
									<div class="col-3 p-1 text-center textBox">
										<b>작성날짜</b>
									</div>
									<div class="col-2 p-1 text-center textBox">
										<b>상태</b>
									</div>
								</div>
								<div class=notice-list id=myboard>
									<c:forEach var="list" items="${docList }" begin="0" end="10">
										<div class="row p-3" id="c-hover"
											style="border-bottom: 1px solid #c9c9c9">
											<div class="col-2 p-2 text-center textBox">
												<a href="/document/toReadPage.document?seq=${list.seq }">${list.seq }</a>
											</div>
											<div class="col-5 p-2 textBox">
												<a href="/document/toReadPage.document?seq=${list.seq }">${list.title }</a>
											</div>
											<div class="col-3 p-2 text-center textBox">
												<a href="/document/toReadPage.document?seq=${list.seq }">${list.write_date }</a>
											</div>
											<div class="col-2 p-2 text-center textBox">
												<a href="/document/toReadPage.document?seq=${list.seq }">${list.status }</a>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<div class="tab-pane fade pt-3" id="pay">
								<div class="row p-3" style="border-bottom: 1px solid #c9c9c9">
									<div class="col-2 p-1 text-center textBox">
										<b>문서번호</b>
									</div>
									<div class="col-4 p-1 pl-2 text-center textBox">
										<b>제목</b>
									</div>
									<div class="col-2 p-1 text-center textBox">
										<b>작성날짜</b>
									</div>
									<div class="col-2 p-1 text-center textBox">
										<b>작성자 | 부서</b>
									</div>
									<div class="col-2 p-1 text-center textBox">
										<b>결재 상태</b>
									</div>
								</div>
								<div class=notice-list id=myboard">
									<c:forEach var="clist" items="${clist }" begin="0" end="10">
										<div class="row p-3" id="c-hover" onclick="fn_toReadPage()"
											style="border-bottom: 1px solid #c9c9c9; cursor: pointer;">
											<div class="col-2 p-2 text-center textBox">${clist.seq }</div>
											<div class="col-4 p-2 textBox text-left pl-4">${clist.title }</div>
											<input type="hidden" id="getSeq" value="${clist.seq}">
											<div class="col-2 p-2 text-center textBox">${clist.write_date }</div>
											<div class="col-2 p-2 text-center textBox">${clist.emp_name }
												|${clist.dept_name}</div>
											<div class="col-2 p-2 text-center textBox">${clist.status}</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="/js/jquery-ui.js"></script>
	<script>
   function fn_toReadPage (){
      var seq=$("#getSeq").val();
      location.href="/document/toReadPage.document?seq="+seq;
   }
</script>
</body>
</html>