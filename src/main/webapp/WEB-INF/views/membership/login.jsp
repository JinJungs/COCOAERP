<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <meta charset="UTF-8">
    <%--<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />--%>
    <title>loginForm</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link href="https://getbootstrap.com/docs/4.0/examples/signin/signin.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <form class="form-signin" method="post" action="/membership/login">
        <h2 class="form-signin-heading">코코아 워크 로그인</h2>
        <p>
            <label for="code" class="sr-only">Username</label>
            <input type="text" id="code" name="code" class="form-control" placeholder="사번 입력" required="required"
                   autofocus="">
        </p>
        <p>
            <label for="password" class="sr-only">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호 입력"
                   required="required">
        </p>
        <p>
        <div class="chk_box">
            <div class="cb">
                <input type="checkbox" id="rememberId" name="rememberId"
                       value="아이디 기억">
                <label for="rememberId"> <b>아이디 기억하기</b> </label>
            </div>
            <div class="find">
                <a href="/membership/findId">아이디</a> / <a href="/membership/findPw">비밀번호 찾기</a>
            </div>
        </div>
        </p>
        <!--input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /-->
        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
    </form>
</div>
<c:if test="${result == 'F'}">
    <script>
        alert("로그인 실패");
    </script>
</c:if>

<!-- 아이디값 쿠키에 저장하기 -->
<script>
    $(document).ready(function () {
        // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
        var userInputId = getCookie("userInputId");
        $("input[id='code']").val(userInputId);

        if ($("input[id='code']").val() != "") {
            // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
            $("#rememberId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
        }

        $("#rememberId").change(function () { // 체크박스에 변화가 있다면,
            if ($("#rememberId").is(":checked")) { // ID 저장하기 체크했을 때,
                var userInputId = $("input[id='code']").val();
                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
            } else { // ID 저장하기 체크 해제 시,
                deleteCookie("userInputId");
            }
        });

        // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
        $("input[id='code']").keyup(function () { // ID 입력 칸에 ID를 입력할 때,
            if ($("#rememberId").is(":checked")) { // ID 저장하기를 체크한 상태라면,
                var userInputId = $("input[id='code']").val();
                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
            }
        });

        //쿠키를 위한 함수
        function setCookie(cookieName, value, exdays) {
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + exdays);
            var cookieValue = escape(value) + ((exdays == null) ? "" : ";expires=" + exdate.toGMTString());
            document.cookie = cookieName + "=" + cookieValue;
        }

        function deleteCookie(cookieName) {
            var expireDate = new Date();
            expireDate.setDate(expireDate.getDate() - 1);
            document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
        }

        function getCookie(cookieName) {
            cookieName = cookieName + '=';
            var cookieData = document.cookie;
            var start = cookieData.indexOf(cookieName);
            var cookieValue = '';
            if (start != -1) {
                start += cookieName.length;
                var end = cookieData.indexOf(';', start);
                if (end == -1) end = cookieData.length;
                cookieValue = cookieData.substring(start, end);
            }
            return unescape(cookieValue);
        }
    });
</script>
</body>
</html>