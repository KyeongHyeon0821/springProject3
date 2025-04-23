<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>roomDetail.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script>
		'use strict';
		
		// 객실 서비스 중지 요청
		function roomDeleteCheck() {
			let ans = confirm("해당 객실 서비스 중지를 요청하시겠습니까?");
			if(!ans) return false;
			else location.href="roomDeleteCheck?idx=${vo.idx}";
		}
		
	</script>
	
	<style>
		.room-detail-container {
		  max-width: 800px;
		  margin: 40px auto;
		  padding: 24px;
		  background-color: #ffffff;
		  border-radius: 16px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		  font-family: 'Noto Sans KR', sans-serif;
		  color: #333;
		}
		
		.room-header {
		  display: flex;
		  justify-content: space-between;
		  align-items: baseline;
		  margin-bottom: 20px;
		}
		
		.room-title {
		  font-size: 1.8rem;
		  font-weight: bold;
		}
		
		.room-price {
		  font-size: 1.2rem;
		  color: #009688;
		  font-weight: 600;
		}
		
		.room-thumbnail img {
		  width: 100%;
		  height: auto;
		  border-radius: 12px;
		  margin-bottom: 20px;
		}
		
		.room-gallery {
		  display: flex;
		  gap: 10px;
		  overflow-x: auto;
		  margin-bottom: 20px;
		}
		
		.room-gallery img {
		  width: 160px;
		  height: auto;
		  border-radius: 8px;
		  object-fit: cover;
		}
		
		.room-info ul {
		  list-style: none;
		  padding: 0;
		  margin: 0 0 20px 0;
		}
		
		.room-info li {
		  padding: 6px 0;
		  font-size: 1rem;
		}
		
		.room-options h4 {
		  margin-bottom: 10px;
		  font-size: 1.2rem;
		}
		
		.option-grid {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 8px;
		}
		
		.option-item {
		  background-color: #f0f0f0;
		  padding: 6px 12px;
		  border-radius: 20px;
		  font-size: 0.9rem;
		}
		
		.room-actions,
		.room-owner-actions {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 10px;
		  margin-top: 30px;
		}
		
		/* 공통 버튼 스타일 */
		input[type="button"],
		a.btn-back,
		a.btn-secondary,
		a.btn-tertiary,
		a.btn-danger {
		  padding: 8px 16px;
		  font-size: 0.95rem;
		  border: none;
		  border-radius: 12px;
		  cursor: pointer;
		  transition: background-color 0.2s ease;
		  text-decoration: none;
		  display: inline-block;
		  font-family: 'Noto Sans KR', sans-serif;
		}
		
		/* ← 이전으로 버튼 */
		a.btn-back {
		  background-color: transparent;
		  color: #555;
		  font-size: 1.4rem;
		  padding: 4px 10px;
		  border: 1px solid #ddd;
		  border-radius: 50%;
		  line-height: 1;
		  text-align: center;
		}
		
		a.btn-back:hover {
		  background-color: #f5f5f5;
		}
		
		/* 예약하기 */
		input.btn-primary {
		  background-color: #009688;
		  color: #fff;
		}
		
		input.btn-primary:hover {
		  background-color: #00796b;
		}
		
		/* 객실 정보 수정 */
		a.btn-secondary {
		  background-color: #1976d2;
		  color: #fff;
		}
		
		a.btn-secondary:hover {
		  background-color: #1565c0;
		}
		
		/* 이미지 수정 */
		a.btn-tertiary {
		  background-color: #757575;
		  color: #fff;
		}
		
		a.btn-tertiary:hover {
		  background-color: #616161;
		}
		
		/* 서비스 중지 요청 */
		a.btn-danger {
		  background-color: #e53935;
		  color: #fff;
		}
		
		a.btn-danger:hover {
		  background-color: #c62828;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="room-detail-container">
  <div class="room-header">
    <h2 class="room-title">${vo.name}</h2>
    <div class="room-price">${vo.price}원 / 1박</div>
  </div>

  <div class="room-thumbnail">
    <img src="${ctp}/roomThumbnail/${vo.thumbnail}" alt="${vo.name}" />
  </div>

  <c:if test="${!empty vo.images}">
    <c:set var="roomImages" value="${fn:split(vo.images, '/')}" />
    <div class="room-gallery">
      <c:forEach var="roomImage" items="${roomImages}">
        <img src="${ctp}/roomImages/${roomImage}" alt="객실 이미지" />
      </c:forEach>
    </div>
  </c:if>

  <div class="room-info">
    <ul>
      <li>👥 최대 인원: ${vo.maxPeople}명</li>
      <li>🐶 반려견 크기 제한: ${vo.petSizeLimit}</li>
      <li>🐾 반려견 최대: ${vo.petCountLimit}마리</li>
    </ul>
  </div>

  <div class="room-options">
    <h4>🛎️ 시설 / 서비스</h4>
    <div class="option-grid">
      <c:forEach items="${roomOptionList}" var="optionVo">
        <span class="option-item">${optionVo.name}</span>
      </c:forEach>
    </div>
  </div>

  
  <div class="room-actions">
	  <a href="${ctp}/hotel/hotelDetail?idx=${vo.hotelIdx}" class="btn-back">〈</a>
	  <input type="button" value="예약하기" onclick="" class="btn-primary" />
	</div>
	
	<c:if test="${vo.mid == sMid}">
	  <div class="room-owner-actions">
	    <a href="roomUpdate?roomIdx=${vo.idx}" class="btn-secondary">객실 정보 수정</a>
	    <a href="roomImageUpdate?roomIdx=${vo.idx}" class="btn-tertiary">객실 이미지 수정</a>
	    <c:if test="${vo.status != '서비스중지요청'}">
	      <a href="javascript:roomDeleteCheck()" class="btn-danger">객실 서비스 중지 요청</a>
	    </c:if>
	  </div>
	</c:if>
	
</div>
</body>
</html>