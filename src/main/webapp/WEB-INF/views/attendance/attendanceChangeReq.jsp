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
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <h5><b>출퇴근 내역</b></h5>
                </div>
            </div>

            <div class="row ">
                <div class="col-12 p-2">
                    <table class="table" >
                        <thead>
                        <tr>
                            <th class="p-0 pl-2 pt-5 pb-5" scope="col">기간 선택</th>
                            <th class="p-0 pt-5 pb-5" scope="col">
                                <input type="date" id="search-start_time"> ~
                                <input type="date" id="search-end_time"></th>

                            <th class="p-0 pt-5 pb-5" scope="col">
                                출퇴근 여부 &nbsp
                                <select class="form-select" id="search-select" style="min-width: 250px;min-height: 30px">
                                    <option value="" selected>전체</option>
                                    <option value=IN>정상출근</option>
                                    <option value=LATE >지각</option>
                                    <option value=OUT >외근</option>
                                </select>
                                &nbsp
                                <button class="btn btn-outline-primary btn-sm" onclick="fn_search()">조회</button>
                            </th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div class="row text-right pb-1">
                <div class="col-12">
                    <select id="select-number" style="min-height: 30px; width: 60px; border-color: #c9c9c9" onchange="fn_changeNumber()">
                        <option selected>10</option>
                        <option>20</option>
                        <option>30</option>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-12 text-center">
                    <table class="table table-hover" style="cursor: pointer" >
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">날짜</th>
                            <th scope="col">출퇴근 여부</th>
                            <th scope="col">출근 시간</th>
                            <th scope="col">퇴근 시간</th>
                            <th scope="col">상태</th>
                        </tr>
                        </thead>
                        <tbody id="contents-container">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="modal fade " id="reqModal" data-backdrop="false" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document" >
        <div class="modal-content">
            <div class="modal-header border-bottom-0 p-0 pt-2 pr-2">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>

            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row p-2" >
                        <div class="col-12">
                            <b>출근 시간 변경</b>
                        </div>
                    </div>
                    <div class="row p-2">
                        <div class="col-3">날짜</div>
                        <div class="col-8" id="modal-date"></div>
                    </div>
                    <div class="row p-2 ">
                        <div class="col-3 pt-1">출근 시간</div>
                        <div class="col-8">
                            <select  name="startTime" style="min-height: 35px; min-width: 80px; border-radius: 5px" >
                                <c:forEach var="i"  begin="0" end="18">
                                    <option value="${i}">${i>9?i:'0'}${i>9?'':i}</option>
                                </c:forEach>
                            </select>
                            :
                            <select  name="endTime" style="min-height: 35px; min-width: 80px; border-radius: 5px">
                                <c:forEach var="i"  begin="0" end="60">
                                    <option value="${i}">${i>9?i:'0'}${i>9?'':i}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row  p-2">
                        <div class="col-3 pt-1">퇴근 시간</div>
                        <div class="col-8">
                            <select  id="startTime" name="startTime"  style="min-height: 35px; min-width: 80px; border-radius: 5px">
                                <c:forEach var="i"  begin="0" end="18">
                                    <option value="${i}">${i>9?i:'0'}${i>9?'':i}</option>
                                </c:forEach>
                            </select>
                            :
                            <select id="endTime" name="startTime" style="min-height: 35px; min-width: 80px; border-radius: 5px">
                                <c:forEach var="i"  begin="0" end="60">
                                    <option value="${i}">${i>9?i:'0'}${i>9?'':i}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row  p-2">
                        <div class="col-3">사유</div>
                        <div class="col-8" ><textarea class="w-100"  id="modal-contents" style="min-height: 150px; max-height: 150px;"></textarea></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-top-0">
                <button type="button" class="btn btn-outline-primary btn-sm" id="btn_ok" data-dismiss="modal">변경 요청</button>
                <button type="button" class="btn btn-outline-dark btn-sm" data-dismiss="modal" >취소</button>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/Chart.min.js"></script>
<script>

    var curdate = new Date();
    var year =curdate.getFullYear();
    var month =curdate.getMonth()+1;
    var date = curdate.getDate();
    var today ="";
    if(month.toString().length==1&&date.toString().length==1) {
        today = year + "-0" + month + "-0" + date;
    }else if(month.toString().length==1){
        today =year + "-0" + month + "-" + date;
    }else{
        today =year + "-" + month + "-" + date;
    }
    var oneMonthAgo = new Date(curdate.setMonth(curdate.getMonth()-1));
    var omayear = oneMonthAgo.getFullYear();
    var omamonth = oneMonthAgo.getMonth()+1;
    var omadate = oneMonthAgo.getDate();
    var oma = ""

    if(omamonth.toString().length==1&&omadate.toString().length==1){
        oma= omayear +"-0"+omamonth+"-0"+omadate;
    }else if(omamonth.toString().length==1){
        oma= omayear +"-0"+omamonth+"-"+omadate;
    }else{
        oma= omayear +"-"+omamonth+"-"+omadate;
    }

    $( function() {
        $("#search-start_time").val(oma);
        $("#search-end_time").val(today);
        fn_getAtdList();
    });

    function fn_openReqModal() {
        $.ajax({
            type : "POST",
            url : "/restattendance/isReq",
            success : function(data) {
                if(data!=null){
                    $("#reqModal").modal();
                }else{
                    $("#modal-contents").val(data.contents);
                    $("#reqModal").modal();
                }
            }
        });
    }

    function fn_getAtdList(){
        $.ajax({
            type : "POST",
            url : "/restattendance/getAtdList",
            data :{number:$("#select-number").val()},
            dataType:"json",
            success : function(data) {
                console.log(data);
                var html="";
                for(var i=0;i<data.length;i++){
                    html+="<tr onclick='fn_openReqModal("+data[i].seq+")'>";
                    html+="<td>"+(i+1)+"</td>";
                    html+="<td>"+data[i].today+"</td>";
                    html+="<td>"+data[i].status+"</td>";
                    html+="<td>"+data[i].sub_start_time+"</td>";
                    html+="<td>"+data[i].sub_end_time+"</td>";
                    html+="<td>"+data[i].req_status+"</td>";
                }
                $("#contents-container").empty();
                $("#contents-container").append(html);
            }
        });
    }

    function fn_search() {
        $.ajax({
            type : "POST",
            url : "/restattendance/search",
            data :{number:$("#select-number").val(),search:$("#search-select").val(),
                start_time:$("#search-start_time").val(),end_time:$("#search-end_time").val()},
            dataType:"json",
            success : function(data) {
                console.log(data);
                var html="";
                for(var i=0;i<data.length;i++){
                    html+="<tr onclick='fn_openReqModal("+data[i].seq+")'>";
                    html+="<td>"+(i+1)+"</td>";
                    html+="<td>"+data[i].today+"</td>";
                    html+="<td>"+data[i].status+"</td>";
                    html+="<td>"+data[i].sub_start_time+"</td>";
                    html+="<td>"+data[i].sub_end_time+"</td>";
                    html+="<td>"+data[i].req_status+"</td>";
                }
                $("#contents-container").empty();
                $("#contents-container").append(html);
            }
        });
    }

    function fn_changeNumber() {
        var isSearch = $("#search-select").val();
        if(isSearch==''){
            fn_getAtdList();
        }else{
            fn_search();
        }
    }
</script>
</body>
</html>