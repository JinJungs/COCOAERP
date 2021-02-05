<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset='utf-8' />
    <link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet' />
    <link href='https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.css' rel='stylesheet'>
    <link href='/fullcalendar/main.css' rel='stylesheet' />
    <script src='/fullcalendar/main.js'></script>
    <title>attendanceView</title>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                themeSystem: 'bootstrap'
            });
            calendar.render();
        });
    </script>
</head>
<body>
    <div class="wrapper d-flex align-items-stretch">
        <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
        <div id="content" class="p-4 p-md-5 pt-5">
            <h2 class="mb-4 board_title">근태현황</h2>
            <div id='calendar' class="p-4 p-md-5 pt-5"></div>
            <div id="attendanceForm">
                <button type="button" onclick="fn_startWork()">출근</button>
                <button type="button" onclick="fn_endWork()">퇴근</button>
            </div>
        </div>
    </div>
    <script>
        function fn_startWork() {
            location.href = "/attendance/startWork";
        }
        function fn_endWork() {
            location.href = "/attendance/endWork"
        }
    </script>
</body>
</html>