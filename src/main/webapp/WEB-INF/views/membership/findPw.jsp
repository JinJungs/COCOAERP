<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>findPwForm</title>
</head>
<body>
    <div class="container">
        <div class="findPw">
            <input type="text" placeholder="이메일을 입력해주세요" id="email" name="email" required>
            <input type="text" placeholder="사번을 입력해주세요" id="code" name="code" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" required>
            <button type="button" onclick="findPw()">조회</button>
        </div>
        <div class="findFail" id="failDiv" style="display: none;">
            등록되지 않은 이메일 또는 사번입니다.
        </div>
        <div class="findSuccess" id="tempPwDiv" style="display: none;">
            <p>임시 비밀번호 : <input type="text" placeholder="임시 비밀번호" id="tempPw" name="tempPw" disabled> </p>
        </div>
        <button type="button" name="btnToLogin" id="btnToLogin" onclick="toLogin()">뒤로가기</button>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script>
        function findPw() {
            $.ajax({
                url: "/membership/findPwByEmail",
                type: "post",
                data: {
                    email: $("#email").val(),
                    code: $("#code").val()
                },
                dataType: "json",
                success: function (result) {
                    if(result.result == null) {
                        console.log(result);
                        $("#failDiv").css("display", "block");
                        //$("#tempPwDiv").css("display", "none");
                    }else {
                        console.log(result);
                        $("#tempPwDiv").css("display", "block");
                        $("#tempPw").val(result.result);
                    }
                }
            })
        }
        function toLogin() {
            location.href = "/";
        }
    </script>
</body>
</html>