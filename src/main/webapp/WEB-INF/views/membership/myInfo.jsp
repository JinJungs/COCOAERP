<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>myInfo</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style type="text/css">
        div {border: 1px solid black}
    </style>
</head>
<body>
    <div class="wrapper d-flex align-items-lg-start">
        <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
        <div class="container">
            <div class="myCode">사번 :
                <input type="text" value=${loginDTO.code} readonly>
            </div>
            <div class="myName">이름 :
                <input type="text" value=${loginDTO.name} readonly>
            </div>
            <div class="myPhone">전화번호 :
                <input type="text" value=${loginDTO.phone} readonly>
            </div>
            <div class="myOfficePhone">사무실 번호 :
                <input type="text" value=${loginDTO.office_phone} readonly>
            </div>
            <div class="myAddress">주소 :
                <input type="text" value=${loginDTO.address} readonly>
            </div>
            <div class="myEmail">이메일 :
                <input type="text" value=${loginDTO.email} readonly>
            </div>
            <div class="myBeamil">사내 이메일 :
                <input type="text" value=${loginDTO.b_email} readonly>
            </div>
            <div class="myHireDate">입사일 :
                <input type="text" value=${loginDTO.hire_date} readonly>
            </div>

            <button type="submit" id="modify">내 정보 수정</button>
       </div>
    </div>
    <script>
        document.getElementById("modify").onclick = function (){
            location.href = "/membership/myInfoModify"
        }
    </script>
</body>
</html>