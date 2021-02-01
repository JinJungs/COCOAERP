<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Board</title>
<link rel="stylesheet" href="/resources/css/noBoard.css" type="text/css"
	media="screen" />
<style>
.tab{border-radius: 0px 10px 0px 0px;cursor:pointer;border:1px solid pink;border-bottom:none;}
.tab:hover{background:#115acf;color:white;}
</style>	
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 보관함</h2>
			
			<div class="row">
				<div class="tab col-1"><b>전체</b></div>
				<div class="tab col-1"><b>일일</b></div>
				<div class="tab col-1"><b>주간</b></div>
				<div class="tab col-1"><b>월별</b></div>
			</div>
			
			<div class="row head_box" style="border-bottom: 1px solid pink;">
				<div class="col-md-1 d-none d-md-block">
					<b>#</b>
				</div>
				<div class="col-sm-12 col-md-3">
					<b>제목</b>
				</div>
				<div class="col-md-2 d-none d-md-block">
					<b>작성자</b>
				</div>
				<div class="col-md-2 d-none d-md-block">
					<b>업무 시작일</b>
				</div>
				<div class="col-md-2 d-none d-md-block">
					<b>업무 마감일</b>
				</div>
				<div class="col-md-2 d-none d-md-block">
					<b>작성일</b>
				</div>
			</div>
			
			<div class="row contents_box" style="border-bottom: 1px solid pink;">
				<div class="col-md-1 d-none d-md-block"></div>
				<div class="col-sm-12 col-md-3"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
				<div class="col-md-2 d-none d-md-block"></div>
			</div>
			<div class="row" style="border-top: 1px solid pink;">
				<div class="col-md-2  footer">
					<button type="button" class="btn btn-primary"
						onclick="fn_home(${cpage})">홈으로</button>
				</div>

				<!--네비게이션  -->
				<div class="col-md-8 navi_box">
					<ul class="pagination justify-content-center mb-0">${navi}</ul>
				</div>
				<div class="col-md-2  footer"></div>
			</div>
		</div>
	</div>
	<script>
	/*-----***참고하기 : tap누르면 contents_box에 불러오는 내용이 다르게 되어야함****-----*/
            let tabs = document.getElementsByClassName("tab");
            let contents = document.getElementsByClassName("contents_box");

            for(let i=0; i<tabs.length; i++){
                tabs[i].addEventListener("click",function(){
                    contents[0].style.backgroundColor=tabs[i].innerHTML;
                    contents[0].innerHTML=tabs[i].innerHTML;
                })
            }

    </script>
</body>
</html>