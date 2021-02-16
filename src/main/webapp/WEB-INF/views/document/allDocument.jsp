<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
   <style>
      .notice-container {
         width: 100%;
      }
      .notice-list {
         padding: 10x;
      }
      .notice-block {
         border-top: 0.5px solid lightgray;
         border-right: 0.5px solid lightgray;
         border-radius: 15px 15px 0 0;
         padding: 20px;
      }
      .notice-block p {
         margin: 0;
      }
      .notice-block a {
         text-decoration: none;
         color: black;
      }
      .notice-title {
         font-size: 1.3rem;
         margin-left: 5px;
      }
      .notice-contents {
         padding: 5px;
      }
      ul.tabs{
         list-style: none;
      }
      ul.tabs li{
         background: none;
         color: #222;
         display: inline-block;
         padding: 10px 20px;
         cursor: pointer;
      }
      ul.tabs li.current{
         background: #ededed;
         border-bottom: 2px solid lightgray;
         color: #222;
      }
      .tab-content{
         display: none;
      }
      .tab-content.current{
         display: inherit;
      }
      .notice-contents{
         margin-left: 10px;
         margin-right: 10px;
      }
      .notice-contents > a{
         color: gray;
      }
      .textBox{
         overflow:hidden;
         text-overflow:ellipsis;
         white-space:nowrap;
      }
      #c-hover:hover{
         background-color: whitesmoke;
       }
   </style>
</head>
<body>
<div class="wrapper d-flex align-items-stretch">
   <%@ include file="/WEB-INF/views/sidebar/sidebar.jsp"%>
   <!-- Page Content  -->

   <div id="content" class="p-4 p-5 pt-5">
      <div class="w-80 p-0" style="min-width: 800px;">
         <h2 class="mb-4">문서함</h2>
         <div class="notice-container">
            <ul class="tabs">
               <li class="tab-link current" data-tab="tab-1">기안함</li>
               <li class="tab-link" data-tab="tab-2">결재함</li>
            </ul>

            <div id="tab-1" class="tab-content current">
               <div class="row p-3" style="border-bottom: 1px solid #c9c9c9">
                  <div class="col-2 p-1 text-center textBox"><b>문서번호</b></div>
                  <div class="col-5 p-1 pl-2 text-center textBox"><b>제목</b></div>
                  <div class="col-3 p-1 text-center textBox"><b>작성날짜</b></div>
                  <div class="col-2 p-1 text-center textBox"><b>상태</b></div>
               </div>
               <div class=notice-list id=myboard>
                  <c:forEach var="list" items="${docList }" begin="0" end="10">
                     <div class="row p-3" id="c-hover" style="border-bottom: 1px solid #c9c9c9">
                        <div class="col-2 p-2 text-center textBox"><a href="/document/toReadPage.document?seq=${list.seq }">${list.seq }</a></div>
                        <div class="col-5 p-2 textBox"><a href="/document/toReadPage.document?seq=${list.seq }">${list.title }</a></div>
                        <div class="col-3 p-2 text-center textBox"><a href="/document/toReadPage.document?seq=${list.seq }">${list.write_date }</a></div>
                        <div class="col-2 p-2 text-center textBox"><a href="/document/toReadPage.document?seq=${list.seq }">${list.status }</a></div>
                     </div>
                  </c:forEach>
               </div>
            </div>

            <div id="tab-2" class="tab-content">
               <div class="row p-3" style="border-bottom: 1px solid #c9c9c9">
                  <div class="col-2 p-1 text-center textBox"><b>문서번호</b></div>
                  <div class="col-4 p-1 pl-2 text-center textBox"><b>제목</b></div>
                  <div class="col-2 p-1 text-center textBox"><b>작성날짜</b></div>
                  <div class="col-2 p-1 text-center textBox"><b>작성자 | 부서</b></div>
                  <div class="col-2 p-1 text-center textBox"><b>결재 상태</b></div>
               </div>
               <div class=notice-list id=myboard ">
                  <c:forEach var="clist" items="${clist }" begin="0" wns="10">
                     <div class="row p-3" id="c-hover" onclick="fn_toReadPage()" style="border-bottom: 1px solid #c9c9c9; cursor:pointer;">
                        <div class="col-2 p-2 text-center textBox">${clist.seq }</div>
                        <div class="col-4 p-2 textBox">${clist.title }</div>
                        <input type="hidden" id="getSeq" value="${clist.seq}">
                        <div class="col-2 p-2 text-center textBox">${clist.write_date }</div>
                        <div class="col-2 p-2 text-center textBox">${clist.emp_name } |${clist.dept_name}</div>
                        <div class="col-2 p-2 text-center textBox">${clist.status}</div>
                     </div>
                  </c:forEach>
               </div>
            </div>

            <script>
               $(document).ready(function() {

                  $('ul.tabs li').click(function() {
                     var tab_id = $(this).attr('data-tab');

                     $('ul.tabs li').removeClass('current');
                     $('.tab-content').removeClass('current');

                     $(this).addClass('current');
                     $("#" + tab_id).addClass('current');
                  })

               })
            </script>
         </div>


      </div>
   </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="/js/jquery-ui.js"></script>
<script>
   function fn_toReadPage (){
      var seq=$("#getSeq").val();
      location.href="/document/toReadPage.document?seq="+seq;
   }
</script>
</body>
</html>