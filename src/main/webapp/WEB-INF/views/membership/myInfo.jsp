<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <meta charset="UTF-8">
    <title>findIdForm</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <style>
        .mod-input{
            border-color:rgba(0, 0, 0, 0.125);
        }
    </style>
</head>
<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="container" style="min-width: 847px;">
            <div class="row p-3" style="border: 1px solid rgba(0, 0, 0, 0.125);background: white; border-radius: 0.25rem;">
                <div class="col-12">
                    <b>프로필</b>
                </div>
            </div>
            <div class="row p-3" style="background:white; border-left: 1px solid rgba(0, 0, 0, 0.125);border-right: 1px solid rgba(0, 0, 0, 0.125); border-bottom: 1px solid rgba(0, 0, 0, 0.125);border-radius: 0.25rem;">
                <div class="col-12">
                    <div class="row">
                        <div class="col-2 pr-0" style="min-width: 147px;">
                            <div class="row">
                                <div class="col-3 p-0">
                                    <div class="row">
                                        <div class="col-12">
                                            <img id="profile" src="${profile}" style="height: 100px; width: 100px; border-radius: 50%">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 p-3">
                                            <form id="fileForm">
                                                <input type="hidden"  name="code" value="${user.code}">
                                                <label style="cursor: pointer;">
                                                    <input type="file" class="fileList"  id="file"
                                                           name="file" style="display: none" onchange="fn_modProfile()">
                                                    <button type="button" class="btn btn-outline-primary btn-sm"  onclick=document.all.file.click() >프로필 변경</button>
                                                </label>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="row">
                                <div class="col-12">
                                    <div class="row">
                                        <div class="col-3 p-2"><b>사원 번호</b></div>
                                        <div class="col-8 p-2"><b>${user.code}</b></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div class="row">
                                        <div class="col-3 p-2"><b>이름</b></div>
                                        <div class="col-8 p-2"><b>${user.name}</b></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row pt-3">
                <div class="col-12 p-0">
                    <div class="accordion" id="accordionExample" >
                        <div class="card">
                            <div class="card-header" id="headingOne"  style="background: white">
                                <h2 class="mb-0">
                                    <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" id="btn_Info">
                                        상세 정보
                                    </button>
                                </h2>
                            </div>
                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                                <div class="card-body">
                                    <div class="container" style="min-width: 847px;">
                                        <div class="row p-2">
                                            <div class="col-2">
                                                <b>성별</b>
                                            </div>
                                            <div class="col-9">
                                                <b>${user.gender}</b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2">
                                                <b>부서 | 직급</b>
                                            </div>
                                            <div class="col-9">
                                                <b>${user.deptname} | ${user.posname}</b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2">
                                                <b>전화 번호</b>
                                            </div>
                                            <div class="col-9">
                                                <b id="main-phone">${user.phone}</b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2">
                                                <b>내선 번호</b>
                                            </div>
                                            <div class="col-9">
                                                <b id="main-officephone">${user.office_phone}</b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2">
                                                <b>이메일</b>
                                            </div>
                                            <div class="col-9">
                                                <b id="main-email">${user.email}</b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2">
                                                <b>회사 이메일</b>
                                            </div>
                                            <div class="col-9">
                                                <b id="main-bemail">${user.b_email}</b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2">
                                                <b>주소</b>
                                            </div>
                                            <div class="col-9">
                                                <b id="main-address">${user.address}</b>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingTwo"  style="background: white">
                                <h2 class="mb-0">
                                    <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" id="btn_modInfo">
                                        상세 정보 변경
                                    </button>
                                </h2>
                            </div>
                            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                                <div class="card-body">
                                    <form id="profileForm">
                                        <input type="hidden" name="code" id="code" value="${user.code}">
                                        <div class="container mod-info" style="min-width: 847px;">
                                            <div class="row p-2">
                                                <div class="col-2 pt-1">
                                                    <b>전화 번호</b>
                                                </div>
                                                <div class="col-3">
                                                    <input class="w-100 mod-input" maxlength="30" name=phone type="text" value="${user.phone}">
                                                </div>
                                            </div>
                                            <div class="row p-2">
                                                <div class="col-2 pt-1">
                                                    <b>내선 번호</b>
                                                </div>
                                                <div class="col-3">
                                                    <input class="w-100 mod-input" maxlength="30" name=office_phone type="text" value="${user.office_phone}">
                                                </div>
                                            </div>
                                            <div class="row p-2">
                                                <div class="col-2 pt-1">
                                                    <b>이메일</b> <b data-bs-toggle="tooltip" data-bs-placement="top" title="비밀번호 찾기시 필요한 사항입니다. 사용중인 이메일을 입력해주세요."><img class="mb-3" id="tipicon" src="/icon/info-circle.svg" style="cursor: pointer"></b>
                                                </div>
                                                <div class="col-3">
                                                    <input class="w-100  mod-input" maxlength="50" name=email type="text" value="${user.email}">
                                                </div>
                                            </div>

                                            <div class="row p-2">
                                                <div class="col-2 pt-1">
                                                    <b>주소</b>
                                                </div>
                                                <div class="col-3">
                                                    <input class="w-100  mod-input" maxlength="100" name=address type="text" id="emp-address" value="${user.address}">
                                                </div>
                                                <div class="col-3 p-0">
                                                    <input type="button" class="btn btn-outline-dark btn-sm" onclick="btn_findAddress()" value="우편번호 찾기">
                                                </div>
                                            </div>
                                            <div class="row p-2">
                                                <div class="col-2 pt-1">
                                                    <b>현재 비밀번호 *</b>
                                                </div>
                                                <div class="col-3">
                                                    <input class="w-100  mod-input" type="password" id="pw">
                                                </div>
                                                <div class="col-4 p-0">
                                                    <b id="pw-msg"></b>
                                                </div>
                                            </div>
                                            <div class="row p-2">
                                                <div class="col-2 pt-1">

                                                </div>
                                                <div class="col-3">
                                                    <button type="button" class="btn btn-outline-primary" onclick="fn_modInfo()">변경 하기</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingThree" style="background: white">
                                <h2 class="mb-0">
                                    <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" id="btn_modPw">
                                        비밀번호 변경
                                    </button>
                                </h2>
                            </div>
                            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
                                <div class="card-body">
                                    <div class="container mod-info" style="min-width: 847px;">
                                        <div class="row p-2">
                                            <div class="col-2 pt-1">
                                                <b>현재 비밀번호</b>
                                            </div>
                                            <div class="col-3">
                                                <input class="w-100 mod-input" id="current-pw" type="password" onblur="fn_checkCurrentPw()">
                                            </div>
                                            <div class="col-4 p-0">
                                                <b id="current-pw-msg"></b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2 pt-1">
                                                <b>변경할 비밀번호</b>
                                            </div>
                                            <div class="col-3">
                                                <input class="w-100 mod-input" id="change-pw" type="password" onblur="fn_changePw()">
                                            </div>
                                            <div class="col-4 p-0">
                                                <b id="change-pw-msg"></b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2 pt-1">
                                                <b>비밀번호 확인</b>
                                            </div>
                                            <div class="col-3">
                                                <input class="w-100 mod-input" id=confirm-pw type="password" onblur="fn_checkConfirmPw()">
                                            </div>
                                            <div class="col-4 p-0">
                                                <b id="confirm-pw-msg"></b>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-2 pt-1">

                                            </div>
                                            <div class="col-3">
                                                <button type="button" class="btn btn-outline-primary" onclick="fn_modPw()">변경 하기</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade " id="alertModal" data-backdrop="false" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm" role="document" >
        <div class="modal-content">
            <div class="modal-body d-flex justify-content-center h-100 pt-5" style="min-height: 120px;">
                <b id="result-msg"></b>
            </div>
        </div>
    </div>
