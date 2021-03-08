<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>

    <meta charset='utf-8' />
    <title>근태</title>
    <style>
        .attend_alert {
            display: flex;
            align-items: center;
            height: 76px;
            padding: 0 24px;
            border: 1px solid #ff8080;
            border-radius: 4px;
            box-sizing: border-box;
            color: #ff8080;
            background-color: snow;
        }
        .attend_alert:hover{
            background-color: whitesmoke;
        }

    </style>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="container-fluid" style="min-width: 900px;">
            <div class="row">
                <div class="col-12" id="top-container" style="border-bottom: 1px solid rgba(0, 0, 0, 0.125);">
                    <div class="row">
                        <div class="col-6">
                            <div class="row">
                                <div class="col-12"><b id=status-msg style="color:#9CA19F; font-size: 0.8rem;"></b></div>
                            </div>
                            <div class="row">
                                <div class="col-12"><b><h5 id="user-name">${empInfo.name}(${empInfo.posname})님</h5></b></div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="row">
                                <div class="col-12 text-right">
                                    <b style="color:#4C4C4C;font-size:0.7rem">근무시간 09:00~18:00 (8H)</b>
                                </div>
                            </div>
                            <div class="row p-0">
                                <div class="col-12 text-right p-0 pr-2">
                                    <button class="btn btn-outline-dark btn-sm m-1" id="btn_in"  onclick="fn_openInModal()">출근하기</button>
                                    <button class="btn btn-outline-dark btn-sm m-1" id="btn_out" onclick="fn_openOutModal()">퇴근하기</button>
                                    <div class="custom-control custom-checkbox">
                                        <form id="chkform">
                                            <input type="checkbox" id="jb-checkbox" name="out" value="out"> 외근
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4 d-none" id="late-container">
                    <div class="row">
                        <div class="col-12 ">
                            <a href="/attendance/toAtdReq" class="attend_alert"><b>정상 출근한 경우 근태 변경 요청을 하세요.</b></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row pt-2" >
                <div class="col-8 p-0">
                    <div class="card">
                        <div class="card-header">
                            <b>금주의 근무 현황</b><b id="totalatd"></b>
                        </div>
                        <div class="card-body">
                            <p class="card-text" id="barchart_div" >
                                <canvas  id="myChart" ></canvas>
                            </p>
                        </div>
                    </div>

                </div>

                <div class="col-4" >
                    <div class="card h-100 d-flex">
                        <div class="card-header">
                            <b id="monthatd">이달의 근무 현황</b>
                        </div>
                        <div class="card-body d-flex justify-content-center" id="nuchart_div" ">
                        <canvas class="m-0" id="myChartDoughnut" height="5" width="5"></canvas>

                    </div>
                </div>

            </div>
        </div>
        <div class="row pt-3">
            <div class="col-5 p-0">
                <div class="card">
                    <div class="card-header" onclick="fn_toAtdReq()" style="cursor: pointer;">
                        <b>근태 변경 요청 현황</b>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover" >
                            <thead>
                            <tr>
                                <th scope="col">날짜</th>
                                <th scope="col">사유</th>
                                <th scope="col">출퇴근 여부</th>
                                <th scope="col">상태</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="i" items="${reqList}">
                                <tr>
                                    <td>${i.today}</td>
                                    <td class="text-truncate" style="max-width: 220px;">${i.contents}</td>
                                    <td>${i.atd_status}</td>
                                    <td >${i.status}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<div class="modal fade" id="modal" tabindex="-1" role="dialog" data-backdrop="false" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
        <div class="modal-content">

            <div class="modal-body">
                <b id="workMsg"></b>
            </div>
            <div class="modal-footer border-top-0">
                <button type="button" class="btn btn-outline-primary btn-sm" id="btn_ok" data-dismiss="modal" onclick="fn_in()">네</button>
                <button type="button" class="btn btn-outline-dark btn-sm" data-dismiss="modal" >아니오</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade " id="resultModal" data-backdrop="false" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm" role="document" >
        <div class="modal-content">
            <div class="modal-body d-flex justify-content-center h-100 pt-5" style="min-height: 120px;">
                <b id="atdResultMsg">출근이 처리가 완료 되었습니다.</b>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/Chart.min.js"></script>
