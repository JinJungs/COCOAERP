<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Album Board</title>
<style type="text/css">
div {border: 1px solid gray}
.navi_box{text-align:center;}
.button_box{text-align:right;}
input{width:100%;height:90%;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4">앨범 게시판</h2>
				
				<div class="row">
					<div class="col-sm-4 d-none d-sm-block">공란</div>
					<div class="col-sm-8">
						<div class="row">
							<!--검색 select box   -->
							<div class="col-3">
								<select>
									<option value="">검색</option>
									<option value="">ㅇㅇ</option>
								</select>
							</div>
							<!-- 검색어입력 -->
							<div class="col-7">
								<input type="text">
							</div>
							<!-- 검색버튼 -->
							<div class="col-2"><button>검색</button></div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="card" style="width: 18rem;">
					  <img src="..." class="card-img-top" alt="...">
					  <div class="card-body">
					   <p class="card-text">사진제목</p>
					  </div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-2 d-none d-md-block">
						<button>홈으로</button>
					</div>
					<!--네비게이션  -->
					<div class="navi_box col-md-7">네비게이션바</div>
					<div class="button_box col-md-3 ">
							<button>글 등록</button>
					</div>
				</div>
				
		</div>
	</div>
</body>
</html>