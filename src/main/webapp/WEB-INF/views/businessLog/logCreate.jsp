<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log Create</title>
<link rel="stylesheet" href="/css/noBoard.css" type="text/css" media="screen" />
<style type="text/css">
.row{border-bottom: 1px solid pink}
.select{text-align:right;}
.date_box>input{width:58%;}
#selectBy{border:none;background-color:transparent;}
#selectBy:focus{outline:1px solid pink;}
input{width:100%;}
</style>
</head>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
		<!-- Page Content  -->
		<div id="content" class="p-4 p-md-5 pt-5">
			<h2 class="mb-4 board_title">업무일지 작성</h2>
			
			<form  method="post"
				id="submitForm" enctype="multipart/form-data">
				
			<div class="row search_box">
				<div class="select col-12">
						<select name="selectBy" id="selectBy">
							<option>업무일지 종류를 설정해 주세요.</option>
							<option value="daily" id="daily">일일</option>
							<option value="weekly" id="weekly">주간</option>
							<option value="monthly" id="monthly">월별</option>
						</select> 
					</div>
			</div>
			<div class="row">
					<div class="col-sm-3 head_box">제목</div>
					<div class="col-sm-9">
					<input type="text" id="title" name="title" value="제목을 입력하세요."
							onclick="title_box()">
					</div>
				</div>

				<div class="row">
					<div class="col head_box">내용</div>
				</div>
				
				<div class="row">
					<textarea class="contents_box col-xs-12" id="contents"
						name="contents" placeholder="내용을 입력하세요."></textarea>
				</div>
				
				<div class="row">
					<div class="col-md-12 head_box">
						<b><span class="files" id="files">일정</span></b>
					</div>
					<div class="col-6 date_box">
						<b>시작일 :</b> 
						<input type="date" class="date ml-1 mr-1" name="report_start" id="report_start">
					</div>
					<div class="col-6 date_box" id="endDate"> 
						<b>마감일 :</b>
						<input type="date" class="date ml-1 mr-1" name="report_end" id="report_end">
					</div>
				</div>
				<script type="text/javascript">
					
				</script>
				<div class="row">
					<div class="col-md-12 head_box">
						<b><span class="files" id="files">첨부파일</span></b>
					</div>
					<div class="col-12 file_input">
						<label>+ File Attach <input type="file" id="myFile"
							name="file" multiple>
						</label> <input type="text" readonly="readonly" title="File Route">
					</div>
				</div>
				
				
				<div class="row">
					<!--홈으로 이동  -->
					<div class="col-sm-2">
						<button type="button" class="btn btn-primary" onclick="fn_home()">HOME</button>
					</div>

					<div class="col-sm-5 d-none d-sm-block"></div>

					<div class="button_box col-sm-5">
					
						<button type="button" class="btn btn-primary" id="btn_tempSaved" 
					 onclick="fn_temp_Saved()">임시저장</button>
						<button type="button" class="btn btn-primary" id="btn_write"
						onclick="fn_write()">작성</button>
						<button type="reset" class="btn btn-primary">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
