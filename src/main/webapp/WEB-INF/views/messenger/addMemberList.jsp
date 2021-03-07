<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <title>채팅방 만들기</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/css/messenger.css">
</head>
<body>
<form name="formAddMember" id="formAddMember" action="/messenger/addChatRoom" method="post">
    <div class="w-100 h-100 chat container-fluid m-0 p-0 min-w-440">
        <div class="card w-100 h-100 p-0 m-0" style="border-radius:2px!important; height: 100vh!important;">
            <!-- head -->
            <div class="card-header msg_head p-0" style="border-radius: 0%;">
                <!-- 제목 -->
                <div class="row w-100 m-0 p-4 con-title">
                    <div class="col-12 m-0 p-0 align-self-center">
                        <span id="searchAll">대화상대 선택</span>
                    </div>
                </div>
                <!-- 선택된 사람의 목록을 띄워주는 자리 -->
                <div class="row m-0 pl-4 pr-4 p-0 pb-1 d-flex justify-content-start" id="addedPartyBox"></div>
                <!-- 검색 -->
                <div class="input-group float-right col-12 col-sm-11 col-md-10 col-lg-8 col-xl-6 pl-4 pr-4 p-0 pb-4">
                    <input type="text" placeholder="이름으로 검색" name=""
                           class="form-control search" id="searchContents">
                    <div class="input-group-prepend">
                          <span class="input-group-text search_btn" id="searchBtn">
                              <i class="fas fa-search"></i>
                          </span>
                    </div>
                </div>
            </div>
            <!-- main -->
            <!-- 전체 : 검색결과가 없는것은 가리고, 검색결과가 모두 없을 때는 코코아를 띄워주자-->
            <div class="card-body addMember_body" style="border-radius:0 !important;">
                <div id="memberAll" style="height: 100%;"></div>
            </div>
            <!-- footer -->
            <div class="card-footer p-3 d-flex justify-content-end" style="height: 70px;">
                <button class="btn btn-outline-primary mr-3" id="confirm_btn" onclick="addChatRoom()" type="button">확인</button>
                <button class="btn btn-outline-lightlight" id="cancel_btn" onclick="closePopup()" type="button">취소</button>
            </div>
        </div>
    </div>
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    let memberAll = document.getElementById("memberAll");
    let checkArr = new Array();
    let jArrayMember = "";
    let searchContents = "";

    $(document).ready(function () {
        // ajax로 목록 불러오기
        searchAjax();
        // 선택된 인원이 없을 때 확인버튼 disabled 처리
        if (checkArr.length == 0) {
            $('#confirm_btn').prop('disabled', true);
        }
    });

    // esc 누르면 창닫기
    $(document).keydown(function (e) {
        if (e.keyCode == 27 || e.which == 27) {
            window.close();
        }
    });

    //-------------------------------- 검색 -------------------------------------
    document.getElementById("searchBtn").addEventListener("click", searchAjax);
    $("#searchContents").on("keydown", function (e) {
        if (e.keyCode == 13) {
            searchAjax();
        }
    });

    // 입력중에 실시간으로 검색
    $("#searchContents").on("propertychange change keyup paste input", function (e) {
        setTimeout(() => {
            searchAjax();
        },400);
    });

    // room의 seq를 받아 해당 채팅방으로 이동
    let winFeature = 'width=450px,height=660px,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,fullscreen=yes';

    function toChatRoom(seq) {
        window.open('/messenger/chat?seq=' + seq, '', winFeature);
    }

    //-------------------------------- 비동기 검색 -------------------------------------
    function searchAjax() {
        searchContents = $("#searchContents").val();
        $.ajax({
            url: "/messenger/addMemberSearchAjax",
            type: "post",
            data: {
                contents: searchContents
            },
            dataType: "json",
            success: function (resp) {
                jArrayMember = resp;
                // -------------- 여기서부터 다시 리스트를 쏴줘야한다. --------------
                // 멤버
                let html = "";
                if (jArrayMember.length == 0) {
                    html += "<div class='none h-100'>";
                    html += "<img class='noFileImg' alt='nofile' src='/img/cocoa2.png'>";
                    html += "<p class='noFileMsg'>검색결과가 없습니다.</p>";
                    html += "</div>";
                } else {
                    html += "<ui class='contacts m-0 p-0'>";
                    for (let i = 0; i < jArrayMember.length; i++) {
                        let parsed = jArrayMember[i].code.toString();
                        html += "<li class='con-list'>";
                        html += "<div class='d-flex bd-highlight'>";
                        html += "<div class='img_cont align-self-center'>";
                        html += "<a href='#'><img src='"+jArrayMember[i].profile+"' class='rounded-circle user_img'></a>";
                        html += "</div>";
                        html += "<a href='#'>";
                        html += "<div class='user_info align-self-center'>";
                        html += "<span>" + jArrayMember[i].name + "</span>";
                        html += "<p>" + jArrayMember[i].deptname + " | ";
                        if(!jArrayMember[i].teamname){
                            html += "무소속</p>";
                        }else{
                            html += jArrayMember[i].teamname + "</p>";
                        }
                        html += "</div></a>";
                        html += "<div class='ml-auto align-self-center'>"
                        html += "<input class='form-check-input align-self-center' id='checkbox" + jArrayMember[i].code + "' type='checkbox' name='emp_code' value='" + jArrayMember[i].code + "' onclick='updateChecklist(" + jArrayMember[i].code + ", \"" + jArrayMember[i].name + "\")'";
                        if (checkArr.includes(parsed) || checkArr.includes(jArrayMember[i].code)) {
                            html += "checked='checked'>";
                        }else{
                            html += ">";
                        }
                        html += "</div>"
                        html += "</div></li>";
                    }
                    html += "</ui>";
                }
                memberAll.innerHTML = html;
            }
        })
    }

    //========================체크박스 값 받기===================================
    function addChatRoom() {
        // 체크된 사람이 0명이라면 넘겨주지 않기
        if (checkArr.length == 0) {
            alert("대화상대를 한 명 이상 선택해주세요.");
            return;
        }
        $("#formAddMember").submit();
    }

    // 체크박스가 체크되었을 때 addParty
    // 체크박스가 해제되었을 때 deleteParty
    function updateChecklist(code, name) {
        // 1. 체크했을 때
        if ($("#checkbox" + code).prop('checked')) {
            addParty(code, name);
            // 2. 체크를 해지했을 때
        } else {
            deleteParty(code);
        }
    }

    // 1. 사람 목록에서 추가하기
    function addParty(code, name) {
        // 1.1. 배열에 추가
        checkArr.push(code);
        // 1.2. 상단에 사람목록 추가
        let html = "";
        html += "<div class='pl-2 pr-2 ml-2 mb-2 addedParty align-self-center' id='addedParty" + code + "'>";
        html += "<span class='mr-1'>" + name + "</span>";
        html += "<i class='fas fa-times ml-auto' onclick='deleteToplist(" + code + ")'></i>";
        html += "</div>";
        $("#addedPartyBox").append(html);
        // 1.3. 선택한 사람의 숫자 보여주기
        updatePartyCount();
    }

    // 2. 사람 목록에서 삭제하기
    function deleteParty(code) {
        // 2.1. 배열에서 삭제
        let idx = checkArr.indexOf(code);
        checkArr.splice(idx, 1);
        // 2.2. 상단에 사람목록 삭제
        $("#addedParty" + code).remove();
        // 2.3. 선택한 사람의 숫자 보여주기
        updatePartyCount();
    }

    // x아이콘을 눌렀을 때 deleteParty & 체크박스해지
    function deleteToplist(code) {
        deleteParty(code);
        document.getElementById("checkbox" + code).checked = false;
    }

    function updatePartyCount() {
        if (checkArr.length == 0) {
            $("#searchAll").html("대화상대 선택");
            $('#confirm_btn').prop('disabled', true);
        } else {
            $("#searchAll").html("대화상대 선택 " + checkArr.length);
            $('#confirm_btn').prop('disabled', false);
        }
    }

    function closePopup() {
        window.open("about:blank", "_self").close();
    }

</script>
<script src="/resources/static/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
</body>
</html>