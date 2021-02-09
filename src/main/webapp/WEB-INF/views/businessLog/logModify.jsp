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

			<form method="post" id="submitForm" enctype="multipart/form-data">

				<input type="hidden" id="status" name="status" value="${status }">
				<input type="hidden" id="temp_code" name="temp_code"
					value="${lr.temp_code}">
				<input type="hidden" id="seq" name="seq" value="${lr.seq}">

				<div class="row">
					<div class="col-sm-2 d-none d-sm-block head_box">제목</div>
					<div class="col-12 col-sm-10">
						<input type="text" id="title" name="title" onclick="title_box()"
							value="${lr.title}">
					</div>
				</div>

				<div class="row">
					<div class="col-md-2 head_box">업무기한</div>
					<div class="col-md-10">
						<div class="row" style="border: none;">
								<div class="col-6" id="test">
									<div class="col date_box">
										<b>시작일 :</b> <input type="date" class="date ml-1 mr-1"
											name="report_start" id="report_start">
									</div>
								</div>
								<div class="col-6" id="test2">
									<div class="col date_box" id="endDate">
										<b>마감일 :</b> <input type="date" class="date ml-1 mr-1"
											name="report_end" id="report_end">
									</div>
								</div>
						</div>
					</div>
				</div>

				<script>
					
				</script>

				<div class="row">
					<div class="col-2 head_box">승인</div>
					<div class="col-5">(영업부)김지영 부장 (0)</div>
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
						<button type="submit" id="btn_tempSave" class="btn btn-primary"
							onclick="fn_tempSave()" formaction="/log/logModifyTempSave.log">임시저장</button>
						<button type="submit" id="btn_modifyDone" class="btn btn-primary" 
						onclick="fn_modifyDone()" formaction="/log/logModifyDone.log">수정</button>
						<button type="reset" class="btn btn-primary">취소</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>
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
	 	/*홈으로 */
		function fn_home(status) {
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
	     // x누른 파일 삭제
	       $('#btn_tempSave').on("click", function() {
	       	for(var i=0; i<delArr.length; i++){
	            submitForm.append($('<input/>', {type: 'hidden', name: 'delArr', value: delArr[i]}));
	         }
         //새로 추가할 파일 최대 갯수 지정
         var x = document.getElementById("myFile");
         var txt = "";
         if ('files' in x) {
            if (x.files.length > 11) {
               alert("파일은 최대 10개까지 첨부 가능합니다.");
               document.getElementById("myFile").value = "";
               return;
            }
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
		/*수정*/
		function fn_modifyDone(){
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
			$("#submitForm").attr("action","/log/logModifyTempSave.log");
			$("#submitForm").submit;
		
		}
		/*임시저장*/
		function fn_tempSave(){
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
			$("#submitForm").attr("action","/log/logModifyDone.log");
			$("#submitForm").submit;
		
		}
	</script>

<script> 
/*페이지 처음 접속 시, temp_code별로 업무기한을 다르게 보여주는 이벤트*/
	window.onload = function(){
		let temp_code = document.getElementById("temp_code");
		let test = document.getElementById("test");
		let test2 = document.getElementById("test2");
		
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
		
		if(temp_code.value==1){
			test2.style.display="none";
	   		today= year + 1 + "-0" + month + "-0" + date;
	        report_end.value = today;
	        console.log(today);
		}else if(temp_code.value==2||temp_code.value==3){
			est2.style.display="block";
		}
	}
</script>
</body>
</html>