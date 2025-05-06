<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reservationDetail.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<script>
		'use strict';
		
		function reservationCancel(reservationNo) {
			let ans = confirm("예약을 취소하시겠습니까?");
			if(!ans) return false;
			else location.href="${ctp}/reservation/reservationCancel/"+reservationNo;
		}
		
		function payment(reservationNo) {
			let ans = confirm("결제 페이지로 이동하시겠습니까?");
			if(!ans) return false;
			else location.href="${ctp}/reservation/payment/"+reservationNo;
		}
	</script>
	<style>
		.reservation-complete-container {
		  max-width: 800px;
		  margin: 40px auto;
		  padding: 30px;
		  background: #fff;
		  border-radius: 16px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		  font-family: 'Pretendard', sans-serif;
		}
		
		.complete-title {
		  font-size: 24px;
		  font-weight: 700;
		  text-align: center;
		  margin-bottom: 10px;
		  color: #333;
		}
		
		.complete-desc {
		  text-align: center;
		  color: #666;
		  margin-bottom: 30px;
		  font-size: 15px;
		}
		
		.summary-box, .info-box {
		  border: 1px solid #e2e2e2;
		  border-radius: 12px;
		  padding: 20px;
		  margin-bottom: 25px;
		  background-color: #fafafa;
		}
		
		.section-title {
		  font-size: 18px;
		  font-weight: 600;
		  margin-bottom: 15px;
		  color: #2c3e50;
		}
		
		.summary-item, .info-line {
		  display: flex;
		  justify-content: space-between;
		  padding: 6px 0;
		  font-size: 15px;
		  color: #444;
		}
		
		.summary-item .label,
		.info-line .label {
		  font-weight: 500;
		  color: #666;
		}
		
		.summary-item .value,
		.info-line strong {
		  font-weight: 600;
		  color: #111;
		}
		
		.guide-box {
		  text-align: center;
		  margin-top: 30px;
		  font-size: 14px;
		  color: #555;
		}
		
		.btn-payment {
		  display: inline-block;
		  margin-top: 10px;
		  padding: 10px 22px;
		  background-color: #5A8DEE;
		  color: #fff;
		  border-radius: 8px;
		  text-decoration: none;
		  font-weight: 600;
		  transition: background-color 0.2s ease;
		}
		
		.btn-cancel {
		  display: inline-block;
		  margin-top: 10px;
		  padding: 10px 22px;
		  background-color: #e74c3c;
		  color: #fff;
		  border-radius: 8px;
		  text-decoration: none;
		  font-weight: 600;
		  transition: background-color 0.2s ease;
		}
		.btn-review {
		  display: inline-block;
		  margin-top: 10px;
		  padding: 10px 22px;
		  background-color: #4da764;
		  color: #fff;
		  border-radius: 8px;
		  text-decoration: none;
		  font-weight: 600;
		  transition: background-color 0.2s ease;
		}
		
		.btn-back {
		  display: inline-block;
		  margin-top: 10px;
		  padding: 10px 22px;
		  background-color: #6c757d;
		  color: #fff;
		  border-radius: 8px;
		  text-decoration: none;
		  font-weight: 600;
		  transition: background-color 0.2s ease;
		  outline: none;
  		border: none;
		}
		
		.btn-payment:hover {
		  background-color: #3f6fd1;
		}
		.btn-cancel:hover {
		  background-color: #c0392b;
		}
		.btn-review:hover {
		  background-color: #3e8f52;
		}
		.btn-back:hover {
		  background-color: #5a6268;
		}
		.memo-line {
		  flex-direction: column;
		  align-items: flex-start;
		}
		
		.memo-line .label {
		  margin-bottom: 6px;
		}
		
		.memo-content {
		  white-space: pre-wrap;
		  color: #333;
		  background-color: #fff;
		  padding: 10px 12px;
		  border-radius: 8px;
		  border: 1px solid #e0e0e0;
		  width: 100%;
		  box-sizing: border-box;
		  font-size: 14px;
		  line-height: 1.6;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<div class="reservation-complete-container">
  <h2 class="complete-title">
  	<c:if test="${reservationVo.status == '결제대기'}">
  		결제 대기중입니다!
  	</c:if>
  	<c:if test="${reservationVo.status == '결제완료'}">
  		결제가 완료되었습니다!
  	</c:if>
  	<c:if test="${reservationVo.status == '이용완료'}">
  		리뷰를 작성해주세요!
  	</c:if>
  	<c:if test="${reservationVo.status == '리뷰작성'}">
  		리뷰가 작성되었습니다!
  	</c:if>
  </h2>
  <c:if test="${reservationVo.status != '예약취소'}">
  	<p class="complete-desc">예약 번호와 상세 내용을 확인해주세요.</p>
	</c:if>
  <c:if test="${reservationVo.status == '예약취소'}">
  	<c:if test="${reservationVo.status == '예약취소'}">
  		<div class="guide-box">
   			 <p><strong>취소된 결제내역입니다.</strong></p>
   		 </div>
    </c:if>
	</c:if>
	
  <!-- 예약 완료 요약 -->
  <div class="summary-box">
    <div class="summary-item">
      <span class="label">예약번호</span>
      <span class="value">${reservationVo.reservationNo}</span>
    </div>
    <div class="summary-item">
      <span class="label">예약자명</span>
      <span class="value">${reservationVo.name}</span>
    </div>
    <div class="summary-item">
      <span class="label">연락처</span>
      <span class="value">${reservationVo.tel}</span>
    </div>
    <div class="summary-item">
      <span class="label">이메일</span>
      <span class="value">${reservationVo.email}</span>
    </div>
    
    <c:if test="${not empty reservationVo.memo}">
		  <div class="info-line memo-line">
		    <span class="label">예약 메모</span>
		    <div class="memo-content">${fn:escapeXml(reservationVo.memo)}</div>
		  </div>
		</c:if>
  </div>

  <!-- 숙소 정보 -->
  <div class="info-box">
    <div class="section-title">숙소 정보</div>
    <div class="info-line">🏨 호텔: ${hotelVo.name}</div>
    <div class="info-line">🏠 객실: ${roomVo.name} (${roomVo.roomNumber})</div>
    <div class="info-line">📅 체크인: <strong>${reservationVo.checkinDate}</strong></div>
    <div class="info-line">📅 체크아웃: <strong>${reservationVo.checkoutDate}</strong></div>
    <div class="info-line">👥 인원: ${reservationVo.guestCount}명</div>
    <div class="info-line">🐶 반려견: ${reservationVo.petCount}마리</div>
  </div>

  <!-- 결제 정보 -->
  <div class="info-box">
    <div class="section-title">결제 정보</div>
    <div class="info-line">
      💰 총 결제 금액:
      <strong><fmt:formatNumber value="${reservationVo.totalPrice}" type="number" pattern="#,##0" />원</strong>
    </div>
    <div class="info-line">
    	<c:if test="${reservationVo.status == '결제대기'}">
      	🕒 예약 일시:
      </c:if>
    	<c:if test="${reservationVo.status == '결제완료' || reservationVo.status == '이용완료' || reservationVo.status == '리뷰작성'}">
      	🕒 결제 일시:
      </c:if>
    	<c:if test="${reservationVo.status == '예약취소'}">
      	🕒 취소 일시:
      </c:if>
      <strong>${fn:substring(reservationVo.regDate, 0, 19)}</strong>
    </div>
    <div class="info-line">
      📄 예약 상태: 
      <strong>${reservationVo.status}</strong>
    </div>
  </div>

  <!-- 하단 안내 -->
  <div class="guide-box">
    <!-- <p>예약 상세 내역은 <strong>마이페이지 > 예약 내역</strong>에서 확인하실 수 있습니다.</p> -->
    <input type="button" value="돌아가기" class="btn-back" onclick="location.href='${ctp}/member/myReservation'"/>
    <c:if test="${reservationVo.status == '결제대기'}">
    	<a href="javascript:reservationCancel('${reservationVo.reservationNo}')" class="btn-cancel">예약취소</a>
    	<a href="javascript:payment('${reservationVo.reservationNo}')" class="btn-payment">결제하기</a>
    </c:if>
    <c:if test="${reservationVo.status == '결제완료'}">
    	<!-- 결제 완료 후 예약취소는 환불처리가 없으므로 됐으므로 미구현 (포인트 생기면 포인트로 환불 가능)-->
    	<a href="" class="btn-cancel">예약취소</a>
    </c:if>
    <c:if test="${reservationVo.status == '이용완료'}">
    	<a href="${ctp}/room/roomUseList" class="btn-review">리뷰작성</a>
    </c:if>
  </div>
</div>
</div>
</body>
</html>