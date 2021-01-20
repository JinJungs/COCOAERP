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

    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="container w-80 p-0">
            <div class="row w-100">
                <h5>업무 *</h5>
            </div>
            <div class="row w-100" style="border-top: 1px solid pink; border-bottom: 1px solid pink;">
                <div class="col-md-2 col-sm-3 col-3 p-3" style="border-right: 1px solid pink">기안 양식</div>
                <div class="col-md-4 col-sm-3 col-3 p-3" style="border-right: 1px solid pink">업무 기안</div>
                <div class="col-md-2 col-sm-3 col-3 p-3" style="border-right: 1px solid pink">문서 번호</div>
                <div class="col-md-4 col-sm-3 col-3 p-3">떙땡땡</div>
            </div>
            <div class="row w-100" style= "border-bottom: 1px solid pink;">
                <div class="col-md-2 col-sm-3 col-3 p-3" style="border-right: 1px solid pink">기안자</div>
                <div class="col-md-4 col-sm-3 col-3 p-3" style="border-right: 1px solid pink">권용국</div>
                <div class="col-md-2 col-sm-3 col-3 p-3" style="border-right: 1px solid pink">기안 부서</div>
                <div class="col-md-4 col-sm-3 col-3 p-3">개발부</div>
            </div>
            <div class="row w-100 pt-5" style="border-bottom: 1px solid pink;">
                <div class="col-md-10 p-0 pt-2"><b>결재선</b></div>
                <div class="col-md-2 p-0 text-right"><button type="button" class="btn btn-outline-dark p-1 mb-2" data-toggle="modal" data-target="#modal">결재선 설정</button>

                </div>
            </div>
            <div class="row w-100 pt-4 pb-4 pl-3 pr-3" style="border-bottom: 1px solid pink;">
                결재선 들어갈 곳 나중에 ajax로
            </div>
            <div class="row w-100 pt-5 pb-2" style="border-bottom: 1px solid pink;">
                <b>기안 내용</b>
            </div>
            <div class="row w-100" style="border-bottom: 1px solid pink;">
                <div class="col-md-2 p-3" style="border-right: 1px solid pink;">기안 제목</div>
                <div class="col-md-10 p-3" ><input type="text" placeholder="기안제목 입력" style="min-width: 400px; border: 1px solid pink;"></div>
            </div>
            <div class="row w-100" style="border-bottom: 1px solid pink;">
                <div class="col-md-2 p-3" style="border-right: 1px solid pink;">파일 첨부</div>
                <div class="col-md-10 p-3"><input type="file" multiple="multiple"></div>
            </div>
            <div class="row w-100 pt-3">
                <div class="col-md-12"><textarea class="w-100" style="min-height: 350px"></textarea></div>
            </div>
        </div>


    </div>


</div>
<div class="container-fluid p-0" style="position: fixed; background-color: white; left: 0; bottom: 0; box-shadow:0 -2px 7px rgba(0,0,0,.15); min-height: 80px;">
    <div class="row">
        <div class="col-md-6 p-3 text-right"><button class="btn btn-secondary">임시저장</button></div>
        <div class="col-md-6 p-3 "><button class="btn btn-dark">상신하기</button></div>
    </div>
</div>
<div class="modal" id="modal" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12"><b>결재선 설정</b></div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 m-3" style="min-height:540px; border: 1px solid pink">
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-md-12 p-2"><input type="text" class="w-100" placeholder="부서명, ID또는 이름 입력."></div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">-대표 회사명 넣을지?</div>
                            </div>
                            <div class="row" style="cursor: pointer;" onclick="fn_openconfirmdept()" id="confirmdept">
                                <div class="col-md-1"><img src="icon/plus-square.svg" id="deptopencloseicon"> </div>
                                <div class="col-md-5 p-0 pl-1">부서이름</div>
                            </div>
                            <div class="row d-none" style=" cursor: pointer;" onclick="fn_openconfirmteam()" id="confirmteam" >
                                <div class="col-md-1 p-0 ml-2 text-right"><img src="icon/plus-square.svg" id="teamopencloseicon"></div>
                                <div class="col-md-5 p-0 pl-1">팀이름</div>
                            </div>
                            <div class="team-container d-none" id="team-container">
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-8 pl-1">-김지영(뭐하지?)</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-8 pl-1">-권용국(영어이름?)</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-8 pl-1">-정의진(별명?)</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1 p-0 d-flex justify-content-center" style="min-height:540px; align-items: center; flex:1;">
                            <div class="row ">
                                <div class="col-md-12">
                                    <button class="btn btn-outline-dark btn-sm" disabled>결재</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 m-3" style="min-height:540px; border: 1px solid pink">
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-md-7 p-2">기안</div>
                                <div class="col-md-5 p-2">김지영(뭐하지?)|기획부</div>
                            </div>
                            <div class="row" style="border-bottom: 1px solid pink;">
                                <div class="col-md-7 p-2">결재자</div>
                            </div>
                            <%--ajax로 추가되는 부분.--%>
                            <div class="row p-2 w-100 m-0" style="border-bottom: 1px solid pink;">
                                <div class="col-md-2 p-2">결재</div>
                                <div class="col-md-7 p-2">김지영(뭐하지?)|기획부</div>
                                <div class="col-md-1 p-2">icon</div>
                                <div class="col-md-1 p-2">icon</div>
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
<script>
    function fn_openconfirmdept(){
        var teamiconsrc = $("#teamopencloseicon").attr("src");
        $("#confirmteam").attr("class","row");
        $("#confirmdept").attr("onclick","fn_closeconfirmdept()");
        $("#deptopencloseicon").attr("src","icon/dash-square.svg");
        if(teamiconsrc=="icon/dash-square.svg"){
            $("#team-container").attr("class","team-container");
        }
    }
    function fn_closeconfirmdept() {
        $("#confirmteam").attr("class","row d-none");
        $("#confirmdept").attr("onclick","fn_openconfirmdept()");
        $("#deptopencloseicon").attr("src","icon/plus-square.svg");
        $("#team-container").attr("class","team-container d-none");
    }

    function fn_openconfirmteam(){
        $("#team-container").attr("class","team-container");
        $("#confirmteam").attr("onclick","fn_closeconfirmteam()");
        $("#teamopencloseicon").attr("src","icon/dash-square.svg");
    }

    function fn_closeconfirmteam() {
        $("#team-container").attr("class","team-container d-none");
        $("#confirmteam").attr("onclick","fn_openconfirmteam()");
        $("#teamopencloseicon").attr("src","icon/plus-square.svg");
    }

</script>

</body>
</html>