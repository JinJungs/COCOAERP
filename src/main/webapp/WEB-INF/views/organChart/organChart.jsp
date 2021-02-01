<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.js"></script>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="container">
            <div class="row w-100">
                <div class="col-3" style="border: 1px solid #c9c9c9">
                    <div class="row w-100 left-top">
                        <div class="col-12 m-2"><h5>조직도</h5></div>
                    </div>
                    <div class="row w-100 left-header">
                        <div class="col-3 m-2">이름</div>
                        <div class="col-7 m-2 text-right">부서/소속팀</div>
                    </div>
                </div>
                <div class="col-8" style="border: 1px solid #c9c9c9">
                    <div class="row right-top">
                        <div class="col-12 text-right"><input class="m-2" type="text" placeholder="검색어를 입력해주세요."> </div>
                    </div>
                    <div class=""
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>