</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<%--<script src="/js/bootstrap.min.js"></script>--%>
<script>
    function btn_findAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    /*     document.getElementById("sample6_address").value = extraAddr;*/

                } else {
                    document.getElementById("emp-address").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("emp-address").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.

            }
        }).open();
    }

    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })


    function fn_closeAlertModal(){
        var setTime=setTimeout(function () {
            $("#alertModal").modal('hide');
        },1000)
    }



    function fn_modPw() {
        var currentPw = $("#current-pw").val();
        var changePw = $("#change-pw").val();
        var confirmPw = $("#confirm-pw").val();
        if(currentPw==""){
            $("#current-pw-msg").text("비밀번호를 입력해주세요.");
            $("#current-pw-msg").css("color","red");
            $("#pw").focus();
            return;
        }else{
            $("#current-pw-msg").text("");
        }
    }

    function fn_checkCurrentPw() {
        var currentPw = $("#current-pw").val();
        if(currentPw==""){
            $("#current-pw-msg").text("비밀번호를 입력해주세요.");
            $("#current-pw-msg").css("color","red");
            return;
        }else{
            $("#current-pw-msg").text("");
        }
        $.ajax({
            type : "POST",
            url : "/membership/checkPw",
            data :{pw: currentPw},
            success : function(data) {
                console.log(data);
                if(data==1){
                    $("#current-pw-msg").text("");
                    $("#current-pw-msg").css("color","blue");
                }else{
                    $("#current-pw-msg").text("비밀번호가 일치하지않습니다.");
                    $("#current-pw-msg").css("color","red");
                    return;
                }
            }
        });
    }

    function fn_checkConfirmPw() {
        var changePw = $("#change-pw").val();
        var confirmPw = $("#confirm-pw").val();
        if(changePw==""){
            $("#change-pw-msg").text("비밀번호를 입력해주세요.");
            $("#change-pw-msg").css("color","red");
            return;
        }else{
            $("#change-pw-msg").text("");
        }
        if(changePw!=confirmPw && confirmPw!=""){
            $("#confirm-pw-msg").text("비밀번호가 일치하지않습니다.");
            $("#confirm-pw-msg").css("color","red");
            return;
        }else{
            $("#confirm-pw-msg").text("");
        }
    }

    function fn_modPw(){
        var code= $("#code").val();
        var currentPw = $("#current-pw").val();
        var changePw = $("#change-pw").val();
        var confirmPw = $("#confirm-pw").val();
        if(currentPw==""){
            $("#current-pw-msg").text("비밀번호를 입력해주세요.");
            $("#current-pw-msg").css("color","red");
            return;
        }else{
            $("#current-pw-msg").text("");
        }
        $.ajax({
            type : "POST",
            url : "/membership/checkPw",
            data :{pw: currentPw},
            success : function(data) {
                if(data==1){
                    $("#current-pw-msg").text("");
                    $("#current-pw-msg").css("color","blue");
                }else{
                    $("#current-pw-msg").text("비밀번호가 일치하지않습니다.");
                    $("#current-pw-msg").css("color","red");
                    return;
                }

                if(changePw==""){
                    $("#change-pw-msg").text("비밀번호를 입력해주세요.");
                    $("#change-pw-msg").css("color","red");
                    return;
                }else{
                    $("#change-pw-msg").text("");
                }
                if(confirmPw==""){
                    $("#confirm-pw-msg").text("비밀번호를 입력해주세요.");
                    $("#confirm-pw-msg").css("color","red");
                    return;
                }
                if(changePw!=confirmPw){
                    $("#confirm-pw-msg").text("비밀번호가 일치하지않습니다.");
                    $("#confirm-pw-msg").css("color","red");
                    return;
                }else{
                    $("#confirm-pw-msg").text("");
                }

                $.ajax({
                    type : "POST",
                    url : "/membership/changePw",
                    data :{code: code, password: changePw},
                    success : function(data) {
                        $("#result-msg").text("변경이 완료되었습니다.")
                        $("#alertModal").modal();
                        fn_closeAlertModal();
                        $("#confirm-pw-msg").text("");
                        $("#change-pw-msg").text("");
                        $("#current-pw-msg").text("");
                        $("#current-pw").val("");
                        $("#change-pw").val("");
                        $("#confirm-pw").val("");
                    }
                });
            }
        });
    }

    function fn_changePw() {
        var changePw = $("#change-pw").val();

        if(changePw!=""){
            $("#change-pw-msg").text("");
        }

    }

    function fn_modProfile(code) {
        var get =$("#file").val();
        if(get==""){
            return;
        }
        $.ajax({
            type : "POST",
            url : "/membership/modProfileAJAX",
            data :new FormData($("#fileForm")[0]),
            enctype: 'multipart/form-data',
            contentType: false,
            processData: false,
            success : function(data) {
                $("#profile").attr("src",data);
                $("#result-msg").text("변경이 완료되었습니다.");
                $("#alertModal").modal();
                fn_closeAlertModal();

            }
        });
    }

    function fn_modInfo(){
        var pw =$("#pw").val();
        if(pw==""){
            $("#pw-msg").text("비밀번호를 입력해주세요.");
            $("#pw-msg").css("color","red");
            $("#pw").focus();
            return;
        }
        $.ajax({
            type : "POST",
            url : "/membership/checkPw",
            data :{pw: pw},
            success : function(data) {
                console.log(data);
                if(data!=1){
                    $("#pw-msg").text("비밀번호가 일치하지않습니다.");
                    $("#pw-msg").css("color","red");
                    $("#pw").focus();
                    return;
                }
                fn_modInfoAjax();
            }
        });

    }

    function decodeString(str){

        if(str.indexOf("+") > 0){

            return decodeURIComponent(decodeURI(str).replace(/\+/g, " "));

        } else {

            return decodeURIComponent(decodeURI(str));

        }

    }

    function fn_modInfoAjax(){
        console.log("도착?");
        $.ajax({
            type : "POST",
            url : "/membership/modInfoAjax",
            data :$("#profileForm").serialize(),
            dataType: "json",
            success : function(data) {

                if(data!=false){
                    $("#main-phone").text((data.phone));
                    $("#main-address").text(data.address);
                    $("#main-email").text(data.email);
                    $("#main-officephone").text(data.office_phone);
                    $("#result-msg").text("변경이 완료되었습니다.");
                    $("#alertModal").modal();
                    fn_closeAlertModal();
                    $("#collapseOne").collapse('show');
                    $("#pw").val("");

                }
            }
        });
    }

</script>
</body>
</html>
