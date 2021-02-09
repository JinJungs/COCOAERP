<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.js"></script>
    <style>
        .deptcontainer, .teamst, .r-teammain, .searchchild, .topcontainer{
            cursor: pointer;
        }
        .deptcontainer:hover, .teamst:hover, .r-teammain:hover,.searchchild:hover, .topcontainer:hover{
            background-color: lightgrey;
        }
        #search{
            height: 40px;
            width: 270px;
            border: none;
            border: 1px solid #c9c9c9;
        }
        .imgbox{
            height: 80%;
            background-repeat: no-repeat;
            background-position: center;
            background-image: url("/img/cocoa2.png");
            background-size: 400px;
            opacity: 0.2;
        }
        .search{
            max-width: 320px;
            min-width: 320px;
            left:15px;
            z-index: 10;
        }
        .searchchild{
            background-color: white;
            right: 10px;
        }
        .emp-contents{
            font-size: 18px;
            font-weight: bold;
        }
        .r-container{
            border-top: 1px solid #333;
            border-bottom: 1px solid #333;
            border-right: 1px solid #333;
            min-width: 800px;
            max-height: 800px;
            overflow-y: auto;
        }
        .user-name{
            cursor: pointer;
        }
        .icon{
            cursor: pointer;
        }
        .icon:hover{
            width: 32px;
            height: 32px;
        }

        .modalemailicon, .modalchaticon{
            width: 28px;
            height: 28px;
        }

    </style>
</head>
<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="container-fluid">
            <div class="row">
                <div class="col-5 p-3" style="font-size: 32px; font-weight: bold">조직도</div>
                <div class="col-4 p-0 pt-3 text-right position-relative">
                </div>
                <div class="col-3 p-0 pt-3">
                    <input class="mt-2" type="text" id="search" placeholder="부서 및 이름을 검색하세요." autocomplete=off>
                    <div class="row search  p-2 mt-1 position-absolute">


                    </div>

                </div>

                <div class="row w-100" style="min-width: 1280px;min-height: 800px;" >
                    <div class="col-3 p-4 " style="border: 1px solid #333; max-width: 400px;">
                        <div class="row pb-3" style="border-bottom: 1px solid #333; ">
                            <div class="col-6  user-name" style="font-size: 18px;font-weight: bold" onclick="fn_getEmpInfo(${user.code})">${user.name} | ${user.posname}</div>
                            <div class="col-6 text-right" style="font-size: 14px;line-height: 28px;color:darkgrey">${user.deptname} | ${user.teamname}</div>
                        </div>
                        <form id="leftform">
                            <div class="row pt-2">
                                <div class="col-12 pl-1 topcontainer" onclick="fn_openDeptList(${top.code})"><img src="/icon/plus-square.svg"><span class="pl-1">${top.name}</span></div>
                            </div>
                            <c:forEach var="dlist" items="${dlist}">
                                <div class="row mt-2 deptcontainer d-none" id="deptcontainer${dlist.code}" onclick="fn_openteamlist(${dlist.code})">
                                    <div class="col-12">
                                        <img src="/icon/plus-square.svg">
                                        <span>${dlist.name}</span>
                                        <input type="hidden" name="code" value="${dlist.code}">
                                    </div>
                                </div>
                            </c:forEach>
                        </form>
                    </div>
                    <div class="col-9  r-container">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="myModal" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered" style="min-width: 600px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row w-100" style="border-bottom: 1px solid #c9c9c9">
                        <div class="col-10 p-2" style="font-size: 24px; font-weight: bold">
                            상세 정보
                        </div>
                        <div class="col-1 pt-3">
                            <img class="icon modalemailicon" src="/icon/envelope-fill.svg/">
                        </div>
                        <div class="col-1 pt-3">
                            <img class="icon modalchaticon"  src="/icon/chat-full.svg/">
                        </div>
                    </div>
                    <div class="row w-100 mt-3">
                        <div class="col-12 text-center">
                            <img src="/img/Profile-m.png" style="width: 100px;height: 100px;">
                        </div>
                    </div>
                    <div class="row w-100 mt-3">
                        <div class="col-10 p-3 text-right">

                        </div>
                    </div>
                    <div class="row w-100 mt-4">
                        <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                            이름
                        </div>
                        <div class="col-8 p-3 emp-contents" id="emp-name">

                        </div>
                    </div>
                    <div class="row w-100 mt-4">
                        <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                            성별
                        </div>
                        <div class="col-8 p-3 emp-contents" id="emp-gender">

                        </div>
                    </div>
                    <div class="row w-100 mt-4">
                        <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                            입사일
                        </div>
                        <div class="col-8 p-3 emp-contents" id="emp-hire_date">

                        </div>
                    </div>
                    <div class="row w-100 mt-4">
                        <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                            부서 | 직급
                        </div>
                        <div class="col-8 p-3 emp-contents" id="emp-dept">

                        </div>
                    </div>
                    <div class="row w-100 mt-4">
                        <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                            내선 번호
                        </div>
                        <div class="col-8 p-3 emp-contents" id="emp-office_phone">

                        </div>
                    </div>
                    <div class="row w-100 mt-4">
                        <div class="col-3 p-3" style="font-size: 18px; font-weight: bold">
                            회사 이메일
                        </div>
                        <div class="col-8 p-3 emp-contents" id="emp-office_email">

                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-dark" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>



