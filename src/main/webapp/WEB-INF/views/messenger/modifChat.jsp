<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 수정</title>
</head>
<body>
채팅방 정보 설정 임시 페이지<br>
채팅방 이미지 : 한다면 수정 가능하도록<br>

채팅방 이름 : <br>
<form id="modifChat" name="modifChat" action="/messenger/modifChatName">
	<input type="hidden" name="seq" value="${messenger.seq}">
	<input type="text" id="name" name="name" value="${messenger.name}" placeholder="채팅방 이름을 설정해주세요.">
	<div id="msg"></div>
	<button type="button" id="btn_submit" onclick="fn_submit(${messenger.seq})" >확인</button>
	<button type="button" id="cancle">취소</button>
</form>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

let name = $("#name").val();

document.getElementById("btn_submit").addEventListener("click", fn_submit);

document.getElementById("cancle").addEventListener("click", fn_cancle);

function fn_submit(seq){
	console.log("submit!!!");
	console.log("seq : ",${messenger.seq});
/* 	if(name == ""){
		$("#msg").text("채팅방 이름은 빈 값은 넣을 수 없습니다.");
		return false;
	} */
	var formName = document.getElementById("modifChat");
	//window.opener.document.location.reload();
	//console.log(formName.target);
	formName.submit();
	//***서브밋까진 되는데 부모창 리로드 + 닫기가 안됨***
 	setTimeout(function(){
 		//방법1: 부모 창 리로드 (크롬에서 안됨??ㅠㅠ)
 		//window.opener.location.reload(true);
 		//opener.parent.location.reload();
 		
 		//방법2 : 부모 창의 href링크 쏴주기
 		//console.log("/messenger/chat?seq="+${messenger.seq});
 		//opener.top.location = "/messenger/chat?seq="+${messenger.seq};
 		//방법2-1
 		//opener.location.href = "/messenger/chat?seq="+${messenger.seq};
 		
 		//방법3
 		//formName.target = opener.name;
 		//formname.action = "/messenger/chat?seq="+${messenger.seq};
 		//formname.submit();
		
 		//닫기 : 닫기도 여기선 작동안함. 
 		//self.close();
 		window.open('','_self').close();
	}, 10000); 
}
//취소 버튼은 작동합니다
function fn_cancle(){
	self.close();
}

/* let fn_cancle = () => self.close();

let fn_submit = () => {
	console.log("submit!!!");
	if(name == ""){
		$("#msg").text("채팅방 이름은 빈 값은 넣을 수 없습니다.");
		return false;
	}
	document.modifChat.action = "/messenger/modifChatName";
	document.modifChat.submit();
	window.open("about:blank", "_self").close();
}
 */
</script>

</body>
</html>