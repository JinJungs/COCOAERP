<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
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

        .confirmheader{
            background-color:#F2F6FF;
        }
        .confirmheader2{
            background-color: #FFF0F5;

        }

        .clickstat:hover{
            cursor: pointer;
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
                <div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${dto.name}</div>
                <div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">문서 번호</div>
                <div class="col-4 p-3">-</div>
            </div>
            <div class="row w-100" style= "border-bottom: 1px solid #c9c9c9;">
                <div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안자</div>
                <div class="col-4 p-3" style="border-right: 1px solid #c9c9c9">${empInfo.name}(${empInfo.posname})</div>
                <div class="col-2 p-3" style="border-right: 1px solid #c9c9c9">기안 부서</div>
                <div class="col-4 p-3">${deptName}</div> <%--로그인 받고 나중에 수정--%>
            </div>
            <div class="row w-100 pt-5" style="border-bottom: 1px solid #c9c9c9;">
                <div class="col-10 p-0 pt-2"><h5>결재선</h5></div>
                <div class="col-2 p-0 text-right"><button type="button" class="btn btn-outline-dark p-1 mb-2" data-toggle="modal" data-target="#modal">결재선 설정</button>

                </div>
            </div>
            <form id="mainform" class="w-100">

                <div class="row w-100 pt-4 pb-4 pl-3 pr-3" style="border-bottom: 1px solid #c9c9c9;">

                    <div class="col-md-12" >
                        <div class="row" id="confirmlist">
                            <div class="col-md-1 col-3 p-0 m-md-3 m-3 confirmbox">
                                <div class="row m-0 confirmheader">
                                    <div class="col-md-12 pt-1 pb-1 text-center" >기안</div>
                                </div>
                                <div class="row m-0">
                                    <div class="col-md-12 pt-2 text-center confirmname" >${empInfo.name}</div>
                                    <div class="col-md-12 text-center confirmposname">(${empInfo.posname})</div>
                                    <div class="col-md-12 text-center confirmdeptname" >${empInfo.deptname}</div>
                                    <input type="hidden" id="getcuruserempcode" name="writer_code" value="${empInfo.code}">
                                    <input type="hidden" name="temp_code" value="${temp_code}">
                                    <input type="hidden" name="dept_code" value="${empInfo.dept_code}">
                                    <input type="hidden" name="contents" id="tempcontents">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row w-100 pt-5 pb-2" style="border-bottom: 1px solid #c9c9c9;">
                    <h5>기안 내용</h5>
                </div>
                <div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
                    <div class="col-2 p-3" style="border-right: 1px solid pink;">기안 제목 *</div>
                    <div class="col-10 p-3"><input type="text"  id="title" name="title" placeholder="기안제목 입력" style="min-width: 400px; border: 1px solid pink;"></div>
                </div>
                <div class="row w-100">
                    <div class="col-2 p-3 " style="border-right: 1px solid #c9c9c9;">파일 첨부</div>
                    <div class="col-3 p-3"><input type="file" multiple="multiple" style="max-width:100%;" id="file" name=file></div>
                </div>

                <div class="row w-100" style="border-bottom: 1px solid #c9c9c9;">
                    <div class="col-2 p-3"  style="border-right: 1px solid #c9c9c9;"></div>
                    <div class="col-9 p-3" id="filecontainer"></div>
                </div>
            </form>
                <div class="row w-100 mt-4" style="border: 1px solid #c9c9c9">
                    <div class="col-12 p-3" style="border-bottom: 1px solid #c9c9c9">
                        <b>물품 입력 칸</b>
                    </div>
                    <div class="row w-100 m-0 text-center">
                        <div class="col-3 p-2" style="border-right: 1px solid #c9c9c9">신청물품 *</div>
                        <div class="col-3 p-2" style="border-right: 1px solid #c9c9c9">수량 *</div>
                        <div class="col-5 p-2" style="border-right: 1px solid #c9c9c9">비고</div>
                        <div class="col-1 p-2">추가</div>
                    </div>
                    <form id="orderform" class="w-100">
                        <div class="ordercontainer w-100">
                            <div class="row w-100 m-0 text-center orderwrap">
                                <div class="col-3 p-3 w-100"style="border-right: 1px solid #c9c9c9"><input type="text" class="w-100" id="order_list" placeholder="신청 물품을 입력하세요."></div>
                                <div class="col-3 p-3 w-100"style="border-right: 1px solid #c9c9c9"><input type="text" class="w-100" id="order_count"  oninput="fn_onlycount(this)" placeholder="수량을 입력하세요."></div>
                                <div class="col-5 p-3 "style="border-right: 1px solid #c9c9c9"><input type="text" class="w-100" placeholder="비고를 입력하세요." id="order_etc"></div>
                                <div class="col-1 p-0 pt-2 w-100"><button type="button" class="btn btn-outline-dark p-0 m-0" style="width: 45px;height: 40px; font-size: 24px;" onclick="fn_addOrderList()">+</button></div>
                            </div>

                            <input type="hidden" id=doc_seq name="doc_seq">
                        </div>
                    </form>

                </div>

                <div class="row w-100 pt-3">
                    <div class="col-12"><textarea id=contents name=contents class="w-100" style="min-height: 350px"></textarea></div>
                </div>
        </div>
    </div>

</div>
<div class="container-fluid p-0" style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow:0 -2px 7px rgba(0,0,0,.15); min-height: 80px;">
    <div class="row">
        <div class="col-6 p-3 text-right"><button type="button" class="btn btn-secondary" onclick="fn_addsave()">임시저장</button></div>
        <div class="col-6 p-3 "><button type="button" class="btn btn-dark" id="btn_add" onclick="fn_clickbtnadd()">상신하기</button></div>
    </div>
</div>

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
                                <div class="col-12 ">-대표 회사명 넣을지?</div>
                            </div>
                            <input type="hidden" id="deptsize" value="${size}">
                            <form id="deptForm">

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
                                <div class="col-5 p-2 text-right" style="font-size:13px; ">${empInfo.name}(${empInfo.posname})|${empInfo.deptname}</div>
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
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-dark" onclick="fn_addconfirm()" data-dismiss="modal">적용</button>
            </div>

        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/jquery.MultiFile.min.js"></script>
<script src="/js/bindWithDelay.js"></script>
<script>
    var indexcount=0;
    var getempcode=0;
    var getaddedempcode = [];
    var count =0;
    var beforeClickEmp =0;
    var beforeTeamcode =-1;
    var beforeDeptCode =-1;
    var getSearchKeyCode=0;

    $( function() {
        fn_getDeptList().then(fn_getteamlist).then(fn_getemplist);
        $(".empcontainer2").selectable();
    } );

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
                    console.log("둘다");
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
        alert("최소 한 명의 결재자를 선택해주세요.");
    }
    function fn_isnull(){
        var title = $("#title").val();
        var contents = $("#contents").val();
        if($(".orderwrap").length==1){
            alert("목록을 추가 해주세요");
            return;
        }

        if(title==""){
            alert("제목을 입력해주세요.");
            $("#title").focus();
            return;
        }else if(contents==""){
            alert("내용을 입력해주세요.");
            $("#contents").focus();
            return;
        }

        ajaxadddoucment().then(ajaxaddorder);

    }

    function ajaxaddorder(param){
        var data = $("#orderform").serializeArray();
        var json = JSON.stringify(data);
        $.ajax({
            type : "POST",
            url : "/restdocument/addorder.document",
            data :json,
            contentType:'application/json',
            success : function(result) {
                if(result=="success"){
                    location.href="/document/toTemplateList.document";
                }
            }
        });
    }

    function ajaxadddoucment(){
        return new Promise(function(resolve, reject){
            var contents = $("#contents").val();
            $("#tempcontents").val(contents);
            $.ajax({
                url:"/restdocument/ajaxadddocument.document",
                type:"post",
                enctype: 'multipart/form-data',
                data:new FormData($("#mainform")[0]),
                contentType: false,
                processData: false,
                success: function (result) {
                    resolve(result);
                    $("#doc_seq").val(result);
                }
            });
        });
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
        }
    });




    function fn_addconfirmlist() {
        var code = getempcode;
        var curemp = $("#getcuruserempcode").val();
        if(curemp==code){
            alert("기안자는 추가할 수 없습니다.");
            return;
        }
        for(var i=0;i<count;i++){
            if(getaddedempcode[i]==getempcode){
                alert("이미 추가된 사용자입니다.");
                return;
            }
        }
        if(count>=5){
            alert("최대 5명까지 가능합니다.");
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
                $("#btn_add").attr("onclick","()");
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


    function ajaxaddsave() {
        return new Promise(function (resolve, reject) {
            var contents = $("#contents").val();
            $("#tempcontents").val(contents);
            $.ajax({
                url: "/restdocument/addsave.document",
                type: "post",
                enctype: 'multipart/form-data',
                data: new FormData($("#mainform")[0]),
                contentType: false,
                processData: false,
                success: function (result) {
                    $("#doc_seq").val(result);
                    resolve(result);
                }
            });
        });
    }


    function fn_addsave(){
        var title = $("#title").val();
        var contents = $("#contents").val();
        var writer_code =$("#getcuruserempcode").val();
        if(title==""){
            alert("제목을 입력해주세요.");
            $("#title").focus();
            return;
        }else if(contents==""){
            alert("내용을 입력해주세요.");
            $("#contents").focus();
            return;
        }
        ajaxaddsave().then(ajaxmodaddorder);

    }

    function ajaxmodaddorder(param){
        var data = $("#orderform").serializeArray();
        var json = JSON.stringify(data);
        $.ajax({
            type : "POST",
            url : "/restdocument/addorder.document",
            data :json,
            contentType:'application/json',
            success : function(result) {
                if(result=="success"){
                    location.href="/document/ d_searchTemporary.document";
                }
            }
        });
    }

    function fn_addOrderList() {
        var order_list = $("#order_list").val();
        var order_count = $("#order_count").val();
        var order_etc = $("#order_etc").val();

        if(order_list==""){
            alert("신청 상품을 입력해주세요.");
            $("#order_list").focus();
            return;
        }else if(order_count==""){
            alert("상품 수량을 입력해주세요.")
            $("#order_count").focus();
            return;
        }
        var html= "";
        html+="<div class=\"row w-100 m-0 text-center orderwrap\">";
        html+="<div class=\"col-3 p-3 w-100\" style=\"border-right:1px solid #c9c9c9\"><input type=text name=order_list class=w-100 value=\""+order_list+"\"></div>";
        html+="<div class=\"col-3 p-3 w-100\" style=\"border-right:1px solid #c9c9c9\"><input type=text name=order_count class=w-100 value=\""+order_count+"\" oninput=fn_onlycount2(this)></div>";
        html+="<div class=\"col-5 p-3\" style=\"border-right:1px solid #c9c9c9\"><input type=text name=order_etc class=w-100 value=\""+order_etc+"\"></div>";
        html+="<div class=\"col-1 p-0 pt-2 w-100\"><button class=\"btn btn-outline-dark p-0 m-0\" style=\"width:45px; height:40px; font-size:24px;\" onclick=fn_delOrderList(this) type=button>-</button></div>";
        $(".ordercontainer").append(html);
        indexcount++;
        $("#order_list").val("");
        $("#order_count").val("");
        $("#order_etc").val("");
    }

    function  fn_delOrderList(obj) {
        var conf = confirm("행을 삭제 하시겠습니까?");
        if(conf==true) {
            $(obj).parent().parent().remove();
        }

    }

    function fn_onlycount(obj) {

        var a= $(obj).val();
        $(obj).val($(obj).val().replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'));
        if(a.length>=6){
            alert("최대 만자리까지 가능합니다.");
            $(obj).val($(obj).val().substr(0,5));

            return;
        }

    }

    function  fn_onlycount2(obj) {
        var a= $(obj).val();
        $(obj).val($(obj).val().replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'));
        if(a.length>=6){
            alert("최대 만자리까지 가능합니다.");
            $(obj).val($(obj).val().substr(0,5));
            return;
        }
    }
</script>

</body>
</html>