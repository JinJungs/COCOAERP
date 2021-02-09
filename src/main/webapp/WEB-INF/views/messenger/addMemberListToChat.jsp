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
    <style>
    </style>
</head>
<body>

<form name="formAddMember" id="formAddMember" action="/messenger/addMemberToChatRoom" methode="post">
    <input type="hidden" name="seq" value="${seq}">
    <!-- top head -->
    <div class="w-100 h-100 chat container-fluid p-0 min-w-450">
        <div class="row w-100 m-0 h15">
            <div class="card-header w-100 p-0 align-center" style="border-radius: 0%;">
                <div>
                    <button onclick="addChatRoom()" type="button">추가</button>
                </div>
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
                <div class="container" id="memberAll"></div>
            </div>
        </div>
    </div>
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    let memberAll = document.getElementById("memberAll");
    let checkArr = new Array();

    $(document).ready(function () {
        // ajax로 목록 불러오기
        searchAjax("");
    });

    //-------------------------------- 검색 -------------------------------------
    document.getElementById("searchBtn").addEventListener("click", searchAjax);
    $("#searchContents").on("keydown", function (e) {
        if (e.keyCode == 13) {
            let searchContents = $("#searchContents").val();
            searchAjax(searchContents);
        }
    });

    // 입력중에 실시간으로 검색
    $("#searchContents").on("propertychange change keyup paste input", function (e) {
        let searchContents = $("#searchContents").val();
        searchAjax(searchContents);
    });

    // room의 seq를 받아 해당 채팅방으로 이동
    let winFeature = 'width=450px,height=660px,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,fullscreen=yes';

    function toChatRoom(seq) {
        window.open('/messenger/chat?seq=' + seq, '', winFeature);
    }

    //-------------------------------- 비동기 검색 -------------------------------------
    function searchAjax(searchContents) {
        $.ajax({
            url: "/messenger/messengerSearchAjax",
            type: "post",
            data: {
                contents: searchContents
            },
            dataType: "json",
            success: function (resp) {
                let jArrayMember = resp[0];
                // -------------- 여기서부터 다시 리스트를 쏴줘야한다. --------------
                setTimeout(function () {
                    // 멤버
                    if (jArrayMember.length == 0) {
                        memberAll.innerHTML = "검색결과가 없습니다.";
                    } else {
                        let html = "";
                        html += "<div class='row mb-2 m-0'></div>";
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
                            html += "<input class='form-check-input' id='checkbox" + jArrayMember[i].code + "' type='checkbox' name='emp_code' value='" + jArrayMember[i].code + "' onclick='updateChecklist("+jArrayMember[i].code+")'>";
                            html += "</li>";
                        }
                        html += "</ui>";
                        memberAll.innerHTML = html;
                        // 다시 검색해서 체크박스를 다시 쏴줄 때도 checkArr 들어있는 값을 value로 가지고 있는 체크박스라면 check를 채워준다.
                        setTimeout(function (){
                            for (let i = 0; i < jArrayMember.length; i++) {
                                console.log("checkArr : " + checkArr);
                                let parsed = jArrayMember[i].code.toString();
                                if (checkArr.includes(parsed) || checkArr.includes(jArrayMember[i].code)) {
                                    console.log("배열에 들어있나? : " + checkArr.includes(parsed));
                                    document.getElementById("checkbox" + jArrayMember[i].code).checked = true;
                                }
                            }
                        },100);
                    }
                }, 200);
            }
        })
    }

    //========================체크박스 값 받기===================================
    function addChatRoom() {
        $("#formAddMember").submit();
        //딜레이 주고 창 닫기
    }

    // 체크박스가 체크되었을 때 체크박스에 담기
    // 체크박스가 해제되었을 때 체크박스에서 빼기
    function updateChecklist(code){
        if($("#checkbox"+code).prop('checked')){
            checkArr.push(code);
        }else{
            let idx = checkArr.indexOf(code);
            checkArr.splice(idx, 1);
        }
    }

</script>
<script src="/resources/static/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
</body>
</html>