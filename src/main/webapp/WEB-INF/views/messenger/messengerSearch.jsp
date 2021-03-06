<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <div class="row w-100 m-0 h-25">
        <div class="card-header col-12 p-0" style="border-radius: 0%;">
            <!-- 제목 -->
            <div class="row w-100 m-0 p-4 con-title">
                <div class="col-12 m-0 p-0 align-self-center">
                    <span id="chatTitle">검색 결과</span>
                </div>
            </div>
            <!-- 검색 -->
            <div class="input-group float-right col-12 col-sm-11 col-md-10 col-lg-8 col-xl-6 pl-4 pr-4 p-0">
                <input type="text" placeholder="이름, 메세지 검색" `name="" class="form-control search" id="searchContents">
                <div class="input-group-prepend">
                  <span class="input-group-text search_btn" id="searchBtn"> <i class="fas fa-search"></i>
                  </span>
                </div>
            </div>
            <!-- 메뉴목록 -->
            <div class="searchMenu w-100 d-flex pl-4 pr-4 pt-2 justify-content-start">
                <div class="p-2" id="searchAll">전체</div>
                <div class="p-2" id="searchMember">멤버</div>
                <div class="p-2" id="searchDept">부서원</div>
                <div class="p-2" id="searchTeam">팀원</div>
                <div class="p-2" id="searchMessage">메세지</div>
            </div>
        </div>
    </div>
    <!-- main -->
    <input type="hidden" id="searchKeyword" value="${searchKeyword}">
    <div class="row w-100 h-75 m-0 p-0 border-top whiteBg search_body">
        <div class=" w-100 m-0 p-0 col-12 col-sm-10 col-md-9 col-lg-8">
            <!-- 전체 : 검색결과가 없는것은 가리고, 검색결과가 모두 없을 때는 코코아를 띄워주자-->
            <div class="container m-0 p-1 h-100" id="memberAll">
                <c:choose>
                    <c:when test="${(empty memberList) && (empty deptList) && (empty teamList) &&(empty messageList)}">
                        <div class='none h-100'>
                            <img class='noFileImg' alt='nofile' src='/img/cocoa2.png'>
                            <p class='noFileMsg'>검색결과가 없습니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty memberList}">
                            <div class="search_small_title row">멤버</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${memberList}">
                                    <li class="con-list">
                                        <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
                                            <div class="img_cont align-self-center">
                                                <a href="#"> <img src="${i.profile}"
                                                                  class="rounded-circle user_img">
                                                </a>
                                            </div>
                                            <a href="#">
                                                <div class="user_info align-self-center">
                                                    <span>${i.name}</span>
                                                    <p>${i.deptname} | ${i.teamname}</p>
                                                </div>
                                            </a>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ui>
                        </c:if>
                        <c:if test="${not empty deptList}">
                            <div class="search_small_title row">부서원</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${deptList}">
                                    <li class="con-list">
                                        <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
                                            <div class="img_cont align-self-center">
                                                <a href="#"> <img src="${i.profile}"
                                                                  class="rounded-circle user_img">
                                                </a>
                                            </div>
                                            <a href="#">
                                                <div class="user_info align-self-center">
                                                    <span>${i.name}</span>
                                                    <p>${i.deptname} | ${i.teamname}</p>
                                                </div>
                                            </a>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ui>
                        </c:if>
                        <c:if test="${not empty teamList}">
                            <div class="search_small_title row">팀원</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${teamList}">
                                    <li class="con-list">
                                        <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
                                            <div class="img_cont align-self-center">
                                                <a href="#"> <img src="${i.profile}"
                                                                  class="rounded-circle user_img">
                                                </a>
                                            </div>
                                            <a href="#">
                                                <div class="user_info align-self-center">
                                                    <span>${i.name}</span>
                                                    <p>${i.deptname} | ${i.teamname}</p>
                                                </div>
                                            </a>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ui>
                        </c:if>
                        <c:if test="${not empty messageList}">
                            <div class="search_small_title row">메세지</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${messageList}">
                                    <li class="con-list">
                                        <div class="d-flex bd-highlight" ondblclick="toChatRoom(${i.m_seq})">
                                            <div class="img_cont align-self-center">
                                                <img src="${i.profile}" class="rounded-circle user_img">
                                            </div>
                                            <div class="user_info align-self-center">
                                                <span class="contents_span">${i.contents}</span>
                                                <p><span class="room_span"><i class="far fa-comment"></i>
                                                <c:choose>
                                                    <c:when test="${i.m_type=='S'}"> <!--1:1채팅방-->
                                                        ${i.party_empname}
                                                    </c:when>
                                                    <c:otherwise> <!--1:N채팅방-->
                                                        ${i.name}
                                                    </c:otherwise>
                                                </c:choose>
                                                </span>&nbsp;${i.empname} | <fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd HH:ss"/></p>
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
            <div class="container m-0 p-1 h-100" id="memberMember">
                <c:choose>
                    <c:when test="${not empty memberList}">
                        <ui class="contacts m-0 p-0">
                            <c:forEach var="i" items="${memberList}">
                                <li class="con-list">
                                    <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
                                        <div class="img_cont align-self-center">
                                            <a href="#"> <img src="${i.profile}"
                                                              class="rounded-circle user_img">
                                            </a>
                                        </div>
                                        <a href="#">
                                            <div class="user_info align-self-center">
                                                <span>${i.name}</span>
                                                <p>${i.deptname} | ${i.teamname}</p>
                                            </div>
                                        </a>
                                    </div>
                                </li>
                            </c:forEach>
                        </ui>
                    </c:when>
                    <c:otherwise>
                        <div class='none h-100'>
                            <img class='noFileImg' alt='nofile' src='/img/cocoa2.png'>
                            <p class='noFileMsg'>검색결과가 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- 부서원 -->
            <div class="container m-0 p-1 h-100" id="memberDept">
                <c:choose>
                    <c:when test="${not empty deptList}">
                        <ui class="contacts m-0 p-0">
                            <c:forEach var="i" items="${deptList}">
                                <li class="con-list">
                                    <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
                                        <div class="img_cont align-self-center">
                                            <a href="#"> <img src="${i.profile}"
                                                              class="rounded-circle user_img">
                                            </a>
                                        </div>
                                        <a href="#">
                                            <div class="user_info align-self-center">
                                                <span>${i.name}</span>
                                                <p>${i.deptname} | ${i.teamname}</p>
                                            </div>
                                        </a>
                                    </div>
                                </li>
                            </c:forEach>
                        </ui>
                    </c:when>
                    <c:otherwise>
                        <div class='none h-100'>
                            <img class='noFileImg' alt='nofile' src='/img/cocoa2.png'>
                            <p class='noFileMsg'>검색결과가 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- 팀원 -->
            <div class="container m-0 p-1 h-100" id="memberTeam">
                <c:choose>
                    <c:when test="${not empty teamList}">
                        <ui class="contacts m-0 p-0">
                            <c:forEach var="i" items="${teamList}">
                                <li class="con-list">
                                    <div class="d-flex bd-highlight" ondblclick="toSingleChatRoom(${i.code})">
                                        <div class="img_cont align-self-center">
                                            <a href="#"> <img src="${i.profile}"
                                                              class="rounded-circle user_img">
                                            </a>
                                        </div>
                                        <a href="#">
                                            <div class="user_info align-self-center">
                                                <span>${i.name}</span>
                                                <p>${i.deptname} | ${i.teamname}</p>
                                            </div>
                                        </a>
                                    </div>
                                </li>
                            </c:forEach>
                        </ui>
                    </c:when>
                    <c:otherwise>
                        <div class='none h-100'>
                            <img class='noFileImg' alt='nofile' src='/img/cocoa2.png'>
                            <p class='noFileMsg'>검색결과가 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- 메세지 -->
            <div class="container m-0 p-1 h-100" id="memberMessage">
                <c:choose>
                    <c:when test="${not empty messageList}">
                        <ui class="contacts m-0 p-0">
                            <c:forEach var="i" items="${messageList}">
                                <li class="con-list">
                                    <div class="d-flex bd-highlight" ondblclick="toChatRoom(${i.m_seq})" onclick="shortContents(${i.seq},'${i.contents}')">
                                        <div class="img_cont align-self-center">
                                            <img src="${i.profile}" class="rounded-circle user_img">
                                        </div>
                                        <div class="user_info align-self-center">
                                            <span class="contents_span" id="contents_span${i.seq}">${i.contents}</span>
                                            <p><span class="room_span"><i class="far fa-comment"></i>
                                                <c:choose>
                                                    <c:when test="${i.m_type=='S'}"> <!--1:1채팅방-->
                                                        ${i.party_empname}
                                                    </c:when>
                                                    <c:otherwise> <!--1:N채팅방-->
                                                        ${i.name}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>&nbsp;${i.empname} | <fmt:formatDate value="${i.write_date}" pattern="yyyy-MM-dd HH:ss"/></p>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ui>
                    </c:when>
                    <c:otherwise>
                        <div class='none h-100'>
                            <img class='noFileImg' alt='nofile' src='/img/cocoa2.png'>
                            <p class='noFileMsg'>검색결과가 없습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 날짜 변경 라이브러리-->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
    let memberAll = document.getElementById("memberAll");
    let memberMember = document.getElementById("memberMember");
    let memberDept = document.getElementById("memberDept");
    let memberTeam = document.getElementById("memberTeam");
    let memberMessage = document.getElementById("memberMessage");
    let searchKeyword = $("#searchKeyword").val();
    let jArrayMember = "";
    let jArrayDept = "";
    let jArrayTeam = "";
    let jArrayMessage = "";

    document.getElementById("searchAll").addEventListener('click', showAll);
    document.getElementById("searchMember").addEventListener('click', showMember);
    document.getElementById("searchDept").addEventListener('click', showDept);
    document.getElementById("searchTeam").addEventListener('click', showTeam);
    document.getElementById("searchMessage").addEventListener('click', showMessage);

    noResult = "";
    noResult += "<div class='none h-100'>";
    noResult += "<img class='noFileImg' alt='nofile' src='/img/cocoa2.png'>";
    noResult += "<p class='noFileMsg'>검색결과가 없습니다.</p>";
    noResult += "</div>";

    $(document).ready(function () {
        //전체라는 글자를 굵게하는 효과
        searchAllBoldText();
        // 검색창에 검색했던 키워드 띄우기
        $("#searchContents").val(searchKeyword);
    });

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
    $("#searchContents").on("propertychange change keyup paste input", function () {
        /*let searchContents = $("#searchContents").val();
        console.log("검색내용 : " + searchContents);*/
        setTimeout(() => {
            searchAjax();
        },400);
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
        console.log("검색내용: " + searchContents);
        $.ajax({
            url: "/messenger/messengerSearchAjax",
            type: "post",
            data: {
                contents: searchContents
            },
            dataType: "json",
            success: function (resp) {
                console.log("멤버 몇명 : " +jArrayMember.length);
                jArrayMember = resp[0];
                jArrayDept = resp[1];
                jArrayTeam = resp[2];
                jArrayMessage = resp[3];
                let html = "";
                let a_html = "";
                let m_html = "";
                // -------------- 여기서부터 다시 리스트를 쏴줘야한다. --------------
                    // 전체
                    if (jArrayMember.length == 0 && jArrayDept.length == 0 && jArrayTeam.length == 0 && jArrayMessage.length == 0) {
                        html = noResult;
                    } else {
                        for(let j=0; j < resp.length-1; j++){
                            if (resp[j].length != 0) {
                                let title = '';
                                if(j==0){
                                    title = '멤버';
                                }else if(j==1){
                                    title = '부서원';
                                }else {
                                    title = '팀원';
                                }
                                html += "<div class='search_small_title row'>"+title+"</div>";
                                html += "<ui class='contacts m-0 p-0'>";
                                for (let i = 0; i < resp[j].length; i++) {
                                    html += "<li class='con-list'>";
                                    html += "<div class='d-flex bd-highlight' ondblclick='toSingleChatRoom("+resp[j][i].code+")'>";
                                    html += "<div class='img_cont align-self-center'>";
                                    html += "<a href='#'><img src='"+resp[j][i].profile+"' class='rounded-circle user_img'></a>";
                                    html += "</div>";
                                    html += "<a href='#'>";
                                    html += "<div class='user_info align-self-center'>";
                                    html += "<span>" + resp[j][i].name + "</span>";
                                    html += "<p>" + resp[j][i].deptname + " | " + resp[j][i].teamname + "</p>";
                                    html += "</div></a></div></li>";
                                }
                                html += "</ui>";
                            }
                        }
                        if (jArrayMessage.length !== 0){
                            let contents_length = 15; // 내용 표시할 글자수 기준
                            let name_length = 10; // 톡방 표시할 글자수 기준
                            html += "<div class='search_small_title row'>메세지</div>";
                            html += "<ui class='contacts m-0 p-0'>";
                            for (let i = 0; i < jArrayMessage.length; i++) {
                                let formed_write_date = moment(jArrayMessage[i].write_date).format('YYYY-MM-DD HH:mm'); // 날짜형식 변경
                                let contents = jArrayMessage[i].contents.trim();
                                let name = jArrayMessage[i].name;
                                html += "<li class='con-list'>";
                                html += "<div class='d-flex bd-highlight' ondblclick='toChatRoom("+jArrayMessage[i].m_seq+")'>";
                                html += "<div class='img_cont align-self-center'>";
                                html += "<img src='"+jArrayMessage[i].profile+"' class='rounded-circle user_img'>";
                                html += "</div>";
                                html += "<div class='user_info align-self-center'>";
                                html += "<span class='contents_span' style='font-size: 16px;'>"+contents+"</span>";
                                html += "<p><span class='room_span'><i class='far fa-comment'></i>&nbsp;";
                                if (jArrayMessage[i].m_type == 'S') {
                                    html += jArrayMessage[i].party_empname;
                                } else {
                                    html += name;
                                }
                                html += "</span>&nbsp;"+jArrayMessage[i].empname+" | "+formed_write_date+"</p>";
                                html += "</div></div></li>";
                            }
                            html += "</ui>";
                        }
                    }
                    memberAll.innerHTML = html;

                // 멤버, 부서원, 팀원
                for(let j=0; j < resp.length-1; j++){
                    if (resp[j].length == 0) {
                        if(j==0){
                            memberMember.innerHTML = noResult;
                        }else if(j==1){
                            memberDept.innerHTML = noResult;
                        }else {
                            memberTeam.innerHTML = noResult;
                        }
                    } else {
                        a_html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < resp[j].length; i++) {
                            a_html += "<li class='con-list'>";
                            a_html += "<div class='d-flex bd-highlight' ondblclick='toSingleChatRoom("+resp[j][i].code+")'>";
                            a_html += "<div class='img_cont align-self-center'>";
                            a_html += "<a href='#'><img src='"+resp[j][i].profile+"' class='rounded-circle user_img'></a>";
                            a_html += "</div>";
                            a_html += "<a href='#'>";
                            a_html += "<div class='user_info align-self-center'>";
                            a_html += "<span>" + resp[j][i].name + "</span>";
                            a_html += "<p>" + resp[j][i].deptname + " | " + resp[j][i].teamname + "</p>";
                            a_html += "</div></a></div></li>";
                        }
                        a_html += "</ui>";
                        if(j==0){
                            memberMember.innerHTML = a_html;
                        }else if(j==1){
                            memberDept.innerHTML = a_html;
                        }else {
                            memberTeam.innerHTML = a_html;
                        }
                    }
                }
                // 메세지
                    if (jArrayMessage.length == 0) {
                        memberMessage.innerHTML = noResult;
                    } else {
                        let contents_length = 15; // 내용 표시할 글자수 기준
                        let name_length = 10; // 톡방 표시할 글자수 기준
                        m_html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < jArrayMessage.length; i++) {
                            let formed_write_date = moment(jArrayMessage[i].write_date).format('YYYY-MM-DD HH:mm');
                            let contents = jArrayMessage[i].contents.trim();
                            let name = jArrayMessage[i].name;
                            m_html += "<li class='con-list'>";
                            m_html += "<div class='d-flex bd-highlight' ondblclick='toChatRoom("+jArrayMessage[i].m_seq+")'>";
                            m_html += "<div class='img_cont align-self-center'>";
                            m_html += "<img src='"+jArrayMessage[i].profile+"' class='rounded-circle user_img'>";
                            m_html += "</div>";
                            m_html += "<div class='user_info align-self-center'>";
                            m_html += "<span class='contents_span' style='font-size: 16px;'>"+contents+"</span>";
                            m_html += "<p><span class='room_span'><i class='far fa-comment'></i>&nbsp;";
                            if (jArrayMessage[i].m_type == 'S') {
                                m_html += jArrayMessage[i].party_empname;
                            } else {
                                m_html += name;
                            }
                            m_html += "</span>&nbsp;"+jArrayMessage[i].empname+" | "+formed_write_date+"</p>";
                            m_html += "</div></div></li>";
                        }
                        m_html += "</ui>";
                        memberMessage.innerHTML = m_html;
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