<script>

    // 결과
    var value = [];
    var getTotal =0;
    var getTotalMonth=0;
    var getTotalOverTimeMonth=0;

    // 오늘의 요일 및 날짜
    var currentDay = new Date();
    var theYear = currentDay.getFullYear();
    var theMonth = Number(currentDay.getMonth()) + 1;
    var theDate  = Number(currentDay.getDate());
    var theDay  = Number(currentDay.getDay());

    // 날짜 업데이트
    var newYear, newMonth, newDate;

    // 이번달 마지막날
    var nowLast = new Date ();
    nowLast.setMonth(nowLast.getMonth() + 1);
    var nowLastDay = new Date( nowLast.getYear(), nowLast.getMonth(), "");
    nowLastDay = nowLastDay.getDate();

    var lastDay; // 이전 달 마지막날 파악

    for (var i = -theDay; i < (theDay-7)*-1; i++){

        newYear = theYear;
        newDate = theDate;
        newMonth = theMonth;

        //첫주 일때
        if(theDate+i < 1){

            if(theMonth == 1){ // 1월 첫째주 일때
                lastDay = new Date(Number(currentDay.getFullYear())-1, Number(currentDay.getMonth())+12, "");
            } else { // 1월 첫째주가 아닐때
                lastDay = new Date(currentDay.getFullYear(), currentDay.getMonth(), "");
            }

            newYear = lastDay.getFullYear();
            newMonth = lastDay.getMonth();
            newDate = Number(lastDay.getDate())+i;

            //마지막주 일때
        } else if( theDate+i > nowLastDay) {

            if(theMonth == 12){ // 12월 마지막주 일때
                newYear = Number(theYear) + 1;
            }

            newMonth = Number(theMonth) + 1;
            newDate = i;

        }

        newDate = (newDate + i);

        // yyyy-mm-dd 형식으로
        if(String(newDate).length < 2){
            newDate = "0" + String(newDate);
        }
        if(String(newMonth).length < 2){
            newMonth = "0" + String(newMonth);
        }


        //이번주 7일의 날짜를 value에 담는다.
        value.push(newMonth + "-" + newDate);
    }


    $( function() {
        $.ajax({
            type : "POST",
            url : "/restattendance/getIsWork",
            success : function(data) {
                var curday= new Date();
                var hour = curday.getHours();
                var min = curday.getMinutes();
                if(hour.toString().length==1){
                    hour="0"+hour;
                }
                if(min.toString().length==1){
                    min="0"+min;
                }
                var hm =parseInt(hour.toString()+min.toString());
                var lateTime=740;
                if(data=="nw"){
                    $("#status-msg").text("아직 출근이 기록되지 않았습니다.");
                    if(hm>lateTime){
                        $("#late-container").attr("class","col-4");
                        $("#top-container").attr("class","col-8");
                    }else{
                        $("#late-container").attr("class","col-4 d-none");
                        $("#top-container").attr("class","col-12");
                    }
                }else{
                    var parseData= JSON.parse(data);
                    $("#status-msg").text("안녕하세요.");
                    if(parseData.status=="LATE"){
                        $("#late-container").attr("class","col-4");
                        $("#top-container").attr("class","col-8");
                    }else{
                        $("#late-container").attr("class","col-4 d-none");
                        $("#top-container").attr("class","col-12");
                    }
                }
            }
        });
        fn_reload();
    });

    function fn_reload(){
        fn_getAtdTime();
        nutchart();
    }

    function fn_getIsWork(){
        $.ajax({
            type : "POST",
            url : "/restattendance/getIsWork",
            success : function(data) {

                var curday= new Date();
                var hour = curday.getHours();
                var min = curday.getMinutes();
                if(hour.toString().length==1){
                    hour="0"+hour;
                }
                if(min.toString().length==1){
                    min="0"+min;
                }
                var hm =parseInt(hour.toString()+min.toString());
                var lateTime=930;
                if(data=="nw"){
                    $("#status-msg").text("아직 출근이 기록되지 않았습니다.");
                    if(hm>lateTime){
                        $("#late-container").attr("class","col-4");
                        $("#top-container").attr("class","col-8");
                    }else{
                        $("#late-container").attr("class","col-4 d-none");
                        $("#top-container").attr("class","col-12");
                    }
                }else{
                   var parseData= JSON.parse(data);
                    $("#status-msg").text("안녕하세요.");
                   if(parseData.status=="LATE"){
                       $("#late-container").attr("class","col-4");
                       $("#top-container").attr("class","col-8");
                   }else{
                       $("#late-container").attr("class","col-4 d-none");
                       $("#top-container").attr("class","col-12");
                   }
                }
            }
        });
    }

    function getHours(){
        var date = new Date();
        var hour = date.getHours();
        var min = date.getMinutes();
        var sec = date.getSeconds();
        var time ="";
        if(hour.toString().length==1){
            hour="0"+hour;
        }
        if(min.toString().length==1){
            min="0"+min;
        }
        if(sec.toString().length==1){
            sec="0"+sec;
        }
        time=hour+":"+min+":"+sec;
        return time;
    }

    function fn_getAtdTime() {

        $.ajax({
            type : "POST",
            url : "/restattendance/getAtdTime",
            dataType :"json",
            success : function(data) {
                $("#barchart_div").empty();
                var html="<canvas  id=myChart></canvas>"
                $("#barchart_div").append(html);
                var ctx = document.getElementById('myChart').getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: [''+value[0]+' 일',''+value[1]+' 월',''+value[2]+' 화',''+value[3]+' 수', ''+value[4]+' 목', ''+value[5]+' 금',''+value[6]+' 토'],
                        datasets: [{
                            label: '근무 시간',
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        },
                            {
                                label: '초과 근무',
                                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            },
                        ],
                    },
                    options: {
                        legend:{
                            display:true,
                            position: 'right'
                        },
                        responsive:true,
                        scales: {
                            xAxes:[{
                                stacked:true,
                            }],
                            yAxes: [{
                                stacked: true,
                                ticks: {
                                    suggestedMin :0,
                                    suggestedMax :15
                                }
                            }]
                        }
                    }
                });

                for(var j=0;j<data.length;j++) {
                    var getDate = data[j].start_time.substr(5,5);
                    if(data[j].end_time==null){
                        continue;
                    }
                    var getTime= data[j].end_time.substr(11,2)-data[j].start_time.substr(11,2);
                    if(getTime>=4){
                        getTime--;
                    }

                    for (var i = 0; i < value.length; i++) {
                        if (value[i] == getDate) {
                            if(getTime>8){
                                while(getTime>8){
                                    getTime--;
                                }
                            }
                            if(getTime<=0) {
                                continue;
                            }
                            myChart.data.datasets[0].data[i] = getTime;
                            myChart.data.datasets[1].data[i] = data[j].overtime;
                            myChart.update();
                            getTotal+=getTime+data[j].overtime;
                            continue;
                        }
                    }
                }
                $("#totalatd").text("("+getTotal+"H)");
                getTotal=0;
            }
        });
    }

    function nutchart(){
        $.ajax({
            type : "POST",
            url : "/restattendance/getMonthAtdTime",
            dataType :"json",
            success : function(data) {
                $("#nuchart_div").empty();
                var html="<canvas class=m-0 id=myChartDoughnut height=5 width=5></canvas>"
                $("#nuchart_div").append(html);
                var ctx2 = document.getElementById('myChartDoughnut').getContext('2d');
                var chart = new Chart(ctx2, {
                    // The type of chart we want to create
                    type: 'doughnut',

                    // The data for our dataset
                    data: {
                        labels: ['근무 시간','초과 근무'],
                        datasets: [{
                            label: 'My First dataset',
                            backgroundColor: ['rgba(54, 162, 235, 0.2)','rgba(255, 99, 132, 0.2)'],
                            data:[0,0],
                        }]
                    },

                    // Configuration options go here
                    options: {
                        layout: {
                            padding: {
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0
                            }
                        }
                    }
                });
                for(var i=0;i<data.length;i++){

                    var getTime= data[i].end_time.substr(11,2)-data[i].start_time.substr(11,2);
                    if(getTime>=4){
                        getTime--;
                    }
                    if(getTime>8){
                        while(getTime>8){
                            getTime--;
                        }
                    }
                    if(getTime<=0){
                        continue;
                    }
                    getTotalMonth+=getTime;
                    getTotalOverTimeMonth+=data[i].overtime;


                }
                chart.data.datasets[0].data[0] = getTotalMonth;
                chart.data.datasets[0].data[1] = getTotalOverTimeMonth;
                chart.update();
                getTotalMonth+=getTotalOverTimeMonth;
                if(getTotalMonth==0){
                    $("#monthatd").text('이달의 근무 현황');
                }else{
                    $("#monthatd").text('이달의 근무 현황('+getTotalMonth+'H)');
                }

                getTotalMonth=0;
                getTotalOverTimeMonth=0;
            }
        });
    }

    function fn_openInModal() {
        $("#btn_ok").attr("onclick","fn_in()");
        $.ajax({
            type : "POST",
            url : "/restattendance/isInWork",
            success : function(data) {
                if(data==""){
                    var time=getHours();
                    $("#modal").modal('show');
                    $("#workMsg").text("현재 시각:"+time+"입니다. 출근하시겠습니까?");
                }else{
                    $("#modal").modal('show');
                    $("#workMsg").text("이미 출근 기록이 있습니다. ("+data+") 다시 출근 처리하시겠습니까?");
                }
            }
        });
    }

    function fn_in() {
        var out = $("input[name='out']:checked").val();
        $.ajax({
            type : "POST",
            data : {out:out},
            url : "/restattendance/atdIn",
            success : function(data) {
                if(data=="updateSuccess") {
                    $("#resultModal").modal('show');
                    $("#atdResultMsg").text("출근 시간 변경이 완료되었습니다.");
                    var setTime = setTimeout(function () {
                        $("#resultModal").modal('hide');
                    },1000)
                    fn_getIsWork()
                    return;
                }
                if(data=="insertSuccess"){
                    $("#resultModal").modal('show');
                    $("#atdResultMsg").text("출근 처리가 완료 되었습니다.");
                    var setTime = setTimeout(function () {
                        $("#resultModal").modal('hide');
                    },1000)
                    fn_getIsWork();
                    return;
                }

            }
        });
    }

    function fn_openOutModal(){
        $("#btn_ok").attr("onclick","fn_out()");
        $.ajax({
            type : "POST",
            url : "/restattendance/isOutWork",
            success : function(data) {
                var date = new Date();
                var hour = date.getHours();
                var min = date.getMinutes();
                var sec = date.getSeconds();
                var time =hour+":"+min+":"+sec;

                if(data=="nyInWork"){
                    $("#resultModal").modal('show');
                    $("#atdResultMsg").text("출근 기록이 없습니다.");
                    var setTime = setTimeout(function () {
                        $("#resultModal").modal('hide');
                    },1000)
                    return;
                }

                if(hour<18 &&data==""){
                    var time=getHours();
                    $("#modal").modal('show');
                    $("#workMsg").text("아직 퇴근 시간이 아닙니다. ("+time+") 퇴근 처리 하시겠습니까?");
                    return;
                }

                if(data==""){
                    var time=getHours();
                    $("#modal").modal('show');
                    $("#workMsg").text("현재 시각:"+time+"입니다. 퇴근 처리 하시겠습니까??");
                }else{
                    $("#modal").modal('show');
                    $("#workMsg").text("이미 퇴근 기록이 있습니다. ("+data+") 다시 퇴근 처리하시겠습니까?");
                }
            }
        });
    }

    function fn_out(){
        $.ajax({
            type : "POST",
            url : "/restattendance/atdOut",
            success : function(data) {
                if(data=="updateSuccess") {
                    $("#resultModal").modal('show');
                    $("#atdResultMsg").text("퇴근 시간 변경이 완료되었습니다.");
                    var setTime = setTimeout(function () {
                        $("#resultModal").modal('hide');
                    },1000)
                    fn_reload();
                    return;
                }
                if(data=="insertSuccess"){
                    $("#resultModal").modal('show');
                    $("#atdResultMsg").text("퇴근 처리가 완료 되었습니다.");
                    var setTime = setTimeout(function () {
                        $("#resultModal").modal('hide');
                    },1000)
                    fn_reload();
                    return;
                }
            }
        });
    }

    function fn_toAtdReq() {
        location.href="/attendance/toAtdReq";
    }



</script>
</body>
</html>