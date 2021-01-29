<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>
<button type="button" class="btn btn-primary" id="showChat_btn">showChat</button>
<button type="button" class="btn btn-primary" id="showContactList_btn">showContactList</button>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    $('#showChat_btn').click(function(){
        var popup = window.open('/messenger/chat','','width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
    })
    $('#showContactList_btn').click(function(){
        var popup = window.open('/messenger/contactList','','width=450px, height=660px, resizable=no, scrollbars=no, fullscreen=yes');
    })
</script>
</body>
</html>