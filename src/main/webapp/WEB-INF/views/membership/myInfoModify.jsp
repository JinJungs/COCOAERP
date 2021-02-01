<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>myInfoModify</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style type="text/css">
        div {border: 1px solid black}
    </style>
</head>
<body>
<div class="wrapper d-flex align-items-lg-start">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
    <div class="container">
        <form action="/membership/myInfoModifyDone" method="post" id="toModify">
            <div class="inputDiv">현재 비밀번호 :
                <input type="text" value=${loginDTO.password} readonly>
            </div>
            <div class="inputDiv">새 비밀번호 :
                <input type="text" id="password" name="password">
            </div>
            <div class="inputDiv">비밀번호 확인 :
                <input type="text" id="checkPassword" name="checkPassword">
            </div>
            <div class="inputDiv">성별 :
                <input type="text" id="gender" name="gender">
            </div>
            <div class="inputDiv">휴대폰 번호 :
                <input type="text" id="phone" name="phone">
            </div>
            <div class="inputDiv">주소 :
                <input type="text" id="address" name="address">
            </div>
            <div class="inputDiv">내선 번호 :
                <input type="text" id="office_phone" name="office_phone">
            </div>

            <button type="submit" id="modify">수정</button>
        </form>
    </div>
</div>
<script>
    // document.getElementById("modify").onclick = function (){
    //     location.href = "/membership/myInfoModify"
    // }
</script>
</body>
</html>