<script>
/*-------------------------작성*/
		function fn_write(){
		var report_start =$("#report_start").val().replaceAll("-","");
        var report_end =$("#report_end").val().replaceAll("-","");
        var start = $("#report_start").val();
        var end = $("#report_end").val();
        var temp =end.split("-");
        var date = new Date(temp[0],temp[1]-1,temp[2]);
        var enddate = new Date(date.setDate(date.getDate()+1));
        var year = enddate.getFullYear();
        var month = enddate.getMonth()+1;
        var date = enddate.getDate();
        var today ="";
        if(month.toString().length==1 && date.toString().length==1) {
            today = year + "-0" + month + "-0" + date;
        }else if(month.toString().length==1){
            today =year + "-0" + month + "-" + date;
        }else{
            today =year + "-" + month + "-" + date;
        }
        $("#temp").val(today);

        if(report_end!=""&&report_start>report_end){
            alert("종료일이 시작일보다 빠릅니다.");
            return;
        }else if(start==""){
            alert("시작일을 입력해주세요.");
            $("#report_start").focus();
            return;
        }else if(end==""){
            alert("종료일을 입력해주세요..");
            $("#report_end").focus();
            return;
        }
			$("#submitForm").attr("action","/log/logCreateDone.log");
			$("#submitForm").submit;
		}
		/*파일첨부 */
		 $('#btn_write').on("click", function() {
         var x = document.getElementById("myFile");
         var txt = "";
         if ('files' in x) {
            if (x.files.length > 11) {
               alert("파일은 최대 10개까지 첨부 가능합니다.");
               document.getElementById("myFile").value = "";
               return;
            }
         }
         if (!$('#contents').val()){
           alert('제목 및 내용을 입력해주세요');
           return;
         }
         $('#submitForm').submit();
        })
        /*파일 추가시 몇 개가 추가 되었는지 보여주는 것*/
        $('.file_input input[type=file]').change(function() {
		    var fileName = $(this).val();
		    var fileCount = $(this).get(0).files.length;
		    if($(this).get(0).files.length == 1){
		        $('.file_input input[type=text]').val(fileName);
		    }
		    else {
		        $('.file_input input[type=text]').val('파일 '+fileCount+'개');
		    }
		});
		
		

	/*----------마감일 Event-------*/
	let selectBy = document.getElementById("selectBy");
	let endDate = document.getElementById("endDate");
	let daily = document.getElementById("daily");
	let report_end = document.getElementById("report_end");
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
    	
	selectBy.addEventListener("change",function(){
	   let index= selectBy.selectedIndex;
	   if(index=="1"){ // 일일
	   		today= year + 1 + "-0" + month + "-0" + date;
	        endDate.style.display="none";
	        report_end.value = today;
	        console.log(today);
	   }else if(index=="2"){ //주간
	        endDate.style.display="block";
	   }else if(index=="3"){ //월별
	        endDate.style.display="block";
	   }
	})
	
	
	/* ------------------임시저장*/
		function fn_temp_Saved(){
			var report_start =$("#report_start").val().replaceAll("-","");
        var report_end =$("#report_end").val().replaceAll("-","");
        var start = $("#report_start").val();
        var end = $("#report_end").val();
        var temp =end.split("-");
        var date = new Date(temp[0],temp[1]-1,temp[2]);
        var enddate = new Date(date.setDate(date.getDate()+1));
        var year = enddate.getFullYear();
        var month = enddate.getMonth()+1;
        var date = enddate.getDate();
        var today ="";
        if(month.toString().length==1 && date.toString().length==1) {
            today = year + "-0" + month + "-0" + date;
        }else if(month.toString().length==1){
            today =year + "-0" + month + "-" + date;
        }else{
            today =year + "-" + month + "-" + date;
        }
        $("#temp").val(today);

        if(report_end!=""&&report_start>report_end){
            alert("종료일이 시작일보다 빠릅니다.");
            return;
        }else if(start==""){
            alert("시작일을 입력해주세요.");
            $("#report_start").focus();
            return;
        }else if(end==""){
            alert("종료일을 입력해주세요..");
            $("#report_end").focus();
            return;
        }
			$("#submitForm").attr("action","/log/logTempSave.log");
			$("#submitForm").submit;
		}
		/* 파일 첨부 - 임시저장 부분*/
		 $('#btn_tempSaved').on("click", function() {
         var x = document.getElementById("myFile");
         var txt = "";
         if ('files' in x) {
            if (x.files.length > 11) {
               alert("파일은 최대 10개까지 첨부 가능합니다.");
               document.getElementById("myFile").value = "";
               return;
            }
         }
         if (!$('#contents').val()){
           alert('제목 및 내용을 입력해주세요');
           return;
         }
         $('#submitForm').submit();
        })
        /*파일 추가시 몇 개가 추가 되었는지 보여주는 것*/
        $('.file_input input[type=file]').change(function() {
		    var fileName = $(this).val();
		    var fileCount = $(this).get(0).files.length;
		    if($(this).get(0).files.length == 1){
		        $('.file_input input[type=text]').val(fileName);
		    }
		    else {
		        $('.file_input input[type=text]').val('파일 '+fileCount+'개');
		    }
		});
		
		
	/*제목부분 누르면 기존에 있던 내용 없애기*/
	 	function title_box(){
	 		if($('#title').val() != null){
			    $('#title').val("");
			}
	 	}
	/*홈으로*/
		function fn_home() {
			location.href = ""
		}
	
		
		
</script>
</body>
</html>