<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/jquery.MultiFile.min.js"></script>
<script src="/js/bindWithDelay.js"></script>
<script>
    var beforeCode=0;
    var beforeSearchCode=0;
    var beforeSearchTeamCode=0

 /*채팅 메일 담당자분 여기다가 작업하시면 됩니다.*/
    function  fn_clickemail(code) {
        alert("메일 클릭"+code);
    }
    function fn_clickChat(code) {
        window.open('/messenger/openCreateSingleChat?partyEmpCode='+code,'','width=450px,height=660px,location=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,fullscreen=yes');
    }

    $( function() {
        fn_getTeamList();
        fn_getAllEmpList();
    });

    $("#search").bindWithDelay("keyup", function (e) {
        $(".search").attr("class","row search p-2 mt-1 position-absolute d-none");
        $(".search").empty();

        if($("#search").val()==""){
            return;
        }
        fn_getSearchTeam();
        $.ajax({
            type : "POST",
            url : "/restorganchart/getSearchList.organ",
            data : {name: $("#search").val()},
            dataType :"json",
            success : function(data) {
                var dept="";
                for(var i=1;i<data.length;i=i+2)
                    for(var j=0;j<data[i].length;j++){
                        dept+="<div class='col-12 searchchild p-2' onclick=fn_clickDeptSearch("+data[i][j].code+")>";
                        dept+="<div class=row>";
                        dept+="<div class=col-12 style='font-size:16px; font-weight: bold'>";
                        dept+=""+data[i][j].name+"("+data[i][j].count+")";
                        dept+="</div>";
                        dept+="</div>";
                        dept+="<div class=row>";
                        dept+="<div class=col-12>";

                        dept+="　";
                        dept+="</div>";
                        dept+="</div>";
                        dept+="</div>";
                    }
                var emp="";
                for(var i=0;i<data.length;i=i+2){
                    for(var j=0;j<data[i].length;j++){
                        emp+="<div class='col-12 searchchild p-2' onclick=fn_clicksearch("+data[i][j].code+")>";
                        emp+="<div class=row>";
                        emp+="<div class=col-12 style='font-size:16px; font-weight: bold'>";
                        emp+=""+data[i][j].name+"";
                        emp+="</div>";
                        emp+="</div>";
                        emp+="<div class=row>";
                        emp+="<div class=col-12>";
                        emp+=""+data[i][j].deptname+" | "+data[i][j].posname+"";
                        emp+="</div>";
                        emp+="</div>";
                        emp+="</div>";
                    }
                }
                fn_getSearchTopDept();
                $(".search").prepend(dept);
                $(".search").append(emp);
                $(".search").attr("class","row search p-2 mt-1 position-absolute");



            }
        });
    }, 400);

    $("#search").bindWithDelay("blur", function (e) {
        $(".search").empty();

    }, 200);

    function fn_clickEmp(code){
        fn_getEmpInfo(code);
    }

    function fn_clicksearch(code){
        fn_getEmpInfo(code);

    }
    function fn_clickTopDeptSearch(code){
        $("#teamcontainer"+beforeSearchTeamCode).css("color","black");
        $("#deptcontainer"+beforeSearchCode).css("color","black");
        $(".topcontainer").css("color","blue");
        fn_getAllEmpList();
    }

    function fn_clickDeptSearch(code) {
        var getClass = $("#deptcontainer"+code).attr("class");
        if(getClass=="row mt-2 deptcontainer d-none"){
            $(".teamWrapper").attr("class","row teamWrapper");
            $(".deptcontainer").attr("class","row mt-2 deptcontainer");
            $(".topcontainer").attr("onclick","fn_closeDeptList()");
            $(".topcontainer").find("img").attr("src","/icon/dash-square.svg/");
        }
        $("#teamcontainer"+beforeSearchTeamCode).css("color","black");
        $("#deptcontainer"+beforeSearchCode).css("color","black");
        $(".topcontainer").css("color","black");
        fn_getDeptEmpList(code);
        $("#deptcontainer"+code).css("color","blue");
        beforeSearchCode=code;
    }

    function fn_getSearchTopDept() {
        $.ajax({
            type : "POST",
            url : "/restorganchart/getSearchTopDept.organ",
            data : {name: $("#search").val()},
            dataType :"json",
            success : function(data) {
                var emp = "";
                if (data.count!=undefined) {
                    emp += "<div class='col-12 searchchild p-2' onclick=fn_clickTopDeptSearch(" + data.code + ")>";
                    emp += "<div class=row>";
                    emp += "<div class=col-12 style='font-size:16px; font-weight: bold'>";
                    emp += "" + data.name + "(" + data.count + ")";
                    emp += "</div>";
                    emp += "</div>";
                    emp += "<div class=row>";
                    emp += "<div class=col-12>";
                    emp += "　";
                    emp += "</div>";
                    emp += "</div>";
                    emp += "</div>";
                    $(".search").prepend(emp);
                }
            }
        });
    }
    function fn_getSearchTeam(){
        $.ajax({
            type : "POST",
            url : "/restorganchart/getSearchTeamList.organ",
            data : {name: $("#search").val()},
            dataType :"json",
            success : function(data) {
                var emp = "";
                for(var i=0;i<data.length;i++){
                    emp += "<div class='col-12 searchchild p-2' onclick=fn_clickTeamSearch(" + data[i].code + ")>";
                    emp += "<div class=row>";
                    emp += "<div class=col-12 style='font-size:16px; font-weight: bold'>";
                    emp += "" + data[i].name + "(" + data[i].count + ")";
                    emp += "</div>";
                    emp += "</div>";
                    emp += "<div class=row>";
                    emp += "<div class=col-12>";
                    emp += "　";
                    emp += "</div>";
                    emp += "</div>";
                    emp += "</div>";

                }
                $(".search").append(emp);
            }
        });
    }



    function fn_getEmpInfo(code){
        $.ajax({
            type: "POST",
            url: "/restorganchart/getEmpInfo.organ",
            data:{code: code},
            dataType: "json",
            success: function (data) {
                $(".modalemailicon").attr("onclick","fn_clickemail("+data.code+")");
                $(".modalchaticon").attr("onclick","fn_clickChat("+data.code+")");
                $("#emp-name").text(data.name);
                $("#emp-hire_date").text(data.hire_date);
                if(data.gender=='M'){
                    $("#emp-gender").text("남");
                }else{
                    $("#emp-gender").text("여");
                }
                $("#emp-dept").text(data.deptname+" | "+data.posname);
                $("#emp-office_phone").text(data.office_phone);
                $("#emp-office_email").text(data.b_email);
                $("#myModal").modal();
            }
        });
    }



    function fn_getTeamList() {
        $.ajax({
            type: "POST",
            url: "/restorganchart/getteamlist.organ",
            data: $("#leftform").serialize(),
            dataType: "json",
            success: function (data) {
                var html = "";
                for (var i = 0; i < data.length; i++) {
                    html += "<div class='row teamWrapper'>";
                    html += "<div class=col-12>";
                    html += "<div class=\"row mt-2 teamst teamcontainer" + data[i].dept_code + " d-none\" id=teamcontainer"+data[i].team_code+" onclick=fn_getteamemplist(" + data[i].team_code + ")>";
                    html += "<div class=col-1></div>"
                    html += "<div class=\"col-5 p-0\">";
                    html += "<span class='pr-2'>" + data[i].team_name + "<span><span class='pl-1'> (" + data[i].count + ")</span>";
                    html += "</div>";
                    html += "</div>";
                    html += "</div>";
                    html += "</div>";
                    $("#deptcontainer"+data[i].dept_code).after(html);
                    html="";
                }
            }
        });
    }



    function fn_openteamlist(code) {
        $(".topcontainer").css("color","black");
        $("#teamcontainer"+beforeSearchTeamCode).css("color","black");
        $("#deptcontainer"+beforeSearchCode).css("color","black");
        $(".teamcontainer"+code).attr("class","row mt-2 teamst teamcontainer"+code+"");
        $("#deptcontainer"+code).attr("onclick","fn_closeteamlist("+code+")");
        $("#deptcontainer"+code).find("img").attr("src","/icon/dash-square.svg/");
        $("#deptcontainer"+code).css("color","blue");
        beforeSearchCode=code;
        fn_getDeptEmpList(code);

    }
    function fn_closeteamlist(code){
        $(".topcontainer").css("color","black");
        $("#teamcontainer"+beforeSearchTeamCode).css("color","black");
        $("#deptcontainer"+beforeSearchCode).css("color","black");
        $(".teamcontainer"+code).attr("class","row teamst d-none mt-2 teamcontainer"+code+" d-none");
        $("#deptcontainer"+code).attr("onclick","fn_openteamlist("+code+")");
        $("#deptcontainer"+code).find("img").attr("src","/icon/plus-square.svg/");
        $("#deptcontainer"+code).css("color","blue");
        beforeSearchCode=code;
        fn_getDeptEmpList(code);
    }

    function fn_openDeptList(code) {
        $(".topcontainer").css("color","blue");
        $("#teamcontainer"+beforeSearchTeamCode).css("color","black");
        $("#deptcontainer"+beforeSearchCode).css("color","black");
        $(".teamWrapper").attr("class","row teamWrapper");
        $(".deptcontainer").attr("class","row mt-2 deptcontainer");
        $(".topcontainer").attr("onclick","fn_closeDeptList()");
        $(".topcontainer").find("img").attr("src","/icon/dash-square.svg/");
        fn_getAllEmpList(code);
    }

    function fn_closeDeptList(code) {
        $(".topcontainer").css("color","blue");
        $("#teamcontainer"+beforeSearchTeamCode).css("color","black");
        $("#deptcontainer"+beforeSearchCode).css("color","black");
        $(".teamWrapper").attr("class","row teamWrapper d-none");
        $(".deptcontainer").attr("class","row mt-2 deptcontainer d-none");
        $(".topcontainer").attr("onclick","fn_openDeptList()");
        $(".topcontainer").find("img").attr("src","/icon/plus-square.svg/");
        fn_getAllEmpList(code);
    }

    function fn_clickTeamSearch(code){
        $("#teamcontainer"+beforeSearchTeamCode).css("color","black");
        $("#deptcontainer"+beforeSearchCode).css("color","black");

        var teamContainer = $("#teamcontainer"+code).attr("class");
        var isCloseRep = teamContainer.replaceAll("d-none","");
        var getCode =isCloseRep.substr(16,15).replaceAll(" ","");
        var getCodeNum =getCode.substr(13,1);
        var teamWrapper =$(".teamWrapper").attr("class");
        var compTeamWrapper ="row teamWrapper d-none";
        var compTeamContainer ="row mt-2 teamst "+getCode+" d-none";

        if(teamWrapper==compTeamWrapper){
            $(".teamWrapper").attr("class","row teamWrapper");
            $(".deptcontainer").attr("class","row mt-2 deptcontainer");
            $(".teamcontainer"+getCodeNum).attr("class","row mt-2 teamst "+getCode);
            $(".topcontainer").find("img").attr("src","/icon/dash-square.svg/");
            $("#deptcontainer"+getCodeNum).find("img").attr("src","/icon/dash-square.svg/");
            $("#deptcontainer"+getCodeNum).attr("onclick","fn_closeteamlist("+getCodeNum+")");
            $(".topcontainer").attr("onclick","fn_closeDeptList()");
        }else{
            $(".deptcontainer").attr("class","row mt-2 deptcontainer");
            $("."+getCode).attr("class","row mt-2 teamst "+getCode);
            $(".teamcontainer"+getCodeNum).attr("class","row mt-2 teamst "+getCode);
            $(".topcontainer").find("img").attr("src","/icon/dash-square.svg/");
            $("#deptcontainer"+getCodeNum).find("img").attr("src","/icon/dash-square.svg/");
            $("#deptcontainer"+getCodeNum).attr("onclick","fn_closeteamlist("+getCodeNum+")");
            $(".topcontainer").attr("onclick","fn_closeDeptList()");
        }
        if(teamContainer==compTeamContainer){
            $("#deptcontainer"+getCodeNum).find("img").attr("src","/icon/dash-square.svg/");
            $("#deptcontainer"+getCodeNum).attr("onclick","fn_closeteamlist("+getCodeNum+")");
            $("#teamcontaner"+code).attr("class","row mt-2 teamst "+getCode);
        }
        fn_getteamemplist(code);
        $("#teamcontainer"+code).css("color","blue");
        beforeSearchTeamCode=code;


    }


    function fn_getAllEmpList(code){
        if(code==beforeCode){return;}
        $.ajax({
            type : "POST",
            url : "/restorganchart/getAllEmpList.organ",
            dataType :"json",
            success : function(data) {
                if(data.length!=0) {
                    var header = "";
                    $(".r-container").empty();
                    header += "<div class=\"row p-3 r-teamheader\">";
                    header += "<div class=col-12>";
                    header += "<span style='font-size: 24px;font-weight: bold;'>" + data[0].deptname + "</span><span class='pl-1' style='font-size: 24px;'>("+data.length+")</span>";
                    header += "</div></div>";
                    var main="";
                    for(var i=0;i<data.length;i++){
                        main+="<div class=\"row p-3 r-teammain\">";
                        main+="<div class=col-4 onclick=fn_clickEmp("+data[i].code+")>";
                        main+="<div class=row>";
                        main+="<div class=col-12 style='font-size: 18px;font-weight: bold'>"+data[i].name+"</div>";
                        main+="</div>";
                        main+="<div class=row>";
                        main+="<div class=col-12>"+data[i].posname+" | "+data[i].deptname+"</div>";
                        main+="</div>";
                        main+="</div>";
                        main+="<div class=\"col-7 text-center\" style='font-size: 18px;color: black;font-weight: bold;'  onclick=fn_clickEmp("+data[i].code+")>";
                        main+="</div>";
                        main+="<div class=\"col-1 pt-2 text-right\">";
                        main+="<div class=row>";
                        main+="<div class=col-6 ><img class=icon src=/icon/envelope-fill.svg/ onclick=fn_clickemail("+data[i].code+")></div>";
                        main+="<div class=col-6 ><img class=icon src=/icon/chat-full.svg/ onclick=fn_clickChat("+data[i].code+")></div>";
                        main+="</div>";
                        main+="</div>";
                        main+="</div>";
                    }
                    $(".r-container").append(header);
                    $(".r-teamheader").after(main);
                }else{
                    isDeptEmpty(code);
                }
                beforeCode=code;
            }
        });
    }

    function fn_getDeptEmpList(code){
        if(code==beforeCode){return;}
        $.ajax({
            type : "POST",
            url : "/restorganchart/getDeptEmpList.organ",
            data : {code :code},
            dataType :"json",
            success : function(data) {
                if(data.length!=0) {
                    var header = "";
                    $(".r-container").empty();
                    header += "<div class=\"row p-3 r-teamheader\">";
                    header += "<div class=col-12>";
                    header += "<span style='font-size: 24px;font-weight: bold;'>" + data[0].deptname + "</span><span class='pl-1' style='font-size: 24px;'>("+data.length+")</span>";
                    header += "</div></div>";
                    var main="";
                    for(var i=0;i<data.length;i++){
                        main+="<div class=\"row p-3 r-teammain\">";
                        main+="<div class=col-4 onclick=fn_clickEmp("+data[i].code+")>";
                        main+="<div class=row>";
                        main+="<div class=col-12 style='font-size: 18px;font-weight: bold'>"+data[i].name+"</div>";
                        main+="</div>";
                        main+="<div class=row>";
                        main+="<div class=col-12>"+data[i].posname+" | "+data[i].deptname+"</div>";
                        main+="</div>";
                        main+="</div>";
                        main+="<div class=\"col-7 text-center\" style='font-size: 18px;color: black;font-weight: bold;' onclick=fn_clickEmp("+data[i].code+")>";
                        main+="</div>";
                        main+="<div class=\"col-1 pt-2 text-right\">";
                        main+="<div class=row>";
                        main+="<div class=col-6 ><img class=icon src=/icon/envelope-fill.svg/ onclick=fn_clickemail("+data[i].code+")></div>";
                        main+="<div class=col-6 ><img class=icon src=/icon/chat-full.svg/ onclick=fn_clickChat("+data[i].code+")></div>";
                        main+="</div>";
                        main+="</div>";
                        main+="</div>";
                    }
                    $(".r-container").append(header);
                    $(".r-teamheader").after(main);
                }else{
                    isDeptEmpty(code);
                }
                beforeCode=code;
            }
        });
    }

    function fn_getteamemplist(code){
        if(code==beforeCode){return;}
        $(".topcontainer").css("color","black");
        $("#teamcontainer"+beforeSearchTeamCode).css("color","black");
        $("#deptcontainer"+beforeSearchCode).css("color","black");
        $("#teamcontainer"+code).css("color","blue");
        beforeSearchTeamCode=code;
        $.ajax({
            type : "POST",
            url : "/restorganchart/getteamemplist.organ",
            data : {team_code:code},
            dataType :"json",
            success : function(data) {
                if(data.length!=0) {
                    var header = "";
                    $(".r-container").empty();
                    header += "<div class=\"row p-3 r-teamheader\">";
                    header += "<div class=col-12>";
                    header += "<span style='font-size: 24px;font-weight: bold;'>" + data[0].teamname + "</span><span class='pl-1' style='font-size: 24px;'>("+data.length+")</span>";
                    header += "</div></div>";
                    var main="";
                    for(var i=0;i<data.length;i++){
                        main+="<div class=\"row p-3 r-teammain\" >";
                        main+="<div class=col-4 onclick=fn_clickEmp("+data[i].code+")>";
                        main+="<div class=row>";
                        main+="<div class=col-12 style='font-size: 18px;font-weight: bold'>"+data[i].name+"</div>";
                        main+="</div>";
                        main+="<div class=row>";
                        main+="<div class=col-12>"+data[i].posname+" | "+data[i].deptname+"</div>";
                        main+="</div>";
                        main+="</div>";
                        main+="<div class=\"col-7 text-center\" style='font-size: 18px;color: black;font-weight: bold;' onclick=fn_clickEmp("+data[i].code+")>";
                        main+="</div>";
                        main+="<div class=\"col-1 pt-2 text-right\">";
                        main+="<div class=row>";
                        main+="<div class=col-6 ><img class=icon src=/icon/envelope-fill.svg/ onclick=fn_clickemail("+data[i].code+")></div>";
                        main+="<div class=col-6 ><img class=icon src=/icon/chat-full.svg/  onclick=fn_clickChat("+data[i].code+")></div>";
                        main+="</div>";
                        main+="</div>";
                        main+="</div>";
                    }
                    $(".r-container").append(header);
                    $(".r-teamheader").after(main);
                }else{
                    isTeamEmpty(code);
                }
                beforeCode=code;
            }
        });
    }
    function isTeamEmpty(code){
        $.ajax({
            type : "POST",
            url : "/restorganchart/getEmptyTeamInfo.organ",
            data : {team_code : code},
            dataType :"json",
            success : function(data) {
                $(".r-container").empty();
                var header = "";
                header += "<div class=\"row p-3 r-teamheader\">";
                header += "<div class=col-12>";
                header += "<span style='font-size: 24px;font-weight: bold;'>" + data.name + "</span><span class='pl-1' style='font-size: 24px;'>(0)</span>";
                header += "</div></div>";
                $(".r-container").append(header);
                $(".r-container").append("<div class=imgbox></div>");
                var img ="";
            }

        });
    }
    function isDeptEmpty(code){
        $.ajax({
            type : "POST",
            url : "/restorganchart/getDeptEmptyInfo.organ",
            data : {code : code},
            dataType :"json",
            success : function(data) {
                $(".r-container").empty();
                var header = "";
                header += "<div class=\"row p-3 r-teamheader\">";
                header += "<div class=col-12>";
                header += "<span style='font-size: 24px;font-weight: bold;'>" + data.name + "</span><span class='pl-1' style='font-size: 24px;'>(0)</span>";
                header += "</div></div>";
                $(".r-container").append(header);
                $(".r-container").append("<div class=imgbox></div>");
                var img ="";
            }

        });
    }
</script>
</body>
</html>