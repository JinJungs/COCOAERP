<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#contents{
	height:100%;
	width:100%;
}
.body{height: 50%;}
.footer{text-align: right}
input[type=text]{
	width:100%;
	border: 1px solid #c9c9c9;
}
.emailContainer{
	border: 1px solid #c9c9c9;
}
.emailContainer div{
	min-width: 90px;	
}
textarea{
	width: 100%;
	min-height: 300px;
	max-height: 300px;
	border: 1px solid #c9c9c9;
}
#listBox{
	width: 100%;
}
</style>
</head>
<body>
   <div class="wrapper d-flex align-items-stretch">
      <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
      <div id="content" class="p-4 p-md-5 pt-5" style="min-width: 400px;">
      	<h2 class="mb-4">메일 작성</h2>
      	<div class="emailContainer pt-4 pl-4 pr-4 pb-3">
      		<form action="/email/sendEmail.email" method=post id=form enctype="multipart/form-data">
	      		<div class="row mb-3">
	      			<div class="col-3 col-sm-2">
	      				제목
	      			</div>
	      			<div class="col pr-5">
	      				<input type=text name=title id=title value="${dto.title }" maxlength=35>
	      			</div>
	      		</div>
	      		
	      		<div class="row mb-3">
	      			<div class="col-3 col-sm-2">
	      				받는사람
	      			</div>
	      			<div class="col pr-5">
	      				<input type=text name=receiver id=receiver value="${dto.sender }" maxlength=20 placeholder="ooo@cocoa.com" required>
	      			</div>
	      		</div>
	      		<c:if test="${empty dto }">
		      		<div class="row mb-3">
		      			<div class="col-3 col-sm-2"></div>
		      			<div class="col text-left">
		      				<label><input type="checkbox" class="mr-1" id=checkBox> 내게 쓰기</label>
		      			</div>
		      			<script>
		      				let box = $("#checkBox");
		      				let receiver = $("#receiver");
		      				box.click(function(){
		      					if(box.is(":checked") == true){
		      						receiver.attr("disabled", true);
		      						receiver.val("${myEmail}");
		      					}else{
		      						receiver.attr("disabled", false);
		      						receiver.val("");
		      					
		      					}
		      					
		      				});
		      			</script>
		      		</div>
	      		</c:if>
	      		<div class="row mb-3">
	      			<div class="col-3 col-sm-2">
	      				파일첨부
	      			</div>
	      			<div class="col">
	      				<input type="file" class="fileList" id="file" name="file" multiple>
	      				<div id="listBox"></div><br>
	      			</div>
	      		</div>
	      		<div class="row">
	      			<div class="col-12">
	      				<textarea name=contents id=contents autofocus>${dto.contents }</textarea>
	      			</div>
	      		</div>
	      		<div class="row mt-1">
	      			<div class="col-10"></div>
	      			<div class="col-1">
	      				<input type=submit id=submitBtn>
	      			</div>
	      		</div>
      		</form>
      	</div>
      	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
		<script src="/js/jquery-ui.js"></script>
		<script src="/js/jquery.MultiFile.min.js"></script>
        <script>
        	$("#form").submit(function(){
        		var receiver = $("#receiver").val();
        		if(receiver.includes("@cocoa.com") == false){
        			alert("이메일 형식이 잘못됐습니다.");
        			$("#receiver").focus();
        			return false;
        		}
        		var title =  $("#title").val();
        		if(title == ""){
        			var titleConfirm = confirm("(제목 없음)으로 진행할까요?");
        			if(titleConfirm==false){
        				$("#title").focus();
        				return false;
        			}
        		}
        		return true;
        	});
        	
        	$("input.fileList").MultiFile({
		        max: 10, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
		        //accept: "jpg|png|gif|jfif", //허용할 확장자(지정하지 않으면 모든 확장자 허용)
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
        </script>
      </div>
   </div>
<script src="/js/bootstrap.min.js"></script>
</body>
</html>