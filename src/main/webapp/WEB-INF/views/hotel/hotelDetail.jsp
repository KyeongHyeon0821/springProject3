<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위드펫 - 호텔상세</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f5f016ee8ec4b87750154cd5e9d07dfb&libraries=services"></script>
	<style>
		.hotel-detail-container {
		  max-width: 800px;
		  margin: 40px auto;
		  padding: 24px;
		  background-color: #ffffff;
		  border-radius: 16px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		  font-family: 'Noto Sans KR', sans-serif;
		  color: #333;
		}
		
		.hotel-header {
	 	  display: flex;
		  justify-content: space-between;
		  align-items: baseline;
		  margin-bottom: 20px;
		}
		
		.hotel-title {
		  font-size: 1.8rem;
		  font-weight: bold;
		}
		
		.heart-icon img {
		  width: 28px;
		  vertical-align: middle;
		}
		
		.hotel-slider {
		  width: 100%;
		  max-width: 800px;
		  margin: 0 auto 2rem;
		  border-radius: 12px;
		  overflow: hidden;
		  cursor:pointer;
		}
		
		.hotel-slider img {
		  width: 100%;
		  height: auto;
		  object-fit: cover;
		  border-radius: 12px;
		}
		.swiper-button-next,
		.swiper-button-prev {
		  color: #888888; 
		}
		.swiper-button-next:hover,
		.swiper-button-prev:hover {
		  color: #666666; 
		}
		.swiper-pagination-bullet {
		  background-color: #cccccc;
		}
		.swiper-pagination-bullet-active {
		  background-color: #666666; 
		}
		
		.roomList {
		  margin: 40px 0;
		}
		
		.roomTypeTitle {
		  font-size: 1.2rem;
		  font-weight: bold;
		  color: #333;
		  margin: 20px 0 10px;
		}
		
		.roomContainer {
		  display: flex;
		  background-color: #fdfdfd;
		  border-radius: 12px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
		  margin-bottom: 20px;
		  overflow: hidden;
		  transition: transform 0.2s;
		  height: 180px;
		}
		
		.roomContainer:hover {
		  transform: translateY(-3px);
		}
		
		.roomThumbnailContainer {
		  width: 280px; /* ← 넓게 조정 */
		  height: 100%; /* 자동 확장 */
		  flex-shrink: 0;
		  overflow: hidden;
		  display: flex;
		  align-items: stretch;
		}
		
		.roomThumbnailContainer img {
		  width: 100%;
		  height: 100%;
		  object-fit: cover;
		}
		
		.roomDetailContainer {
		  padding: 16px 20px;
		  display: flex;
		  flex-direction: column;
		  flex: 1;
		  position: relative;
		}
		
		.roomTopRow {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  margin-bottom: 0px;
		}
		
		.roomStayLabel {
		  font-size: 13px;
		  font-weight: 600;
		  border-radius: 6px;
		  display: inline-block;
		}
		
		.roomDetailLink {
		  font-size: 14px;
		  font-weight: 500;
		  text-decoration: none;
		}
		
		.roomDetailLink:hover {
		  text-decoration: underline;
		}
		
		.roomDetailLink .arrow {
		  font-size: 18px;  /* 화살표만 좀 더 크게 */
		  margin-left: 2px;
		  position: relative;
		  top: 1px; /* 살짝 수직 정렬 맞추기 */
		}
		
		.roomNumber {
		  font-size: 15px;
		  font-weight: bold;
		  color: #333;
		  margin-top: 0px;
		}
		
		.roomTime {
		  font-size: 14px;
		  color: #666;
		  margin-top: 4px;
		}
		
		.roomPrice {
		  font-size: 22px;
		  font-weight: bold;
		  color: #222;
		  text-align: right;
		  margin-top: 12px;
		  position: absolute;
	    right: 16px;
	    bottom: 20px;
		}
		
		.hotel-info {
		  margin-top: 0.5rem;
		  display: flex;
		  flex-direction: column;
		  gap: 0.5rem;
		  font-size: 0.9rem;
		  color: #555; /* 글자색 회색 */
		}
		
		.hotel-info div {
		  display: flex;
		  align-items: center;
		  gap: 0.5rem;
		}
		
		.hotel-info img {
		  width: 15px;
		  height: 15px;
		  vertical-align: middle;
		  filter: grayscale(100%) brightness(0.6); /* 회색 + 살짝 어둡게 */
		}
		.hotel-description {
		  margin-top: 24px;
		  padding: 16px;
		  background: #f9f9f9;
		  border-radius: 10px;
		}
		
		.hotel-description h4 {
		  margin-bottom: 8px;
		  font-size: 18px;
		  color: #444;
		}
		
		.button-group {
		  display: flex;
		  flex-wrap: wrap;
		  justify-content: center; 
		  gap: 10px;
		  margin-top: 20px;
		}
		
		.custom-btn {
		  padding: 10px 18px;
		  font-size: 15px;
		  border: none;
		  border-radius: 8px;
		  text-decoration: none;
		  color: white;
		  background-color: #007bff; /* 밝은 파란색 */
		  transition: background-color 0.3s ease;
		}
		
		.custom-btn:hover {
		  filter: brightness(85%); /* hover 시 살짝 어두워짐 */
		}
		
		.back-btn {
		  background-color: #6c757d; /* 회색 */
		}
		
		.green-btn {
		  background-color: #28a745; /* 밝은 초록색 */
		}
		
		.orange-btn {
		  background-color: #fd7e14; /* 밝은 주황색 */
		}
		
		.blue-btn {
		  background-color: #007bff; /* 파란색 */
		}
		
		.red-btn {
		  background-color: #dc3545; /* 밝은 빨간색 */
		}

		
		.reservation-search {
		  border-radius: 10px;
		  padding: 5px 0 30px 0;
		  margin: 30px 0;
		}
		
		.reservation-search form {
		  display: flex;
		  flex-wrap: wrap;
		  align-items: flex-end;
		  gap: 32px;
		}
		
		.reservation-search label {
		  display: flex;
		  flex-direction: column;
		  font-size: 14px;
		  color: #333;
		  flex: -1 1 200px;
		}
		
		.reservation-search label.small-input {
		  flex: 0 0 100px;
		}
		
		.reservation-search input {
		  padding: 8px 10px;
		  border: 1px solid #ccc;
		  border-radius: 6px;
		  font-size: 14px;
		  margin-top: 4px;
		  width: 100%;
		  cursor: pointer;
		}
		
		.reservation-search button {
		  padding: 10px 18px;
		  background-color: #28a745;
		  color: white;
		  border: none;
		  border-radius: 8px;
		  font-size: 15px;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		  flex-shrink: 0;
		  height: 40px;
		}
		
		.reservation-search button:hover {
		  background-color: #218838;
		}
		
		#map {
	  position: relative;
		}
		
		#category {
		  position: absolute;
		  top: 10px;
		  left: 10px;
		  z-index: 10;
		  margin: 0;
		  padding: 0;
		}
		
		#category li {
		  display: inline-block;
		  background-color: #2e7d32;
		  color: white;
		  font-weight: bold;
		  padding: 8px 14px;
		  border-radius: 6px;
		  cursor: pointer;
		  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
		  transition: background-color 0.2s ease;
		}
		
		#category li:hover {
		  background-color: #1b5e20;
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
		
		.review-preview-container{
			margin-top: 1rem;
		}
		#allReviewShow {
			text-decoration: none;
   		margin-bottom: 5px;
    	margin-right: 2px;
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
		
		/* 호텔 이미지 모달 */
		/* 모달 전체 배경 */
		.image-modal {
		  display: none;
		  position: fixed;
		  z-index: 10000;
		  inset: 0; /* top, right, bottom, left 0 */
		  background-color: rgba(0, 0, 0, 0.3);
		  justify-content: center;
		  align-items: flex-start; /* 스크롤 시 위에서부터 보이게 */
		  overflow-y: auto; 
		}
		
		.image-modal-content {
		  position: relative;
		  background-color: white;
		  margin: auto auto;
		  padding: 3rem 0 1rem 0;
		  width: 90%;
		  max-width: 1000px;
		  height: 100vh; 
		  overflow-y: auto; /* ✅ 내부 스크롤 가능하게 */
		  border-radius: 16px;
		  box-shadow: 0 0 20px rgba(0,0,0,0.6);
		}
		
		/* 닫기 버튼 */
		.image-modal-close {
		  position: absolute;
		  top: 0px;
		  right: 13px;
		  font-size: 28px;
		  font-weight: bold;
		  color: #888;
		  cursor: pointer;
		}
		
		.image-modal-close:hover {
		  color: #000;
		}
		
		/* 이미지 리스트 */
		.modal-images {
		  display: flex;
		  flex-wrap: wrap;
		  justify-content: center;
		  gap: 1.2rem;
		}
		
		.modal-images img {
		  width: 100% !important;
		  max-width: 48% !important;
		  height: auto !important;
		  object-fit: cover !important;
		  border-radius: 12px;
		  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.6);
		}
		
		.hotel-info-guide {
		  margin-top: 2rem;
		  padding: 1.5rem;
		  background-color: #f9f9f9;
		  border-radius: 12px;
		  line-height: 1.6;
		  font-size: 0.95rem;
		}
		
		.hotel-info-guide h4,
		.hotel-info-guide h5 {
		  margin-top: 1rem;
		  color: #2a2a2a;
		}
		
		.hotel-info-guide ul {
		  margin-left: -0.5rem;
		  list-style: disc;
		  padding-left: 1.5rem;
		}
		
		.hotel-info-guide .guide-note {
		  margin-top: 1rem;
		  font-size: 1rem;
		  color: #555;
		  font-style: italic;
		}
		
		.hotel-images img {
		  width: 245px !important;
		  height: auto !important;
		  margin: 5px 5px 0 0;
		  border-radius: 8px;
		  cursor:pointer;
		}
		.hotel-images p {
			display: flex;
   	  justify-content: center;
	    margin-top: -30px;
		}
		.modal-backdrop.show {
		  background-color: rgba(0, 0, 0, 0.2); /* 더 밝은 배경 */
		}
	</style>

	<script>
		'use strict';
		
		// 호텔 서비스 중지 요청
		function hotelDeleteCheck() {
			let ans = confirm("해당 호텔 서비스 중지를 요청하시겠습니까?");
			if(!ans) return false;
			else location.href="hotelDeleteCheck?idx=${hotelVo.idx}";
		}
		
		// 호텔 찜 추가하기
		function hotelLikeOk() {
			let mid = '${sMid}';
			let hotelIdx = ${hotelVo.idx};
			
			if(mid == "") {
				alert("로그인 후 이용해주세요.");
				return false;
			}
			
			$.ajax({
				url : "hotelLikeOk",
				type : "post",
				data : {
					mid : mid,
					hotelIdx, hotelIdx
				},
				success : function(res) {
					if(res == "1") {
						$("#likeImg").attr("src", "${ctp}/images/heartRed.png");
						$("#likeFn").attr("href", "javascript:hotelLikeNo()");
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
		
		// 호텔 찜 취소하기
		function hotelLikeNo() {
			let mid = '${sMid}';
			let hotelIdx = ${hotelVo.idx};
			
			if(mid == "") {
				alert("로그인 후 이용해주세요.");
				return false;
			}
			
			$.ajax({
				url : "hotelLikeNo",
				type : "post",
				data : {
					mid : mid,
					hotelIdx, hotelIdx
				},
				success : function(res) {
					if(res == "1") {
						$("#likeImg").attr("src", "${ctp}/images/heartBlack.png");
						$("#likeFn").attr("href", "javascript:hotelLikeOk()");
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
		
		// 체크인 체크아웃 날짜 처리
		window.addEventListener('DOMContentLoaded', function () {
		  const checkinInput = document.getElementById('checkinDate');
		  const checkoutInput = document.getElementById('checkoutDate');
		
		  // 오늘 날짜로 체크인 최소 설정
		  const today = new Date().toISOString().split('T')[0];
		  checkinInput.min = today;
		
		  // 체크인 값이 이미 있는 경우 초기 처리
		  if (checkinInput.value) {
		    checkoutInput.disabled = false;
		    checkoutInput.min = checkinInput.value;
		
		    // 체크아웃 날짜가 체크인보다 빠른 경우 초기화
		    if (checkoutInput.value && checkoutInput.value < checkinInput.value) {
		      checkoutInput.value = '';
		    }
		  } else {
		    checkoutInput.disabled = true;
		  }

		  // 체크인 날짜가 변경되면
		  checkinInput.addEventListener('change', function () {
		    if (checkinInput.value) {
		      checkoutInput.disabled = false;
		      checkoutInput.min = checkinInput.value;
		      checkoutInput.value = '';
		    } else {
		      checkoutInput.disabled = true;
		      checkoutInput.value = '';
		    }
		  });
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="hotel-detail-container">
  <div class="hotel-header">
    <h2 class="hotel-title">
      ${hotelVo.name} 
    </h2>
    <span class="heart-icon">
      <c:if test="${hotelLike == 'Ok'}">
        <a id="likeFn" href="javascript:hotelLikeNo()"><img id="likeImg" src="${ctp}/images/heartRed.png" /></a>
      </c:if>
      <c:if test="${hotelLike == 'No'}">
        <a id="likeFn" href="javascript:hotelLikeOk()"><img id="likeImg" src="${ctp}/images/heartBlack.png" /></a>
      </c:if>
    </span>
  </div>

  <!-- 이미지 슬라이드 -->
  <div class="hotel-slider swiper">
	  <div class="swiper-wrapper">
	    <!-- 썸네일 먼저 -->
	    <div class="swiper-slide">
	      <img src="${ctp}/hotelThumbnail/${hotelVo.thumbnail}" alt="${hotelVo.name}" onclick="openModal()" />
	    </div>
		 </div>
	  <!-- 네비게이션 (옵션) -->
	  <div class="swiper-button-next"></div>
	  <div class="swiper-button-prev"></div>
	  <div class="swiper-pagination"></div>
	</div>
	
	<div class="hotel-images" onclick="openModal()">
    ${hotelVo.images}
  </div>
	
	
	<c:set var="images" value="${fn:replace(hotelVo.images, '<p>', '')}" />
	<c:set var="images" value="${fn:replace(images, '</p>', '')}" />
	<!-- 이미지 모달 -->
	<div id="imageModal" class="image-modal" onclick="closeModal(event)">
	  <div class="image-modal-content">
	    <span class="image-modal-close" onclick="closeModal()">&times;</span>
	    <div class="modal-images">
	      <img src="${ctp}/hotelThumbnail/${hotelVo.thumbnail}" alt="썸네일" />
	      <c:if test="${!empty hotelVo.images}">
	      	${images}
	      </c:if>
	    </div>
	  </div>
	</div>
	
  <!-- 리뷰 미리보기 -->
	<div class="review-preview-container mt-5">
		<h4 class="mb-0" style="font-size: 1.2rem; font-weight: bold;">리뷰</h4>
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
	
	<h4 class="mt-5 mb-1" style="font-size: 1.2rem; font-weight: bold;">예약 가능 객실</h4>
  <div class="reservation-search" style="margin: 0 0 30px 0;">
	  <form method="get" action="hotelDetail?idx=${hotelVo.idx}">
		  <input type="hidden" name="idx" value="${hotelVo.idx}" />
		  
		  <label>체크인
		    <input type="date" id="checkinDate" name="checkinDate" value="${checkinDate}" required />
		  </label>
		  
		  <label>체크아웃
		    <input type="date" id="checkoutDate" name="checkoutDate" value="${checkoutDate}" required />
		  </label>
		  
		  <label class="small-input">인원
		    <input type="number" name="guestCount" min="1" max="10" value="${guestCount}" required />
		  </label>
		  
		  <label class="small-input">반려견
		    <input type="number" name="petCount" min="0" max="5" value="${petCount}" required />
		  </label>
		
		  <button type="submit">예약가능 객실검색</button>
		</form>
	</div>

	<c:if test="${empty roomVos}">
		<div class="text-center mb-5">예약 가능한 객실이 없습니다. 조건을 변경하거나 다른 날짜를 시도해 보세요.</div>
	</c:if>
	<div class="roomList">
	  <c:set var="previousRoomType" value="" />
	
	  <c:forEach items="${roomVos}" var="roomVo">
	    <c:if test="${roomVo.name != previousRoomType}">
	      <h5 class="roomTypeTitle">${roomVo.name}</h5>
	      <c:set var="previousRoomType" value="${roomVo.name}" />
	    </c:if>
	
	    <div class="roomContainer">
	      <div class="roomThumbnailContainer">
	        <img src="${ctp}/roomThumbnail/s_${roomVo.thumbnail}" alt="Room Thumbnail"/>
	      </div>
	      <div class="roomDetailContainer">
	        <div class="roomTopRow">
	          <span class="roomStayLabel">숙박</span>
	          <a class="roomDetailLink" href="${ctp}/room/roomDetail?roomIdx=${roomVo.idx}&searchString=${searchString}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&guestCount=${guestCount}&petCount=${petCount}">
	            상세보기<span class="arrow">&rsaquo;</span>
	          </a>
	        </div>
	        <div class="roomNumber">${roomVo.roomNumber}</div>
	        <div class="roomTime">체크인 15:00 ~ 체크아웃 11:00</div>
	        <div class="roomPrice">
	          <fmt:formatNumber value="${roomVo.price}" type="number" pattern="#,##0" />원
	        </div>
	      </div>
	    </div>
	  </c:forEach>
	</div>

  
	
	<h4 style="font-size: 1.2rem; font-weight: bold;">위치/주변관광지</h4>
  <div id="mapContainer" style="cursor:pointer; position:relative;">
		<div id="map" style="width:100%; height:400px; position:relative;">
			<ul id="category">
				<li id="TOUR" data-order="99"><span class="category_bg tour"></span>관광지</li>
				<li id="mapBig" data-order="99"><span class="category_bg tour"></span>지도크게보기</li>
			</ul>
		</div>
	</div>
	
	<div class="hotel-info">
	  <div>
	    <img src="${ctp}/images/mapflag.png" alt="위치 아이콘" />
	    ${hotelVo.address}
	  </div>
	  <div>
	    <img src="${ctp}/images/tel.png" alt="전화 아이콘" />
	    ${hotelVo.tel}
	  </div>
	</div>

  <!-- 관광지 정보 출력 -->
  <div id="touristInfo" style="margin-top:30px; padding:20px; background:#ffffff; border:1px solid #ddd; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.08); display:none;">
	  <div style="display:flex; align-items:center; margin-bottom:15px;">
	    <img src="${ctp}/images/paw_marker.png" alt="관광지" style="width:35px; height:35px; margin-right:8px;">
	    <h4 id="touristName" style="margin:0; color:#2e7d32; font-weight:bold;"></h4>
	  </div>
	  <div style="font-size:14px; color:#555; margin-bottom:10px; padding-left:30px;">
	    <i class="bi bi-geo-alt-fill" style="color:#dc3545; margin-right:5px;"></i><span id="touristAddress"></span>
	  </div>
	  <div style="font-size:15px; color:#333; line-height:1.6; margin-top:20px; padding-left:30px; padding-right:30px; word-break:keep-all;">
	    <p id="touristDescription" style="margin:0;"></p>
	  </div>
	  <c:if test="${hotelVo.mid == sMid}">
	    <div style="text-align:right; margin-top:15px;">
	      <small style="color:#dc3545;">(수정/삭제는 관리자에게 문의하세요)</small>
	    </div>
	  </c:if>
   </div>

  <div class="hotel-description">
    <h4>🏨 호텔 소개</h4>
    <p>${fn:replace(hotelVo.description, newLine, "<br>")}</p>
  </div>

  
  
  <div class="hotel-info-guide">
	  <h4>📋호텔 이용안내</h4>
	  <ul>
	    <li>모든 객실 및 공용 공간은 금연입니다.</li>
	    <li>호텔 내 반려견 동반이 가능한 구역과 제한 구역이 구분되어 있습니다.</li>
	    <li>체크인: 오후 3시 이후 / 체크아웃: 오전 11시 이전</li>
	    <li>호텔 내 주차장 무료 이용 가능</li>
	    <li>전 객실 Wi-Fi 무료 제공</li>
	    <li>조식은 별도 신청 시 제공되며, 반려견 동반 시 테라스 좌석 이용 가능</li>
	    <li>호텔 주변 반려견 산책로 및 놀이터 안내는 프론트에서 확인 가능합니다</li>
	  </ul>
	
	  <h5>■ 반려견 동반 시 유의사항</h5>
	  <ul>
	    <li>반려견 동반 시 사전 고지 필수 (예약 시 또는 체크인 전)</li>
	    <li>호텔 내 이동 시 리드줄(2m 이하) 필수 착용</li>
	    <li>객실 외부에서는 배변 처리 및 위생 관리 철저히 해주세요</li>
	    <li>짖음, 공격성 있는 반려견은 출입이 제한될 수 있습니다</li>
	    <li>호텔에 따라 반려동물 입장 가능 공간이 상이할 수 있습니다</li>
	  </ul>
	
	  <h5>■ 안전 및 편의시설</h5>
	  <ul>
	    <li>호텔 로비 및 복도에 CCTV 설치 운영 중</li>
	    <li>호텔 내 응급 키트 및 반려견 응급처치 키트 비치</li>
	    <li>프론트 데스크 24시간 운영</li>
	  </ul>
	
	  <p class="guide-note">※ 위 안내는 호텔 정책에 따라 변경될 수 있으며, 정확한 사항은 프론트 또는 고객센터를 통해 확인 부탁드립니다.</p>
	</div>
  
  <div class="button-group">
	  <a href="${ctp}/hotel/hotelList?searchString=${searchString}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&guestCount=${guestCount}&petCount=${petCount}" class="custom-btn back-btn">목록으로</a>
	
	  <c:if test="${hotelVo.mid == sMid || sLevel == 0}">
	    <a href="${ctp}/room/roomInput?hotelIdx=${hotelVo.idx}" class="custom-btn green-btn">객실 등록</a>
	    <a href="${ctp}/touristSpotInput?hotelIdx=${hotelVo.idx}" class="custom-btn orange-btn">주변 관광지 등록</a>
	    <a href="hotelUpdate?idx=${hotelVo.idx}" class="custom-btn blue-btn">호텔 정보 수정</a>
	    <c:if test="${vo.status != '서비스중지요청'}">
	      <a href="javascript:hotelDeleteCheck()" class="custom-btn red-btn">서비스 중지 요청</a>
	    </c:if>
	  </c:if>
	</div>
	
</div>


<!-- 모달 형태로 지도 띄우기 -->
<div id="modalMapContainer" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(128, 128, 128, 0.9); z-index: 9999;">
   <!-- 지도 모달 박스 -->
    <div id="modalMap" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 50%; height: 95%; background-color: white; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);">
       <button onclick="closeModalMap()" style="position: absolute; top: 10px; right: 10px; background-color: transparent; border: none; font-size: 30px; z-index: 10000;">&times;</button>
 	   <!-- 관광지 버튼: 지도 위에 고정되게 배치 -->
		  <ul id="modalCategory" style="position: absolute; top: 15px; left: 15px; z-index: 10000;">
		    <li id="MODAL_TOUR" style="display:inline-block; background:#2e7d32; color:white; font-weight:bold; padding:8px 14px; border-radius:6px; cursor:pointer;">
		      관광지
		    </li>
		  </ul>   
    </div>
</div>


<script>
'use strict';
	var touristMarkers = [];
	var tourVisible = false;
	var modalTourMarkers = [];
	var modalTourVisible = false;
	var touristListData = [];
	var modalMap;
	
	var mapContainer = document.getElementById('map');  // 지도를 표시할 div
	var mapOption = {
	  center: new kakao.maps.LatLng(33.450701, 126.570667),
	  level: 3  // 지도의 확대 레벨
	};
	
	// 지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	//map.setDraggable(false); // 지도 드래그 막기
	//map.setZoomable(false);   // 지도 확대, 축소
	// 더블 클릭 확대 막기
	/* kakao.maps.event.addListener(map, 'dblclick', function(event) {
	    event.preventDefault(); // 더블 클릭으로 인한 확대 막기
	}); */
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${hotelVo.address}', function(result, status) {
	  
	  // 정상적으로 검색이 완료됐으면
	  if (status === kakao.maps.services.Status.OK) {
		  
	    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    
	    // 결과값으로 받은 위치를 마커로 표시합니다
	    var marker = new kakao.maps.Marker({ map: map, position: coords });
	    
	    // 인포윈도우로 장소에 대한 설명을 표시합니다
	    var infowindow = new kakao.maps.InfoWindow({ content: '<div style="width:150px;text-align:center;padding:6px 0;">${hotelVo.name}</div>' });
	    infowindow.open(map, marker);
	    
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map.setCenter(coords);
	  }
	});
	
	// 지도 클릭 시 전체 화면을 열기 위한 스크립트
	// 기존 지도 클릭 시 모달 열기
	 document.getElementById('mapBig').addEventListener('click', function(e) {
		const target = e.target;
		// 마커, 관광지 버튼을 클릭한 경우에는 모달 열지 않게 막기
		//if (target.closest('#category')) return;
		//if (target.tagName === 'IMG') return;
		  openHotelModalMap();
	 });
	
	// 모달 열기
	function openHotelModalMap() {
      document.getElementById('modalMapContainer').style.display = 'block';
		
		setTimeout(function() {
		  modalTourMarkers.length = 0;

     // 모달 지도 설정
     var mapContainer = document.getElementById('modalMap');
     modalMap = new kakao.maps.Map(mapContainer, {
         center: new kakao.maps.LatLng(33.450701, 126.570667), // 임시 좌표
         level: 3 // 기본 레벨 설정
     });
		
	    // 주소 검색 후 위치 표시
	    var geocoder = new kakao.maps.services.Geocoder();
	    geocoder.addressSearch('${hotelVo.address}', function(result, status) {
	      if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        var marker = new kakao.maps.Marker({ map: modalMap, position: coords });
	        var infowindow = new kakao.maps.InfoWindow({
	        	content: '<div style="width:150px;text-align:center;padding:6px 0;">${hotelVo.name}</div>'
	        });
	        infowindow.open(modalMap, marker);
	        
	        // 모달 지도 중심을 해당 위치로 이동
	        modalMap.setCenter(coords);
	      }
	    });
	  }, 300);
	}
	
	// 모달 지도 닫기
	function closeModalMap() {
	  document.getElementById('modalMapContainer').style.display = 'none';
	}
	
	// 관광지 버튼 처리
	function setupTouristButton(mapObj, buttonId, markerList, visibleFlagName) {
	  const btn = document.getElementById(buttonId);
	  let openInfoWindow = null;
	  
	  if (btn) {
	      btn.addEventListener('click', function() {
	    	let targetMap = mapObj;
	        if (buttonId === 'MODAL_TOUR') {
	          targetMap = modalMap; // 모달은 modalMap으로 강제 세팅
	      }
	      if (!window[visibleFlagName]) {
          
	        touristListData.forEach(spot => {
	          const coords = new kakao.maps.LatLng(Number(spot.lat), Number(spot.lng));
	          const markerImage = new kakao.maps.MarkerImage('${ctp}/images/paw_marker.png', new kakao.maps.Size(40, 40));
	          const marker = new kakao.maps.Marker({ map: targetMap, position: coords, title: spot.name, image: markerImage });
	          
	          let spotDescription = '';
	          if('${spotDescription}' != '') spotDescription = '${spotDescription}';
	          
	          var tempName = '';
	          var tempAddress = '';
	          <c:forEach var="vo" items="${vos}" varStatus="st">
	            if('${hotelVo.spotName}' == spot.name) {
	            	tempName = '${hotelVo.spotName}';
	            	tempAddress = '${hotelVo.spotAddress}';
	            }
	          </c:forEach>

	          const content = '<div style="padding:10px; font-size:13px; line-height:1.6; word-break:break-word; width:200px;">'
	            + '<div style="font-weight:bold; color:#2e7d32; margin-bottom:5px;">'+spot.name+'</div>'
	            + '<div style="font-size:12px; color:gray;">주소: '+spot.address+'</div>'
	            + '</div>';
	          const infoWindow = new kakao.maps.InfoWindow({ content: content });
	          
	          kakao.maps.event.addListener(marker, 'click', function() {

	        	if (openInfoWindow) {
	              openInfoWindow.close(); // 이전 열린 창 닫기
	            }
	            infoWindow.open(targetMap, marker); // 새 창 열기
	            openInfoWindow = infoWindow; // 현재 열린 창 기록
	            
	            // 관광지 정보 텍스트 영역에 내용 채우기
	            document.getElementById('touristInfo').style.display = 'block';
	            document.getElementById('touristName').innerText = spot.name;
	            document.getElementById('touristAddress').innerText = spot.address;
	            document.getElementById('touristDescription').innerText = spot.description;
	            
	          });
	          
	          markerList.push({ marker: marker, infoWindow: infoWindow });
	        });
	        window[visibleFlagName] = true;
	      } else {
	    	  markerList.forEach(obj => {
	              if (obj.infoWindow) obj.infoWindow.close();
	              if (obj.marker) obj.marker.setMap(null);
	            });
	            markerList.length = 0;
	            window[visibleFlagName] = false;
	      }
	    });
	  }
	}

	// 관광지 데이터 저장
	<c:forEach var="spot" items="${touristList}">
		touristListData.push({
		  lat: "${spot.lat}",
		  lng: "${spot.lng}",
		  name: "${spot.name}",
		  address: "${spot.address}",
		  description: "${spot.description}"
		});
	</c:forEach>

	console.log("touristListData = ", touristListData);
	
	// 초기 관광지 버튼 설정
	window.addEventListener('DOMContentLoaded', function() {
	  setupTouristButton(map, 'TOUR', touristMarkers, 'tourVisible'); // 메인 지도용
	  setupTouristButton(null, 'MODAL_TOUR', modalTourMarkers, 'modalTourVisible'); // 모달 지도용
	});
	
	// 지도 위에 마우스 올렸을 때 커서 변경
  /*   document.addEventListener("DOMContentLoaded", function () {
  	  setTimeout(() => {
  	    const mapArea = document.querySelector('#map > div');
  	    if (mapArea) {
  	      mapArea.style.cursor = 'grab';
  	    } else {
  	      console.warn('지도 내부 요소를 찾을 수 없습니다.');
  	    }
  	  }, 500); // 지도가 렌더링될 시간 기다려줌
  	}); */
</script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
	// 호텔 썸네일 외 이미지 3개만 보여주기
	document.addEventListener("DOMContentLoaded", function () {
    var imagesContainer = document.querySelector('.hotel-images');
    var imgTags = imagesContainer.querySelectorAll('img');

    for (var i = 0; i < imgTags.length; i++) {
      if (i >= 3) {
        imgTags[i].style.display = 'none';
      }
    }
  });


	new Swiper('.hotel-slider', {
	  loop: true,
	  pagination: {
	    el: '.swiper-pagination',
	    clickable: true
	  },
	  navigation: {
	    nextEl: '.swiper-button-next',
	    prevEl: '.swiper-button-prev'
	  },
	  autoplay: {
	    delay: 5000,
	    disableOnInteraction: false
	  }
	});
	
	// 모달 관련 요소들 선택
	const modal = document.getElementById('imageModal');
	const closeModalBtn = document.querySelector('.image-modal-close');

	// 모달 열기 함수
	function openModal() {
	  modal.style.display = 'flex';  // 모달을 보이게 설정
	}

	// 모달 닫기 함수
	function closeModal(event) {
	  if (event) {
	    // 모달 외부를 클릭하면 닫히도록
	    if (event.target === modal) {
	      modal.style.display = 'none';
	    }
	  } else {
	    modal.style.display = 'none';  // 닫기 버튼 클릭 시 모달 닫기
	  }
	}

	// 닫기 버튼 클릭 시 모달 닫기
	closeModalBtn.addEventListener('click', closeModal);
	
</script>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>