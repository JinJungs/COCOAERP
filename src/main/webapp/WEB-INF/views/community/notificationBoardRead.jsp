<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CocoaWorks Notification Board Read</title>
<style type="text/css">
div {border: 1px solid gray}
input{width:100%;height:90%;}
.contents_box{height:400px;}
.width{height:50px;}
.button_box{text-align:right;}
textarea{width:100%;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<input type="hidden" name="cpage" value="${cpage}"> 
		<input type="hidden" name="seq" value="${dto.seq}" />
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">회사 소식(글읽기)</h2>
					
			    <div class="row">
			        <div class="col-sm-3 d-none d-sm-block">작성자</div>
			        <div class="col-sm-6"></div>
			        <div class="col-sm-3 d-none d-sm-block">${dto.write_date}</div>
			    </div>
			    
			    <div class="row">
			    	<div class="col-sm-3">제목</div>
			    	<div class="col-sm-9">${dto.title}</div>
			    </div>
			    
			    <div class="row">
			    	<div class="col">내용</div>
			    </div>
			    <div class="row contents_box">${dto.contents}</div>
			    
			    <div class="row">
			        <div class="col-md-9">파일첨부</div>
			    </div>
			    
			    <div class="row">
			    	<!--홈으로 이동  -->
			        <div class="col-sm-2">
						<button type="button" onclick="fn_home(${cpage})">HOME</button>
			        </div>
			        
			        <div class="col-sm-7 d-none d-sm-block"></div>
			     
			        <!--관리자에게만 보이는 버튼  -->
			        <div class="button_box col-sm-3">
						<button type="submit" onclick="fn_modify(${cpage},${dto.seq})">수정</button>
						<button type="button" onclick="fn_delete(${cpage},${dto.seq})">삭제</button>
			        </div>
			    </div>
			    
			    <!--글읽기와 댓글 사이 공간-->
			    <div class="width row"> </div>
				
				
				<!-- 댓글 -->
				<div class="row">
					<div class="col">댓글</div>
				</div>
				<div class="row">
					<div class="col-sm-9">
						<textarea></textarea>
					</div>
					<div class="col-sm-3">
						<button>댓글달기</button>
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
	</script>
</body>
</html>