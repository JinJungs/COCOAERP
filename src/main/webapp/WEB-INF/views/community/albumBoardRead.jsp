<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Album Board Read</title>
<link rel="stylesheet" href="/resources/css/noBoard.css" type="text/css"
	media="screen" />
<style type="text/css">
#contents_box{margin:1px;height:400px;border:none;}
.row{border-bottom: 1px solid pink;} 
#only{border-top: 1px solid pink;}
.fileLi{font-size:13px;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">앨범게시판(글읽기)</h2>
			
					<input type="hidden" name="cpage" value="${cpage}"> 
		<input type="hidden" name="seq" value="${dto.seq}">
		<input type="hidden" name="menu_seq" value="${dto.menu_seq}">
					
			    <div class="row">
			        <div class="col-sm-3 d-none d-sm-block">작성자</div>
			        <div class="col-sm-6"></div>
			        <div class="col-sm-3 d-none d-sm-block">날짜</div>
			    </div>
			    
			   <div class="row">
			    	<div class="col-sm-3">제목</div>
			    	<div class="col-sm-9"></div>
			    </div>
			    
			    <div class="row">
			    	<div class="col">내용 </div>
			    </div>
			    <div class="row">
			        <div class="contents_box col-xs-12">
			        </div>
			    </div>
			    
			    <div class="row">
			        <div class="col-md-9">파일첨부</div>
			        <div class="col-md-3"></div>
			    </div>
			    
			    <div class="row">
			    	<!--홈으로 이동  -->
			        <div class="col-sm-2">
						<button>HOME</button>
			        </div>
			        
			        <div class="col-sm-7 d-none d-sm-block"></div>
			        
			        <div class="button_box col-sm-3">
						<button>수정</button>
						<button>삭제</button>
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
</body>
</html>