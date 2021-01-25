<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

</head>
<body>

<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->

    <div id="content" class="p-4 p-5 pt-5" style="min-width: 1148px;">
        <div class="container w-80 p-0">
            <div class="row w-100">
                <h5>업무 *</h5>
            </div>
            <div class="row w-100" style="border-top: 1px solid pink; border-bottom: 1px solid pink;">
                <div class="col-2 p-3" style="border-right: 1px solid pink">기안 양식</div>
                <div class="col-4 p-3" style="border-right: 1px solid pink">${dto.name}</div>
                <div class="col-2 p-3" style="border-right: 1px solid pink">문서 번호</div>
                <div class="col-4 p-3">-</div>
            </div>
            <div class="row w-100" style= "border-bottom: 1px solid pink;">
                <div class="col-2 p-3" style="border-right: 1px solid pink">기안자</div>
                <div class="col-4 p-3" style="border-right: 1px solid pink">${name}</div>
                <div class="col-2 p-3" style="border-right: 1px solid pink">기안 부서</div>
                <div class="col-4 p-3">${deptName}</div> <%--로그인 받고 나중에 수정--%>
            </div>
            <div class="row w-100 pt-5" style="border-bottom: 1px solid pink;">
                <div class="col-10 p-0 pt-2"><b>결재선</b></div>
                <div class="col-2 p-0 text-right"><button type="button" class="btn btn-outline-dark p-1 mb-2" data-toggle="modal" data-target="#modal">결재선 설정</button>

                </div>
            </div>
            <div class="row w-100 pt-4 pb-4 pl-3 pr-3" style="border-bottom: 1px solid pink;">
                결재선 들어갈 곳 나중에 ajax로
            </div>
            <div class="row w-100 pt-5 pb-2" style="border-bottom: 1px solid pink;">
                <b>기안 내용</b>
            </div>
            <div class="row w-100" style="border-bottom: 1px solid pink;">
                <div class="col-2 p-3" style="border-right: 1px solid pink;">기안 제목</div>
                <div class="col-10 p-3" ><input type="text" placeholder="기안제목 입력" style="min-width: 400px; border: 1px solid pink;"></div>
            </div>
            <div class="row w-100">
                <div class="col-2 p-3" style="border-right: 1px solid pink;">파일 첨부</div>
                <div class="col-3 p-3"><input type="file" multiple="multiple" style="max-width:100%;" id="file" onchange="fn_filechange()"></div>
            </div>
            <div class="row w-100" style="border-bottom: 1px solid pink;">
                <div class="col-2 p-3"  style="border-right: 1px solid pink;"></div>
                <div class="col-9 p-3" id="filecontainer"></div>
            </div>

            <div class="row w-100 pt-3">
                <div class="col-12"><textarea class="w-100" style="min-height: 350px"></textarea></div>
            </div>
        </div>
    </div>


</div>
<div class="container-fluid p-0" style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow:0 -2px 7px rgba(0,0,0,.15); min-height: 80px;">
    <div class="row">
        <div class="col-6 p-3 text-right"><button class="btn btn-secondary">임시저장</button></div>
        <div class="col-6 p-3 "><button class="btn btn-dark">상신하기</button></div>
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
                    <div class="row">
                        <div class="col-4 m-3" style=" border: 1px solid pink">
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-12 p-2"><input type="text" class="w-100" id="search" placeholder="부서명, 이름 입력."></div>
                            </div>
                            <div class="row">
                                <div class="col-12 ">-대표 회사명 넣을지?</div>
                            </div>
                            <input type="hidden" id="deptsize" value="${size}">

                                <c:forEach var="i" items="${deptList}">
                                    <div class="allcontainer">
                                        <div class="deptteamcontainer" id="deptteamcontainer${i.code}">
                                            <div class="row" style="cursor: pointer;" id="confirmdept${i.code}">
                                                <div class="col-1 "><img src="/icon/plus-square.svg" id="deptopencloseicon${i.code}" onclick="fn_getteamlist(${i.code})"> </div>
                                                <div class="col-5  p-0 pl-1" >${i.name}</div>
                                                <input type="hidden" id="deptname${i.code}" value="${i.name}">
                                            </div>
                                        </div>
                                        <div id="childcontainer${i.code}"></div>

                                    </div>
                                </c:forEach>

                        </div>
                        <div class="col-1 p-0 d-flex justify-content-center" style="min-height:540px; align-items: center; flex:1;">
                            <div class="row ">
                                <div class="col-12">
                                    <button class="btn btn-outline-dark btn-sm" id="btn_confirm" disabled onclick="fn_addconfirm()">결재</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 m-3" style="min-height:540px; border: 1px solid pink">
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-7 p-2">기안</div>
                                <div class="col-5 p-2">김지영(뭐하지?)|기획부</div>
                            </div>
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-7 p-2">결재자</div>
                            </div>
                            <%--ajax로 추가되는 부분.--%>
                            <div class="confirmcontainer" id="sortable">

                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-dark">적용</button>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
