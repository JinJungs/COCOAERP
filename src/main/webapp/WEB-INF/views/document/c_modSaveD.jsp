<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" th:content="${_csrf.token}">
    <meta name="_csrf_header" th:content="${_csrf.headerName}">
    <title>업무 보고서</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <style>

        .confirmname{
            font-size: 13px;
            color:#333;
        }
        .confirmposname{
            font-size: 13px;
            color:#333;
        }

        .confirmdeptname{
            font-size: 12px;
            color: #999;
        }

        .confirmbox{
            border: 1px solid #DCDCDC;
            min-width: 135px;
            min-height:120px;
        }
        .confirmbox2{
            border: 1px solid #DCDCDC;
            min-width: 135px;
            min-height:120px;
        }

        .confirmheader{
            background-color:#F2F6FF;
        }
        .confirmheader2{
            background-color: #FFF0F5;

        }

        .clickstat:hover{
            cursor: pointer;
        }

        .deptteamcontainer:hover, .teamcontainer:hover, .empcontainer:hover{
            background-color: #F2F6FF;
        }



    </style>

</head>
<body>

<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->

    <div id="content" class="p-4 p-5 pt-5" style="min-width: 1148px;">
        <div class="container w-80 p-0">
            <div class="row w-100">
                <h5>${dto.name}</h5>
            </div>
            <div class="row w-100" style="border-top: 1px solid #c9c9c9; border-bottom: 1px solid #c9c9c9;">
                <div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안 양식</div>
                <div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${ddto.temp_name}</div>
                <div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">문서 번호</div>
                <div class="col-4 p-3">${ddto.seq}</div>
            </div>
            <div class="row w-100" style= "border-bottom: 1px solid #c9c9c9;">
                <div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안자</div>
                <div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${ddto.emp_name}(${ddto.pos_name})</div>
                <div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안 부서</div>
                <div class="col-4 p-3">${ddto.dept_name}</div> <%--로그인 받고 나중에 수정--%>
            </div>
            <div class="row w-100 pt-5" style="border-bottom: 1px solid #c9c9c9;">
                <div class="col-10 p-0 pt-2"><h5>결재선</h5></div>
                <div class="col-2 p-0 text-right"><button type="button" class="btn btn-outline-dark p-1 mb-2" data-toggle="modal" data-target="#modal">결재선 설정</button>

                </div>
            </div>
            <form id="mainform" method="post" enctype="multipart/form-data">
                <div class="row w-100 pt-4 pb-4 pl-3 pr-3" style="border-bottom: 1px solid #c9c9c9;">

                    <div class="col-md-12" >
                        <div class="row" id="confirmlist">
                            <div class="col-md-1 col-3 p-0 m-md-3 m-3 confirmbox">
                                <div class="row m-0 confirmheader">
                                    <div class="col-md-12 pt-1 pb-1 text-center" >기안</div>
                                </div>
                                <div class="row m-0">
                                    <div class="col-md-12 pt-2 text-center confirmname">${ddto.emp_name}</div>
                                    <div class="col-md-12 text-center confirmposname">${ddto.pos_name}</div>
                                    <div class="col-md-12 text-center confirmdeptname" >${ddto.dept_name}</div>
                                    <input type="hidden" id="getcuruserempcode" name="writer_code" value="${ddto.writer_code}">
                                    <input type="hidden" name="temp_code" value="${ddto.temp_code}">
                                    <input type="hidden" name="dept_code" value="${ddto.dept_code}">
                                    <input type="hidden" name="seq" value="${ddto.seq}">
                                    <input type="hidden" name="status" value="${ddto.status}">
                                    <input type="hidden" name="ori_temp_code" value="${ori_temp_code}">

                                </div>
                            </div>
                            <%--포이치 돌려서--%>
                            <c:forEach var="i" items="${clist}">
                                <div class="col-md-1 col-3 p-0 m-md-3 m-3 confirmbox2">
                                    <div class="row m-0 confirmheader2">
                                        <div class="col-md-12 pt-1 pb-1 text-center" >결재</div>
                                    </div>
                                    <div class="row m-0">
                                        <input type="hidden" name="approver_code" value="${i.approver_code}">
                                        <div class="col-md-12 pt-2 text-center confirmname">${i.emp_name}</div>
                                        <div class="col-md-12 text-center confirmposname">${i.pos_name}</div>
                                        <div class="col-md-12 text-center confirmdeptname" >${i.dept_name}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="row w-100 pt-5 pb-2" style="border-bottom: 1px solid #c9c9c9;">
                    <h5>기안 내용</h5>
                </div>
                <div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
                    <div class="col-2 p-3" style="border-right: 1px solid #c9c9c9;">기안 제목</div>
                    <div class="col-10 p-3"><input type="text"  id="title" name="title" placeholder="기안제목 입력" style="min-width: 400px; border: 1px solid #c9c9c9;" value="${ddto.title}" autocomplete="off"></div>
                </div>
                <div class="row w-100">
                    <div class="col-2 p-3 " style="border-right: 1px solid #c9c9c9;">파일 첨부</div>
                    <div class="col-10 p-3">
                        <input type="file" multiple="multiple" style="max-width:100%;" id="file" name=file>
                        <div id="filecontainer"></div>
                    </div>
                </div>

                <div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
                    <div class="col-2 p-3"  style="border-right: 1px solid #c9c9c9;"></div>
                </div>

                <div class="row w-100 pt-3 mb-5">
                    <div class="col-12"><textarea id=contents name=contents class="w-100" style="min-height: 350px">${ddto.contents}</textarea></div>
                </div>
        </div>
    </div>

