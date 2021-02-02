<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>통합검색</title>
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
    <style>
    </style>
</head>
<body>

<!-- top head -->
<div class="w-100 h-100 chat container-fluid p-0 min-w-450">
    <div class="row w-100 m-0 h15">
        <div class="card-header w-100 p-0 align-center" style="border-radius: 0%;">
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
    <div class="row w-100 h-85 m-0 p-4 border-top whiteBg">
        <div class="search_body w-100 m-0 pl-0 col-12 col-sm-10 col-md-9 col-lg-8">
            <!-- 전체 : 검색결과가 없는것은 가리고, 검색결과가 모두 없을 때는 코코아를 띄워주자-->
            <div class="container" id="memberAll">
                <c:choose>
                    <c:when test="${(empty memberList) && (empty deptList) && (empty teamList)}">
                        검색결과가 없습니다.
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty memberList}">
                            <div class="row mb-2 m-0">멤버</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${memberList}">
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
                                </c:forEach>
                            </ui>
                        </c:if>
                        <c:if test="${not empty deptList}">
                            <div class="row mb-2 m-0">부서</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${deptList}">
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
                                </c:forEach>
                            </ui>
                        </c:if>
                        <c:if test="${not empty teamList}">
                            <div class="row mb-2 m-0">팀</div>
                            <ui class="contacts m-0 p-0">
                                <c:forEach var="i" items="${teamList}">
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
<script>
    let memberAll = document.getElementById("memberAll");
    let memberMember = document.getElementById("memberMember");
    let memberDept = document.getElementById("memberDept");
    let memberTeam = document.getElementById("memberTeam");
    //let memberMessage = document.getElementById("memberMessage");
    let searchKeyword = $("#searchKeyword").val();

    document.getElementById("searchAll").addEventListener('click', showAll);
    document.getElementById("searchMember").addEventListener('click', showMember);
    document.getElementById("searchDept").addEventListener('click', showDept);
    document.getElementById("searchTeam").addEventListener('click', showTeam);
    //let showMessage = document.getElementById("showMessage");

    $(document).ready(function () {
        //전체라는 글자를 굵게하는 효과
        searchAllBoldText();
        // 검색창에 검색했던 키워드 띄우기
        $("#searchContents").val(searchKeyword);
        //하이라이팅 효과
        /*$(".search_body:contains('"+searchKeyword+"')").each(function () {
            var regex = new RegExp(searchKeyword,'gi');
            $(this).html( $(this).text().replace(regex, "<span class='highlighted'>"+searchKeyword+"</span>") );
        });*/
    });

    function searchAllBoldText() {
        $("#searchAll").css("font-weight", "Bold");
    }

    function showAll() {
        memberAll.style.display = "block";
        memberMember.style.display = "none";
        memberDept.style.display = "none";
        memberTeam.style.display = "none";
        $("#searchAll").css("font-weight", "Bold");
        $("#searchMember").css("font-weight", "normal");
        $("#searchDept").css("font-weight", "normal");
        $("#searchTeam").css("font-weight", "normal");
        //memberMessage.style.display="none";
    };

    function showMember() {
        memberAll.style.display = "none";
        memberMember.style.display = "block";
        memberDept.style.display = "none";
        memberTeam.style.display = "none";
        $("#searchAll").css("font-weight", "normal");
        $("#searchMember").css("font-weight", "Bold");
        $("#searchDept").css("font-weight", "normal");
        $("#searchTeam").css("font-weight", "normal");
        //memberMessage.style.display="none";
    };

    function showDept() {
        memberAll.style.display = "none";
        memberMember.style.display = "none";
        memberDept.style.display = "block";
        memberTeam.style.display = "none";
        $("#searchAll").css("font-weight", "normal");
        $("#searchMember").css("font-weight", "normal");
        $("#searchDept").css("font-weight", "Bold");
        $("#searchTeam").css("font-weight", "normal");
        //memberMessage.style.display="none";
    };

    function showTeam() {
        memberAll.style.display = "none";
        memberMember.style.display = "none";
        memberDept.style.display = "none";
        memberTeam.style.display = "block";
        $("#searchAll").css("font-weight", "normal");
        $("#searchMember").css("font-weight", "normal");
        $("#searchDept").css("font-weight", "normal");
        $("#searchTeam").css("font-weight", "Bold");
        //memberMessage.style.display="none";
    };

    //-------------------------------- 검색 -------------------------------------
    document.getElementById("searchBtn").addEventListener("click", search);
    $("#searchContents").on("keydown", function (e) {
        if (e.keyCode == 13) {
            searchAjax();
        }
    });

    // 입력중에 실시간으로 검색
    $("#searchContents").on("propertychange change keyup paste input", function (e) {
        searchAjax();
    });

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
                let jArrayMember = resp[0];
                let jArrayDept = resp[1];
                let jArrayTeam = resp[2];
                // 내용초기화
                memberAll.innerHTML = "";
                // -------------- 여기서부터 다시 리스트를 쏴줘야한다. --------------
                // 전체
                if (jArrayMember.length == 0 && jArrayDept.length == 0 && jArrayTeam.length == 0) {
                    memberAll.innerHTML = "검색결과가 없습니다.";
                }else{
                    let html = "";
                    if(jArrayMember.length != 0){
                        html += "<div class='row mb-2 m-0'>멤버</div>";
                        html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < jArrayMember.length; i++) {
                            html += "<li class='con-list'>";
                            html += "<div class='d-flex bd-highlight'>";
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
                    if(jArrayDept.length != 0){
                        html += "<div class='row mb-2 m-0'>부서</div>";
                        html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < jArrayDept.length; i++) {
                            html += "<li class='con-list'>";
                            html += "<div class='d-flex bd-highlight'>";
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
                    if(jArrayDept.length != 0){
                        html += "<div class='row mb-2 m-0'>부서</div>";
                        html += "<ui class='contacts m-0 p-0'>";
                        for (let i = 0; i < jArrayDept.length; i++) {
                            html += "<li class='con-list'>";
                            html += "<div class='d-flex bd-highlight'>";
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
                    memberAll.innerHTML = html;
                }

                // 멤버
                if (jArrayMember.length == 0) {
                    memberMember.innerHTML = "검색결과가 없습니다.";
                }else {
                    let html = "";
                    html += "<div class='row mb-2 m-0'>멤버-검색결과</div>";
                    html += "<ui class='contacts m-0 p-0'>";
                    for (let i = 0; i < jArrayMember.length; i++) {
                        html += "<li class='con-list'>";
                        html += "<div class='d-flex bd-highlight'>";
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
                }else{
                    let html = "";
                    html += "<div class='row mb-2 m-0'>부서-검색결과</div>";
                    html += "<ui class='contacts m-0 p-0'>";
                    for (let i = 0; i < jArrayDept.length; i++) {
                        html += "<li class='con-list'>";
                        html += "<div class='d-flex bd-highlight'>";
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
                }else {
                    let html = "";
                    html += "<div class='row mb-2 m-0'>부서-검색결과</div>";
                    html += "<ui class='contacts m-0 p-0'>";
                    for (let i = 0; i < jArrayTeam.length; i++) {
                        html += "<li class='con-list'>";
                        html += "<div class='d-flex bd-highlight'>";
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
            }
        })
    }
</script>
<script src="/resources/static/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
</body>
</html>