<script>

    var getempcode=0;
    var getaddedempcode = [];
    var count =0;

    function fn_openconfirmdept(code){
        var a= $("#deptteamcontainer"+code).nextAll();
        a.css("display","block");
        $("#deptopencloseicon"+code).attr("onclick","fn_closeconfirmdept("+code+")");
        $("#deptopencloseicon"+code).attr("src","/icon/dash-square.svg");
    }

    function fn_closeconfirmdept(code) {
        var a= $("#deptteamcontainer"+code).nextAll();
        a.css("display","none");
        $("#deptopencloseicon"+code).attr("onclick","fn_openconfirmdept("+code+")");
        $("#deptopencloseicon"+code).attr("src","/icon/plus-square.svg");
    }

    function fn_openconfirmteam(code,rootcode){
        var a= $("#teamcontainer"+code).next();
        a.css("display","block");
        $("#teamopencloseicon"+code).attr("onclick","fn_closeconfirmteam("+code+")");
        $("#teamopencloseicon"+code).attr("src","/icon/dash-square.svg");
    }

    function fn_closeconfirmteam(code,rootcode) {
        var a= $("#teamcontainer"+code).next();
        a.css("display","none");
        $("#teamopencloseicon"+code).attr("onclick","fn_openconfirmteam("+code+")");
        $("#teamopencloseicon"+code).attr("src","/icon/plus-square.svg");

    }

    /*파일 추가 부분*/
    function fn_filechange(){
        var inputFile= $("#file")[0].files;
        if((inputFile).length>5){
            alert("파일 첨부는 최대 5개까지 가능합니다.");
            return;
        }
        var html="";
        for(var i=0;i<inputFile.length;i++){
            html+="<span class=p-2 id=inputfile"+i+">"+inputFile[i].name+"<img src=/icon/close-x.svg onclick=fn_deleteinputfile("+i+")></span>"
        }
        $("#filecontainer").html(html);

    }
    function fn_deleteinputfile(seq){

    }

    function fn_getteamlist(code){
        $.ajax({
            type : "POST",
            url : "/restdocument/getteamlist.document",
            data : {code },
            dataType :"json",
            success : function(data) {
                console.log(code);
                var html="";
                for(var i=0;i<data.length;i++){
                    html+="<div id=teamcontainer"+data[i].code+">";
                    html+="<div class=row d-none style=cursor:pointer onclick=fn_closeconfirmteam() id=confirmteam"+data[i].code+">";
                    html+="<div class=\"col-1 p-0 ml-2 text-right\"><img src=/icon/plus-square.svg id=teamopencloseicon"+data[i].code+" onclick=fn_getemplist("+data[i].code+","+code+")></div>";
                    html+="<div class=\"col-5 p-0 pl-1\">"+data[i].name+"</div>";
                    html+="</div>";
                    html+="</div>";
                }
                $("#childcontainer"+code).append(html);
                $("#deptopencloseicon"+code).attr("src","/icon/dash-square.svg");
                $("#deptopencloseicon"+code).attr("onclick","fn_closeconfirmdept("+code+")");
            }
        });
    }

    function fn_getemplist(code,rootcode){
        $.ajax({
            type : "POST",
            url : "/restdocument/getemplist.document",
            data : {code },
            dataType :"json",
            success : function(data) {
                var html="";
                console.log(rootcode);
                html+="<div class=empcontainer2>";
                for(var i=0;i<data.length;i++){
                    html+="<div id=empcontainer"+data[i].code+">";
                    html+="<div class=row id=getemp"+code+" onclick=fn_getempname("+code+","+data[i].code+")>";
                    html+="<div class=col-1></div>";
                    html+="<div class=\"col-8 pl-1\">-"+data[i].name+"("+data[i].posname+")</div>";
                    html+="<input type=hidden value="+data[i].name+">";
                    html+="</div>";
                    html+="</div>";
                }
                html+="</div>";
                $("#teamcontainer"+code).after(html);
                $("#teamopencloseicon"+code).attr("src","/icon/dash-square.svg");
                $("#teamopencloseicon"+code).attr("onclick","fn_closeconfirmteam("+code+","+rootcode+")");
            }
        });
    }


    $("#search").keydown(function (key) {
        var size = $("#deptsize").val();
        var search = $("#search").val();
        if(key.keyCode==13) {
            for (var i = 1; i <= size; i++) {
                var a = $("#deptname" + i).val();
                if (a.includes(search)) {
                    $(".allcontainer").eq(i - 1).css("display", "block");
                } else {
                    $(".allcontainer").eq(i - 1).css("display", "none");
                }
            }
        }

    })

    function fn_getempname(code,empcode){
        var a = $("#getemp"+code).children('input').val();
        $("#btn_confirm").attr("disabled",false);
        getempcode=empcode;
    }
    function fn_addconfirm() {
        var code = getempcode;
        console.log(getaddedempcode);
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
            url : "/restdocument/addconfirm.document",
            data : {code},
            dataType : "json",
            success : function(data) {
                var html = "";
                for (var i = 0; i < data.length; i++) {
                    html += "<div class=\"row p-2 w-100 m-0\" style=\"border-bottom:1px solid pink\">";
                    html += "<div class=\"col-2 p-2\">결재</div>";
                    html += "<div class=\"col-6 p-2\">" + data[i].name + "|" + data[i].deptname + "</div>";
                    html += "<div class=\"col-2 p-2 text-right\"><img src=/icon/close-x.svg></div>";
                    html += "<div class=\"col-2 p-2 text-right\"><img class=ui-state-default src=/icon/item-list.svg></div>";
                    html += "</div>";
                }

                getaddedempcode[count]=getempcode;
                count++;
                $(".confirmcontainer").append(html);
            }
        });
    }
    $( function() {
        $( "#sortable" ).sortable();
        $( "#sortable" ).disableSelection();
    } );







</script>

</body>
</html>