</div>
<div class="container-fluid p-0" style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow:0 -2px 7px rgba(0,0,0,.15); min-height: 80px;">
    <div class="row">
        <c:choose>
            <c:when test="${ddto.status=='TEMP'}">
                <div class="col-6 p-3 text-right"><button type="button" class="btn btn-secondary" onclick="fn_modsaveconfirm()">임시저장</button></div>
                <div class="col-6 p-3 "><button type="button" class="btn btn-dark" id="btn_add" onclick="fn_clickbtnadd()">상신하기</button></div>
            </c:when>
            <c:otherwise>
                <div class="col-6 p-3 text-right"><button type="button" class="btn btn-secondary" onclick="fn_addsave()">임시저장</button></div>
                <div class="col-6 p-3 "><button type="button" class="btn btn-dark" id="btn_add" onclick="fn_clickbtnadd()">재상신하기</button></div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</form>
<div class="modal" id="modal" tabindex="-1" >
    <div class="modal-dialog modal-xl modal-dialog-centered" style="min-width: 1138px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12"><b>결재선 설정</b></div>
                    </div>
                    <div class="row w-100">
                        <div class="col-4 m-3" style=" border: 1px solid pink">
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-12 p-2"><input type="text" class="w-100" id="search" placeholder="부서명, 이름 입력." autocomplete="off"></div>
                            </div>
                            <div class="row">
                                <div class="col-12 pb-1"></div>
                            </div>
                            <input type="hidden" id="deptsize" value="${size}">
                            <form id="deptForm" style="max-height:485px; overflow-y: auto;">

                            </form>

                        </div>
                        <div class="col-1 p-0 d-flex justify-content-center" style="min-height:540px; align-items: center; flex:1;">
                            <div class="row ">
                                <div class="col-12">
                                    <button class="btn btn-outline-dark btn-sm" id="btn_confirm" disabled onclick="fn_addconfirmlist()">결재</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 m-3" style="min-height:540px; border: 1px solid pink">
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-7 p-2">기안</div>
                                <div class="col-5 p-2 text-right" style="font-size:13px; ">${ddto.emp_name}|${ddto.dept_name}</div>
                            </div>
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-7 p-2">결재자</div>
                            </div>
                            <%--ajax로 추가되는 부분.--%>
                            <form id="confirmform" name="confirmform">
                                <div class="confirmcontainer" id="sortable">

                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-secondary" onclick="fn_closeModal()"  data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-dark" onclick="fn_addconfirm()" data-dismiss="modal">적용</button>
            </div>

        </div>
    </div>
</div>
<form class="tempconfirm" id="tempconfirm">
    <c:forEach var="i" items="${clist}">
        <input type="hidden" name="approver_code" value="${i.approver_code}">
    </c:forEach>
</form>


