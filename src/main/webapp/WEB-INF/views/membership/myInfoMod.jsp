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
        .emp-contents{
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="container" style="max-width: 600px;">
            <div class="row" style="border-bottom: 1px solid #c9c9c9">
                <div class="col-10 p-2" style="font-size: 24px; font-weight: bold">
                    개인정보 변경
                </div>
            </div>
            <div class="row  mt-3">
                <div class="col-12 text-center">
                    <img id="profile" src="${profile}" style="width: 100px;height: 100px;">
                </div>
            </div>
            <div class="row  mt-3">
                <div class="col-3"></div>
                <div class="col-5 p-3 text-center">
                    <form id="fileForm">
                        <div class="input-group">
                            <input type="file" name="file" oninput="fn_modProfile(${user.code})">
                        </div>
                    </form>
                </div>
            </div>
            <form id="profileForm" action="/membership/modInfo" method="post">
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        사번
                    </div>
                    <div class="col-8 p-3 emp-contents" id="emp-code">
                        ${user.code}
                    </div>
                </div>
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        이름
                    </div>
                    <div class="col-8 p-3 emp-contents" id="emp-name">
                        ${user.name}
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        성별
                    </div>
                    <div class="col-8 p-3 emp-contents" id="emp-gender">
                        ${user.gender}
                    </div>
                </div>
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        입사일
                    </div>
                    <div class="col-8 p-3 emp-contents" id="emp-hire_date">
                        ${user.hire_date}
                    </div>
                </div>
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        부서 | 직급
                    </div>
                    <div class="col-8 p-3 emp-contents" id="emp-dept">
                        ${user.deptname}|${user.posname}
                    </div>
                </div>
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        내선 번호
                    </div>
                    <div class="col-8 p-3 emp-contents" id="emp-office_phone">
                        <input type="text" name="office_phone" value="${user.office_phone}">
                    </div>
                </div>
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        이메일
                    </div>
                    <div class="col-8 p-3 emp-contents" id="emp-email">
                        <input type="text" name=email value="${user.email}">
                    </div>
                </div>
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        회사 이메일
                    </div>
                    <div class="col-8 p-3 emp-contents" id="emp-office_email">
                        <input type="text" name="b_email" value="${user.b_email}">
                    </div>
                </div>
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        주소
                    </div>
                    <div class="col-5 p-3 emp-contents">
                        <input type="button" class="btn btn-dark" onclick="btn_findAddress()" value="우편번호 찾기">
                    </div>
                </div>
                <div class="row  mt-1">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                    </div>
                    <div class="col-8 p-3 emp-contents" >
                        <input type="text" class="w-100" name=address id="emp-address" value="${user.address}" placeholder="주소"><br>
                    </div>
                </div>
                <div class="row  mt-4">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                        현재 비밀번호
                    </div>
                    <div class="col-5 p-3 emp-contents" id="emp-password">
                        <input type="password" id="pw" onblur="fn_checkPw()" value="">
                    </div>
                    <div class="col-4 p-3 emp-contents" id="btn-modPw">
                        <button class="btn btn-dark" type="button" onclick="fn_modPw()">비밀번호 변경</button>
                    </div>
                </div>
                <input type="hidden" id=getCode name="code" value="${user.code}">
                <div class="row  mt-1" style="border-bottom: 1px solid #c9c9c9">
                    <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                    </div>
                    <div class="col-8 p-3 pt-0 emp-contents" id="pw-msg">

                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-6 text-right">
                        <button type="button" class="btn btn-dark" onclick="fn_toMyPage()">뒤로 가기</button>
                    </div>
                    <div class="col-6 text-left">
                        <button type="button" class="btn btn-dark" onclick="fn_modInfo()">정보 변경하기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal" id="myModal" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered" style="min-width: 600px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row w-100" style="border-bottom: 1px solid #c9c9c9">
                        <div class="col-10 p-2" style="font-size: 24px; font-weight: bold">
                            비밀번호 변경
                        </div>
                    </div>
                    <div class="row w-100 mt-4">
                        <div class="col-5 p-3" style="font-size: 18px; font-weight: bold">
                            변경 할 비밀번호
                        </div>
                        <div class="col-7 p-3 emp-contents" id="emp-gender">
                            <input type="password" class="w-100" id="modPw" onblur="fn_checkIsNullPw()">
                        </div>
                        <div class="col-5">

                        </div>
                        <div class="col-7" id="modPwmsg">
                            
                        </div>
                    </div>
                    <div class="row w-100 mt-4">
                        <div class="col-5 p-3" style="font-size: 18px; font-weight: bold">
                            비밀번호 확인
                        </div>
                        <div class="col-7 p-3 emp-contents" id="emp-hire_date">
                            <input type="password" class="w-100" id="checkModPw" onblur="fn_checkModPw()">
                        </div>
                        <div class="col-5">

                        </div>
                        <div class="col-7" id="check-modPwmsg">

                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-dark" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-dark"  onclick="fn_btnModPw()">확인</button>
            </div>
        </div>
    </div>
</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script>

    var clickBtn=0;

    function fn_toMyPage() {
        location.href="/membership/myInfo"
    }

    function fn_modInfo() {
        var pw =$("#pw").val();
        if(pw==""){
            $("#pw-msg").text("비밀번호를 입력해주세요.");
            $("#pw-msg").css("color","black");
            $("#pw-msg").focus();
            return;
        }

        $.ajax({
            type : "POST",
            url : "/membership/checkPw",
            data :{pw: pw},
            success : function(data) {
                if(data==1){
                    $("#pw-msg").text("비밀번호가 일치합니다.");
                    $("#pw-msg").css("color","blue");
                }else{
                    $("#pw-msg").text("비밀번호가 일치하지않습니다.");
                    $("#pw-msg").css("color","red");
                    $("#pw-msg").focus();
                    return;
                }

                $("#profileForm").submit();

            }
        });

    }

    function fn_checkPw() {
        var pw = $("#pw").val();
        $.ajax({
            type : "POST",
            url : "/membership/checkPw",
            data :{pw: pw},
            success : function(data) {
                if(data==1){
                    $("#pw-msg").text("비밀번호가 일치합니다.");
                    $("#pw-msg").css("color","blue");
                }else if(data==0){
                    $("#pw-msg").text("비밀번호가 일치하지않습니다.");
                    $("#pw-msg").css("color","red");
                }
                if(pw==""){
                    $("#pw-msg").text("비밀번호를 입력해주세요.");
                    $("#pw-msg").css("color","black");
                    $("#pw-msg").focus();
                    return;
                }

            }
        });


    }


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


    function fn_modProfile(code) {

        $.ajax({
            type : "POST",
            url : "/membership/modProfileAJAX",
            data :new FormData($("#fileForm")[0]),
            enctype: 'multipart/form-data',
            contentType: false,
            processData: false,
            success : function(data) {
                $("#profile").attr("src",data);
            }
        });
    }

    function fn_modPw(){
        var pw = $("#pw").val();
        $.ajax({
            type : "POST",
            url : "/membership/checkPw",
            data :{pw: pw},
            success : function(data) {
                if(pw==""){
                    $("#pw-msg").text("비밀번호를 입력해주세요.");
                    $("#pw-msg").css("color","black");
                    $("#pw-msg").focus();
                    return;
                }
                if(data==1){
                    $("#pw-msg").text("비밀번호가 일치합니다.");
                    $("#pw-msg").css("color","blue");
                    $("#myModal").modal();
                }else{
                    $("#pw-msg").text("비밀번호가 일치하지않습니다.");
                    $("#pw-msg").css("color","red");
                    $("#pw-msg").focus();
                    return;
                }

            }
        });

    }
    
    function fn_btnModPw() {
        var pw = $("#modPw").val();
        var check =$("#checkModPw").val();
        var code= $("#getCode").val();


        if(pw==""){
            $("#check-modPwmsg").text("");
            $("#modPwmsg").text("비밀번호를 입력해주세요.");
            $("#modPw").focus();
            return;
        }
        if(pw!=check){
            $("#check-modPwmsg").text("비밀번호와 일치하지않습니다.");
            $("#check-modPwmsg").css("color","red");
            $("#modPwmsg").text("");
            return;
        }else{
            $("#modPwmsg").text("");
        }


        $.ajax({
            type : "POST",
            url : "/membership/changePw",
            data :{code: code, password: pw},
            success : function(data) {
                $("#myModal").modal("hide");
                alert("변경되었습니다.");
                $("#modPwmsg").text("");
                $("#modPw").val("");
                $("#checkModPw").val("");
                $("#check-modPwmsg").text("");
            }
        });
    }

    function fn_checkModPw() {
        var pw = $("#modPw").val();
        var check =$("#checkModPw").val();
        if(pw!=check){
            $("#check-modPwmsg").text("비밀번호와 일치하지않습니다.");
            $("#check-modPwmsg").css("color","red");
            $("#modPwmsg").text("");
        }else{
            $("#check-modPwmsg").text("");
            $("#modPwmsg").text("");
        }
    }

    function fn_checkIsNullPw() {
        var pw = $("#modPw").val();
        if(pw==""){
            $("#check-modPwmsg").text("");
            $("#modPwmsg").text("비밀번호를 입력해주세요.");
            $("#modPw").focus();
            return;
        }
    }
</script>
</body>
</html>
