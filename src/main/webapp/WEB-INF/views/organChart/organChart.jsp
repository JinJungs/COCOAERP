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
        .deptcontainer, .teamst, .r-teammain{
            cursor: pointer;
        }
        .deptcontainer:hover, .teamst:hover, .r-teammain:hover{
            background-color: #cbd3da;
        }
        .
    </style>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="container-fluid">
            <div class="row">
                <div class="col-5 p-3">코코아 조직도</div>
                <div class="col-5 p-3 text-right"><input type="text"></div>
            </div>

            <div class="row" style="min-width: 1280px;min-height: 800px;" >
                <div class="col-3  p-4" style="border: 1px solid black; max-width: 400px;">
                    <div class="row pb-3" style="border-bottom: 1px solid black; ">
                        <div class="col-5" style="font-size: 18px;font-weight: bold">${user.name}</div><div class="col-7 text-right" style="font-size: 14px;line-height: 28px;">${user.deptname} | ${user.teamname}</div>
                    </div>
                    <form id="leftform">
                        <c:forEach var="dlist" items="${dlist}">
                            <div class="row mt-2 deptcontainer" id="deptcontainer${dlist.code}" onclick="fn_openteamlist(${dlist.code})">
                                <div class="col-12">
                                    <img src="/icon/plus-square.svg">
                                    <span>${dlist.name}</span>
                                    <input type="hidden" name="code" value="${dlist.code}">
                                </div>
                            </div>
                        </c:forEach>
                    </form>
                </div>
                <div class="col-9  r-container" style="border: 1px solid black; min-width: 800px;">

                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/jquery.MultiFile.min.js"></script>
<script>
    $( function() {
        fn_getTeamList();
    });

    function fn_getTeamList() {
        $.ajax({
            type : "POST",
            url : "/restorganchart/getteamlist.organ",
            data : $("#leftform").serialize(),
            dataType :"json",
            success : function(data) {
                var html="";
                for(var i=0;i<data.length;i++){
                    html+="<div class=\"row mt-2 teamst teamcontainer"+data[i].dept_code+" d-none\" id=teamcontainer onclick=fn_getteamemplist("+data[i].team_code+")>";
                    html+="<div class=col-1></div>"
                    html+="<div class=\"col-5 p-0\">";
                    html+="<span class='pr-2'>"+data[i].team_name+"<span><span class='pl-1'> ("+data[i].count+")</span>";
                    html+="</div>";
                    html+="</div>";
                    $("#deptcontainer"+data[i].dept_code).after(html);
                    html="";
                }
            }
        });
    }

    function fn_openteamlist(code) {
        $(".teamcontainer"+code).attr("class","row mt-2 teamst teamcontainer"+code+"");
        $("#deptcontainer"+code).attr("onclick","fn_closeteamlist("+code+")");
    }
    function fn_closeteamlist(code){
        $(".teamcontainer"+code).attr("class","row teamst d-none mt-2 teamcontainer"+code+" d-none");
        $("#deptcontainer"+code).attr("onclick","fn_openteamlist("+code+")");
    }
    function fn_getteamemplist(code){
        $.ajax({
            type : "POST",
            url : "/restorganchart/getteamemplist.organ",
            data : {team_code:code},
            dataType :"json",
            success : function(data) {
                $(".r-container").empty();
                if(data.length!=0) {
                    var header = "";
                    header += "<div class=\"row p-3 r-teamheader\">";
                    header += "<div class=col-12>";
                    header += "<span style='font-size: 24px;font-weight: bold;'>" + data[0].teamname + "</span><span class='pl-1' style='font-size: 24px;'>("+data.length+")</span>";
                    header += "</div></div>";


                    var main="";
                    for(var i=0;i<data.length;i++){
                        main+="<div class=\"row p-2 r-teammain\">";
                        main+="<div class=col-12>";
                        main+="<div class=row>";
                        main+="<div class=col-12 style='font-size: 18px;font-weight: bold'>"+data[i].name+"</div>";
                        main+="</div>";
                        main+="<div class=row>";
                        main+="<div class=col-12>"+data[i].posname+" | "+data[i].deptname+"</div>";
                        main+="</div>";
                        main+="</div>";
                        main+="</div>";
                    }
                    $(".r-container").append(header);
                    $(".r-teamheader").after(main);
                }



            }
        });
    }
</script>
</body>
</html>