<div class="modal fade " id="alertModal" data-backdrop="false" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm" role="document" >
        <div class="modal-content">
            <div class="modal-body d-flex justify-content-center h-100 pt-5" style="min-height: 120px;">
                <b id="result-msg">출근이 처리가 완료 되었습니다.</b>
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
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    if(token && header) {
        $(document).ajaxSend(function(event, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    }

    var getempcode=0;
    var getaddedempcode = [];
    var count =0;
    var beforeClickEmp =0;
    var clickstat = document.getElementsByClassName("clickstat");
    var beforeTeamcode =-1;
    var beforeDeptCode =-1;
    var getSearchKeyCode=0;

    $( function() {
        fn_getDeptList().then(fn_getteamlist).then(fn_getemplist);
        $(".empcontainer2").selectable();
        $.ajax({
            type: "POST",
            url: "/restdocument/getfileList.document",
            data: $("#mainform").serialize(),
            dataType: "json",
            success: function (data) {
                if(data.length!=0){
                    var html="";
                    for(var i=0;i<data.length;i++){
                        html+="<div class=MultiFile-label>";
                        html+="<a class=MultiFile-remove href=#file>"
                        html+="<img src=/icon/close-x.svg onclick=fn_delfile(this,"+data[i].seq+")>";
                        html+="</a>";
                        html+="<span>";
                        html+="<span class=MultiFile-label title=\'File selected:"+data[i].oriname+"\'>";
                        html+="<span class=MultiFile-title> "+data[i].oriname+"</span>";
                        html+="</span>";
                        html+="</span>";
                        html+="</div>";
                    }
                    $("#filecontainer").append(html);
                }
            }
        });

        if($("#tempconfirm").serialize()!="") {
            $.ajax({
                type: "POST",
                url: "/restdocument/loadconfirmlist.document",
                data: $("#tempconfirm").serialize(),
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    var html = "";
                    for (var i = 0; i < data.length; i++) {
                        html += "<div class=\"row p-2 w-100 m-0\" id=closeconfirm" + data[i].code + " style=\"border-bottom:1px solid #c9c9c9\">";
                        html += "<div class=\"col-2 p-2\">결재</div>";
                        html += "<div class=\"col-6 p-2\">" + data[i].emp_name + "|" + data[i].pos_name + "</div>";
                        html += "<input type=hidden value=" + data[i].code + " name=code>";
                        html += "<div class=\"col-2 p-2 text-right\"><img src=/icon/close-x.svg style=cursor:pointer onclick=fn_deleteconfirm(" + data[i].code + ")></div>";
                        html += "<div class=\"col-2 p-2 text-right\"><img class=ui-state-default src=/icon/item-list.svg></div>";
                        html += "</div>";
                        getaddedempcode[count++] = data[i].code;
                    }
                    $(".confirmcontainer").append(html);
                    $("#btn_add").attr("onclick", "fn_isnull()");

                }
            });
        }
    });

    function fn_closeAlertModal(){
        var setTime=setTimeout(function () {
            $("#alertModal").modal('hide');
        },1000)
    }



    function fn_getDeptList(){
            return new Promise(function (resolve,reject) {
                $.ajax({
                    type : "POST",
                    url : "/test/getDeptList",
                    dataType :"json",
                    success : function(data) {
                        var html="";
                        for(var i=0;i<data.length;i++){
                            html+="<div class='allcontainer w-100'>";
                            html+="<div class=deptteamcontainer id=deptteamcontainer"+data[i].code+" onclick=fn_openTeamList("+data[i].code+")>";
                            html+="<div class=row style='cursor:pointer;' id=confirmdept"+data[i].code+">";
                            html+="<div class=col-1><img src='/icon/plus-square.svg' id=deptopencloseicon"+data[i].code+"></div>"
                            html+="<div class=\"col-5  p-0 pl-1\" >"+data[i].name+"</div>";
                            html+="<input type=hidden id=deptname"+data[i].code+" value="+data[i].name+">";
                            html+="<input type=hidden name=code value="+data[i].code+">";
                            html+="</div>";
                            html+="</div>";
                            html+="<div class=\"childcontainer d-none\" id=childcontainer"+data[i].code+"></div>";
                            html+="</div>";
                        }
                        $("#deptForm").append(html);
                        resolve(data);

                    }
                });
            })
        }

        function fn_getteamlist(){
            return new Promise(function (resolve,reject) {
                $.ajax({
                    type : "POST",
                    url : "/test/getTeamList",
                    data : $("#deptForm").serialize(),
                    dataType :"json",
                    success : function(data) {
                        var html="";
                        for(var i=0;i<data.length;i++){
                            html+="<div class=teamcontainer id=teamcontainer"+data[i].team_code+">";
                            html+="<div class=row d-none style=cursor:pointer; id=closeOpenTeamDiv"+data[i].team_code+" onclick=fn_openEmpList("+data[i].team_code+")>";
                            html+="<input type=hidden name=team_code value="+data[i].team_code+">";
                            html+="<div class=\"col-1 p-0 ml-2 text-right\"><img src=/icon/plus-square.svg id=teamopencloseicon"+data[i].code+"></div>";
                            html+="<div class=\"col-5 p-0 pl-1\">"+data[i].team_name+"</div>";
                            html+="</div>";
                            html+="</div>";
                            html+="<div class='empWrapper d-none' id=empWrapper"+data[i].team_code+">";
                            html+="</div>";
                            $("#childcontainer"+data[i].dept_code).append(html);
                            html="";
                        }
                        resolve(data);
                    }
                });
            })
        }

        function fn_getemplist(){
            $.ajax({
                type : "POST",
                url : "/test/getemplist",
                data :$("#deptForm").serialize(),
                dataType :"json",
                success : function(data) {
                    var html="";
                    for(var i=0;i<data.length;i++){
                        html+="<div class=empcontainer id=empcontainer"+data[i].code+" onclick=fn_clickCurMember("+data[i].code+")>";
                        html+="<div class=\"row clickstat\" id=clickStat"+data[i].code+">";
                        html+="<div class=col-1></div>";
                        html+="<div class=\"col-8 pl-1\">-"+data[i].name+"("+data[i].pos_name+")</div>";
                        html+="<input type=hidden value="+data[i].name+">";
                        html+="</div>";
                        html+="</div>";
                        $("#empWrapper"+data[i].team_code).append(html);
                        html="";
                    }
                }
            });
        }

        function fn_getSearchDeptList(code){
            return new Promise(function (resolve,reject) {
                $.ajax({
                    type : "POST",
                    data : {code:code},
                    url : "/test/getSearchDeptList",
                    dataType :"json",
                    success : function(data) {
                        if(code==beforeDeptCode){
                            return;
                        }
                        var html="";
                        html+="<div class='allcontainer w-100 d-none'>";
                        html+="<div class=deptteamcontainer id=deptteamcontainer"+data.code+" onclick=fn_closeTeamList("+data.code+")>";
                        html+="<div class=row style='cursor:pointer;' id=confirmdept"+data.code+">";
                        html+="<div class=col-1><img src='/icon/plus-square.svg' id=deptopencloseicon"+data.code+"></div>"
                        html+="<div class=\"col-5  p-0 pl-1\" >"+data.name+"</div>";
                        html+="<input type=hidden id=deptname"+data.code+" value="+data.name+">";
                        html+="<input type=hidden name=code value="+data.code+">";
                        html+="</div>";
                        html+="</div>";
                        html+="<div class=\"childcontainer\" id=childcontainer"+data.code+"></div>";
                        html+="</div>";
                        $("#deptForm").append(html);
                        beforeDeptCode=code;
                        resolve(data);

                    }
                });
            })
        }

        function fn_getSearchTeamList(code){
            return new Promise(function (resolve,reject) {
                var tid=setTimeout(function () {
                    $.ajax({
                        type : "POST",
                        url : "/test/getSearchTeamList",
                        data : {code:code},
                        dataType :"json",
                        success : function(data) {
                            if(code==beforeTeamcode){
                                return;
                            }
                            $("#deptopencloseicon"+data.dept_code).attr("src","/icon/dash-square.svg");
                            var html="";
                            html+="<div class=teamcontainer id=teamcontainer"+data.code+">";
                            html+="<div class=row d-none style=cursor:pointer; id=closeOpenTeamDiv"+data.code+" onclick=fn_closeEmpList("+data.code+")>";
                            html+="<input type=hidden name=team_code value="+data.code+">";
                            html+="<div class=\"col-1 p-0 ml-2 text-right\"><img src=/icon/plus-square.svg id=teamopencloseicon"+data.code+"></div>";
                            html+="<div class=\"col-5 p-0 pl-1\">"+data.name+"</div>";
                            html+="</div>";
                            html+="</div>";
                            html+="<div class='empWrapper' id=empWrapper"+data.code+">";
                            html+="</div>";
                            $("#childcontainer"+data.dept_code).append(html);
                            beforeTeamcode=code;
                            resolve(data);
                        }
                    });
                },50)

            })
        }

        function fn_getSearchEmpList(code){
            return new Promise(function (resolve,reject) {
                var tid= setTimeout(function () {
                    $.ajax({
                        type : "POST",
                        url : "/test/getSearchEmpList",
                        data :{code:code},
                        dataType :"json",
                        success : function(data) {
                            $("#teamopencloseicon"+data.team_code).attr("src","/icon/dash-square.svg");
                            var html="";
                            html+="<div class=empcontainer id=empcontainer"+data.code+" onclick=fn_clickCurMember("+data.code+")>";
                            html+="<div class=\"row clickstat\" id=clickStat"+data.code+">";
                            html+="<div class=col-1></div>";
                            html+="<div class=\"col-8 pl-1\">-"+data.name+"("+data.posname+")</div>";
                            html+="<input type=hidden value="+data.name+">";
                            html+="</div>";
                            html+="</div>";
                            $("#empWrapper"+data.team_code).append(html);
                            resolve(data);
                            $(".allcontainer").attr("class","allcontainer w-100");
                        }

                    });
                },100)

            });
        }



        $("#search").bindWithDelay("keyup", function (e) {
            beforeTeamcode=-1;
            beforeDeptCode=-1;
            if($("#search").val()==""){
                if(getSearchKeyCode==8){
                    return;
                }
                $("#deptForm").empty();
                fn_getDeptList().then(fn_getteamlist).then(fn_getemplist);
                getSearchKeyCode=e.keyCode;
                return;
            }
            $.ajax({
                type : "POST",
                url : "/test/getSearchList",
                data : {name: $("#search").val()},
                dataType :"json",
                success : function(data) {
                    getSearchKeyCode=0;
                    var d1 = data[0].length; //부서검색
                    var d2 = data[1].length; //팀검색
                    var d3 = data[2].length; //이름검색
                    $("#deptForm").empty();
                    if(d3!=0&&d2==0||d1==0){
                        for(var i=2;i<data.length;i=i+2){
                            for(var j=0;j<data[i].length;j++){
                                fn_getSearchDeptList(data[i][j].dept_code).then(fn_getSearchTeamList(data[i][j].team_code)).then(fn_getSearchEmpList(data[i][j].code));
                            }
                        }
                    }
                    if(d3==0&&d2==0&&d1!=0){
                        for(var i=0;i<data.length;i=i+2){
                            for(var j=0;j<data[i].length;j++){
                                fn_getSearchDeptList(data[i][j].code);
                            }
                        }
                        var tid=setTimeout(function () {
                            $(".allcontainer").attr("class","allcontainer w-100");
                        },20)
                    }
                    if(d3==0&&d2!=0&&d1==0){
                        console.log("팀");
                        for(var i=1;i<data.length;i=i+2){
                            for(var j=0;j<data[i].length;j++){
                                fn_getSearchDeptList(data[i][j].dept_code).then(fn_getSearchTeamList(data[i][j].code));
                            }
                        }
                        var tid=setTimeout(function () {
                            $(".allcontainer").attr("class","allcontainer w-100");
                        },20)
                    }
                    if(d3==0&&d2!=0&&d1!=0){
                        for(var i=1;i<data.length;i=i+2){
                            for(var j=0;j<data[i].length;j++){
                                fn_getSearchDeptList(data[i][j].dept_code).then(fn_getSearchTeamList(data[i][j].code));
                            }
                        }
                        var tid=setTimeout(function () {
                            $(".allcontainer").attr("class","allcontainer w-100");
                        },20)
                    }
                    if(d3!=0&&d2!=0&&d1!=0){
                        for(var i=2;i<data.length;i=i+2){
                            for(var j=0;j<data[i].length;j++){
                                fn_getSearchDeptList(data[i][j].dept_code).then(fn_getSearchTeamList(data[i][j].team_code)).then(fn_getSearchEmpList(data[i][j].code));
                            }
                        }
                    }


                }
            });

        }, 300);

        function fn_openTeamList(code) {
            $("#childcontainer" + code).attr("class", "childcontainer");
            $("#deptteamcontainer" + code).attr("onclick", "fn_closeTeamList(" + code + ")");
            $("#deptteamcontainer" + code).find('img').attr("src", "/icon/dash-square.svg");
        }

        function fn_closeTeamList(code) {
            $("#childcontainer" + code).attr("class", "childcontainer d-none");
            $("#deptteamcontainer" + code).attr("onclick", "fn_openTeamList(" + code + ")");
            $("#deptteamcontainer" + code).find('img').attr("src", "/icon/plus-square.svg");
        }

        function fn_openEmpList(code) {
            $("#empWrapper"+code).attr("class","empWrapper");
            $("#teamcontainer"+code).find('img').attr("src","/icon/dash-square.svg");
            $("#closeOpenTeamDiv"+code).attr("onclick","fn_closeEmpList("+code+")");
        }

        function fn_closeEmpList(code) {
            $("#empWrapper"+code).attr("class","empWrapper d-none");
            $("#teamcontainer"+code).find('img').attr("src","/icon/plus-square.svg");
            $("#closeOpenTeamDiv"+code).attr("onclick","fn_openEmpList("+code+")");
        }

        function fn_clickCurMember(code) {
            $("#clickStat"+beforeClickEmp).css("color","black");
            getempcode=code;
            $("#btn_confirm").attr("disabled",false);
            $("#clickStat"+code).css("color","blue");
            beforeClickEmp=code;

        }






    function fn_clickbtnadd() {
        $("#result-msg").text("최소 한 명의 결재자를 선택해주세요.")
        $("#alertModal").modal();
        fn_closeAlertModal();
    }




    $("#file").MultiFile({
        max: 5, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
        //accept: 'jpg|png|gif', //허용할 확장자(지정하지 않으면 모든 확장자 허용)
        maxfile: 5120, //각 파일 최대 업로드 크기
        maxsize: 20480,  //전체 파일 최대 업로드 크기
        STRING: { //Multi-lingual support : 메시지 수정 가능
            remove : "<img src='/icon/close-x.svg'>", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
            duplicate : "$file 은 이미 선택된 파일입니다.",
            //denied : "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
            //selected:'$file 을 선택했습니다.',
            toomuch: "업로드할 수 있는 최대크기를 초과하였습니다.($size)",
            toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
            toobig: "$file 은 크기가 매우 큽니다. (max $size)"
        },
        list:"#filecontainer"

    });


    function fn_addconfirmlist() {
        var code = getempcode;
        var curemp = $("#getcuruserempcode").val();
        if(curemp==code){
            $("#result-msg").text("기안자는 추가할 수 없습니다.");
            $("#alertModal").modal();
            fn_closeAlertModal();
            return;
        }
        for(var i=0;i<count;i++){
            if(getaddedempcode[i]==getempcode){
                $("#result-msg").text("이미 추가된 사용자입니다.");
                $("#alertModal").modal();
                fn_closeAlertModal();
                return;
            }
        }
        if(count>=5){
            $("#result-msg").text("최대 다섯명까지 가능합니다");
            $("#alertModal").modal();
            fn_closeAlertModal();
            return;
        }

        $.ajax({
            type : "POST",
            url : "/restdocument/addconfirmlist.document",
            data : {code},
            dataType : "json",
            success : function(data) {
                var html = "";
                for (var i = 0; i < data.length; i++) {
                    html += "<div class=\"row p-2 w-100 m-0\" id=closeconfirm"+data[i].code+" style=\"border-bottom:1px solid #c9c9c9\">";
                    html += "<div class=\"col-2 p-2\">결재</div>";
                    html += "<div class=\"col-6 p-2\">" + data[i].name + "|" + data[i].deptname + "</div>";
                    html += "<input type=hidden value="+code+" name=code>";
                    html += "<div class=\"col-2 p-2 text-right\"><img src=/icon/close-x.svg style=cursor:pointer onclick=fn_deleteconfirm("+data[i].code+")></div>";
                    html += "<div class=\"col-2 p-2 text-right\"><img class=ui-state-default src=/icon/item-list.svg></div>";
                    html += "</div>";
                }
                getaddedempcode[count]=getempcode;
                count++;
                $(".confirmcontainer").append(html);
                $("#btn_add").attr("onclick","fn_isnull()");
            }
        });
    }
    $( function() {
        $( "#sortable" ).sortable();
        $( "#sortable" ).disableSelection();
    } );

    function fn_deleteconfirm(code) {
        $(".confirmcontainer").find($("#closeconfirm"+code)).remove();
        for(var i=0;i<getaddedempcode.length;i++){
            if(getaddedempcode[i]==code){
                getaddedempcode.splice(i,1);
                count--;
            }
        }
        if(getaddedempcode.length==0){
            $("#btn_add").attr("onclick","fn_clickbtnadd()");
        }
    }

    function fn_addconfirm(){
        $("#confirmlist>div:first").nextAll().remove();
        $.ajax({
            url:"/restdocument/addmainconfirmlist.document",
            type:"post",
            data:$("#confirmform").serialize(),
            dataType :"json",
            success: function (data) {
                console.log(data[0].pos_name);
                html="";
                for(var i=0;i<data.length;i++){
                    html+="<div class=\"col-md-1 p-0 col-3 m-md-3 m-3 confirmbox\">";
                    html+="<div class=\"row m-0 confirmheader2\">";
                    html+="<div class=\"col-md-12 pt-1 pb-1 text-center\">결재</div>";
                    html+="</div>";
                    html+="<div class=\"row m-0\">";
                    html+="<div class=\"col-md-12 pt-2 text-center confirmname\" >"+data[i].emp_name+"</div>";
                    html+="<div class=\"col-md-12 text-center confirmposname\">("+data[i].pos_name+")</div>";
                    html+="<div class=\"col-md-12 text-center confirmdeptname\" >"+data[i].dept_name+"</div>";
                    html+="<input type=hidden  name=approver_code value="+data[i].code+">";
                    html+="</div>";
                    html+="</div>";
                }
                $("#confirmlist").append(html);


            }
        });
    }

    function fn_addsave(){
        var title = $("#title").val();
        var contents = $("#contents").val();
        var writer_code =$("#getcuruserempcode").val();
        if(title==""){
            $("#result-msg").text("제목을 입력해주세요.")
            $("#alertModal").modal();
            fn_closeAlertModal();
            $("#title").focus();
            return;
        }else if(contents==""){
            $("#result-msg").text("내용을 입력해주세요.")
            $("#alertModal").modal();
            fn_closeAlertModal();
            $("#contents").focus();
            return;
        }

        $.ajax({
            url:"/restdocument/addsave.document",
            type:"post",
            enctype: 'multipart/form-data',
            data:new FormData($("#mainform")[0]),
            contentType: false,
            processData: false,
            success: function (result) {
                if(result>=1){
                    window.location.replace("/document/d_searchTemporary.document");
                }
            }
        });
    }

    function fn_modsaveconfirm(){
        $.ajax({
            url:"/restdocument/modsaveconfirm.document",
            type:"post",
            enctype: 'multipart/form-data',
            data:new FormData($("#mainform")[0]),
            contentType: false,
            processData: false,
            success: function (result) {
                if(result>=1){
                    window.location.replace("/document/d_searchTemporary.document");
                }
            }
        });
    }

    function fn_delfile(obj,seq) {
        $(obj).parent().parent().remove();
        $.ajax({
            type: "POST",
            url: "/restdocument/deldocfile.document",
            data: {seq},
            success: function (data) {
                console.log(data);
            }
        });
    }

    function fn_isnull(){
        var title = $("#title").val();
        var contents = $("#contents").val();
        if(title==""){
            $("#result-msg").text("제목을 입력해주세요.");
            $("#alertModal").modal();
            fn_closeAlertModal();
            $("#title").focus();
            return;
        }else if(contents==""){
            $("#result-msg").text("내용을 입력해주세요.");
            $("#alertModal").modal();
            fn_closeAlertModal();
            $("#contents").focus();
            return;
        }

        $.ajax({
            url:"/restdocument/modaddconfirm.document",
            type:"post",
            enctype: 'multipart/form-data',
            data:new FormData($("#mainform")[0]),
            contentType: false,
            processData: false,
            success: function (result) {
                if(result>=1){
                    window.location.replace("/document/d_searchRaise.document");
                }
            }
        });
    }

    function fn_closeModal() {
        for(var i=0;i<getaddedempcode.length;i++){
            $(".confirmcontainer").find($("#closeconfirm"+getaddedempcode[i])).remove();
        }
        getempcode=0;
        getaddedempcode = [];
        count =0;
        beforeClickEmp =0;
        clickstat = document.getElementsByClassName("clickstat");
        beforeTeamcode =-1;
        beforeDeptCode =-1;
        getSearchKeyCode=0;
        $("#confirmlist>div:first").nextAll().remove();
        $("#deptForm").empty();
        fn_getDeptList().then(fn_getteamlist).then(fn_getemplist);
        $(".empcontainer2").selectable();
        $("#btn_add").attr("onclick","fn_clickbtnadd()");
    }


</script>

</body>
</html>