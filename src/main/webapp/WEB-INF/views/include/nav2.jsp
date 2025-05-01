<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/linkMain.css"/>
	<script>
		'use strict';
		
		$(document).ready(function() {
			
			 $('#search-result').click(function() {
          if ($("#hotel-search-container").css("display") === "none") {
              $("#hotel-search-container").show();  
          } else {
              $("#hotel-search-container").hide();  
          }
      });
			
		});
	</script>

	<style>
    ul, li {
      text-decoration: none;
      list-style: none;
    }

    body.modal-open {
      padding-right: 0 !important;
    }

    .nav-container {
      display: flex; /* flex로 설정 */
      justify-content: space-between; /* 항목 간 간격을 고르게 배치 */
      align-items: center; /* 세로로 중앙 정렬 */
      padding: 20px;
      max-width: 1200px;
      margin: 0 auto;
      z-index: 2000;
    }

    .nav-left {
      display: flex; /* 로고와 검색 결과를 묶은 div */
      align-items: center; /* 세로로 중앙 정렬 */
    }

    .logo {
      display: flex;
      align-items: center;
      line-height: 80px;
    }

    .search-result {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      background-color: #f7f7f7;
      padding: 10px 20px;
      border-radius: 5px;
      margin-left: 30px;
      white-space: nowrap; /* 한 줄로 유지 */
      overflow: hidden; /* 넘치지 않도록 */
    }
    .search-result:hover {
      background-color: #eee;
      cursor:pointer;
    }

    .nav-links {
      display: flex;
      align-items: center;
    }
    
    .nav-links a {
	  font-size: 18px;
	  font-weight: 500;
	}

    /* Style The Dropdown Button */
    .dropbtn {
      color: black;
      padding: 16px;
      font-size: 16px;
      border: none;
      cursor: pointer;
    }

    /* The container <div> - needed to position the dropdown content */
    .dropdown {
      position: relative;
      display: inline-block;
    }

    /* Dropdown Content (Hidden by Default) */
    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #f9f9f9;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
      z-index: 1;
    }

    /* Links inside the dropdown */
    .dropdown-content a {
      color: black;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
    }

    /* Change color of dropdown links on hover */
    .dropdown-content a:hover {
      background-color: #f1f1f1;
    }

    /* Show the dropdown menu on hover */
    .dropdown:hover .dropdown-content {
      display: block;
    }

    .dropdown:hover .dropbtn {
      background-color: #eee;
    }

    .search-result div {
      margin-right: 10px;
      font-size: 14px;
      font-weight: bold;
    }
    .search-result img {
   		 margin-top: -2px; 
		}
	</style>

<body>
<nav>
  <div class="nav-container">
    <div class="nav-left">
        <a href="${ctp}/" class="logo" style="display:flex; line-height: 80px;"><img src="${ctp}/images/logo.png" width="110px"/></a>
        
        <div class="search-result" id="search-result">
            <div class="search-item"><span><img src="${ctp}/images/search.png" width="19px" class="me-2"/>${searchString}</span></div>
            <div class="search-item me-0"><span>${fn:replace(fn:substring(checkinDate, 5, 10), '-', '.')}</span></div>
            <div class="search-item ms-1 me-1"><span>-</span></div>
            <div class="search-item ms-0"><span>${fn:replace(fn:substring(checkoutDate, 5, 10), '-', '.')}</span></div>
            <div class="search-item">인원<span> ${guestCount}</span></div>
            <div class="search-item">반려견<span> ${petCount}</span></div>
        </div>
    </div>
    
    <ul class="nav-links">
        <li><a href="${ctp}/">홈</a></li>
        <c:if test="${sLevel == 0 || sLevel == 1}">
            <li><a href="${ctp}/hotel/hotelInput">숙박시설 등록</a></li>
        </c:if>
        <li><a href="${ctp}/hotel/hotelList">전체 숙소 보기</a></li>
        <c:if test="${empty sessionScope.sLogin}">
            <li class="nav-item"><a class="nav-link" href="${ctp}/member/memberLogin">로그인</a></li>
        </c:if>
        <c:if test="${sMid == 'admin'}">
            <li class="nav-item"><a class="nav-link" href="${ctp}/admin/adminMain">관리자</a></li>
        </c:if>
        <c:if test="${not empty sessionScope.sLogin}">
            <li class="nav-item"><a class="nav-link" href="${ctp}/member/memberLogout">로그아웃</a></li>
            <li class="nav-item"><a class="nav-link" href="${ctp}/member/memberMyPage">마이페이지</a></li>
        </c:if>
        <li class="nav-item dropdown">
            <a class="nav-link dropbtn" href="#" role="button" data-bs-toggle="modal" data-bs-target="#myModal3">고객센터</a>
            <div class="dropdown-content">
                <a href="#">1:1문의</a>
                <a href="#">FQA</a>
                <a href="#">Q&A</a>
            </div>
        </li>
    </ul>
  </div>
</nav>

</body>
