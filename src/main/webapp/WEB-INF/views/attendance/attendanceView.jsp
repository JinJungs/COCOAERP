<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset='utf-8' />
    <link href='/lib/main.css' rel='stylesheet' />
    <script src='/lib/main.js'></script>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
          integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
          crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
            crossorigin="anonymous"></script>
    <title>attendanceView</title>
    <style type="text/css">
        div {
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }
        #clock{
            width: 400px;
            height: 70px;
            line-height: 70px;
            color: #666;
            font-size: 36px;
        }
        .fc-toolbar-chunk {
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body onload="printClock()">
    <div class="wrapper d-flex align-items-stretch">
        <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
        <div id="content" class="p-4 p-md-5 pt-5">
            <h2 class="mb-4 board_title">근태현황 보기</h2>
<%--            <div class="row">--%>
                <div class="box attendance col-12 mb-3">
                    <div class="row">
                        <div class="col-12 col-sm-7" id="clock"></div>
<%--                        <div class="col text-left text-sm-right p-sm-3">--%>
                        <div class="text-center p-sm-3">
                            <div class="card bg-light">
                                <div class="card-header">
                                    <b>이번달 근태 현황 요약</b>
                                </div>
                                <div class="card-body">
                                    <ul class="list-group list-group-horizontal-sm">
                                        <li class="list-group-item" id="countLate">지각 :</li>
                                        <li class="list-group-item" id="countIn">출근 :</li>
                                        <li class="list-group-item" id="countWorkTime">총 근무 시간 :</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <div id='calendar'></div>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script>
        function printClock() {
            var clock = document.getElementById("clock");            // 출력할 장소 선택
            var currentDate = new Date();                                     // 현재시간
            var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
            var amPm = 'AM'; // 초기값 AM
            var currentHours = addZeros(currentDate.getHours(),2);
            var currentMinute = addZeros(currentDate.getMinutes() ,2);
            var currentSeconds =  addZeros(currentDate.getSeconds(),2);

            if(currentHours >= 12){
                amPm = 'PM';
                if(currentHours > 12){
                    currentHours = addZeros(currentHours - 12,2);
                }
            }

            clock.innerHTML = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size: 24px;'>"+ amPm+"</span>"; //날짜를 출력해 줌

            setTimeout("printClock()",1000);         // 1초마다 printClock() 함수 호출
        }

        function addZeros(num, digit) { // 자릿수 맞춰주기
            var zero = '';
            num = num.toString();
            if (num.length < digit) {
                for (i = 0; i < digit - num.length; i++) {
                    zero += '0';
                }
            }
            return zero + num;
        }

        document.addEventListener('DOMContentLoaded', function (){
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: '',
                    center: 'prev title next',
                    right: 'today'
                },

                locale : "ko",
                navLinks: true,
                businessHours: true,
                editable: false,
                events: [
                        <c:forEach var="i" items="${attendance}" varStatus="status">
                        {
                            start: '${i.start_time}',
                            <c:choose>
                                <c:when test="${i.status=='IN'}">
                                    title: '출근',
                                    color: 'blue',
                                </c:when>
                                <c:when test="${i.status=='LATE'}">
                                    title: '지각',
                                    color: 'yellow'
                                </c:when>
                                <c:when test="${i.status=='OUT'}">
                                    title: '외근',
                                    color: 'black'
                                </c:when>
                            </c:choose>
                        },
                        </c:forEach>
                        <c:forEach var="i" items="${attendance}" varStatus="status">
                        {
                            title: '퇴근',
                            color: 'gray',
                            start: '${i.end_time}'
                        }
                            <c:choose>
                            <c:when test="${status.last}">
                            </c:when>
                            <c:otherwise>
                            ,
                            </c:otherwise>
                            </c:choose>
                        </c:forEach>
                ]
            });
            calendar.render();
        });

        $(document).ready(function () {
            $.ajax({
                url: "/attendance/count",
                type: "post",
                data: {},
                dataType: "json",
                success: function (result) {
                    $("#countLate").html("지각 : "+result[0]+"번");
                    $("#countIn").html("출근 : "+result[1]+"번");
                    $("#countWorkTime").html("총 근무 시간 : "+result[2]+"시간 "+result[3]+"분");
                }
            })
        });
    </script>
    <script src="/js/bootstrap.min.js"></script>
</body>
</html>