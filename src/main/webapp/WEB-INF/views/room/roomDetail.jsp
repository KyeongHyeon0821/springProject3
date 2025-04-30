<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		
		//리뷰 리스트 보여주기
		function modalCheck(idx,hotelIdx,roomIdx,reviewTotCnt,reviewCnt,mid,nickName,roomName,purpose,star,content,hostIp,reviewDate) {
			$("#idx").val(idx);
			$("#hotelIdx").val(hotelIdx);
			$("#roomIdx").val(roomIdx);
			$("#reviewTotCnt").val(reviewTotCnt);
			$("reviewCnt").val(reviewCnt);
			$("#mid").val(mid);
			$("#nickName").val(nickName);
			$("#roomName").val(roomName);
			$("#purpose").val(purpose);
			$("#star").val(star);
			$("#content").val(content);
			$("#hostIp").val(hostIp);
			$("#reviewDate").val(reviewDate);
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
		  margin: 0 0 30px 0;
		}
		
		.room-info li {
		  padding: 0px;
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
		
		.room-owner-actions {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 10px;
		  margin-top: 30px;
		}
		
		/* 공통 버튼 스타일 */
		input[type="button"],
		a.btn-secondary,
		a.btn-tertiary,
		a.btn-danger,
		a.btn-warning {
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
		a.btn-warning {
			background-color: #FCF259;
			color: green; 
		}
		/* 기존 컨테이너에 아래 여백 추가 */
		.room-detail-container {
		  padding-bottom: 160px;
		}
		
		/* 고정 바 전체 영역 (화면 하단에 고정, 가운데 정렬용) */
		.room-reserve-bar-wrapper {
		  position: fixed;
		  bottom: 0;
		  left: 0;
		  width: 100%;
		  background: transparent;
		  display: flex;
		  justify-content: center;
		  z-index: 1000;
		}
		
		/* 고정 바 본체 (컨테이너 너비에 맞춤) */
		.room-reserve-bar {
		  width: 800px;
		  max-width: 90%;
		  background-color: #ffffff;
		  border-top: 1px solid #ddd;
		  box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.08);
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  padding: 10px 24px;
		  font-family: 'Noto Sans KR', sans-serif;
		  gap: 20px;
		}
		
		/* 왼쪽 예약 정보 */
		.reserve-left {
		  font-size: 0.95rem;
		  color: #444;
		}
		
		.reserve-dates {
		  font-weight: 600;
		  font-size: 0.9rem;
		  margin-bottom: 6px;
		}
		
		.reserve-summary {
		  font-size: 1.5rem;
		  color: #333;
		}
		
		/* 예약 버튼 */
		.reserve-form {
		  flex-shrink: 0;
		}
		
		.btn-reserve {
		  background-color: #009688;
		  color: white;
		  padding: 12px 32px;
		  font-size: 1rem;
		  border: none;
		  border-radius: 10px;
		  cursor: pointer;
		  transition: background-color 0.2s ease;
		  width: 300px; /* 버튼 길이 조절 가능 */
		}
		
		.btn-reserve:hover {
		  background-color: #00796b;
		}
		
		.modal-backdrop.show {
		  background-color: rgba(0, 0, 0, 0.6); 
		}
		
		/* 리뷰 모달 전체 박스 */
		.review-modal {
		  font-family: 'Arial', sans-serif;
		}
		
		/* 리뷰 하나 박스 */
		.review-box {
		  padding: 15px;
		  margin-bottom: 20px;
		  background-color: #f9f9f9;
		  border-radius: 10px;
		  border: 1px solid #ddd;
		  box-shadow: 0 2px 5px rgba(0,0,0,0.05);
		}
		
		/* 리뷰 사이의 구분선 제거 (이미 박스로 구분되니까) */
		.review-box hr {
		  display: none;
		}
		
		/* 별점 + 날짜 */
		.review-line1 {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		}
		
		/* 별 모양 */
		.stars .star {
		  color: gold;
		  font-size: 18px;
		  margin-right: 2px;
		}
		.stars .star.gray {
		  color: #ccc;
		}
		
		/* 닉네임, 목적, hostIp */
		.review-line2 {
		  display: flex;
		  justify-content: space-between;
		  font-size: 14px;
		  color: #555;
		  margin-top: 5px;
		}
		
		/* 객실 이름 */
		.review-line3 {
		  font-weight: bold;
		  margin-top: 5px;
		  color: #333;
		}
		
		/* 내용 */
		.review-content {
		  margin-top: 8px;
		  line-height: 1.5;
		  white-space: pre-wrap;
		}
		.modal-header {
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  position: relative;
		}
		
		.modal-header .modal-title {
		  flex-grow: 1;
		  text-align: center;
		}
		
		.modal-header .btn-close {
		  position: absolute;
		  right: 1rem;
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
      <li>👥 최대 ${vo.maxPeople}인</li>
      <li>🐶 ${vo.petSizeLimit}견까지 동반 가능</li>
      <li>🐾 반려견 최대 ${vo.petCountLimit}마리</li>
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

	<c:if test="${vo.mid == sMid}">
	  <div class="room-owner-actions">
	    <a href="roomUpdate?roomIdx=${vo.idx}" class="btn-secondary">객실 정보 수정</a>
	    <a href="roomImageUpdate?roomIdx=${vo.idx}" class="btn-tertiary">객실 이미지 수정</a>
	    <c:if test="${vo.status != '서비스중지요청'}">
	      <a href="javascript:roomDeleteCheck()" class="btn-danger">객실 서비스 중지 요청</a>
	    </c:if>
	  </div>
	</c:if>
	
	<!-- 리뷰 -->
	<a href="#" id="reviewCheck" class="btn-warning mt-5" data-bs-toggle="modal" data-bs-target="#myModal" onclick="modalCheck('${ReviewVo.idx}','${ReviewVo.hotelIdx}','${ReviewVo.roomIdx}','${ReviewVo.reviewTotCnt}','${ReviewVo.reviewCnt}','${ReviewVo.mid}','${ReviewVo.nickName}','${ReviewVo.roomName}','${ReviewVo.purpose}','${ReviewVo.star}','${ReviewVo.content}','${ReviewVo.hostIp}','${ReviewVo.reviewDate}')">리뷰 확인하기</a>
  <c:forEach var="ReivewVo" items="rVos">
  	<input type="hidden" value="${ReviewVo.idx}" >
  </c:forEach>
  
	<!-- 예약 고정 바 (컨테이너 내부에 위치) -->
	<div class="room-reserve-bar-wrapper">
	  <div class="room-reserve-bar">
	    <div class="reserve-left">
	      <div class="reserve-dates">${fn:substring(checkinDate,5,10)}~${fn:substring(checkoutDate,5,10)}</div>
	      <div class="reserve-summary">
	        <strong><fmt:formatNumber value="${vo.price * nights}" type="number" pattern="#,##0" />원</strong>
	      </div>
	    </div>
	    <form action="${ctp}/reservation/reservationForm" method="get" class="reserve-form">
	      <input type="hidden" name="roomIdx" value="${vo.idx}" />
	      <input type="hidden" name="searchString" value="${searchString}" />
	      <input type="hidden" name="checkinDate" value="${checkinDate}" />
	      <input type="hidden" name="checkoutDate" value="${checkoutDate}" />
	      <input type="hidden" name="guestCount" value="${guestCount}" />
	      <input type="hidden" name="petCount" value="${petCount}" />
	      <input type="hidden" name="nights" value="${nights}" />
	      <input type="submit" value="예약하기" class="btn-reserve" />
	    </form>
	  </div>
	</div>
	
	
	<!-- 모달창으로 리뷰 띄우기 -->
	<div class="modal modal-lg" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content review-modal">
	      <div class="modal-header">
				  <h3 class="modal-title" id="exampleModalLabel">리뷰</h3>
				  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
	
	      <div class="modal-body">
	        <c:forEach var="ReviewVo" items="${rVos}">
	          <div class="review-box">
	            <!-- 1줄: 별점 + 날짜 -->
	            <div class="review-line1">
	              <div class="stars">
	                <c:forEach var="i" begin="1" end="${ReviewVo.star}">
	                  <span class="star">★</span>
	                </c:forEach>
	                <c:forEach var="i" begin="${ReviewVo.star + 1}" end="5">
	                  <span class="star gray">★</span>
	                </c:forEach>
	              </div>
	              <div class="date">${fn:substring(ReviewVo.reviewDate, 0, 10)}</div>
	            </div>
	
	            <!-- 2줄: 닉네임 | 목적    hostIp (관리자만) -->
	            <div class="review-line2">
	              <div class="writer">${ReviewVo.nickName} | ${ReviewVo.purpose}</div>
	              <c:if test="${sLevel == 0}">
	                <div class="host-ip">${ReviewVo.hostIp}</div>
	              </c:if>
	            </div>
	
	            <!-- 3줄: 객실 이름 -->
	            <div class="review-line3">${ReviewVo.roomName}</div>
	
	            <!-- 4줄: 내용 -->
	            <div class="review-content">${ReviewVo.content}</div>
	
	            <hr />
	          </div>
	        </c:forEach>
	      </div>
	    </div>
	  </div>
	</div>
	
</div>
</body>
</html>