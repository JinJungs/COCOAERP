<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

</head>
<body>

<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->

    <div id="content" class="p-4 p-5 pt-5">
        <div class="container w-80 p-0"  style="min-width: 900px;">
            <div class="row w-100">
                <h5>업무 ㅇㅇㅇ</h5>
            </div>
            <div class="row w-100" style="border-top: 1px solid pink; border-bottom: 1px solid pink;">
                <div class="col-2 p-3" style="border-right: 1px solid pink">기안 양식</div>
                <div class="col-4 p-3" style="border-right: 1px solid pink"></div>
                <div class="col-2 p-3" style="border-right: 1px solid pink">문서 번호</div>
                <div class="col-4 p-3">-</div>
            </div>
            <div class="row w-100" style= "border-bottom: 1px solid pink;">
                <div class="col-2 p-3" style="border-right: 1px solid pink">기안자</div>
                <div class="col-4 p-3" style="border-right: 1px solid pink"></div>
                <div class="col-2 p-3" style="border-right: 1px solid pink">기안 부서</div>
                <div class="col-4 p-3"></div> <%--로그인 받고 나중에 수정--%>
            </div>
            <div class="row w-100 pt-5" style="border-bottom: 1px solid pink;">
                <div class="col-10 p-0 pb-2"><b>결재선</b></div>
                <div class="col-2 p-0 text-right">
                </div>
            </div>
            <div class="row w-100 pt-4 pb-4 pl-3 pr-3" style="border-bottom: 1px solid pink;">
                결재선 들어갈 곳 나중에 ajax로
            </div>
            <div class="row w-100 pt-5 pb-2" style="border-bottom: 1px solid pink;">
                <b>기안 내용</b>
            </div>
            <div class="row w-100" style="border-bottom: 1px solid pink;">
                <div class="col-2 p-3" style="border-right: 1px solid pink;">기안 제목</div>
                <div class="col-10 p-3" >--제목--</div>
            </div>
            <div class="row w-100">
                <div class="col-2 p-3" style="border-right: 1px solid pink;">첨부 파일</div>
                <div class="col-3 p-3"></div>
            </div>
            <div class="row w-100" style="border-bottom: 1px solid pink;">
                <div class="col-2 p-3"  style="border-right: 1px solid pink;"></div>
                <div class="col-9 p-3" id="filecontainer"></div>
            </div>

            <div class="row w-100 pt-3">
                <div class="col-12">--내용--</div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid p-0" style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow:0 -2px 7px rgba(0,0,0,.15); min-height: 80px;">
    <div class="row">
        <div class="col-6 p-3 text-right"><button class="btn btn-secondary">임시저장</button></div>
        <div class="col-6 p-3 "><button class="btn btn-dark">상신하기</button></div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
</body>
</html>