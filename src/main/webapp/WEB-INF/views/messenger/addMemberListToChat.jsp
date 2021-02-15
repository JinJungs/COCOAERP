<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<form name="formAddMember" id="formAddMember" methode="post">
    <input type="hidden" name="seq" value="${seq}">
    <input type="hidden" id="existingMemberNum" value="${fn:length(partyList)}">
    <div class="w-100 h-100 chat container-fluid p-0 min-w-450">
        <div class="row w-100 m-0">
            <!-- head -->
            <div class="card-header w-100 p-0 align-center memberList-header fixed-top" style="border-radius: 0%;">
                <div class="row w-100 ml-4 pt-3">
                    <div class="col-12 col-sm-10 col-md-9 col-lg-8">
                        <div class="row searchMenu">
                            <div class="col-12 p-0" id="searchAll">대화상대 선택</div>
                        </div>
                    </div>
                </div>
                <!-- 선택된 사람의 목록을 띄워주는 자리 -->
                <div class="row w-100 ml-4 pt-3" id="addedPartyBox"></div>
                <div class="input-group float-right col-10 col-sm-9 col-md-8 p-2">
                    <input type="text" placeholder="이름으로 검색" name=""
                           class="form-control search" id="searchContents">
                    <div class="input-group-prepend">
                  <span class="input-group-text search_btn" id="searchBtn"> <i
                          class="fas fa-search"></i>
                  </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- main -->
        <div class="row w-100 h70 m-0 p-4 border-top whiteBg">
            <div class="search_body w-100 m-0 pl-0 col-12 col-sm-10 col-md-9 col-lg-8">
                <!-- 전체 : 검색결과가 없는것은 가리고, 검색결과가 모두 없을 때는 코코아를 띄워주자-->
                <div class="container" id="memberAll"></div>
            </div>
        </div>
        <!-- footer -->
        <div class="row w-100 h15 m-0 pt-2 whiteBg fixed-bottom" style="border-top: 1px solid lightgray;">
            <div class="col-4"></div>
            <div class="col-2 m-0 p-0">
                <button class="btn-primary" id="confirm_btn" onclick="addChatRoom()" type="button">확인</button>
            </div>
            <div class="col-2 m-0 p-0">
                <button class="btn-primary" id="cancel_btn" onclick="closePopup()" type="button">취소</button>
            	<button class="btn-primary" id="confirm_btn_test" type="button">확인 버튼 테스트</button>

            </div>
            <div class="col-4"></div>
        </div>
    </div>
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    let memberAll = document.getElementById("memberAll");
    let existingMemberNum = $("#existingMemberNum").val();
    let checkArr = new Array();

    $(document).ready(function () {
        console.log("기존 멤버 수 : " + existingMemberNum);
        // ajax로 목록 불러오기
        searchAjax("");
        // partyList 확인해서 체크박스 체크 & 상단목록 띄우기
        // 체크박스는 해제할 수 없고, 상단 리스트를 삭제할 수도 없다.
        <c:forEach var="i" items="${partyList}">
        console.log("기존멤버 : " + ${i.emp_code});
        addExistingMembers(${i.emp_code}, "${i.empname}");
        disableCheckbox(${i.emp_code}) // 체크박스를 수정할 수 없도록 상태를 disabled로 수정
        </c:forEach>
    });

    // 체크박스를 수정할 수 없도록 상태를 disabled로 수정
    function disableCheckbox(code) {
        setTimeout(function () {
            $("#checkbox"+code).attr("disabled", true);
        }, 400);
    }

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
                // 멤버
                if (jArrayMember.length == 0) {
                    memberAll.innerHTML = "검색결과가 없습니다.";
                } else {
                    let html = "";
                    html += "<div class='row mb-2 m-0'></div>";
                    html += "<ui class='contacts m-0 p-0'>";
                    for (let i = 0; i < jArrayMember.length; i++) {
                        html += "<li class='con-list item'>";
                        html += "<div class='d-flex bd-highlight'>";
                        html += "<div class='img_cont'>";
                        html += "<a href='#'><img src='/img/profile-default.jpg' class='rounded-circle user_img'></a>";
                        html += "</div>";
                        html += "<a href='#'>";
                        html += "<div class='user_info item'>";
                        html += "<span>" + jArrayMember[i].name + "</span>";
                        html += "<p>" + jArrayMember[i].deptname + "/" + jArrayMember[i].teamname + "</p>";
                        html += "</div></a>";
                        html += "<div class='item ml-auto pb-4 align-self-center'>"
                        html += "<input class='form-check-input' id='checkbox" + jArrayMember[i].code + "' type='checkbox' name='emp_code' value='" + jArrayMember[i].code + "' onclick='updateChecklist(" + jArrayMember[i].code + ", \"" + jArrayMember[i].name + "\")'>";
                        html += "</div>"
                        html += "</div></li>";
                    }
                    html += "</ui>";
                    memberAll.innerHTML = html;
                    // 다시 검색해서 체크박스를 다시 쏴줄 때도 checkArr 들어있는 값을 value로 가지고 있는 체크박스라면 check를 채워준다.
                    setTimeout(function () {
                        for (let i = 0; i < jArrayMember.length; i++) {
                            let parsed = jArrayMember[i].code.toString();
                            if (checkArr.includes(parsed) || checkArr.includes(jArrayMember[i].code)) {
                                console.log("배열에 들어있나? : " + checkArr.includes(parsed));
                                document.getElementById("checkbox" + jArrayMember[i].code).checked = true;
                            }
                        }
                    }, 100);
                }
            }
        })
    }

    //========================체크박스 값 받기===================================

    //========================확인 후 부모창으로 값 전송============================
    document.getElementById("confirm_btn_test").addEventListener('click', getReturnValue);
    function getReturnValue(){
    	//alert("validAddList!");
    	console.log("checkArr in validAddList : ",checkArr);

        //체크된 사람이 0명이라면 넘겨주지 않기
        if (checkArr.length == 0) {
            alert("대화상대를 한 명 이상 선택해주세요.");
            return;
        }
        //!!이 부분 에러나서 주석처리했습니다!!
        //기존 멤버에서 추가된 사람이 없을 때
/*         if(checkArr.length <= existingMemberNum){
            return;
        } */

        try{
            opener.getReturnValue(JSON.stringify(checkArr)); // 부모창 함수 호출
        }catch(e){ // 부모 자식간의 연결이 끊어졌을 경우 처리
            alert('채팅방과 연결이 끊어졌습니다. 창을 닫고 다시 시도해주세요.');
        }
      	window.close();
    }
  	//========================확인 후 부모창으로 값 전송============================

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
        console.log("checkArr: "+checkArr);
    }

    // 기존멤버를 목록에 추가하기
    function addExistingMembers(code, name){
        // 1.1. 체크박스를 체크함
        setTimeout(function (){
            if(code !== ${loginDTO.code}){ //본인은 체크하지 말아야함
                document.getElementById("checkbox"+code).checked = true;
            }
        },400);
        // 1.2. 상단에 사람목록 추가 & x 아이콘 추가하지 않음
        let html = "";
        html += "<div class='col-2 ml-2 mb-2 addedParty' id='addedParty" + code + "'>";
        html += "<span>" + name + "</span>";
        html += "</div>";
        $("#addedPartyBox").append(html);
        // 1.3. 선택한 사람의 숫자 보여주기
        updatePartyCount();
    }

    // 1. 사람 목록에서 추가하기
    function addParty(code, name) {
        // 1.1. 배열에 추가
        checkArr.push(code);
        // 1.2. 상단에 사람목록 추가
        let html = "";
        html += "<div class='col-2 ml-2 mb-2 addedParty' id='addedParty" + code + "'>";
        html += "<span>" + name + "</span>";
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
        if(checkArr.length <= existingMemberNum){
            $("#searchAll").html("대화상대 선택 " + existingMemberNum);
            $('#confirm_btn').prop('disabled', true);
        } else {
            $("#searchAll").html("대화상대 선택 " + checkArr.length + existingMemberNum);
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