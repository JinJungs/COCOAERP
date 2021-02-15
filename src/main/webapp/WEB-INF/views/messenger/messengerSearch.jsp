<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>통합검색</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
          integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
          crossorigin="anonymous">
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/css/messenger.css">
</head>
<body>

<!-- top head -->
<div class="w-100 h-100 chat container-fluid p-0 min-w-450">
    <div class="row w-100 m-0 h15">
        <div class="card-header w-100 p-0 pb-2 align-center fixed-top search_top" style="border-radius: 0%;">
            <div class="input-group float-right col-10 col-sm-9 col-md-8 p-2">
                <input type="text" placeholder="이름,부서,팀 검색" name=""
                       class="form-control search" id="searchContents">
                <div class="input-group-prepend">
                  <span class="input-group-text search_btn" id="searchBtn"> <i
                          class="fas fa-search"></i>
                  </span>
                </div>
            </div>
            <div class="row w-100 ml-4 pt-3">
                <div class="col-12 col-sm-10 col-md-9 col-lg-8">
                    <div class="row searchMenu">
                        <div class="col-2 p-0" id="searchAll">전체</div>
                        <div class="col-2 p-0" id="searchMember">멤버</div>
                        <div class="col-2 p-0" id="searchDept">부서</div>
                        <div class="col-2 p-0" id="searchTeam">팀</div>
                        <div class="col-2 p-0" id="searchMessage">메세지</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- main -->
    <input type="hidden" id="searchKeyword" value="${searchKeyword}">
    <div class="row w-100 h85 m-0 p-4 border-top whiteBg search_body">
        <div class=" w-100 m-0 pl-0 col-12 col-sm-10 col-md-9 col-lg-8">
            <!-- 전체 : 검색결과가 없는것은 가리고, 검색결과가 모두 없을 때는 코코아를 띄워주자-->
            <div class="container" id="memberAll">
                <c:choose>
                    <c:when test="${(empty memberList) && (empty deptList) && (empty teamList) &&(empty messageList)}">
                        검색결과가 없습니다.
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty memberList}">
                            <div class="row mb-2 m-0">멤버</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${memberList}">
                                    <li class="con-list">
                                        <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
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
                                </c:forEach>
                            </ui>
                        </c:if>
                        <c:if test="${not empty deptList}">
                            <div class="row mb-2 m-0">부서</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${deptList}">
                                    <li class="con-list">
                                        <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
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
                                </c:forEach>
                            </ui>
                        </c:if>
                        <c:if test="${not empty teamList}">
                            <div class="row mb-2 m-0">팀</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${teamList}">
                                    <li class="con-list">
                                        <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
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
                                </c:forEach>
                            </ui>
                        </c:if>
                        <c:if test="${not empty messageList}">
                            <div class="row mb-2 m-0">메세지</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${messageList}">
                                    <li class="con-list">
                                        <div class="d-flex bd-highlight" ondblclick="toChatRoom(${i.m_seq})">
                                            <div class="img_cont">
                                                <img src="/img/profile-default.jpg" class="rounded-circle user_img">
                                            </div>
                                            <div class="user_info">
                                                <span style="font-size: 16px;">${i.contents}</span>
                                                <p><span><i class="far fa-comment"></i>
                                                <c:choose>
                                                    <c:when test="${i.m_type=='S'}"> <!--1:1채팅방-->
                                                        ${i.party_empname}
                                                    </c:when>
                                                    <c:otherwise> <!--1:N채팅방-->
                                                        ${i.name}
                                                    </c:otherwise>
                                                </c:choose>
                                                </span>&nbsp;${i.empname} | ${i.write_date}</p>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ui>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- 멤버 -->
            <div class="container" id="memberMember">
                <c:choose>
                    <c:when test="${not empty memberList}">
                        <div class="row mb-2 m-0">멤버-검색결과</div>
                        <ui class="contacts m-0 p-0">
                            <c:forEach var="i" items="${memberList}">
                                <li class="con-list">
                                    <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
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
                            </c:forEach>
                        </ui>
                    </c:when>
                    <c:otherwise>
                        검색결과가 없습니다.
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- 부서 -->
            <div class="container" id="memberDept">
                <c:choose>
                    <c:when test="${not empty deptList}">
                        <div class="row mb-2 m-0">부서-검색결과</div>
                        <ui class="contacts m-0 p-0">
                            <c:forEach var="i" items="${deptList}">
                                <li class="con-list">
                                    <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
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
                            </c:forEach>
                        </ui>
                    </c:when>
                    <c:otherwise>
                        검색결과가 없습니다.
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- 팀 -->
            <div class="container" id="memberTeam">
                <c:choose>
                    <c:when test="${not empty teamList}">
                        <div class="row mb-2 m-0">팀-검색결과</div>
                        <ui class="contacts m-0 p-0">
                            <c:forEach var="i" items="${teamList}">
                                <li class="con-list">
                                    <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
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
                            </c:forEach>
                        </ui>
                    </c:when>
                    <c:otherwise>
                        검색결과가 없습니다.
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- 메세지 -->
            <div class="container" id="memberMessage">
                <c:choose>
                    <c:when test="${not empty messageList}">
                        <div class="row mb-2 m-0">메세지-검색결과</div>
                        <ui class="contacts m-0 p-0">
                            <c:forEach var="i" items="${messageList}">
                                <li class="con-list">
                                    <div class="d-flex bd-highlight" ondblclick="toChatRoom(${i.m_seq})" onclick="shortContents(${i.seq},'${i.contents}')">
                                        <div class="img_cont">
                                            <img src="/img/profile-default.jpg" class="rounded-circle user_img">
                                        </div>
                                        <div class="user_info">
                                            <span class="contents_span" id="contents_span${i.seq}" style="font-size: 16px;">${i.contents}</span>
                                            <p><span><i class="far fa-comment"></i>
                                                <c:choose>
                                                    <c:when test="${i.m_type=='S'}"> <!--1:1채팅방-->
                                                        ${i.party_empname}
                                                    </c:when>
                                                    <c:otherwise> <!--1:N채팅방-->
                                                        ${i.name}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>&nbsp;${i.empname} | ${i.write_date}</p>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ui>
                    </c:when>
                    <c:otherwise>
                        검색결과가 없습니다.
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 날짜 변경 라이브러리-->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="/js/bindWithDelay.js"></script>
<script>
    let memberAll = document.getElementById("memberAll");
    let memberMember = document.getElementById("memberMember");
    let memberDept = document.getElementById("memberDept");
    let memberTeam = document.getElementById("memberTeam");
    let memberMessage = document.getElementById("memberMessage");
    let searchKeyword = $("#searchKeyword").val();

    document.getElementById("searchAll").addEventListener('click', showAll);
    document.getElementById("searchMember").addEventListener('click', showMember);
    document.getElementById("searchDept").addEventListener('click', showDept);
    document.getElementById("searchTeam").addEventListener('click', showTeam);
    document.getElementById("searchMessage").addEventListener('click', showMessage);

    $(document).ready(function () {
        //전체라는 글자를 굵게하는 효과
        searchAllBoldText();
        // 검색창에 검색했던 키워드 띄우기
        $("#searchContents").val(searchKeyword);
    });

    /*    function shortContents(seq, contents){
            console.log("이거 실행 됨? " + seq +" : "+ contents);
            // 글자 초과시 말줄임 표시로 바꾸기
            let length = 15; // 표시할 글자수 기준
            if (contents.length > length) {
                contents = contents.substr(0, length-2) + '...';
            }
            $("#contents_span"+seq).html(contents);
        }*/

    // esc 누르면 창닫기
    $(document).keydown(function (e) {
        if (e.keyCode == 27 || e.which == 27) {
            window.close();
        }
    });

    function searchAllBoldText() {
        $("#searchAll").css("font-weight", "Bold");
    }

    function showAll() {
        memberAll.style.display = "block";
        memberMember.style.display = "none";
        memberDept.style.display = "none";
        memberTeam.style.display = "none";
        memberMessage.style.display = "none";
        $("#searchAll").css("font-weight", "Bold");
        $("#searchMember").css("font-weight", "normal");
        $("#searchDept").css("font-weight", "normal");
        $("#searchTeam").css("font-weight", "normal");
        $("#searchMessage").css("font-weight", "normal");
    };

    function showMember() {
        memberAll.style.display = "none";
        memberMember.style.display = "block";
        memberDept.style.display = "none";
        memberTeam.style.display = "none";
        memberMessage.style.display = "none";
        $("#searchAll").css("font-weight", "normal");
        $("#searchMember").css("font-weight", "Bold");
        $("#searchDept").css("font-weight", "normal");
        $("#searchTeam").css("font-weight", "normal");
        $("#searchMessage").css("font-weight", "normal");
    };

    function showDept() {
        memberAll.style.display = "none";
        memberMember.style.display = "none";
        memberDept.style.display = "block";
        memberTeam.style.display = "none";
        memberMessage.style.display = "none";
        $("#searchAll").css("font-weight", "normal");
        $("#searchMember").css("font-weight", "normal");
        $("#searchDept").css("font-weight", "Bold");
        $("#searchTeam").css("font-weight", "normal");
        $("#searchMessage").css("font-weight", "normal");
    };

    function showTeam() {
        memberAll.style.display = "none";
        memberMember.style.display = "none";
        memberDept.style.display = "none";
        memberTeam.style.display = "block";
        memberMessage.style.display = "none";
        $("#searchAll").css("font-weight", "normal");
        $("#searchMember").css("font-weight", "normal");
        $("#searchDept").css("font-weight", "normal");
        $("#searchTeam").css("font-weight", "Bold");
        $("#searchMessage").css("font-weight", "normal");
    };

    function showMessage() {
        memberAll.style.display = "none";
        memberMember.style.display = "none";
        memberDept.style.display = "none";
        memberTeam.style.display = "none";
        memberMessage.style.display = "block";
        $("#searchAll").css("font-weight", "normal");
        $("#searchMember").css("font-weight", "normal");
        $("#searchDept").css("font-weight", "normal");
        $("#searchTeam").css("font-weight", "normal");
        $("#searchMessage").css("font-weight", "Bold");
    }

    //-------------------------------- 검색 -------------------------------------
    document.getElementById("searchBtn").addEventListener("click", searchAjax);
    $("#searchContents").on("keydown", function (e) {
        if (e.keyCode == 13) {
            searchAjax();
        }
    });

    // 입력중에 실시간으로 검색
    $("#searchContents").on("propertychange change keyup paste input", function (e) {
            searchAjax();

    });

    // room의 seq를 받아 해당 채팅방으로 이동
    let winFeature = 'width=450px,height=660px,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,fullscreen=yes';

    function toChatRoom(seq) {
        window.open('/messenger/chat?seq=' + seq, 'toChat'+seq, winFeature);
    }

    // 소형 추가 - 상대방 EMP_CODE를 받아 개인 채팅방 열기
    function toSingleChatRoom(code) {
        window.open('/messenger/openCreateSingleChat?partyEmpCode='+code,'singleChat'+code,winFeature);
    }

    //-------------------------------- 비동기 검색 -------------------------------------



    function searchAjax() {
        let searchContents = $("#searchContents").val();
        console.log("검색내용: ?" + searchContents);

            $.ajax({
                url: "/messenger/messengerSearchAjax",
                type: "post",
                data: {
                    contents: searchContents
                },
                dataType: "json",
                success: function (resp) {
                    console.log(resp);
                    let jArrayMember = resp[0];
                    let jArrayDept = resp[1];
                    let jArrayTeam = resp[2];
                    let jArrayMessage = resp[3];
                    // -------------- 여기서부터 다시 리스트를 쏴줘야한다. --------------
                    // 전체
                    if (jArrayMember.length == 0 && jArrayDept.length == 0 && jArrayTeam.length == 0 && jArrayMessage.length == 0) {
                        memberAll.innerHTML = "검색결과가 없습니다.";
                    } else {
                        let html = "";
                        if (jArrayMember.length != 0) {
                            html += "<div class='row mb-2 m-0'>멤버</div>";
                            html += "<ui class='contacts m-0 p-0'>";
                            for (let i = 0; i < jArrayMember.length; i++) {
                                html += "<li class='con-list'>";
                                html += "<div class='d-flex bd-highlight' ondblclick='toSingleChatRoom("+jArrayMember[i].code+")'>";
                                html += "<div class='img_cont'>";
                                html += "<a href='#'><img src='/img/profile-default.jpg' class='rounded-circle user_img'></a>";
                                html += "</div>";
                                html += "<a href='#'>";
                                html += "<div class='user_info'>";
                                html += "<span>" + jArrayMember[i].name + "</span>";
                                html += "<p>" + jArrayMember[i].deptname + "/" + jArrayMember[i].teamname + "</p>";
                                html += "</div></a></div>";
                            }
                            html += "</ui>";
                        }
                        if (jArrayDept.length != 0) {
                            html += "<div class='row mb-2 m-0'>부서</div>";
                            html += "<ui class='contacts m-0 p-0'>";
                            for (let i = 0; i < jArrayDept.length; i++) {
                                html += "<li class='con-list'>";
                                html += "<div class='d-flex bd-highlight' ondblclick='toSingleChatRoom("+jArrayDept[i].code+")'>";
                                html += "<div class='img_cont'>";
                                html += "<a href='#'><img src='/img/profile-default.jpg' class='rounded-circle user_img'></a>";
                                html += "</div>";
                                html += "<a href='#'>";
                                html += "<div class='user_info'>";
                                html += "<span>" + jArrayDept[i].name + "</span>";
                                html += "<p>" + jArrayDept[i].deptname + "/" + jArrayDept[i].teamname + "</p>";
                                html += "</div></a></div>";
                            }
                            html += "</ui>";
                        }
                        if (jArrayTeam.length != 0) {
                            html += "<div class='row mb-2 m-0'>팀</div>";
                            html += "<ui class='contacts m-0 p-0'>";
                            for (let i = 0; i < jArrayTeam.length; i++) {
                                html += "<li class='con-list'>";
                                html += "<div class='d-flex bd-highlight' ondblclick='toSingleChatRoom("+jArrayTeam[i].code+")'>";
                                html += "<div class='img_cont'>";
                                html += "<a href='#'><img src='/img/profile-default.jpg' class='rounded-circle user_img'></a>";
                                html += "</div>";
                                html += "<a href='#'>";
                                html += "<div class='user_info'>";
                                html += "<span>" + jArrayTeam[i].name + "</span>";
                                html += "<p>" + jArrayTeam[i].deptname + "/" + jArrayTeam[i].teamname + "</p>";
                                html += "</div></a></div>";
                            }
                            html += "</ui>";
                        }
                        if (jArrayMessage.length !== 0){
                            let contents_length = 15; // 내용 표시할 글자수 기준
                            let name_length = 10; // 톡방 표시할 글자수 기준
                            html += "<div class='row mb-2 m-0'>메세지</div>";
                            html += "<ui class='contacts m-0 p-0'>";
                            for (let i = 0; i < jArrayMessage.length; i++) {
                                let formed_write_date = moment(jArrayMessage[i].write_date).format('YY-MM-DD HH:mm'); // 날짜형식 변경
                                let contents = jArrayMessage[i].contents.trim();
                                let name = jArrayMessage[i].name;
                                html += "<li class='con-list'>";
                                html += "<div class='d-flex bd-highlight' ondblclick='toChatRoom("+jArrayMessage[i].m_seq+")'>";
                                html += "<div class='img_cont'>";
                                html += "<img src='/img/profile-default.jpg' class='rounded-circle user_img'>";
                                html += "</div>";
                                html += "<div class='user_info'>";
                                html += "<span class='contents_ellipsis' style='font-size: 16px;'>"+contents+"</span>";
                                html += "<p><span class='name_ellipsis'><i class='far fa-comment'></i>";
                                if (jArrayMessage[i].m_type == 'S') {
                                    html += jArrayMessage[i].party_empname;
                                } else {
                                    html += name;
                                }
                                html += "</span>&nbsp;"+jArrayMessage[i].empname+" | "+formed_write_date+"</p>";
                                html += "</div></div></li>";
                            }
                            html += "</ui>";
                        }else{
                            console.log("검색결과가 없을 때...");
                            return;
                        }
                        memberAll.innerHTML = html;
                    }

                    // 멤버
                    if (jArrayMember.length == 0) {
                        memberMember.innerHTML = "검색결과가 없습니다.";
                    } else {
                        let html = "";
                        html += "<div class='row mb-2 m-0'>멤버-검색결과</div>";
                        html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < jArrayMember.length; i++) {
                            html += "<li class='con-list'>";
                            html += "<div class='d-flex bd-highlight' ondblclick='toSingleChatRoom("+jArrayMember[i].code+")'>";
                            html += "<div class='img_cont'>";
                            html += "<a href='#'><img src='/img/profile-default.jpg' class='rounded-circle user_img'></a>";
                            html += "</div>";
                            html += "<a href='#'>";
                            html += "<div class='user_info'>";
                            html += "<span>" + jArrayMember[i].name + "</span>";
                            html += "<p>" + jArrayMember[i].deptname + "/" + jArrayMember[i].teamname + "</p>";
                            html += "</div></a></div>";
                        }
                        html += "</ui>";
                        memberMember.innerHTML = html;
                    }

                    // 부서
                    if (jArrayDept.length == 0) {
                        memberDept.innerHTML = "검색결과가 없습니다.";
                    } else {
                        let html = "";
                        html += "<div class='row mb-2 m-0'>부서-검색결과</div>";
                        html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < jArrayDept.length; i++) {
                            html += "<li class='con-list'>";
                            html += "<div class='d-flex bd-highlight' ondblclick='toSingleChatRoom("+jArrayDept[i].code+")'>";
                            html += "<div class='img_cont'>";
                            html += "<a href='#'><img src='/img/profile-default.jpg' class='rounded-circle user_img'></a>";
                            html += "</div>";
                            html += "<a href='#'>";
                            html += "<div class='user_info'>";
                            html += "<span>" + jArrayDept[i].name + "</span>";
                            html += "<p>" + jArrayDept[i].deptname + "/" + jArrayDept[i].teamname + "</p>";
                            html += "</div></a></div>";
                        }
                        html += "</ui>";
                        memberDept.innerHTML = html;
                    }

                    // 팀
                    if (jArrayTeam.length == 0) {
                        memberTeam.innerHTML = "검색결과가 없습니다.";
                    } else {
                        let html = "";
                        html += "<div class='row mb-2 m-0'>팀-검색결과</div>";
                        html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < jArrayTeam.length; i++) {
                            html += "<li class='con-list'>";
                            html += "<div class='d-flex bd-highlight' ondblclick='toSingleChatRoom("+jArrayTeam[i].code+")'>";
                            html += "<div class='img_cont'>";
                            html += "<a href='#'><img src='/img/profile-default.jpg' class='rounded-circle user_img'></a>";
                            html += "</div>";
                            html += "<a href='#'>";
                            html += "<div class='user_info'>";
                            html += "<span>" + jArrayTeam[i].name + "</span>";
                            html += "<p>" + jArrayTeam[i].deptname + "/" + jArrayTeam[i].teamname + "</p>";
                            html += "</div></a></div>";
                        }
                        html += "</ui>";
                        memberTeam.innerHTML = html;
                    }

                    // 메세지
                    if (jArrayMessage.length == 0) {
                        memberMessage.innerHTML = "검색결과가 없습니다.";
                    } else {
                        let html = "";
                        let contents_length = 15; // 내용 표시할 글자수 기준
                        let name_length = 10; // 톡방 표시할 글자수 기준
                        html += "<div class='row mb-2 m-0'>메세지-검색결과</div>";
                        html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < jArrayMessage.length; i++) {
                            let formed_write_date = moment(jArrayMessage[i].write_date).format('YY-MM-DD HH:mm');
                            let contents = jArrayMessage[i].contents.trim();
                            let name = jArrayMessage[i].name;
                            html += "<li class='con-list'>";
                            html += "<div class='d-flex bd-highlight' ondblclick='toChatRoom("+jArrayMessage[i].m_seq+")'>";
                            html += "<div class='img_cont'>";
                            html += "<img src='/img/profile-default.jpg' class='rounded-circle user_img'>";
                            html += "</div>";
                            html += "<div class='user_info'>";
                            html += "<span class='contents_ellipsis' style='font-size: 16px;'>"+contents+"</span>";
                            html += "<p><span class='name_ellipsis'><i class='far fa-comment'></i>";
                            if (jArrayMessage[i].m_type == 'S') {
                                html += jArrayMessage[i].party_empname;
                            } else {
                                html += name;
                            }
                            html += "</span>&nbsp;"+jArrayMessage[i].empname+" | "+formed_write_date+"</p>";
                            html += "</div></div></li>";
                        }
                        html += "</ui>";
                        memberMessage.innerHTML = html;
                    }
                }
            })

    }
</script>
<script src="/resources/static/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
</body>
</html>