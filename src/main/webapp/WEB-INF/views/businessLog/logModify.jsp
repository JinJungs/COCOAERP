<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Modify Page</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css"
	media="screen" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<style>
.row{border-bottom: 1px solid pink}
.date_box>input{width:60%;}
.btn_deleteFile{width:10%;color:#866EC7;}
#contents_box{margin:1px;height:400px;border:none;}
input{width:100%;}	
</style>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 수정</h2>

			<form action="/log/logModifyTempSave.log" method="post"
				name="submitForm" id="submitForm" enctype="multipart/form-data">

				<input type="hidden" id="status" name="status" value="${status }">
				<input type="hidden" id="temp_code" name="temp_code"
					value="${lr.temp_code}"> <input type="hidden" id="seq"
					name="seq" value="${lr.seq}">

				<div class="row">
					<div class="col-sm-2 d-none d-sm-block head_box">제목</div>
					<div class="col-6 col-sm-4">
						<input type="text" id="title" name="title" onclick="title_box()"
							value="${lr.title}">
					</div>
					<div class="col-sm-2 d-none d-sm-block head_box">작성일</div>
					<div class="col-6 col-sm-4">
						<input type="text" id="write_date" name="write_date"
							value="${lr.write_date}">
					</div>
				</div>

				<div class="row">
					<div class="col-md-2 head_box">업무기한</div>
					<div class="col-md-10">
						<div class="row" style="border: none;">
							<div class="col-md-12 head_box">
								<b><span class="files" id="files">일정</span></b>
							</div>
							<div class="col-12 date_box" id="startDate">
								<input type="date" id="report_start" class="date ml-1 mr-1"
									name="report_start" value="${lr.report_start }">
							</div>
							<div class="col-12 date_box" id="report_start_week">
								<input type="week" id="week" class="week ml-1 mr-1"
									name="report_start_week" value="${lr.report_start }">
							</div>
							<div class="col-12 date_box" id="report_start_month">
								<input type="month" id="month" class="month ml-1 mr-1"
									name="report_start_month" value="${lr.report_start }">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-2 head_box">작성자</div>
					<div class="col-3">${lr.name}</div>
				</div>

				<div class="row">
					<div class="col head_box">내용</div>
				</div>
				<div class="row" id="contents_box">
					<textarea class=" col-xs-12" id="contents" name="contents">${lr.contents}</textarea>
				</div>
				<!--첨부파일  -->
				<div class="row">
					<!-- 해당 게시글에 저장된 파일 갯수 확인 -->
					<div class="col-md-12 head_box" id="only">
						<b><span class="files" id="files">첨부파일</span></b>
						<ul>
							<c:forEach var="i" items="${fileList}">
								<li class="fileLi"><a
									href="/files/downloadNotificationBoardFiles.files?seq=${i.seq}&savedname=${i.savedname}&oriname=${i.oriname}">
										${i.oriname}</a><input type=button class="btn_deleteFile"
									value="X" data-seq="${i.seq}"></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 head_box">
						<b><span class="files" id="files">추가파일</span></b>
					</div>
					<div class="col-12 file_input">
						<input type="file" class="fileList" id="file" name="file"
							accept="image/*" multiple>
						<!-- <label>+ File Attach 
						</label> -->
						<div id="listBox"></div>
						<br>
					</div>
				</div>
				<div class="row">
					<!--보낸편지함으로 이동  -->
					<c:choose>
						<c:when test="${status eq 'RAISE'}">
							<div class="col-sm-2">
								<button type="button" class="btn btn-primary"
									onclick="fn_sentHome()">HOME</button>
							</div>
						</c:when>
						<c:otherwise>
							<!--홈으로 이동  -->
							<div class="col-sm-2">
								<button type="button" class="btn btn-primary"
									onclick="fn_home()">HOME</button>
							</div>
						</c:otherwise>
					</c:choose>

					<div class="col-sm-4 d-none d-sm-block"></div>

					<div class="button_box col-sm-5">
						<button type="button" id="btn_modifyDone" class="btn btn-primary">작성</button>
						<button type="submit" id="btn_tempSave" class="btn btn-primary">임시저장</button>
						<button type="reset" class="btn btn-primary">되돌리기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="/js/jquery-ui.js"></script>
	<script src="/js/jquery.MultiFile.min.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	<script>
	 //유효성 검사 -임시저장
        $('#btn_tempSave').on("click", function() {
        
		if (!$('#title').val()){
	           alert('제목을 입력해주세요');
           	   $("#title").focus();
	           return false;
	    }else if (!$('#contents').val()){
	           alert('내용을 입력해주세요');
           	   $("#contents").focus();
	           return;
	    }
		$("#submitForm").submit;
        })
        
	 //유효성 검사 -저장
         $('#btn_modifyDone').on("click", function() {
         
		if (!$('#title').val()){
	           alert('제목을 입력해주세요');
           	   $("#title").focus();
	           return;
	    }else if (!$('#contents').val()){
	           alert('내용을 입력해주세요');
           	   $("#contents").focus();
	           return;
	    }
	    if (!$('#report_start').val() && $("#selectBy").val()=="daily" ){
	           alert('일정을 입력해주세요');
	           return;
	        }
	        if (!$('#week').val()  && $("#selectBy").val()=="weekly"){
	           alert('주간일정을 입력해주세요');
	           return;
	        }
	        if (!$('#month').val()  && $("#selectBy").val()=="monthly"){
	           alert('월별일정을 입력해주세요');
	           return;
	        }
		$("#submitForm").attr("action","/log/logModifyDone.log");
         $('#submitForm').submit();
        })
         
    	$("input.fileList").MultiFile({
        max: 10, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
        accept: 'jpg|png|gif|jfif', //허용할 확장자(지정하지 않으면 모든 확장자 허용)
        maxfile: 10240, //각 파일 최대 업로드 크기
        maxsize: 20480,  //전체 파일 최대 업로드 크기
        STRING: { //Multi-lingual support : 메시지 수정 가능
            remove : "<img src='/icon/close-x.svg'>", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
            duplicate : "$file 은 이미 선택된 파일입니다.",
            toomuch: "업로드할 수 있는 최대크기를 초과하였습니다.($size)",
            toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
            toobig: "$file 은 크기가 매우 큽니다. (max $size)"
	        },
	        list:"#listBox"
	    });
		/*제목부분 누르면 기존에 있던 내용 없애기*/
	 	function title_box(){
	 		if($('#title').val() != null){
			    $('#title').val("");
			}
	 	}
	 	/*내용부분 누르면 기존에 있던 내용 없애기*/
	 	function contents_box(){
	 		if($('#contents').val() != null){
			    $('#contents').val("");
			}
	 	}
	 	/*홈으로 - 보낸편지함에서 온 경우*/
	 	function fn_sentHome(){
	 		location.href = "/log/logSentBoard.log";
	 	}
	 	/*홈으로 */
		function fn_home() {
			location.href = "/log/logBoard.log?status=${status}";
		}
		/*파일 삭제*/
		// 화면상에서만 리스트가 사라진 것처럼 보이게 gkrl &제거 전 제거될 파일의 seq값을 리스트에 추가
	      var delSeq = ""; // 제거된 파일의 Seq
	      var delArr = []; // 제거된 파일의 Seq를 담을 배열
	      var submitForm = $('#submitForm');
	      $(".btn_deleteFile").on("click",function(e){
	         delSeq = $(this).data("seq");   // 제거된 파일의 Seq
	         $(this).parent().remove();      // 파일 삭제버튼을 포함하는 parent인 <li>전체를 없앰
	         delArr.push(delSeq);         // 제거된 파일의 Seq를 delArr에 추가
	      })
	    
       
/*페이지 처음 접속 시, temp_code별로 업무기한을 다르게 보여주는 이벤트*/
	window.onload = function(){
		let temp_code = document.getElementById("temp_code");
		let startDate= document.getElementById("startDate");
		let report_start_week = document.getElementById("report_start_week");
		let report_start_month = document.getElementById("report_start_month");
		var curdate = new Date();
	    var year =curdate.getFullYear();
	    var month =curdate.getMonth()+1;
	    var date = curdate.getDate();
	    var today ="";
	    if(month.toString().length==1&&date.toString().length==1) {
	        today = year + "-0" + month + "-0" + date;
	    }else if(month.toString().length==1){
	        today =year + "-0" + month + "-" + date;
	    }else{
	        today =year + "-" + month + "-" + date;
	    }
		if(temp_code.value==1){
			startDate.style.display="block";
			report_start_week.style.display="none";
			report_start_month.style.display="none";
		}else if(temp_code.value==2){
			startDate.style.display="none";
			report_start_week.style.display="block";
			report_start_month.style.display="none";
		}else if(temp_code.value==3){
			startDate.style.display="none";
			report_start_week.style.display="none";
			report_start_month.style.display="block";
		}
	}
</script>
</body>
</html>