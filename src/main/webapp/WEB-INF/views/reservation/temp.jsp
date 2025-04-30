<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
<!-- 약관 동의 영역 -->
		<div class="checkbox-area">
		  <!-- 전체 동의 -->
		  <div class="form-check mb-2">
		    <input class="form-check-input" type="checkbox" id="allAgreeCheck" />
		    <label class="form-check-label fw-bold" for="allAgreeCheck">
		      전체 동의
		    </label>
		  </div>
		
		  <!-- 개별 약관 -->
		  <div class="form-check">
		    <input class="form-check-input sub-check" type="checkbox" id="termsCheck" />
		    <label class="form-check-label" for="termsCheck">
		      [필수] 이용약관 동의
		      <button type="button" class="btn btn-link p-0 ms-2" onclick="openModal('termsModal')">보기</button>
		    </label>
		  </div>
		
		  <div class="form-check mt-2">
		    <input class="form-check-input sub-check" type="checkbox" id="privacyCheck" />
		    <label class="form-check-label" for="privacyCheck">
		      [필수] 개인정보 수집 및 이용 동의
		      <button type="button" class="btn btn-link p-0 ms-2" onclick="openModal('privacyModal')">보기</button>
		    </label>
		  </div>
		
		  <div class="form-check mt-2">
		    <input class="form-check-input sub-check" type="checkbox" id="ageCheck" />
		    <label class="form-check-label" for="ageCheck">
		      [필수] 만 14세 이상입니다
		    </label>
		  </div>
		</div>




<!-- 약관 모달 -->
<div id="termsModal" style="display: none; position: fixed; top: 10%; left: 50%; transform: translateX(-50%);
     width: 90%; max-width: 600px; background: #fff; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.2); z-index: 9999; padding: 20px;">
  <h5 style="margin-bottom: 20px;">이용약관 및 환불규정</h5>
  <div style="max-height: 300px; overflow-y: auto; font-size: 0.95rem; line-height: 1.6;">
    <strong>1. 예약 안내</strong><br/>
    - 예약은 선착순으로 진행되며, 결제 완료 시 예약이 확정됩니다.<br/>
    - 예약 시 정확한 정보를 입력하지 않아 발생하는 문제에 대해 책임지지 않습니다.<br/><br/>

    <strong>2. 체크인 / 체크아웃</strong><br/>
    - 체크인: 오후 3시 이후<br/>
    - 체크아웃: 오전 11시 이전<br/><br/>

    <strong>3. 취소 및 환불 규정</strong><br/>
    - 이용일 5일 전까지 취소 시: 전액 환불<br/>
    - 이용일 4~3일 전: 50% 환불<br/>
    - 이용일 2일 전~당일 취소/노쇼: 환불 불가<br/>
    - 단, 천재지변이나 부득이한 사유로 인한 취소는 증빙자료 제출 시 별도 협의 가능<br/><br/>

    <strong>4. 반려견 동반 규정</strong><br/>
    - 등록된 반려견 외에는 입실이 제한될 수 있습니다.<br/>
    - 반려견의 안전 및 타 고객 피해 예방을 위해 반드시 켄넬 및 배변 패드를 지참해주세요.<br/>
    - 반려견 동반으로 인한 객실 손상이 발생할 경우 수리 비용이 청구될 수 있습니다.<br/><br/>

    <strong>5. 기타 유의사항</strong><br/>
    - 모든 객실은 금연입니다.<br/>
    - 퇴실 시 쓰레기는 분리수거해 주시고, 기본 청소 상태로 정리해 주세요.
  </div>
  <div style="text-align: right; margin-top: 20px;">
    <button onclick="closeTerms()" style="padding: 6px 16px; border: none; border-radius: 6px; background-color: #5A8DEE; color: #fff;">닫기</button>
  </div>
</div>
	
	<!-- 모달 백그라운드 -->
<div id="modalOverlay" style="display:none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
     background: rgba(0, 0, 0, 0.4); z-index: 9998;" onclick="closeTerms()"></div>
</div>
</body>
</html>