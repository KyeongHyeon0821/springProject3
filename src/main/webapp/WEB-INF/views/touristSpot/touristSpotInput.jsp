<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>touristSpotInput.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    .form-container { max-width: 600px; margin: 30px auto; }
    .form-group label { font-weight: bold; }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container form-container">
  <h3 class="mb-4">관광명소 등록</h3>
  <form action="${ctp}/touristSpot/input" method="post">
    <div class="mb-3">
      <label for="hotelIdx" class="form-label">호텔 선택</label>
      <select name="hotelIdx" id="hotelIdx" class="form-select" required>
        <c:forEach var="hotel" items="${hotelList}">
          <option value="${hotel.idx}">${hotel.name}</option>
        </c:forEach>
      </select>
    </div>
    <div class="mb-3">
      <label for="name" class="form-label">관광지 이름</label>
      <input type="text" class="form-control" id="name" name="name" required>
    </div>
    <div class="mb-3">
      <label for="lat" class="form-label">위도 (lat)</label>
      <input type="text" class="form-control" id="lat" name="lat" required>
    </div>
    <div class="mb-3">
      <label for="lng" class="form-label">경도 (lng)</label>
      <input type="text" class="form-control" id="lng" name="lng" required>
    </div>
    <div class="mb-3">
      <label for="address" class="form-label">주소</label>
      <input type="text" class="form-control" id="address" name="address">
    </div>
    <div class="mb-3">
      <label for="description" class="form-label">설명</label>
      <textarea class="form-control" id="description" name="description" rows="4"></textarea>
    </div>
    <button type="submit" class="btn btn-success">등록</button>
    <a href="${ctp}/hotel/hotelList" class="btn btn-secondary">취소</a>
  </form>
</div>
</body>
</html>
