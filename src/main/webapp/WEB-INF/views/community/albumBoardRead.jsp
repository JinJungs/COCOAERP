<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Album Board Read</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css"
	media="screen" />
<style type="text/css">
.row{border-bottom: 1px solid pink;} 
#only{border-top: 1px solid pink;}
.fileLi{font-size:13px;}
</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">${s.mid_name}(글읽기)</h2>
			<input type="hidden" name="cpage" value="${cpage}"> <input
				type="hidden" name="seq" value="${dto.seq}"> <input
				type="hidden" name="menu_seq" value="${dto.menu_seq}">
				<input
				type="hidden" name="type" value="${s.type}">

			<!--제목  -->
			<div class="row">
				<div class="col-sm-12 head_box">${dto.title}</div>
			</div>
			<!--작성자 / 날짜  -->
			<div class="row">
				<div class="col-9  head_box">${dto.name}</div>
				<div class="col-3  head_box">${dto.write_date}</div>
			</div>

			<!--내용  -->
			<div class="row">
				<div class="col-9  head_box head_box">
					<b>내용</b>
				</div>
				<div class="col-3  head_box">
					<b>조회수 : ${dto.view_count}</b>
				</div>
			</div>
			<div class="row contents_box"><div class="col">${dto.contents}</div></div>
			<input type="hidden" id="boardfileCount" value="${fileCount} " />

			<!--첨부파일  -->
			<div class="row">
				<!-- 해당 게시글에 저장된 파일 갯수 확인 -->
				<div class="col-md-12 head_box" >
					<b><span class="files" id="files">첨부파일 : ${fileCount}개</span></b>
					<ul>
						<c:forEach var="i" items="${fileList}">
							<li class="fileLi"><a
								href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">${i.oriname}</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<div class="row">
				<!--작성자에게만 보이는 버튼  -->
				<div class="button_box col-sm-3" style="text-align: left;">
					<c:choose>
						<c:when test="${checkWriter>0}">
							<button type="submit" class="btn btn-primary"
								onclick="fn_modify(${cpage},${dto.seq},${dto.menu_seq})">수정</button>
							<button type="button" class="btn btn-primary"
								onclick="fn_delete(${cpage},${dto.seq},${dto.menu_seq})">삭제</button>
						</c:when>
					</c:choose>
				</div>

				<div class="col-sm-7 d-none d-sm-block"></div>
				<!--홈으로 이동  -->
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary" onclick="fn_home()">HOME</button>
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
			<!--게시판 댓글쓰기-->
			<div class="row">
				<div class="col-md-10 head_box">
					<input type="hidden" name="seq" value="${seq}">
					<textarea id="comment_contents" ></textarea>
				</div>
				<div class="col-md-2">
					<button class="btn btn-primary" id="writeComment">댓글등록</button>
				</div>
			</div>
			<!--게시판 댓글 불러오기 -->
			<div id="commentForm" ></div>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   	<script src="/js/bootstrap.min.js"></script>
	<script>
		/*댓글 - 페이지 불러올 때 댓글 불러오기*/
		$(function() {
	       getCommentList();
	   });
	   /*댓글 리스트 불러오기*/
	   function getCommentList() {
	       $.ajax({
	           type : 'POST',
	           url : "/comment/noBoardWriteCommentList.co",
	           dataType : "json",
	           data :  {seq : ${seq}}, 
	           success : function(data) {
	           console.log(data.length);
	              	    var html = "";
						if (data.length > 0) {
	                   for (i = 0; i < data.length; i++) {	
	                       html += "<div class='row' id='comment_row'>";
	                       html += "<div class='on col-2'><b>"+data[i].name+"</b></div>"
	                       html += "<div class='on col-8'></div>";
	                       html += "<div class='on col-2'>"+data[i].write_date+"</div>"
	                       html += "<div class='on col-md-1'></div>";
	                       if(data[i].checkWriter>0){
	                       		html += "<div class='on col-md-9 main_content"+data[i].seq+"'>"+data[i].contents+"</div>"
						   }else if (data[i].checkWriter==0){
	                       		html += "<div class='on col-md-9'>"+data[i].contents+"</div>"
						   };			
	                       html += "<div class='on col-sm-12 col-md-2'>";
	                       /*댓글 수정 삭제 */
	                       if(data[i].checkWriter>0){
		                     html += "<button class='btn btn-outline-primary btn-sm' id='btn-upd"+data[i].seq+"' onclick='updateComment("+data[i].seq+")'>수정</button>  ";
		                     html += "<button class='btn btn-outline-danger btn-sm' id='btn-del"+data[i].seq+"' onclick='deleteComment("+data[i].seq+")'>삭제</button>";
						   };			
		                   html += "</div>";
		                   html += "</div>";
						   updateComment(data[i].seq);
	                       $("#commentForm").html(html);			
	                   }
	               }else if(data.length==0){
	                   $("#commentForm").html("");
	               }
	           }
	       });
	   }
	    /*댓글 수정*/
	   	function updateComment(seq){
		$("#btn-upd"+seq).attr("onclick",null);	
	   	$(".main_content"+seq).append("<textarea class='modify_contents'name='modify_contents' id='modify_contents"+seq+"' placeholder='수정 할 내용을 적어주세요.'></textarea>");
	   	$("#btn-upd"+seq).text("저장");
		$("#btn-upd"+seq).attr("onclick","modComment("+seq+")");
			
 		}
 		function modComment(seq){
			let contents= $("#modify_contents"+seq).val();
	 		$.ajax({
					data : {contents, seq},
		           type: "post",
		           url: "/comment/noBoardUpdateComment.co",
		           success: function(data){
		           console.log(data);
		           console.log("수정 성공!");
		           getCommentList();
		      	 }
		  	 })
 		}
	   /*댓글 작성*/
	 	$(document).ready(function(){
			$("#writeComment").click(function(){
			   var contents = $('#comment_contents').val();
			   if(contents.length==0){return;}
		       
		       $.ajax({
		           type: "post",
		           url: "/comment/noBoardWriteComment.co",
		           data: {contents : contents, seq : ${seq}},
		           success: function(data){
		           console.log(data);
		           console.log("입력성공!");
	          		$('#comment_contents').val("");
		           getCommentList();
		       		},
		   		});
		   	});
	   	});
	   	
	   	/*댓글 삭제*/
	   	function deleteComment(seq){
		   $.ajax({
	           data: 
	           {seq : seq},
	           type: "post",
	           url: "/comment/noBoardDeleteComment.co",
	           success: function(data){
	           confirm("댓글을 정말 삭제하시겠습니까?");
	           console.log(data);
	           console.log("삭제성공!");
	           getCommentList();
	      	 }
	  	 })
  		}
		/*홈으로*/
		function fn_home() {
			location.href = "/";
		}
		/*수정*/
		function fn_modify(cpage,seq,menu_seq) {
			location.href = "/noBoard/notificationBoardModify.no?seq="+seq+"&cpage="+cpage+"&menu_seq="+menu_seq;
		}
		/*삭제*/
		function fn_delete(cpage,seq,menu_seq) {
			doubleCheck = confirm("해당 게시글을 정말 삭제 하시겠습니까?");
			if(doubleCheck==true){
				location.href = "/noBoard/notificationBoardDelete.no?seq="+seq+"&cpage="+cpage+"&menu_seq="+menu_seq;
				return;
			}
		}
	
	</script>
</body>
</html>