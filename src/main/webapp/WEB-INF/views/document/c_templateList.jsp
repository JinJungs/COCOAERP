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
            <div class="row" id="defaultheader" style="border-top:1px solid #c9c9c9; cursor: pointer" onclick="fn_closelist()">
                <div class="col-md-11 col-sm-10 col-10 pt-md-3"><b>기본 양식 ${size}</b></div>
                <div class="col-md-1 col-sm-2 col-2 text-right pt-md-3">▼</div>
            </div>
            <div class="row" id="defaultmain">
                <div class="col-md-12" >
                    <div class="row" style="border-bottom: 1px solid #c9c9c9;">
                    <c:forEach var="list" items="${list}">
                        <div class="col-md-1 col-3 p-0 m-md-3 m-3 conbox" style="border: 1px solid #DCDCDC; min-width:135px; max-width: 135px; min-height:130px" id="templatelist"+{list.code} onclick="fn_toWriteDocument(${list.code},'${list.name}')">
                            <div class="row m-0 pt-1 pb-1" style="background-color: #F2F6FF">
                                <div class="col-md-12 text-center" >${list.name}</div>
                            </div>
                            <div class="row m-0">
                                <div class="col-md-12">${list.name}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                </div>
            </div>
            <c:if test="${subsize!=0}">
                <div class="row" id="subheader" style=" cursor: pointer; border-bottom: 1px solid  #c9c9c9; padding-bottom: 10px;" onclick="fn_subopenlist()">
                    <div class="col-md-11 col-sm-10 col-10 pt-md-3"><b>만든 양식 ${subSize}</b></div>
                    <div class="col-md-1 col-sm-2 col-2 text-right pt-md-3">▼</div>
                </div>
                <div class="row" id="submain" style="display: none; ">
                    <div class="col-md-12" >
                        <div class="row" style="border-bottom: 1px solid  #c9c9c9;">
                            <c:forEach var="sublist" items="${subList}">
                                <div class="col-md-1 col-3 p-0 m-md-3 m-3" style="border: 1px solid  #c9c9c9; min-width: 135px; min-height:120px">
                                    <div class="row m-0" style="border-bottom: 1px solid  #c9c9c9;">
                                        <div class="col-md-12 text-center" >${sublist.name}</div>
                                    </div>
                                    <div class="row m-0">
                                        <div class="col-md-12">${sublist.name}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                </div>
            </c:if>
        </div>
    </div>

</div>
<script>
    /*접어따 펴따*/
    function fn_closelist(){
        $("#defaultmain").css("display","none");
        $("#defaultheader").css("border-bottom","1px solid pink");
        $("#defaultheader").css("padding-bottom","10px");
        $("#defaultheader").attr("onclick","fn_openlist()");
    }
    function fn_openlist() {
        $("#defaultmain").css("display","block");
        $("#defaultheader").css("border-bottom","none");
        $("#defaultheader").attr("onclick","fn_closelist()");
    }
    function fn_subcloselist(){
        $("#submain").css("display","none");
        $("#subheader").css("border-bottom","1px solid pink");
        $("#subheader").css("padding-bottom","10px");
        $("#subheader").attr("onclick","fn_subopenlist()");
    }
    function fn_subopenlist() {
        $("#submain").css("display","block");
        $("#subheader").css("border-bottom","none");
        $("#subheader").attr("onclick","fn_subcloselist()");
    }

    /*컨펌 이동*/
    function fn_toWriteDocument(code,name) {
        location.href="/document/toWriteDocument.document?code="+code+"&name="+name;

    }
</script>
</body>
</html>