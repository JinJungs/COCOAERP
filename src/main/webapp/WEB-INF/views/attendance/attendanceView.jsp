<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset='utf-8' />
    <link href='/lib/main.css' rel='stylesheet' />
    <script src='/lib/main.js'></script>
    <title>attendanceView</title>
<%--    <script>--%>
<%--        document.addEventListener('DOMContentLoaded', function() {--%>
<%--            var calendarEl = document.getElementById('calendar');--%>
<%--            var calendar = new FullCalendar.Calendar(calendarEl, {--%>
<%--                themeSystem: 'bootstrap'--%>
<%--            });--%>
<%--            calendar.render();--%>
<%--        });--%>
<%--    </script>--%>
</head>
<body>
    <div class="wrapper d-flex align-items-stretch">
        <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
        <div id="content" class="p-4 p-md-5 pt-5">
            <h2 class="mb-4 board_title">근태현황</h2>
            <div id='calendar'></div>
            <div id="attendanceForm">
                <form action="/attendance/startWork" method="post">
                    <button type="submit" onclick="fn_startWork()">출근</button>
                    <button type="button" onclick="fn_endWork()">퇴근</button>
                    <label> <input type="checkbox" name="outSide" id="outSide" value="out"> 외근 </label>
                </form>
            </div>
        </div>
    </div>
    <c:choose>
        <c:when test="${result eq 'success'}">
            <script>
                alert("출근 하였습니다.");
            </script>
        </c:when>
        <c:when test="${result eq 'already'}">
            <script>
                alert("이미 출근되어 있습니다.");
            </script>
        </c:when>
        <c:when test="${result eq 'offWork'}">
            <script>
                alert("퇴근되었습니다.");
            </script>
        </c:when>
        <c:when test="${result eq 'alreadyOff'}">
            <script>
                alert("이미 퇴근하였습니다.");
            </script>
        </c:when>
        <c:when test="${result eq 'workedYet'}">
            <script>
                alert("아직 출근하지 않았습니다.");
            </script>
        </c:when>
    </c:choose>
    <script>
        function fn_startWork() {
            location.href = "/attendance/startWork";
        }
        function fn_endWork() {
            location.href = "/attendance/endWork"
        }
        document.addEventListener('DOMContentLoaded', function (){
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'dayGridMonth,dayGridWeek,dayGridDay',
                    center: 'title',
                    right: 'prev,next'
                },

                local : "ko",
                navLinks: true,
                businessHours: true,
                editable: false,
                events: [
                        <c:forEach var="i" items="${attendance}" varStatus="status">
                        {
                            title: '출근',
                            start: '${i.start_time}'
                        },
                        </c:forEach>
                        <c:forEach var="i" items="${attendance}" varStatus="status">
                        {
                            title: '퇴근',
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
    </script>
</body>
</html>