<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>

    <meta charset='utf-8' />
    <title>근태</title>
</head>
<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="container-fluid p-4">
            <div class="row" >
                <div class="col-8" style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);">
                    <div class="row">
                        <div class="col-6">
                            <div class="row">
                                <div class="col-12"><b style="color:#9CA19F; font-size: 0.7rem;">출근 처리가 누락되었습니다.</b></div>
                            </div>
                            <div class="row">
                                <div class="col-12"><b><h4>권용국(부서)님</h4></b></div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="row">
                                <div class="col-12 text-right">
                                    <b style="color:#4C4C4C;font-size:0.7rem">오늘의 근무시간 09:00~18:00 (8H)</b>
                                </div>
                            </div>
                            <div class="row p-0">
                                <div class="col-12 text-right p-0 pr-2">
                                    <button class="btn btn-outline-dark btn-sm m-1">출근하기</button>
                                    <button class="btn btn-outline-dark btn-sm m-1">퇴근하기</button>
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" id="jb-checkbox" class="custom-control-input">
                                        <label class="custom-control-label" for="jb-checkbox">외근</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="row">
                        <div class="col-12">
                            <div class="alert alert-danger" role="alert">

                                <b class="mb-2">출근한 경우 근태 변경 요청을 하세요.</b>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
</script>
</body>
</html>