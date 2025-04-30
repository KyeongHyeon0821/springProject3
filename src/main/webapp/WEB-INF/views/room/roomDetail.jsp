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
		  font-size: 0.95rem;
		}
		
		.room-options h4 {
		  margin-bottom: 12px;
		  margin-top: 50px;
		  font-size: 1.2rem;
		  font-weight:bold;
		}
		
		.review-preview-container h4{
			margin-bottom: 0px;
		  margin-top: 50px;
		  font-size: 1.2rem;
		  font-weight:bold;
		}
		
		
		.option-grid {
		  display: grid;
		  grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개씩 */
		  gap: 0px 20px; /* 세로, 가로 간격 */
		}
		
		.option-item {
		  display: flex;
		  align-items: center;
		  gap: 8px;
		  padding: 5px 14px 0px 0px;
		  font-size: 0.95rem;
		}
		
		.option-item img {
		  width: 18px;
		  height: 18px;
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
		  font-size: 1.1rem;
		  font-weight:bold;
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
		
		.room-details-guide {
		  margin-top: 3rem;
		  padding: 1.5rem;
		  background-color: #f9f9f9;
		  border-radius: 12px;
		  line-height: 1.6;
		}
		
		.room-details-guide h4,
		.room-details-guide h5 {
		  margin-top: 1rem;
		  color: #333;
		}
		
		.room-details-guide ul {
		  margin-left: -0.5rem;
		  list-style: disc;
		}
		
		.review-preview-container{
			margin-top: 1rem;
		}
		#allReviewShow {
			text-decoration: none;
   		margin-bottom: 5px;
    	margin-right: 2px;
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
	      <div class="option-item">
	        <img src="${ctp}/images/check.png" alt="체크" />
	        <span>${optionVo.name}</span>
	      </div>
	    </c:forEach>
	  </div>
	</div>

	
	<div class="room-details-guide">
	  <h4>📋기본 정보 및 반려견 동반 안내</h4>
	  <ul>
	    <li>상기 이미지는 실제와 다를 수 있습니다.</li>
	    <li>객실(취사불가) + 펫 동반 가능</li>
	  </ul>
	
	  <h5>■ 객실 제공 서비스 안내</h5>
	  <ul>
	    <li>펫 객실 비품: 방석, 식기, 배변판, 배변시트 3ea, 펫타월 2ea, 접착 테이프, 탈취제, 고정형 목줄(1.5m)</li>
	    <li>펫 플레이그라운드 무료 이용</li>
	    <li>펫플레이그라운드 이용 인원 기준: (패밀리/스위트) 보호자 2인 + 투숙 반려견 / (실버/골드) 보호자 4인 + 투숙 반려견</li>
	  </ul>
	
	  <h5>■ 반려동물 입실 기준</h5>
	  <ul>
	    <li>체급 분류: 소형 ~10kg / 중형 11~15kg / 중대형 16~25kg / 대형 26~45kg</li>
	    <li>객실 타입별 허용 마리 수 상세 설명</li>
	    <li>중대/대형견 추가 시 보호자 1인 동반 필수 (프론트 확인)</li>
	  </ul>
	
	  <h5>■ 반려동물 입실 구비서류</h5>
	  <ul>
	    <li>광견병, 종합백신 접종확인서 (연령별 기준 있음)</li>
	    <li>추가 요금: 소/중형 3만원, 중대형 4만원, 대형 5만원</li>
	    <li>맹견, 3개월 이하, 공격성 강한 견종 불가</li>
	  </ul>
	
	  <h5>■ 기타 안내</h5>
	  <ul>
	    <li>132.23㎡ / 기준 6인, 최대 9인</li>
	    <li>구성: 침실2 + 파우더룸 + 거실 + 주방 및 식당 + 욕실2</li>
	    <li>※ 하이라이트(1구) 설치로 최소 조리만 가능</li>
	  </ul>
	</div>
	
	<!-- 리뷰 미리보기 -->
	<div class="review-preview-container">
		<h4>리뷰</h4>
		<c:if test="${!empty rVos}">
			<a id="allReviewShow" href="#" class="text-end" data-bs-toggle="modal" data-bs-target="#myModal" style="display:block">전체 리뷰 보기</a>
		  <c:forEach var="ReviewVo" items="${rVos}" varStatus="st">
		    <c:if test="${st.index < 2}">
		      <div class="review-box">
		        <!-- 별점 + 날짜 -->
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
		        <div class="review-line2">
		          <div class="writer">${ReviewVo.nickName} | ${ReviewVo.purpose}</div>
		          <c:if test="${sLevel == 0}">
		            <div class="host-ip">${ReviewVo.hostIp}</div>
		          </c:if>
		        </div>
		        <div class="review-line3">${ReviewVo.roomName}</div>
		        <div class="review-content">${ReviewVo.content}</div>
		      </div>
		    </c:if>
		  </c:forEach>
	  </c:if>
	  <c:if test="${empty rVos}"><div class="mt-2">아직 작성된 리뷰가 없습니다.</div></c:if>
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