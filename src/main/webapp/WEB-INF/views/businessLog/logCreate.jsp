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
#selectBy:focus{outline:none;}
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
			
			<form action="/log/logCreateDone.log" method="post" name="submitForm"
				id="submitForm" enctype="multipart/form-data">
				
			<div class="row search_box">
				<div class="select col-12" id="select">
						<select name="selectBy" id="selectBy">
							<option value="" selected>업무일지 종류를 설정해 주세요.</option>
							<option value="daily" id="daily">일일</option>
							<option value="weekly" id="weekly">주간</option>
							<option value="monthly" id="monthly">월별</option>
						</select> 
					</div>
			</div>
			<div class="row">
					<div class="col-sm-3 head_box">제목</div>
					<div class="col-sm-9">
					<input type="text" id="title" name="title" placeholder="제목을 입력하세요."
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
						<input type="file" class="fileList"  id="file"
							name="file" accept="image/*"  multiple>
							<div id="listBox"></div><br>
					</div>
				</div>
				
				
				<div class="row">
					<!--홈으로 이동  -->
					<div class="col-sm-2">
						<button type="button" class="btn btn-primary" onclick="fn_home()">HOME</button>
					</div>

					<div class="col-sm-5 d-none d-sm-block"></div>

					<div class="button_box col-sm-5">
						<button type="button" class="btn btn-primary" 
						id="btn_write" >작성</button>
						<button type="button" class="btn btn-primary" 
						id="btn_tempSaved" >임시저장</button>
						<button type="reset" class="btn btn-primary">되돌리기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/jquery.MultiFile.min.js"></script>
<script>
/*-------------------------작성*/
		 $('#btn_write').on("click", function() {
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
			if ( $("#selectBy").val()==""){
	           alert('업무일지 종류를 선택해주세요');
           	   $("#selectBy").focus();
	           return ;
	         }else if (!$('#title').val()){
	           alert('제목을 입력해주세요');
           	   $("#title").focus();
	           return ;
	          }else if (!$('#contents').val()){
	           alert('내용을 입력해주세요');
           	   $("#contents").focus();
	           return ;
	         }else if(report_end==""){
	            alert("종료일을 입력하세요.");
	            return ;
	        }else if (report_start>report_end) {
	            alert("시작일을 다시 선택해 주세요.");
	            return ;
	        }else if(start==""){
	            alert("시작일을 입력해주세요.");
	            return ;
	        }else if(end==""){
	            alert("종료일을 입력해주세요..");
	            return ;
	        }
         $('#submitForm').submit();
        })
        /*파일첨부 */
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
	   		console.log("일일");
	        endDate.style.display="none";
	        report_start.value=today;
	        report_end.value = today;
	        console.log(today);
	   }else if(index=="2"){ //주간
	        endDate.style.display="block";
	        report_start.value=null;
	        report_end.value = null;
	   }else if(index=="3"){ //월별
	        endDate.style.display="block";
	        report_start.value=null;
	        report_end.value = null;
	   }
	})
	
	
	/* ------------------임시저장*/
		
		 $('#btn_tempSaved').on("click", function() {
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

       if ( $("#selectBy").val()==""){
	           alert('업무일지 종류를 선택해주세요');
	           return ;
	    }else if (!$('#contents').val()){
	           alert('내용을 입력해주세요');
           	   $("#contents").focus();
	           return ;
	   }else if (!$('#title').val()){
	           alert('제목을 입력해주세요');
           	   $("#title").focus();
	           return ;
	   }else if(report_end!=""&&report_start>report_end){
            alert("종료일이 시작일보다 빠릅니다.");
            return ;
        }else if(start==""){
            alert("시작일을 입력해주세요.");
            $("#report_start").focus();
            return ;
        }else if(end==""){
            alert("종료일을 입력해주세요..");
            $("#report_end").focus();
            return ;
        }
		$("#submitForm").attr("action","/log/logTempSave.log");
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
	/*홈으로*/
		function fn_home() {
			location.href = "/"
		}
	
		
		
</script>
</body>
</html>