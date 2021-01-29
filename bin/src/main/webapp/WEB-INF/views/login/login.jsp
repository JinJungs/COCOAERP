<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%--<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />--%>
    <title>loginForm</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link href="https://getbootstrap.com/docs/4.0/examples/signin/signin.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <form class="form-signin" method="post" action="/membership/login">
        <h2 class="form-signin-heading">코코아 워크 로그인</h2>
        <p>
            <label for="code" class="sr-only">Username</label>
            <input type="text" id="code" name="code" class="form-control" placeholder="사번 입력" required="" autofocus="">
        </p>
        <p>
            <label for="password" class="sr-only">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호 입력" required="">
        </p>
        <!--input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /-->
        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
    </form>
</div>
</body>
</html>