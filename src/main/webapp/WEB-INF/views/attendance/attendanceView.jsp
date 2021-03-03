<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <meta charset='utf-8' />
    <link href='/lib/main.css' rel='stylesheet' />
    <script src='/lib/main.js'></script>
    <title>attendanceView</title>
</head>
<body>
    <div class="wrapper d-flex align-items-stretch">
        <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
        <div id="content" class="p-4 p-md-5 pt-5">
            <h2 class="mb-4 board_title">근태현황</h2>
            <div id='calendar'></div>
        </div>
    </div>
<%--    <c:choose>--%>
<%--        <c:when test="${result eq 'success'}">--%>
<%--            <script>--%>
<%--                alert("출근 하였습니다.");--%>
<%--            </script>--%>
<%--        </c:when>--%>
<%--        <c:when test="${result eq 'already'}">--%>
<%--            <script>--%>
<%--                alert("이미 출근되어 있습니다.");--%>
<%--            </script>--%>
<%--        </c:when>--%>
<%--        <c:when test="${result eq 'offWork'}">--%>
<%--            <script>--%>
<%--                alert("퇴근되었습니다.");--%>
<%--            </script>--%>
<%--        </c:when>--%>
<%--        <c:when test="${result eq 'alreadyOff'}">--%>
<%--            <script>--%>
<%--                alert("이미 퇴근하였습니다.");--%>
<%--            </script>--%>
<%--        </c:when>--%>
<%--        <c:when test="${result eq 'workedYet'}">--%>
<%--            <script>--%>
<%--                alert("아직 출근하지 않았습니다.");--%>
<%--            </script>--%>
<%--        </c:when>--%>
<%--    </c:choose>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
                            start: '${i.start_time}',
                            <c:choose>
                                <c:when test="${i.status=='IN'}">
                                    title: '출근'
                                </c:when>
                                <c:when test="${i.status=='LATE'}">
                                    title: '지각'
                                </c:when>
                            </c:choose>
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
    <script src="/js/bootstrap.min.js"></script>
</body>
</html>