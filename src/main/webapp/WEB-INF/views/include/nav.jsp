<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/linkMain.css"/>

	<style>
		ul, li {
			text-decoration: none;
			list-style: none;
		}
				
		body.modal-open {
  		padding-right: 0 !important;
		}
		
		.nav-container {
		  display: grid;
		  grid-template-columns: auto 1fr auto;
		  align-items: center;
		  padding: 20px;
		  max-width: 1400px;
		  margin: 0 auto;
		}

		.nav-links {
			display: flex;
			align-items: center;
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
		  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
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
		.dropdown-content a:hover {background-color: #f1f1f1}
		
		/* Show the dropdown menu on hover */
		.dropdown:hover .dropdown-content {
		  display: block;
		}
		
		/* Change the background color of the dropdown button when the dropdown content is shown */
		.dropdown:hover .dropbtn {
		  background-color: #eee;
		}
	</style>

<body>
<nav>
  <div class="nav-container">
    <a href="${ctp}/" class="logo" style="display:flex; line-height: 80px;"><img src="${ctp}/images/logo.png" width="80px"/>withPet</a>
    <ul class="nav-links">
    	<li class="nav-item">
      	<a class="nav-link" href="${ctp}/hotel/hotelInput">숙박시설 등록</a>
      </li>
      <c:if test="${empty sessionScope.sLogin}">
	      <li class="nav-item">
	      	<a class="nav-link" href="${ctp}/member/memberLogin">로그인</a>
	      </li>
      </c:if>
      <c:if test="${sMid == 'admin'}">
	      <li class="nav-item">
	      	<a class="nav-link" href="${ctp}/admin/adminMain">관리자</a>
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
