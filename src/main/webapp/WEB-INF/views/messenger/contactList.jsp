<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title>Chat</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
	<link rel="stylesheet" href="/css/messenger.css">
	<meta name="mobile-web-app-capable" content="yes">
</head>
<!--Coded With Love By Mutiullah Samim-->
<body>
<div class="w-100 h-100 chat container-fluid p-0 min-w-450">
	<!-- 전체 시작 -->
	<div class="row m-0 h-100 whiteBg contactList_body">
		<!-- 왼쪽 - contact list sidebar -->
		<div class="col-3 col-md-2 col-xl-1 bgMain container-fluid p-o m-0 pl-2 con-sidebar">
			<a href="#" id="chatLogo">
				<div class="row p-0 m-0 text-center">
					<div class="col-12 align-self-center">
						<img src="/icon/chat-text.svg">
					</div>
				</div>
			</a><a href="#" id="showAll">
				<div class="row p-2 text-center">
					<div class="col-12 ml-2 text-left">
						<img src="/icon/person.svg">
						<span>전체</span>
					</div>
				</div>
			</a> <a href="#" id="showDept">
			<div class="row p-2 text-center">
				<div class="col-12 ml-2 text-left">
					<img src="/icon/diagram-3.svg">
					<span>부서원</span>
				</div>
			</div>
		</a> <a href="#" id="showTeam">
			<div class="row p-2 text-center">
				<div class="col-12 ml-2 text-left">
					<img src="/icon/people.svg">
					<span>팀원</span>
				</div>
			</div>
		</a> <a href="#" id="showChat">
			<div class="row p-2 text-center">
				<div class="col-12 ml-2 text-left">
					<img src="/icon/chat.svg">
					<span>채팅방</span>
				</div>
			</div>
		</a>
		</div>
		<!-- 오른쪽 -->
		<div class="col-9 col-md-10 col-xl-11 p-0">
			<!-- top head -->
			<div class="row w-100 m-0 h20 whiteBg">
				<div class="card-header col-12 p-0" style="border-radius: 0%;">
					<div class="row w-100 m-0 p-4 con-title">
						<div class="col-10 m-0 p-0 align-self-center">
							<span id="chatTitle">전체 연락처</span>
						</div>
						<div class="col-2 m-0 p-0 d-flex justify-content-end align-self-center" id="openMemberList">
							<a class="btn btn-outline-light">
							<img src="/icon/chat-plus.svg"></a>
						</div>
					</div>
					<div class="input-group float-right col-12 col-sm-11 col-md-10 col-lg-8 col-xl-6 pl-4 pr-4 p-0">
						<input type="text" placeholder="이름, 메세지 검색" name=""
							   class="form-control search" id="searchContents">
						<div class="input-group-prepend">
						  <span class="input-group-text search_btn" id="searchBtn"> <i
								  class="fas fa-search"></i>
						  </span>
						</div>
					</div>
				</div>
			</div>
			<!-- contact list part -->
			<div class="row w-100 m-0 h80">
				<div class="con-memberList col-12 p-0">
					<div class="card contacts_card h-100 b-radius-0">
						<div class="card-body contacts_body" style="border-radius:0 !important;">
						<!-- 나의 프로필 상단 고정 -->
						<ui class="contacts" id="myProfil">
							<li class="con-list">
								<div class="d-flex bd-highlight">
									<div class="img_cont myprofilImg align-self-center">
										<a href="#"> <img src="${loginDTO.profile}"
														  class="rounded-circle user_img">
										</a>
									</div>
									<a href="#">
										<div class="user_info align-self-center">
											<span>${loginDTO.name}</span>
											<p>${loginDTO.deptname} | ${loginDTO.teamname}</p>
										</div>
									</a>
								</div>
							</li>
						</ui>
						<ui class="contacts" id="memberAll"> <c:forEach var="i"
																		items="${memberList}">
							<li class="con-list">
								<div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})" >
									<div class="img_cont align-self-center">
										<a href="#"> <img src="${i.profile}"
														  class="rounded-circle user_img">
										</a>
									</div>
									<div class="user_info align-self-center">
										<span>${i.name}</span>
										<p>${i.deptname} |
											<c:choose>
												<c:when test="${not empty i.teamname}">
													${i.teamname}
												</c:when>
												<c:otherwise>
													무소속
												</c:otherwise>
											</c:choose>
										</p>
									</div>
								</div>
							</li>
						</c:forEach> </ui>
						<ui class="contacts" id="memberDept"> <c:forEach var="i"
																		 items="${memberList}">
							<c:if test="${i.dept_code eq loginDTO.dept_code}">
								<li class="con-list">
									<div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
										<div class="img_cont align-self-center">
											<a href="#"> <img src="${i.profile}"
															  class="rounded-circle user_img">
											</a>
										</div>
										<div class="user_info align-self-center">
											<span>${i.name}</span>
											<p>${i.deptname} |
												<c:choose>
													<c:when test="${not empty i.teamname}">
														${i.teamname}
													</c:when>
													<c:otherwise>
														무소속
													</c:otherwise>
												</c:choose>
											</p>
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach> </ui>
						<ui class="contacts" id="memberTeam"> <c:forEach var="i"
																		 items="${memberList}">
							<c:if test="${i.team_code eq loginDTO.team_code}">
								<li class="con-list">
									<div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
										<div class="img_cont align-self-center">
											<a href="#"> <img src="${i.profile}" class="rounded-circle user_img">
											</a>
										</div>
										<div class="user_info align-self-center">
											<span>${i.name}</span>
											<p>${i.deptname} |
												<c:choose>
													<c:when test="${not empty i.teamname}">
														${i.teamname}
													</c:when>
													<c:otherwise>
														무소속
													</c:otherwise>
												</c:choose>
											</p>
										</div>
									</div>
								</li>
							</c:if>
						</c:forEach> </ui>
						<ui class="contacts" id="chatList">
							<c:forEach var="i" items="${chatList}">
								<li class="con-list">
									<div class="d-flex bd-highlight" ondblclick="toChatRoom(${i.seq})">
										<div class="img_cont align-self-center">
											<img src="${i.profile}" class="rounded-circle user_img">
										</div>
										<div class="user_info align-self-center">
											<c:choose>
												<c:when test="${i.type=='S'}"> <!--1:1채팅방-->
													<span class="con-room">${i.empname}</span>
												</c:when>
												<c:otherwise> <!--1:N채팅방-->
													<span class="con-room">${i.name}</span>
												</c:otherwise>
											</c:choose>
											<p>
												<c:choose>
													<c:when test="${i.msg_type=='IMAGE'}">
														<span class="con-message" id="con-message${i.seq}"><c:out value="사진"/></span>
													</c:when>
													<c:otherwise>
														<span class="con-message" id="con-message${i.seq}"><c:out value="${i.contents}"/></span>
													</c:otherwise>
												</c:choose>
											</p>
										</div>
										<div class="con-date">
											<fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd"/>
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
</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- sockjs, stomp CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
	let chatTitle = document.getElementById("chatTitle");
	let memberAll = document.getElementById("memberAll");
	let memberDept = document.getElementById("memberDept");
	let memberTeam = document.getElementById("memberTeam");
	let chatList = document.getElementById("chatList");

	let showAll = document.getElementById("showAll");
	let showDept = document.getElementById("showDept");
	let showTeam = document.getElementById("showTeam");
	let showChat = document.getElementById("showChat");
	const textLength = 20;

	showAll.onclick = function() {
		memberAll.style.display="block";
		memberDept.style.display="none";
		memberTeam.style.display="none";
		chatList.style.display="none";
		chatTitle.innerHTML = "전체 연락처";
		$("#myProfil").show();
		$(".search").focus();
	};
	showDept.onclick = function() {
		memberAll.style.display="none";
		memberDept.style.display="block";
		memberTeam.style.display="none";
		chatList.style.display="none";
		chatTitle.innerHTML = "부서원";
		$("#myProfil").show();
		$(".search").focus();
	};
	showTeam.onclick = function() {
		memberAll.style.display="none";
		memberDept.style.display="none";
		memberTeam.style.display="block";
		chatList.style.display="none";
		chatTitle.innerHTML = "팀원";
		$("#myProfil").show();
		$(".search").focus();
	};
	showChat.onclick = function() {
		memberAll.style.display="none";
		memberDept.style.display="none";
		memberTeam.style.display="none";
		chatList.style.display="block";
		chatTitle.innerHTML = "채팅방";
		$("#myProfil").hide();
		$(".search").focus();
	};

	// 연락처리스트 소켓으로 메세지받기
	//스톰프 연결
	function connectStomp() {
		var sock = new SockJS("/stompTest"); // endpoint
		var client = Stomp.over(sock); //소크로 파이프 연결한 스톰프
		isStomp = true;
		socket = client;

		client.connect({}, function () {
			console.log("ContactList stompTest!");
			// 해당 토픽을 구독한다!
			// 여기에 for문을 돌려야할까...
			<c:forEach var="i" items="${chatList}">
				client.subscribe('/contact/' +${i.seq}, function (e) {
				let msg = JSON.parse(e.body).contents;
				let type = JSON.parse(e.body).type;
				let m_seq = JSON.parse(e.body).m_seq;
				if(msg.length > textLength){
					msg = msg.substr(0, textLength-2) + '...';
				}
				// type이 IMAGE일 때는 '사진'으로 메세지를 띄워준다.
				if(type=='IMAGE'){
					$("#con-message${i.seq}").html("사진");
				}else{
					$("#con-message${i.seq}").html(msg);
				}
			});
			</c:forEach>
		});
	}

	// 의진 추가 - room의 seq를 받아 해당 채팅방으로 이동
	let winFeature = 'width=450px,height=660px,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,fullscreen=yes';
    function toChatRoom(seq) {
      window.open('/messenger/chat?seq='+seq,'chat'+seq,winFeature);
    }

    // 소형 추가 - 상대방 EMP_CODE를 받아 개인 채팅방 열기
    function toSingleChatRoom(code) {
      window.open('/messenger/openCreateSingleChat?partyEmpCode='+code,'singleChat'+code,winFeature);
    }

	$(document).ready(function () {
		// 검색창 포커스
		$(".search").focus();
		// 스톰프 연결
		connectStomp();
	});

    //-------------------------------- 검색 -------------------------------------
    document.getElementById("searchBtn").addEventListener("click",search);
	// enter키 클릭시 검색
	$("#searchContents").on("keydown", function (e) {
		if (e.keyCode == 13) {
			search();
		}
	});
	// esc 누르면 창닫기
	$(document).keydown(function(e) {
		if ( e.keyCode == 27 || e.which == 27 ) {
			window.close();
		}
	});

	//검색창 열기
    function search(){
		let searchContents = $("#searchContents").val().trim();
		if(searchContents == ''){
			return;
		}
		window.open('/messenger/messengerSearch?contents='+searchContents,'search',winFeature);
	}
	
    //-------------------------------- 채팅방 추가 ---------------------------------
	document.getElementById("openMemberList").addEventListener("click", openMemberList);
    function openMemberList(){
		var popup = window.open('/messenger/openMemberList?seq=0','',winFeature);
    }
    
</script>
<script src="/resources/static/js/messenger.js"></script>
<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
</body>
</html>