<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- <link rel="stylesheet" type="text/css" href="${ctp}/css/linkAdmin.css"/> -->
  <title>adminLeft.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<style>
		ul, li, a {
			list-style: none;
			text-decoration: none;
		}
		li {
			margin-bottom: 24px;
		}
		body {
			background-color:#EEE;
		}
	</style>
</head>
<body>
<p><br/></p>
<!-- SIDEBAR -->
  <div id="sidebar">
  	<div class="text-center">
    	<h5><a href="${ctp}/admin/adminContent" target="adminContent" class="brand" ><b>관리자페이지</b></a></h5>
    </div>
    <hr/>
    <p></p>
    <div class="text-center">
    	<p><a href="${ctp}/" target="_top">홈으로</a></p>
    </div>
    <ul class="side-menu top">
      <li class="active">
        <a href="#">
          <i class='bx bxs-dashboard bx-sm'></i>
          <span class="text">대시보드</span>
        </a>
      </li>
      <li>
        <a href="#">
          <i class='bx bxs-doughnut-chart bx-sm'></i>
          <span class="text">통계</span>
        </a>
      </li>
      <li>
        <a href="${ctp}/hotel/hotelList">
          <i class='bx bxs-shopping-bag-alt bx-sm'></i>
          <span class="text">호텔리스트</span>
        </a>
      </li>
      <li>
        <a href="#">
          <i class='bx bxs-message-dots bx-sm'></i>
          <span class="text">고객센터</span>
        </a>
      </li>
      <li>
        <a href="${ctp}/admin/member/memberList" target="adminContent">
          <i class='bx bxs-group bx-sm'></i>
          <span class="text">멤버관리(사업자관리)</span>
        </a>
      </li>
      <li>
        <a href="${ctp}/admin/complaint/complaintList" target="adminContent">
          <i class='bx bxs-group bx-sm'></i>
          <span class="text">신고관리</span>
        </a>
      </li>
    </ul>
    <p></p>
    <ul class="side-menu bottom">
      <li>
        <a href="#">
          <i class='bx bxs-cog bx-sm bx-spin-hover'></i>
          <span class="text">1:1문의채팅</span>
        </a>
      </li>
      <li>
        <a href="#" class="logout">
          <i class='bx bx-power-off bx-sm bx-burst-hover'></i>
          <span class="text">Logout</span>
        </a>
      </li>
    </ul>
  </div>
  <!-- SIDEBAR -->
<p><br/></p>
</body>
</html>