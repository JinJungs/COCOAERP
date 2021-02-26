<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>통합검색</title>
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
          crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
          integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
          crossorigin="anonymous">
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/css/messenger.css">
    <style>
    </style>
</head>
<body>

<!-- top head -->
<div class="w-100 h-100 chat container-fluid p-0 min-w-450">
    <div class="row w-100 m-0 h15">
        <div class="card-header w-100 p-3 align-center" style="border-radius: 0%;">
            <div class="input-group float-right col-10 col-sm-9 col-md-8 p-2">
                <input type="text" placeholder="파일,이미지 이름 검색" name=""
                       class="form-control search" id="searchContents">
                <div class="input-group-prepend">
                  <span class="input-group-text search_btn" id="searchBtn"> <i
                          class="fas fa-search"></i>
                  </span>
                </div>
            </div>
            <div class="row w-100 ml-4 pt-3">
                <div class="col-12 col-sm-10 col-md-9 col-lg-8">
                    <div class="row searchMenu">
                        <div class="col-2 p-0" id="showAll">전체</div>
                        <div class="col-2 p-0" id="showImage">사진/영상</div>
                        <div class="col-2 p-0" id="showFile">파일</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- main -->
    <input type="hidden" id="searchKeyword" value="${searchKeyword}">
    <div class="row w-100 h-85 m-0 p-4 border-top whiteBg">
        <div class="search_body col-12">
            <!-- 이미지/파일 모두 불러오기-->
            <div class="container col-12" id="jointAll">
            <c:choose>
            	<c:when test="${empty list}">
            		채팅방에 공유된 이미지/파일이 없습니다.
            	</c:when>
            	<c:otherwise>
            		<div class="containerPerDate mb-4">
                    <div class="flex-container p-0 m-0">
	                    <c:forEach var="i" items="${list}" varStatus="status">
                            <%--<fmt:formatDate value="${list[status.index].uploadeddate}" pattern="yyyy년 M월 d일" var="before_date" />
                            <fmt:formatDate value="${list[status.index+1].uploadeddate}" pattern="yyyy년 M월 d일" var="after_date" />--%>
                            <c:if test="${list[status.index].s_uploadeddate ne list[status.index-1].s_uploadeddate}">
                            <div class="row w-100" id="dateBox${i.seq}">
                                <div class="col-12 date" id="date${i.seq}">${i.s_uploadeddate}</div>
                            </div>
                            </c:if>
	                    	<c:choose>
	                    		<c:when test="${i.type eq 'IMAGE'}">
			                    	<a href="/files/downloadMessengerFile.files?savedname=${i.savedname}&oriname=${i.orinameEncoded}">
			                            <div class="flex-item">
			                                <img src="/messengerFile/${i.savedname}">
			                            </div>
			                        </a>
	                    		</c:when>
	                    		<c:otherwise>
			                    	<a href="/files/downloadMessengerFile.files?savedname=${i.savedname}&oriname=${i.orinameEncoded}">
			                            <div class="flex-item">
			                                <div class="fileIcon"></div>
			                                <span id="filename">${i.oriname}</span>
			                            </div>
			                        </a>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </c:forEach>  
                    </div>
                </div>
            	</c:otherwise>
            </c:choose>
            	<!-- sample images --> 
                <div class="containerPerDate mb-4">
                    <div class="date">2020-00-00</div>
                    <div class="flex-container">
                        <a href="#.pdf">
                            <div class="flex-item">
                                <div class="fileIcon"></div>
                                <span id="filename">filenamee</span>
                            </div>
                        </a>
                        <a href="#"> 
                            <div class="flex-item">
                                <img src="/img/run.png" alt="sampleimg">
                            </div>
                        </a>
                    </div>
                </div>
                <!-- sample images -->                
            </div>
            
            <!-- 이미지 불러오기 -->
            <div class="container col-12" id="jointImage">
            이미지만 올라올 예정
            날짜별로 분류할라믄 의진씨처럼 항목별로 따로 받을까
            고민즁
            </div>
            <!-- 파일 불러오기 -->
            <div class="container col-12" id="jointFile">
            파일만 올라올 예정
            날짜별로 분류할라믄 의진씨처럼 항목별로 따로 받을까
            고민즁
            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 날짜 변경 라이브러리-->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
    let jointAll = document.getElementById("jointAll");
    let jointImage = document.getElementById("jointImage");
    let jointFile = document.getElementById("jointFile");
    //let memberMessage = document.getElementById("memberMessage");
    let searchKeyword = $("#searchKeyword").val();

    document.getElementById("showAll").addEventListener('click', showAll);
    document.getElementById("showImage").addEventListener('click', showImage);
    document.getElementById("showFile").addEventListener('click', showFile);
    //let showMessage = document.getElementById("showMessage");

    $(document).ready(function () {
        //전체라는 글자를 굵게하는 효과
        showAllBoldText();
        // 검색창에 검색했던 키워드 띄우기
        $("#searchContents").val(searchKeyword);

        /*// 날짜별로 구분하기
        let uploadeddate = moment(${i.uploadeddate}).format('YYYY년 M월 D일');
        if(before_date !== uploadeddate) {
            existMsg += "<div class='row w-100 text-center font-weight-light m-0 p-0'>"
            existMsg += "<div class='col-12 pb-3'>" + delete_hours_date + "</div></div>"
            before_date = uploadeddate;
        }*/
    });

    function showAllBoldText() {
        $("#showAll").css("font-weight", "Bold");
    }

    function showAll() {
        jointAll.style.display = "block";
        jointImage.style.display = "none";
        jointFile.style.display = "none";
        $("#showAll").css("font-weight", "Bold");
        $("#showImage").css("font-weight", "normal");
        $("#showFile").css("font-weight", "normal");
        //memberMessage.style.display="none";
    };

    function showImage() {
        jointAll.style.display = "none";
        jointImage.style.display = "block";
        jointFile.style.display = "none";
        $("#showAll").css("font-weight", "normal");
        $("#showImage").css("font-weight", "Bold");
        $("#showFile").css("font-weight", "normal");
        //memberMessage.style.display="none";
    };

    function showFile() {
        jointAll.style.display = "none";
        jointImage.style.display = "none";
        jointFile.style.display = "block";
        $("#showAll").css("font-weight", "normal");
        $("#showImage").css("font-weight", "normal");
        $("#showFile").css("font-weight", "Bold");
        //memberMessage.style.display="none";
    };



</script>
<script src="/resources/static/js/messenger.js"></script>
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
</body>
</html>