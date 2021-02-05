<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<title>Sidebar 02</title>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
   href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900"
   rel="stylesheet">

<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/css/style.css">
</head>
<body>

   <nav id="sidebar">
      <div class="custom-menu">
         <button type="button" id="sidebarCollapse" class="btn btn-primary">
            <i class="fa fa-bars"></i> <span class="sr-only">Toggle Menu</span>
         </button>
      </div>
      <div class="p-4 pt-5">
         <h3>
            <a href="index.html" class="logo">COCOAWORK</a>
         </h3>
         <ul class="list-unstyled components mb-5">
            
            <!-- 업무일지 --> 
            <li class="active">
               <a href="#BusinessLog" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">업무일지</a>
               <ul class="collapse list-unstyled" id="BusinessLog">
                  <li><a href="#">업무일지 작성</a></li>
                  <li><a href="#">업무일지 보관함</a></li>
                  <li><a href="#">확인요청 업무일지함</a></li>
                  <li><a href="#">임시저장 업무일지함</a></li>
                  <li><a href="#">내가보낸 업무일지함</a></li>
               </ul>
            </li>
            <!-- 전자결재 -->
            <li class="active">
               <a href="#Document1" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">전자결재</a>
               <ul class="collapse list-unstyled" id="Document1">
                  <li><a href="#">결재문서 작성</a></li>
               </ul>
            </li>
            <!-- 전자결재 (기안함)-->
            <li><a href="#Document2" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">전자결재 (기안함)</a>
               <ul class="collapse list-unstyled" id="Document2">
                  <li><a href="/document/d_searchTemporary.document?&searchText=">저장된 문서</a></li>
                  <li><a href="/document/d_searchRaise.document?&searchText=">상신한 문서</a></li>
                  <li><a href="/document/d_searchApproval.document?&searchText=">승인된 문서</a></li>
                  <li><a href="/document/d_searchReject.document?&searchText=">반려된 문서</a></li>
                  <li><a href="/document/d_searchReturn.document?&searchText=">회수한 문서</a></li>
                  <li><a href="/document/allDocument.document">전체보기</a></li>
                  <li><a href="/document/allConfirmDoc.document">문서대장</a></li>
               </ul>
            </li>
            <!-- 전자결재 (결재함)-->
            <li><a href="#Document3" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">전자결재 (결재함)</a>
               <ul class="collapse list-unstyled" id="Document3">
                  <li><a href="#">결재전 문서</a></li>
                  <li><a href="#">진행중 문서</a></li>
                  <li><a href="#">완료된 문서</a></li>
                  <li><a href="#">반려한 문서</a></li>
               </ul>
            </li>
            <!-- 일정관리 -->    
            <li><a href="#Email" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">일정관리</a>
               <ul class="collapse list-unstyled" id="Email">
                  <li><a href="/schedule/toScheduleMain.schedule">회사일정</a></li>
                  <li><a href="#">휴가 현황</a></li>
               </ul>
            </li>
            <!-- 근태현황-->
            <li><a href="#Schedule" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">근태현황</a>
               <ul class="collapse list-unstyled" id="Schedule">
                  <li><a href="#">근태현황 보기</a></li>
                  <li><a href="#">출퇴근 체크</a></li>
               </ul>
            </li>
            <!-- 메신저-->
            <li><a href="#Chat" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">메신저</a>
               <ul class="collapse list-unstyled" id="Chat">
                  <li><a href="#">연락처 리스트</a></li>
                  <li><a href="#">1:1 채팅</a></li>
                  <li><a href="#">1:N 채팅</a></li>
               </ul>
            </li>
            <!-- 전자우편-->
            <li><a href="#Mail" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">전자우편</a>
               <ul class="collapse list-unstyled" id="Mail">
                  <li><a href="/email/sendPage.email">메일작성</a></li>
                  <li><a href="/email/receiveList.email?cpage=1">받은 메일함</a></li>
                  <li><a href="/email/sendToMeList.email?cpage=1">내게 쓴 메일함</a></li>
                  <li><a href="/email/sendList.email?cpage=1">보낸 메일</a></li>
                  <li><a href="/email/deleteList.email?cpage=1">휴지통</a></li>
               </ul>
            </li>
            <!-- 커뮤니티-->
            <li><a href="#Community" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">커뮤니티</a>
               <ul class="collapse list-unstyled" id="Community">
                  <li><a href="#">회사소식 게시판</a></li>
                  <li><a href="#">자유 게시판</a></li>
                  <li><a href="#">앨범 게시판</a></li>
                  <li><a href="#">내가 쓴글</a></li>
               </ul>
            </li>
            <!-- 개인정보-->
            <li><a href="#PersonalInfor" data-toggle="collapse"
               aria-expanded="false" class="dropdown-toggle">개인정보</a>
               <ul class="collapse list-unstyled" id="PersonalInfor">
                  <li><a href="#">개인정보 수정</a></li>
               </ul>
            </li>
            <!-- 조직도 -->
            <li><a href="#">조직도</a></li>
            <!-- 버그리포팅 -->
            <li><a href="#">버그리포팅</a></li>
         </ul>


      </div>
   </nav>

   <script src="/js/jquery.min.js"></script>
   <script src="/js/popper.js"></script>
   <script src="/js/bootstrap.min.js"></script>
   <script src="/js/main.js"></script>
</body>
</html>