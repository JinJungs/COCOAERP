
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <meta charset="UTF-8">
    <title>findIdForm</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <style>
        input {
            width: 100%
        }
        .login-Container{
            color: white;
            background-color: #00000080;
        }

        .flex-container{
            background: #000000;  /* fallback for old browsers */
            background: -webkit-linear-gradient(to right, #434343, #000000);  /* Chrome 10-25, Safari 5.1-6 */
            background: linear-gradient(to right, #434343, #000000); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */


            background-size: 400% 400%;
            width: 100%;
            height: 100vh;
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-align: center;
            -ms-flex-align: center;
            align-items: center;
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            justify-content: center;
        }
        .btn-login{
            font-weight: bold;
            color:white;
            background-color: #00000070;
        }
        .btn-login:hover{
            background-color: royalblue;
        }
        .find-id, .find-pw{
            font-weight: bold;
            cursor: pointer;
        }
        .find-id:hover, .find-pw:hover{
            color:#c9c9c9;
        }

    </style>
</head>
<body>
<div class="flex-container" id="loginDiv">
    <div class="row d-flex justify-content-center login-Container" style="min-width: 450px;">

        <div class="col-12 p-5">
            <div class="row w-100">
                <div class= "col-12 p-3">
                    <h4 class="form-signin-heading" style="font-weight: bold">아이디 찾기</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-12 p-3">
                    <label for="email" class="sr-only">Username</label>
                    <input type="text" id="email" name="code" class="form-control w-100" placeholder="이메일을 입력해주세요."
                           required="required"
                           autofocus="" autocomplete="off">
                </div>
            </div>
            <div class="row">
                <div class="col-12 p-3 idContainer">

                </div>
            </div>

            <div class="row">
                <div class="col-4 p-3">
                    <button class="btn btn-login" type="button" onclick="toLogin()">로그인 하기</button>
                </div>
                <div class="col-5 p-3">
                    <button class="btn btn-login" type="button" onclick="fn_toFindPw()">비밀번호 찾기</button>
                </div>
                <div class="col-3 p-0 pt-3">
                    <button class="btn btn-login" type="button" onclick="findId()">찾기</button>
                </div>
            </div>
            <!--input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /-->
        </div>


    </div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
    var tempEmail ="";

    function findId() {
        var email= $("#email").val();
        if(email==""){
            var html="";
            $(".idContainer").empty();
            html+="<div class=row>";
            html+="<div class='col-12 p-3'>";
            html+="이메일을 입력해주세요.";
            html+="</div>";
            html+="</div>";
            $(".idContainer").append(html);
            $("#email").focus();
            return;
        }
        $.ajax({
            url: "/membership/findIdByEmail",
            type: "post",
            data: {email: $("#email").val()},
            dataType: "json",
            success: function (data) {
                tempEmail=$("#email").val();
                var html="";
                $(".idContainer").empty();
                if(data!="") {
                    html+="<div class=row>";
                    html+="<div class='col-12 p-3'>";
                    html+="고객님의 정보와 일치하는 아이디 목록입니다.";
                    html+="</div>";
                    html+="</div>";
                    for (var i = 0; i < data.length; i++) {
                        html += "<div class=row>";
                        html += "<div class='col-12 p-3'>";
                        html += "<div class='custom-control custom-radio'>"
                        html += "<input type=radio name=code id=code"+i+" class=custom-control-input value="+data[i].code+">";
                        html += "<label class='custom-control-label' for=code"+i+">"+data[i].code+"</label>";
                        html += "</div>";
                        html += "</div>";
                        html += "</div>";
                    }
                    $(".idContainer").append(html);
                }else{
                    html+="<div class=row>";
                    html+="<div class='col-12 p-3'>";
                    html+="고객님의 정보와 일치하는 정보가 없습니다.";
                    html+="</div>";
                    html+="</div>";
                    $(".idContainer").append(html);
                }


            }
        })
    }

    function toLogin() {
        var getRadio=$("input[name=code]:checked").val();
        if(getRadio!=undefined){
            location.href="/membership/toLogin?code="+getRadio+"";
        }else{
            location.href="/";
        }

    }
    function fn_toFindPw(){
        var getRadio=$("input[name=code]:checked").val();
        if(tempEmail!=""||getRadio!=undefined){
            location.href="/membership/findPw?email="+tempEmail+"&code="+getRadio;
        }else{
            location.href="/membership/findPw";
        }

    }
</script>
</body>
</html>