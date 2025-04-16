<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<nav class="navbar navbar-expand-sm navbar-light" style="background-color: #ffb6c1;">
  <div class="container-fluid">
    <a class="navbar-brand" href="${ctp}/">위드펫</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="${ctp}/hotel/hotelList">호텔리스트</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${ctp}/hotel/hotelInput">호텔등록</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${ctp}/admin/adminMain">관리자</a>
        </li>  
        <li class="nav-item">
          <a class="nav-link" href="#">고객센터</a>
        </li>  
        <li class="nav-item">
          <a class="nav-link" href="#">로그인</a>
        </li>  
        <li class="nav-item">
          <a class="nav-link" href="#">로그아웃</a>
        </li>  
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">더보기</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">마이페이지</a></li>
            <li><a class="dropdown-item" href="#">더보기</a></li>
            <li><a class="dropdown-item" href="#">더보기</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>