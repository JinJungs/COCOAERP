<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>진행중 문서</title>
    <style type="text/css">
        div{
            font-size: 16px;
        }
        select {
            min-width: 90px;
        }

        .row {
            margin-top: 10px;
        }
        .textBox{
            overflow:hidden;
            text-overflow:ellipsis;
            white-space:nowrap;
        }
        .item{
            background-color : #6749b930;
        }
        #list_contents:hover{
            background-color:  whitesmoke;
        }
		.row{
			margin-bottom: 10px;
		}
    </style>
</head>
<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">
        <h2 class="mb-4">진행중 문서</h2>
        <hr>
        <form method="post" id="searchform">
            <div class="search pb-2">
                <div class="row">
                    <div class="col-2 col-md-2">저장일</div>
                    <div class="col-9">
                        <input type="hidden" name="approver_code" value="${user}">
                        <input type=date class="date ml-1 mr-1" name=startDate id=start_date onblur="fn_insertdate()">
                        ~
                        <input type=date class="date ml-1 mr-1"  id=end_date onblur="fn_insertdate()">
                        <input type="hidden" id=temp name="endDate">
                        <span id="dateinvalidmsg"></span>
                    </div>

                </div>
                <div class="row">
                    <div class="col-2 mb-2">기안양식</div>
                    <div class="col-3 pl-3">
                        <select class="selectTemplate" name=template id="templateSelect">
                            <option value=전체>전체</option>
                            <c:forEach var="i" items="${tempList}">
                                <option value=${i.name}>${i.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="selectSearch col-2 mb-3">
                        <select name=searchOption id="searchOption">
                            <option value=title selected>기안제목</option>
                            <option value=writer >기안자</option>
                            <option value=dept >기안부서</option>
                        </select>
                    </div>

                    <div class="col-3 col-sm-2 mb-3 pl-3">
                        <input type="hidden">
                        <input type=text name=searchText value=>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 text-center">
                        <input type="hidden">
                        <input type=button class="btn btn-primary" value=조회 onclick="fn_btnsearch()">
                    </div>
                    <input type="hidden" name="cpage" id=cpage value="${cpage}">
                </div>
            </div>
        </form>
        <hr>
        <div class="documentList row text-center item p-2">
            <div class="col-1 col-sm-2"><b>양식</b></div>
            <div class="col-3 col-sm-2 d-none d-sm-block"><b>제목</b></div>
            <div class="col-1 col-sm-2"><b>기안자 | 부서</b></div>
            <div class="col-1 col-sm-2"><b>상신일</b></div>
            <div class="col-1 col-sm-2"><b>결재구분</b></div>
            <div class="col-1 col-sm-2"><b>결재대기</b></div>
        </div>

        <!-- 리스트 출력 부분 -->
        <div class="row  mt-0 p-0">
            <div class="col-12 listcontainer p-0" id="listcontainer">
                <c:forEach var="list" items="${list}">
                    <div class="row text-center m-0 pt-2 pb-2" id="list_contents">
                        <div class="col-1 col-sm-2 textBox">${list.temp_name}</div>
                        <div class="col-3 col-sm-2 d-none d-sm-block textBox text-left pl-4" style="cursor: pointer" onclick="fn_toread(${list.seq})">${list.title}</div>
                        <div class="col-1 col-sm-2 textBox">${list.emp_name } | ${list.dept_name}</div>
                        <div class="col-1 col-sm-2 textBox">${list.write_date }</div>
                        <div class="col-1 col-sm-2 textBox">결재</div>
                        <div class="col-1 col-sm-2">${list.con_empname} | ${list.con_deptname}</div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- 리스트 출력 부분 -->

        <%--<a href="/document/toReadPage.document?seq=${list.seq }">--%>

        <div class="row">
            <div class="navi col-12 text-center" id="navicontainer">${navi}</div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
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

    $(function() {
        $("#start_date").val(oma);
        $("#end_date").val(today);
    });

    $('input[type="text"]').keydown(function() {
        if (event.keyCode === 13) {
            event.preventDefault();
        };
    });

    function fn_insertdate(){
        var dayRegExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
        var start_date = $("#start_date").val();
        var end_date = $("#end_date").val();

        if(dayRegExp.test(start_date)==false) {
            $("#dateinvalidmsg").css("color", "red");
            $("#dateinvalidmsg").text("날짜 형식에 맞춰 작성해주세요. 예)"+today);
            $("#start_date").val("");
            return;
        }else if(dayRegExp.test(end_date)==false){
            $("#dateinvalidmsg").css("color", "red");
            $("#dateinvalidmsg").text("날짜 형식에 맞춰 작성해주세요. 예)"+today);
            $("#end_date").val("");
            return;
        }else{
            $("#dateinvalidmsg").text("");
            return;
        }

    }

    function fn_btnsearch(){
        var leave_start =$("#start_date").val().replaceAll("-","");
        var leave_end =$("#end_date").val().replaceAll("-","");
        var start = $("#start_date").val();
        var end = $("#end_date").val();
        var temp =end.split("-");
        var date = new Date(temp[0],temp[1]-1,temp[2]);
        var enddate = new Date(date.setDate(date.getDate()+1));
        var year = enddate.getFullYear();
        var month = enddate.getMonth()+1;
        var date = enddate.getDate();
        var today ="";
        if(month.toString().length==1&&date.toString().length==1) {
            today = year + "-0" + month + "-0" + date;
        }else if(month.toString().length==1){
            today =year + "-0" + month + "-" + date;
        }else{
            today =year + "-" + month + "-" + date;
        }
        $("#temp").val(today);

        if(leave_end!=""&&leave_start>leave_end){
            alert("종료일이 시작일보다 빠릅니다.");
            return;
        }else if(start==""){
            alert("시작일을 입력해주세요.");
            $("#start_date").focus();
            return;
        }else if(end==""){
            alert("종료일을 입력해주세요..");
            $("#end_date").focus();
            return;
        }
        var data = JSON.stringify($("#searchform").serializeArray());
        $.ajax({
            url:"/restdocument/searchNFdocument.document",
            type:"post",
            data:data,
            contentType:'application/json',
            dataType:"json",
            success: function (data) {
                $("#listcontainer").empty();
                html="";
                for(var i=0;i<data.length-1;i++){
                    html+="<div class=\"row text-center m-0 pt-2 pb-2\" id=\"list_contents\" >";
                    html+="<div class=\"col-1 col-sm-2 textbox\">"+data[i].temp_name+"</div>";
                    html+="<div class=\"col-3 col-sm-2 d-none d-sm-block textBox text-left pl-4\"  style=cursor:pointer onclick=fn_toread("+data[i].seq+")>"+data[i].title+"</div>";
                    html+="<div class=\"col-1 col-sm-2 textBox\">"+data[i].emp_name+" | "+data[i].dept_name+"</div>";
                    html+="<div class=\"col-1 col-sm-2 textBox\">"+data[i].write_date+"</div>";
                    html+="<div class=\"col-1 col-sm-2 textBox\">결재</div>";
                    html+="<div class=\"col-1 col-sm-2 textBox\">"+data[i].con_empname+" | "+data[i].con_deptname+"</div>";
                    html+="</div>";
                }
                $("#listcontainer").html(html);
                navi="";
                navindex=data.length-1;
                startNavi = data[navindex].startNavi;
                endNavi =data[navindex].endNavi;
                if(data[navindex].needPrev){
                    navi+="<a style=\"cursor:pointer\" onclick=fn_btnsearch2("+(startNavi-1)+") > < </a>";
                }
                for(var i=startNavi;i<=endNavi;i++){
                    navi+="<a style=\"cursor:pointer\" onclick=fn_btnsearch2("+i+")> "+i+" </a>";
                }
                if(data[navindex].needNext){
                    navi+="<a style=\"cursor:pointer\" onclick=fn_btnsearch2("+(endNavi+1)+") style=cursor:pointer> < </a>";
                }

                $("#navicontainer").empty();
                $("#navicontainer").append(navi);
            }
        });
    }

    function fn_btnsearch2(cpage){
        var leave_start =$("#start_date").val().replaceAll("-","");
        var leave_end =$("#end_date").val().replaceAll("-","");
        var start = $("#start_date").val();
        var end = $("#end_date").val();
        var temp =end.split("-");
        var date = new Date(temp[0],temp[1]-1,temp[2]);
        var enddate = new Date(date.setDate(date.getDate()+1));
        var year = enddate.getFullYear();
        var month = enddate.getMonth()+1;
        var date = enddate.getDate();
        var today ="";
        $("#cpage").val(cpage);
        if(month.toString().length==1&&date.toString().length==1) {
            today = year + "-0" + month + "-0" + date;
        }else if(month.toString().length==1){
            today =year + "-0" + month + "-" + date;
        }else{
            today =year + "-" + month + "-" + date;
        }
        $("#temp").val(today);

        if(leave_end!=""&&leave_start>leave_end){
            alert("종료일이 시작일보다 빠릅니다.");
            return;
        }else if(start==""){
            alert("시작일을 입력해주세요.");
            $("#start_date").focus();
            return;
        }else if(end==""){
            alert("종료일을 입력해주세요..");
            $("#end_date").focus();
            return;
        }
        var data = JSON.stringify($("#searchform").serializeArray());
        $.ajax({
            url:"/restdocument/searchNFdocument.document",
            type:"post",
            data:data,
            contentType:'application/json',
            dataType:"json",
            success: function (data) {
                $("#listcontainer").empty();
                html="";
                for(var i=0;i<data.length-1;i++){
                    html+="<div class=\"row text-center m-0 pt-2 pb-2\" id=\"list_contents\">";
                    html+="<div class=\"col-1 col-sm-2 textbox\">"+data[i].temp_name+"</div>";
                    html+="<div class=\"col-3 col-sm-2 d-none d-sm-block textBox text-left pl-4\" style=cursor:pointer onclick=fn_toread("+data[i].seq+")>"+data[i].title+"</div>";
                    html+="<div class=\"col-1 col-sm-2 textBox\">"+data[i].emp_name+" | "+data[i].dept_name+"</div>";
                    html+="<div class=\"col-1 col-sm-2 textBox\">"+data[i].write_date+"</div>";
                    html+="<div class=\"col-1 col-sm-2 textBox\">결재</div>";
                    html+="<div class=\"col-1 col-sm-2 textBox\">"+data[i].con_empname+" | "+data[i].con_deptname+"</div>";
                    html+="</div>";
                }
                $("#listcontainer").html(html);
                navi="";
                navindex=data.length-1;
                startNavi = data[navindex].startNavi;
                endNavi =data[navindex].endNavi;
                if(data[navindex].needPrev){
                    navi+="<a style=\"cursor:pointer\" onclick=fn_btnsearch2("+(startNavi-1)+") > < </a>";
                }
                for(var i=startNavi;i<=endNavi;i++){
                    navi+="<a style=\"cursor:pointer\" onclick=fn_btnsearch2("+i+")> "+i+" </a>";
                }
                if(data[navindex].needNext){
                    navi+="<a style=\"cursor:pointer\" onclick=fn_btnsearch2("+(endNavi+1)+") style=cursor:pointer> < </a>";
                }

                $("#navicontainer").empty();
                $("#navicontainer").append(navi);
            }
        });
    }

    function fn_toread(seq){
        location.href="/document/toReadPage.document?seq="+seq;
    }

</script>
</body>
</html>