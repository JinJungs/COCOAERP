<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>

    <meta charset='utf-8' />
    <title>근태</title>

</head>

<body>
<div class="wrapper d-flex align-items-stretch">
    <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
    <div id="content" class="p-4 p-md-5 pt-5">

    </div>
</div>
<div class="modal fade" id="modal" tabindex="-1" role="dialog" data-backdrop="false" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
        <div class="modal-content">

            <div class="modal-body">
                <b id="workMsg"></b>
            </div>
            <div class="modal-footer border-top-0">
                <button type="button" class="btn btn-primary btn-sm" id="btn_ok" data-dismiss="modal" onclick="fn_in()">네</button>
                <button type="button" class="btn btn-dark btn-sm" data-dismiss="modal" >아니오</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade " id="resultModal" data-backdrop="false" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm" role="document" >
        <div class="modal-content">
            <div class="modal-header border-bottom-0 p-0 pt-2 pr-2">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body pb-2 text-center" style="min-height: 80px;">
                <b id="atdResultMsg">출근이 처리가 완료 되었습니다.</b>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/Chart.min.js"></script>
<script>

</script>
</body>
</html>