<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Album Board Modify</title>
<style type="text/css">
div {border: 1px solid gray}
input{width:100%;height:90%;}
.contents_box{height:400px;}
.width{height:50px;}
.button_box{text-align:right;}
textarea{width:100%; height:100%;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">앨범게시판(글수정)</h2>
					
			    <div class="row">
			        <div class="col-sm-3 d-none d-sm-block">작성자</div>
			        <div class="col-sm-6"></div>
			        <div class="col-sm-3 d-none d-sm-block">날짜</div>
			    </div>
			    
			    <div class="row">
			    	<div class="col-sm-3">제목</div>
			    	<div class="col-sm-9">
			    		<input type="text">
			    	</div>
			    </div>
			    
			    <div class="row">
			    	<div class="col">내용 </div>
			    </div>
			    <div class="row">
			        	<textarea class="contents_box col-xs-12"></textarea>
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
						<button>취소</button>
			        </div>
			    </div>
		</div>
	</div>
</body>
</html>