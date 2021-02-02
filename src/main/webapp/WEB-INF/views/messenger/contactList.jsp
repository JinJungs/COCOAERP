<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>Chat</title>
	<link rel="stylesheet"
		  href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
		  integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
		  crossorigin="anonymous">
	<link rel="stylesheet"
		  href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
		  integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
		  crossorigin="anonymous">
	<link rel="stylesheet" type="text/css"
		  href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
	<link rel="stylesheet" href="/css/messenger.css">
</head>
<!--Coded With Love By Mutiullah Samim-->
<body>
<div class="w-100 h-100 chat container-fluid p-0 min-w-450">
	<!-- top head -->
	<div class="row w-100 m-0 h15">
		<div class="card-header w-100 p-0" style="border-radius: 0%;">
			<div class="window-control d-flex justify-content-end">
				<div class="p-2">-</div>
				<div class="p-2">ㅁ</div>
				<div class="p-2">X</div>
			</div>
			<div class="input-group float-right col-7 col-sm-6 col-md-5 p-2">
				<input type="text" placeholder="이름,부서,팀 검색" name=""
					   class="form-control search" id="searchContents">
				<div class="input-group-prepend">
                  <span class="input-group-text search_btn" id="searchBtn"> <i
						  class="fas fa-search"></i>
                  </span>
				</div>
			</div>
		</div>
	</div>
	<!-- contact list sidebar -->
	<div class="row m-0 h85">
		<div class="col-2 col-md-1 bgMain container-fluid p-o m-0 con-sidebar">
			<a href="#" id="showAll">
				<div class="row p-2">전체</div>
			</a> <a href="#" id="showDept">
			<div class="row p-2">부서원</div>
		</a> <a href="#" id="showTeam">
			<div class="row p-2">팀원</div>
		</a> <a href="#" id="showChat">
			<div class="row p-2">채팅방</div>
		</a>
		</div>
		<!-- contact list part -->
		<div class="col-10 col-md-11 p-0">
			<div class="card contacts_card h-100 b-radius-0">
				<div class="card-body contacts_body h-75 style="border-radius:0px;!important">
				<!-- 나의 프로필 상단 고정 -->
				<ui class="contacts" id="myProfil">
					<li class="con-list">
						<div class="d-flex bd-highlight myprofil">
							<div class="img_cont myprofilImg">
								<a href="#"> <img src="/img/profile-default.jpg"
												  class="rounded-circle user_img">
								</a>
							</div>
							<a href="#">
								<div class="user_info">
									<span>${loginDTO.name}</span>
									<p>${loginDTO.deptname}/${loginDTO.teamname}</p>
								</div>
							</a>
						</div>
					</li>
				</ui>
				<ui class="contacts" id="memberAll"> <c:forEach var="i"
																items="${memberList}">
					<li class="con-list">
						<div class="d-flex bd-highlight">
							<div class="img_cont">
								<a href="#"> <img src="/img/profile-default.jpg"
												  class="rounded-circle user_img">
								</a>
							</div>
							<a href="#">
								<div class="user_info">
									<span>${i.name}</span>
									<p>${i.deptname}/${i.teamname}</p>
								</div>
							</a>
						</div>
					</li>
				</c:forEach> </ui>
				<ui class="contacts" id="memberDept"> <c:forEach var="i"
																 items="${memberList}">
					<c:if test="${i.dept_code eq loginDTO.dept_code}">
						<li class="con-list">
							<div class="d-flex bd-highlight">
								<div class="img_cont">
									<a href="#"> <img src="/img/profile-default.jpg"
													  class="rounded-circle user_img">
									</a>
								</div>
								<a href="#">
									<div class="user_info">
										<span>${i.name}</span>
										<p>${i.deptname}/${i.teamname}</p>
									</div>
								</a>
							</div>
						</li>
					</c:if>
				</c:forEach> </ui>
				<ui class="contacts" id="memberTeam"> <c:forEach var="i"
																 items="${memberList}">
					<c:if test="${i.team_code eq loginDTO.team_code}">
						<li class="con-list">
							<div class="d-flex bd-highlight">
								<div class="img_cont">
									<a href="#"> <img src="/img/profile-default.jpg"
													  class="rounded-circle user_img">
									</a>
								</div>
								<a href="#">
									<div class="user_info">
										<span>${i.name}</span>
										<p>${i.deptname}/${i.teamname}</p>
									</div>
								</a>
							</div>
						</li>
					</c:if>
				</c:forEach> </ui>
				<ui class="contacts" id="chatList">
					<a href="#">채팅방 추가</a>
					<c:forEach var="i" items="${chatList}">
						<li class="con-list">
							<div class="d-flex bd-highlight" ondblclick="toChatRoom(${i.seq})">
								<div class="img_cont">
									<img src="/img/profile-default.jpg" class="rounded-circle user_img">
								</div>
									<div class="user_info">
										<c:choose>
											<c:when test="${i.type=='S'}"> <!--1:1채팅방-->
												<span>${i.empname} / ${i.deptname}</span>
											</c:when>
											<c:otherwise> <!--1:N채팅방-->
												<span>${i.name}</span>
											</c:otherwise>
										</c:choose>
										<p>채팅 메세지 조금 띄워주나요...</p>
									</div>
							</div>
						</li>
					</c:forEach>
				</ui>
			</div>
		</div>
	</div>
</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	let memberAll = document.getElementById("memberAll");
	let memberDept = document.getElementById("memberDept");
	let memberTeam = document.getElementById("memberTeam");
	let chatList = document.getElementById("chatList");

	let showAll = document.getElementById("showAll");
	let showDept = document.getElementById("showDept");
	let showTeam = document.getElementById("showTeam");
	let showChat = document.getElementById("showChat");

	showAll.onclick = function() {
		memberAll.style.display="block";
		memberDept.style.display="none";
		memberTeam.style.display="none";
		chatList.style.display="none";
	};
	showDept.onclick = function() {
		memberAll.style.display="none";
		memberDept.style.display="block";
		memberTeam.style.display="none";
		chatList.style.display="none";
	};
	showTeam.onclick = function() {
		memberAll.style.display="none";
		memberDept.style.display="none";
		memberTeam.style.display="block";
		chatList.style.display="none";
	};
	showChat.onclick = function() {
		memberAll.style.display="none";
		memberDept.style.display="none";
		memberTeam.style.display="none";
		chatList.style.display="block";
	};
	
	// 의진 추가 - room의 seq를 받아 해당 채팅방으로 이동
    function toChatRoom(seq) {
      window.open('/messenger/chat?seq='+seq,'','width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
    }

    //-------------------------------- 검색 -------------------------------------
    document.getElementById("searchBtn").addEventListener("click",search);
	$("#searchContents").on("keydown", function (e) {
		if (e.keyCode == 13) {
			search();
		}
	});

    function search(){
		let searchContents = $("#searchContents").val();
		if(searchContents == ''){
			return;
		}
		window.open('/messenger/messengerSearch?contents='+searchContents,'','width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
	}
</script>
<script src="/resources/static/js/messenger.js"></script>
<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
</body>
</html>