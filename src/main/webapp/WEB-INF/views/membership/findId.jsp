<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <meta charset="UTF-8">
    <title>findIdForm</title>
</head>
<body>
<div class="container">
    <form class="findId" method="post" action="/membership/findIdByEmail">
        <div class="findId">
            <input type="text" placeholder="이메일을 입력해주세요" id="email" name="email">
            <button type="button" onclick="findId()">조회</button>
            <p>조회한 결과 : <input type="text" placeholder="결과" id="result" name="result" disabled> </p>
            <button type="button" name="btnToLogin" id="btnToLogin" onclick="toLogin()">뒤로가기</button>
        </div>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
    function findId() {
        $.ajax({
            url: "/membership/findIdByEmail",
            type: "post",
            data: {email: $("#email").val()},
            dataType: "json",
            success: function (result) {
                if(result.result == null) {
                    $("#result").val("등록되지 않은 이메일");
                    $("#btnToLogin").text("뒤로가기");
                }else {
                    $("#result").val(result.result);
                    $("#btnToLogin").text("로그인");
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