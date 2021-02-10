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
                    마이 페이지
                </div>
            </div>
            <div class="row  mt-3">
                <div class="col-12 text-center">
                    <img src="${profile}" style="width: 100px;height: 100px;">
                </div>
            </div>
            <div class="row  mt-3">
                <div class="col-10 p-3 text-right">

                </div>
            </div>
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
                    ${user.office_phone}
                </div>
            </div>
            <div class="row  mt-4">
                <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                    이메일
                </div>
                <div class="col-8 p-3 emp-contents" id="emp-email">
                    ${user.email}
                </div>
            </div>
            <div class="row  mt-4">
                <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                    회사 이메일
                </div>
                <div class="col-8 p-3 emp-contents" id="emp-office_email">
                    ${user.b_email}
                </div>
            </div>
            <div class="row  mt-4" style="border-bottom: 1px solid #c9c9c9">
                <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                    주소
                </div>
                <div class="col-8 p-3 emp-contents" id="emp-address">
                    ${user.address}
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-12 text-center">
                    <button type="button" class="btn btn-dark" onclick="fn_toModInfo()">정보 변경하기</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function fn_toModInfo() {
        location.href="/membership/myInfoModify/"
    }

</script>
</body>
</html>
