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
			min-height: 400px;
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
			<form method=post action="/document/submitToRewrite.document?seq=${dto.seq }" id=mainform>
				<div class="row w-100">
					<h5>${dto.temp_name }</h5>
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
					<div class="col-10 p-0 pt-2"><b>결재선</b></div>
					<div class="col-2 p-0 text-right"><button type="button" class="btn btn-outline-dark p-1 mb-2" data-toggle="modal" data-target="#modal">결재선 설정</button>

					</div>
				</div>
				<div class="row w-100 pt-5 pb-2"
					 style="border-bottom: 1px solid #c9c9c9;">
					<b>기안 내용</b>
				</div>
				<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">기안
						제목</div>
					<div class="col-10 p-3"><input type=text value="${dto.title }" name="title"></div>
				</div>
				<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">시작일</div>
					<div class="col-4 p-3" style="border-right: 1px solid #c9c9c9;" id="filecontainer"><input type=date class="date ml-1 mr-1" name=leave_start value=${dto.leave_start }></div>
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">종료일</div>
					<div class="col-4 p-3" id="filecontainer"><input type=date class="date ml-1 mr-1" name=leave_end value=${dto.leave_end }></div>
				</div>
				<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
					<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">휴가 종류</div>
					<div class="col-2 p-3">
						<select id="leavetype" class="ml-1" name=leave_type style="border: 1px solid #c9c9c9">
							<option value="연차">연차</option>
							<option value="정기">정기</option>
							<option value="반차">반차</option>
							<option value="병가">병가</option>
							<option value="조퇴">조퇴</option>
							<option value="보건">보건</option>
							<option value="출산">출산</option>
							<option value="경조사">경조사</option>
							<option value="기타">기타</option>
						</select>
					</div>
				</div>
				<c:if test="${fileList != null}">
					<div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
						<div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">파일 첨부</div>
						<div class="col-3 p-3">
							<c:forEach var="i" items="${fileList }">
								${i.oriname }<br>
							</c:forEach>
						</div>
					</div>
				</c:if>
				<div class="row w-100 pt-3">
					<div class="col-12 contents mb-6">
						<textarea name=contents class="w-100" style="min-height: 350px">${dto.contents }</textarea>
					</div>
				</div>
				<div class="container-fluid p-0" style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow:0 -2px 7px rgba(0,0,0,.15); min-height: 80px;">
					<div class="row">
						<div class="col-6 p-3 text-right"><button value="temp" class="btn btn-dark" name=submitType onclick="fn_submitToTemp">임시저장</button></div>
						<div class="col-6 p-3 "><button value="raise" class="btn btn-dark" name=submitType onclick="fn_submitToRaise">상신하기</button></div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
	function fn_submitToTemp(){
		$("formtag").submit();
	}
	function fn_sumbitToRaise(){
		$("formtag").submit();
	}
</script>
<div class="modal" id="modal" tabindex="-1" >
	<div class="modal-dialog modal-xl modal-dialog-centered" style="min-width: 1138px;">
		<div class="modal-content">
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-12"><b>결재선 설정</b></div>
					</div>
					<div class="row w-100">
						<div class="col-4 m-3" style=" border: 1px solid pink">
							<div class="row" style="border-bottom: 1px solid pink;">
								<div class="col-12 p-2"><input type="text" class="w-100" id="search" placeholder="부서명, 이름 입력."></div>
							</div>
							<div class="row">
								<div class="col-12 ">-대표 회사명 넣을지?</div>
							</div>
							<input type="hidden" id="deptsize" value="${size}">

							<c:forEach var="i" items="${deptList}">
								<div class="allcontainer w-100">
									<div class="deptteamcontainer" id="deptteamcontainer${i.code}">
										<div class="row" style="cursor: pointer;" id="confirmdept${i.code}">
											<div class="col-1 "><img src="/icon/plus-square.svg" id="deptopencloseicon${i.code}" onclick="fn_getteamlist(${i.code})"> </div>
											<div class="col-5  p-0 pl-1" >${i.name}</div>
											<input type="hidden" id="deptname${i.code}" value="${i.name}">
										</div>
									</div>
									<div id="childcontainer${i.code}"></div>
								</div>
							</c:forEach>

						</div>
						<div class="col-1 p-0 d-flex justify-content-center" style="min-height:540px; align-items: center; flex:1;">
							<div class="row ">
								<div class="col-12">
									<button class="btn btn-outline-dark btn-sm" id="btn_confirm" disabled onclick="fn_addconfirmlist()">결재</button>
								</div>
							</div>
						</div>
						<div class="col-6 m-3" style="min-height:540px; border: 1px solid pink">
							<div class="row" style="border-bottom: 1px solid pink;">
								<div class="col-7 p-2">기안</div>
								<div class="col-5 p-2 text-right" style="font-size:13px; ">${empInfo.name}(${empInfo.posname})|${empInfo.deptname}</div>
							</div>
							<div class="row" style="border-bottom: 1px solid pink;">
								<div class="col-7 p-2">결재자</div>
							</div>
							<form id="confirmform" name="confirmform">
								<div class="confirmcontainer" id="sortable">

								</div>
							</form>

						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer d-flex justify-content-center">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-dark" onclick="fn_addconfirm()" data-dismiss="modal">적용</button>
			</div>

		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery.MultiFile.min.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script src="/js/bootstrap-datepicker.ko.min.js"></script>
</body>
</html>