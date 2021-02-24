<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기안 양식함</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.js"></script>
    <style>
        .conbox{
            cursor: pointer;
        }
        .conbox:hover{
            background-color: whitesmoke;
        }
    </style>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>   <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">
        <h4>기안 양식함</h4>
        <div id="container">
            <form id="formList">
                <c:forEach var="i" items="${formList}">
                    <div class="row" id="header${i.code}" style="cursor: pointer" onclick="fn_closelist(${i.code})">
                        <input type="hidden" name="form_code" value="${i.code}">
                        <div class="col-md-11 col-sm-10 col-10 pt-md-3"><b id="formTitle">${i.title} ${i.count}</b></div>
                        <div class="col-md-1 col-sm-2 col-2 text-right pt-md-3"><img src="/icon/caret-down-fill.svg"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12" >
                            <div class="row" id="contents${i.code}" style="border-bottom: 1px solid #c9c9c9;">
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </form>
        </div>
    </div>
</div>

</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
    /*접어따 펴따*/
    function fn_closelist(code){
        $("#contents"+code).attr("class","row d-none");
        $("#header"+code).css("border-bottom","1px solid pink");
        $("#header"+code).css("padding-bottom","10px");
        $("#header"+code).attr("onclick","fn_openlist("+code+")");
    }
    function fn_openlist(code) {
        $("#contents"+code).attr("class","row");
        $("#header"+code).css("border-bottom","none");
        $("#header"+code).attr("onclick","fn_closelist("+code+")");
    }

    /*컨펌 이동*/
    function fn_toWriteDocument(form_code,code) {
        location.href="/document/toWriteDocument.document?form_code="+form_code+"&code="+code;
    }
    $(function() {
        $.ajax({
            type : "POST",
            url : "/restdocument/getTemplatesListAjax.document",
            data : $("#formList").serialize(),
            dataType :"json",
            success : function(data) {
                html="";
                for(var i=0; data.length;i++) {
                    html+="<div class='col-md-1 col-3 p-0 m-md-3 m-3 conbox' style='border: 1px solid #DCDCDC; min-width:135px; max-width: 135px; min-height:130px' id=templatelist onclick=fn_toWriteDocument("+data[i].temp_code+","+data[i].code+")>";
                    html+="<div class='row m-0 pt-1 pb-1' style='background-color: #F2F6FF'>";
                    html+="<div class='col-md-12 text-center'>"+data[i].tempname+"</div>";
                    html+="</div>";
                    html+="<div class=\"row m-0\">";
                    html+="<div class=\"col-md-12\">"+data[i].explain+"</div>";
                    html+="</div></div>";
                    $("#contents"+data[i].form_code).append(html);
                    html="";
                }
            }
        })
    })


</script>
</body>
</html>