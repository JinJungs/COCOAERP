<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board Read</title>
<style type="text/css">
.row{border-bottom: 1px solid pink} 
input{width:100%;height:90%;}
.board_title{color:#866EC7;}
.board_title:hover{color:blue;}
.head_box{font-size:17px;color:#866EC7;}
.fileLi{font-size:13px;}
.contents_box{height:400px;}
.width{height:50px;}
.button_box{text-align:right;}
textarea{width:100%; border:1px solid pink;}
textarea:focus{outline:none;}
.footer{margin-top:5px;}
button{height:90%;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<input type="hidden" name="cpage" value="${cpage}"> <input
			type="hidden" name="seq" value="${dto.seq}" />
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">회사 소식(글읽기)</h2>
			<!--제목  -->
			<div class="row">
				<div class="col-sm-12 head_box">${dto.title}</div>
			</div>

			<div class="row" style="">
				<div class="col-sm-9 d-none d-sm-block head_box">${dto.name}</div>
				<div class="col-sm-3 d-none d-sm-block head_box">${dto.write_date}</div>
			</div>

			<!--내용  -->
			<div class="row">
				<div class="col head_box">
					<b>내용</b>
				</div>
			</div>
			<div class="row contents_box">${dto.contents}</div>
				<input type="hidden" id="boardfileCount" value="${fileCount} " />

			<!--첨부파일  -->
			<div class="row">
				<!-- 해당 게시글에 저장된 파일 갯수 확인 -->
				<div class="col head_box" >
					<b><span class="files" id="files">첨부파일 : ${fileCount}개</span></b>
					<div class="myModal" id="myModal">
						<div class="fileList">
							<ul>
								<c:forEach var="i" items="${fileList}">
									<li class="fileLi"><a
										href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">${i.oriname}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row footer">
				<!--홈으로 이동  -->
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary"
						onclick="fn_home(${cpage})">HOME</button>
				</div>

				<div class="col-sm-7 d-none d-sm-block"></div>

				<!--관리자에게만 보이는 버튼  -->
				<div class="button_box col-sm-3">
					<button type="submit" class="btn btn-primary"
						onclick="fn_modify(${cpage},${dto.seq})">수정</button>
					<button type="button" class="btn btn-primary"
						onclick="fn_delete(${cpage},${dto.seq})">삭제</button>
				</div>
			</div>

			<!--글읽기와 댓글 사이 공간-->
			<div class="width row"></div>


			<!-- 댓글 -->
			<div class="row">
				<div class="col head_box">
					<b>댓글</b>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-9 footer">
					<textarea></textarea>
				</div>
				<div class="col-sm-3 footer">
					<button class="btn btn-primary">댓글달기</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		/*홈으로*/
		function fn_home(cpage) {
			location.href = "/noBoard/notificationBoardList.no?cpage="+cpage;
		}
		/*수정*/
		function fn_modify(cpage,seq) {
			location.href = "/noBoard/notificationBoardModify.no?seq="+seq+"&cpage="+cpage;
		}
		/*삭제*/
		function fn_delete(cpage,seq) {
			doubleCheck = confirm("해당 게시글을 정말 삭제 하시겠습니까?");
			if(doubleCheck==true){
				location.href = "/noBoard/notificationBoardDelete.no?seq="+seq+"&cpage="+cpage;
			}else{
				return;
			}
		}
		/*첨부파일 보기*/
			// 모달창 만들어주기
			function modal(id) {
				let zIndex = 9999;
				let modal = $('#' + id);

				// 모달 div 뒤에 희끄무레한 레이어
				let bg = $('<div>').css({
					position : 'fixed',
					zIndex : zIndex,
					left : '0px',
					top : '0px',
					width : '100%',
					height : '100%',
					overflow : 'auto',
					// 레이어 색갈은 여기서 바꾸면 됨
					backgroundColor : 'rgba(0,0,0,0.4)'
				}).appendTo('body');

				modal
					.css(
						{
						position : 'fixed',
						boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

						// 시꺼먼 레이어 보다 한칸 위에 보이기
						zIndex : zIndex + 1,

						// div center 정렬
						top : '50%',
						left : '50%',
						transform : 'translate(-50%, -50%)',
						msTransform : 'translate(-50%, -50%)',
						webkitTransform : 'translate(-50%, -50%)'
					}).show()
				// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
				.find('#btn_close_modal').on('click', function() {
					bg.remove();
					modal.hide();
				});
			}
	</script>
</body>
</html>