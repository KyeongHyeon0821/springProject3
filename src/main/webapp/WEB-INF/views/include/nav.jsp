<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" type="text/css" href="${ctp}/css/linkMain.css"/>

	<style>
		ul, li {
			text-decoration: none;
			list-style: none;
		}
				
		body.modal-open {
  		padding-right: 0 !important;
		}
		

	</style>

<body>
<nav>
  <div class="nav-container">
    <a href="${ctp}/" class="logo" style="display:flex; line-height: 80px;"><img src="${ctp}/images/logo.png" width="80px"/>withPet</a>
    <ul class="nav-links">
    	<li>
      	<a href="${ctp}/hotel/hotelInput">숙박시설 등록</a>
      </li>
      <c:if test="${empty sessionScope.sLogin}">
	      <li>
	      	<a href="${ctp}/member/memberLogin">로그인</a>
	      </li>
      </c:if>
      <c:if test="${sMid == 'admin'}">
	      <li>
	      	<a href="${ctp}/admin/adminMain">관리자</a>
	      </li>
      </c:if>
              <!-- 로그인 상태일 때만 로그아웃 & 마이페이지 표시 -->
			<c:if test="${not empty sessionScope.sLogin}">
		  	<li class="nav-item">
		    	<a class="nav-link" href="${ctp}/member/memberLogout">로그아웃</a>
		  	</li>
			  <li class="nav-item">
			    <a class="nav-link" href="${ctp}/member/memberMyPage">마이페이지</a>
			  </li>
			</c:if>
	    <li class="nav-item dropdown">
        <a class="nav-link dropbtn" href="#" role="button" data-bs-toggle="modal" data-bs-target="#myModal3" id="customButton3">고객센터</a>
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
