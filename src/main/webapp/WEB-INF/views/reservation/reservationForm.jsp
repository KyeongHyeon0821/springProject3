<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약하기</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<style>
		.reservation-box {
			max-width: 800px;
			margin: 50px auto;
			padding: 30px;
			border-radius: 16px;
			background-color: #fff;
			box-shadow: 0 4px 12px rgba(0,0,0,0.05);
		}
		.reservation-title {
			font-size: 2rem;
			font-weight: 700;
			text-align: center;
			margin-bottom: 30px;
		}
		.section-title {
			font-size: 1.2rem;
			font-weight: 600;
			margin-bottom: 15px;
			border-left: 5px solid #5A8DEE;
			padding-left: 10px;
		}
		.info-box {
			padding: 20px;
			background-color: #f9f9f9;
			border-radius: 12px;
			margin-bottom: 30px;
			border: 1px solid #eee;
		}
		.form-group {
			margin-bottom: 20px;
		}
		.form-group label {
			font-weight: 600;
			margin-bottom: 8px;
			display: block;
		}
		.form-control {
			width: 100%;
			padding: 10px 14px;
			border-radius: 8px;
			border: 1px solid #ccc;
			font-size: 1rem;
		}
		.info-line {
			font-size: 1rem;
			color: #444;
			margin-bottom: 10px;
		}
		.total-price {
			font-size: 1.3rem;
			font-weight: 600;
			margin-top: 10px;
			color: #222;
		}
		.checkbox-area {
			margin: 20px 0px;
			font-size: 0.95rem;
		}
		.btn-reserve {
			display: block;
			width: 100%;
			padding: 16px;
			margin-top: 20px;
			border: none;
			border-radius: 12px;
			font-size: 1.1rem;
			font-weight: bold;
			transition: background-color 0.3s ease;
		}
		.btn-disabled {
			background-color: #ccc;
			color: #666;
			cursor: default;
			pointer-events: none;
		}
		.btn-active {
			background-color: #5A8DEE;
			color: white;
			cursor: pointer;
		}
		.btn-active:hover {
			background-color: #3f6fd1;
		}
		textarea.form-control {
			resize: none; 
			overflow-y: auto;
			min-height: 100px; 
		}
	</style>
	<script>
		document.addEventListener('DOMContentLoaded', function () {
			// 이용약관 체크시 결제 버튼 활성화
			const allAgreeCheck = document.getElementById('allAgreeCheck');
			const termsCheck = document.getElementById('termsCheck');
			const privacyCheck = document.getElementById('privacyCheck');
			const ageCheck = document.getElementById('ageCheck');
			const reserveBtn = document.getElementById('reserveBtn');
			const autoFillCheck = document.getElementById('autoFillCheck');
			const name = document.getElementById('name');
			const tel = document.getElementById('tel');
			const email = document.getElementById('email');

			allAgreeCheck.addEventListener('change', function () {
				if (this.checked) {
					termsCheck.checked = true;
					privacyCheck.checked = true;
					ageCheck.checked = true;
					reserveBtn.disabled = false;
					reserveBtn.classList.remove('btn-disabled');
					reserveBtn.classList.add('btn-active');
				} else {
					reserveBtn.disabled = true;
					reserveBtn.classList.remove('btn-active');
					reserveBtn.classList.add('btn-disabled');
				}
			});
			
			// 개별 체크박스 변경 시
			[termsCheck, privacyCheck, ageCheck].forEach(function (checkbox) {
		    checkbox.addEventListener('change', function () {
	        // 3개의 체크박스 중 하나라도 체크되지 않으면 전체 동의 체크 풀기
	        if (termsCheck.checked && privacyCheck.checked && ageCheck.checked) {
            allAgreeCheck.checked = true;
	        } else {
            allAgreeCheck.checked = false;
	        }
	        // 결제 버튼 활성화/비활성화
	        if (termsCheck.checked && privacyCheck.checked && ageCheck.checked) {
            reserveBtn.disabled = false;
            reserveBtn.classList.remove('btn-disabled');
            reserveBtn.classList.add('btn-active');
	        } else {
            reserveBtn.disabled = true;
            reserveBtn.classList.remove('btn-active');
            reserveBtn.classList.add('btn-disabled');
	        }
		    });
			});
			
			// 내 정보 불러오기 체크박스
			autoFillCheck.addEventListener('change', function () {
				if (this.checked) {
					name.value = '${memberVo.name}';
					tel.value = '${memberVo.tel}';
					email.value = '${memberVo.email}';
				} else {
					name.value = "";
					tel.value = "";
					email.value = "";
				}
			});

		});
		
		// 결제 창으로 이동 전 폼 체크
		function fCheck() {
			let name = document.getElementById('name').value.trim();
			let tel = document.getElementById('tel').value.trim();
			let memo = document.getElementById('memo').value.trim();
			let regTel = /^\d{2,3}-\d{3,4}-\d{4}$/;
			let regName = /^[가-힣a-zA-Z]+$/;

			if (name == "") {
				alert("예약자 이름을 입력해주세요.");
				document.getElementById('name').focus();
				return false;
			}
			if (!regName.test(name)) {
				alert("성명은 한글 또는 영문만 입력 가능합니다.");
				document.getElementById('name').focus();
				return false;
			}
			if (name.length > 10) {
	      alert("예약자 이름은 10자 이내로 입력해주세요.");
	      document.getElementById('name').focus();
	      return false;
	    }
			
			if (tel == "") {
				alert("예약자 연락처를 입력해주세요.");
				document.getElementById('tel').focus();
				return false;
			}
			if (!regTel.test(tel)) {
			    alert("연락처 형식이 올바르지 않습니다.");
			    document.getElementById('tel').focus();
			    return false;
			  }
			if (memo.length > 300) {
	      alert("예약 메모는 300자 이내로 입력해주세요.");
	      document.getElementById('memo').focus();
	      return false;
	    }
			return true;
		}
		
		// 모달 열기 함수
		function openModal(modalId) {
		    // 모달을 찾고 보이게 설정
		    var modal = document.getElementById(modalId);
		    var overlay = document.getElementById("modalOverlay");

		    // 모달과 오버레이 보이게 설정
		    modal.style.display = "block";
		    overlay.style.display = "block";
		}

		// 모달 닫기 함수
		function closeTerms() {
		    // 약관 모달을 찾고 숨기기
		    var modal1 = document.getElementById("termsModal");
		    var modal2 = document.getElementById("privacyModal");
		    var overlay = document.getElementById("modalOverlay");

		    modal1.style.display = "none";
		    modal2.style.display = "none";
		    overlay.style.display = "none";
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="reservation-box">
	<h2 class="reservation-title">${hotelVo.name} 예약</h2>

	<form name="reservationForm" method="post" onsubmit="return fCheck();">

		<!-- 예약자 정보 박스 -->
		<div class="info-box">
			<div class="section-title">예약자 정보</div>
			<div class="checkbox-area form-check mb-3">
				<label class="form-check-label">
					<input type="checkbox" id="autoFillCheck" class="form-check-input"/>
					내 정보 불러오기
				</label>
			</div>
			<div class="form-group">
				<label for="name">예약자 이름</label>
				<input type="text" name="name" id="name" class="form-control" required placeholder="예 : 홍길동 또는 John">
			</div>
			<div class="form-group">
				<label for="tel">예약자 연락처</label>
				<input type="text" name="tel" id="tel" class="form-control" required placeholder="예 : 010-1234-5678">
			</div>
			<div class="form-group">
				<label for="email">예약자 이메일</label>
				<input type="email" name="email" id="email" class="form-control" required placeholder="abcdefg1234@naver.com">
			</div>
			
			<div class="form-group">
				<label for="memo">예약 메모 (선택)</label>
				<textarea name="memo" id="memo" class="form-control" rows="4" placeholder="요청사항이나 전달할 메시지를 입력해주세요."></textarea>
			</div>
		</div>

		<!-- 숙소 정보 박스 -->
		<div class="info-box">
			<div class="section-title">숙소 정보</div>
			<div class="info-line">📅 체크인: <strong>${checkinDate}</strong></div>
			<div class="info-line">📅 체크아웃: <strong>${checkoutDate}</strong></div>
			<div class="info-line">🛏️ 총 숙박: ${nights}박</div>
			<div class="info-line">👥 인원: ${guestCount}명</div>
			<div class="info-line">🐶 반려견: ${petCount}마리</div>
			<div class="info-line">🏠 객실: ${roomVo.name} ${roomVo.roomNumber}</div>
		</div>

		<!-- 결제 금액 박스 -->
		<div class="info-box">
			<div class="section-title">결제 금액</div>
			<p class="total-price">
				<fmt:formatNumber value="${roomVo.price}" type="number" pattern="#,##0" />원 x ${nights}박 =
				<strong><fmt:formatNumber value="${roomVo.price * nights}" type="number" pattern="#,##0" />원</strong>
			</p>

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

			<!-- 결제 버튼 -->
			<button type="submit" class="btn-reserve btn-disabled" id="reserveBtn" disabled>결제하기</button>
		</div>

		<input type="hidden" name="roomIdx" value="${roomVo.idx}" />
		<input type="hidden" name="guestCount" value="${guestCount}" />
		<input type="hidden" name="petCount" value="${petCount}" />
		<input type="hidden" name="totalPrice" value="${roomVo.price * nights}" />
	</form>
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


<div id="privacyModal" style="display: none; position: fixed; top: 10%; left: 50%; transform: translateX(-50%);
     width: 90%; max-width: 600px; background: #fff; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.2); z-index: 9999; padding: 20px;">
  <h5 style="margin-bottom: 20px;">개인정보 처리방침</h5>
  <div style="max-height: 300px; overflow-y: auto; font-size: 0.95rem; line-height: 1.6;">
    <strong>1. 개인정보 수집 목적</strong><br/>
    - 예약 및 결제 서비스 제공을 위한 개인정보 수집<br/>
    - 예약 관리, 고객 서비스 제공, 회원 관리 등을 위한 개인정보 활용<br/><br/>

    <strong>2. 수집하는 개인정보 항목</strong><br/>
    - 이름, 연락처(전화번호, 이메일), 생년월일, 주소 등 기본 정보<br/>
    - 예약 내용 및 결제 정보, 반려견 관련 정보<br/><br/>

    <strong>3. 개인정보의 보유 및 이용 기간</strong><br/>
    - 회원 가입 시 수집된 개인정보는 회원 탈퇴 시까지 보유됩니다.<br/>
    - 예약 관련 개인정보는 예약 완료 후 5년 동안 보관될 수 있습니다.<br/><br/>

    <strong>4. 개인정보의 제공 및 공유</strong><br/>
    - 법적 의무가 있는 경우를 제외하고는 사용자의 동의 없이 제3자에게 개인정보를 제공하지 않습니다.<br/><br/>

    <strong>5. 개인정보 처리 위탁</strong><br/>
    - 고객 정보 보호 및 서비스 제공을 위한 일부 업무가 제3자에게 위탁될 수 있습니다.<br/><br/>

    <strong>6. 개인정보의 안전성 확보 조치</strong><br/>
    - 개인정보는 암호화하여 저장되며, 이를 보호하기 위한 기술적, 관리적 조치를 취합니다.<br/><br/>

    <strong>7. 이용자의 권리</strong><br/>
    - 이용자는 언제든지 개인정보 열람, 수정, 삭제를 요청할 수 있습니다.<br/>
    - 개인정보를 삭제하려면 고객센터로 문의하거나 회원 탈퇴를 진행할 수 있습니다.<br/><br/>

    <strong>8. 개인정보 수집 및 이용에 대한 동의</strong><br/>
    - 본 개인정보 처리방침에 대해 동의하시면 서비스를 이용하실 수 있습니다.<br/>
    - 동의하지 않으실 경우, 일부 서비스 이용에 제한이 있을 수 있습니다.<br/>
  </div>
  <div style="text-align: right; margin-top: 20px;">
    <button onclick="closeTerms()" style="padding: 6px 16px; border: none; border-radius: 6px; background-color: #5A8DEE; color: #fff;">닫기</button>
  </div>
</div>
	<!-- 모달 백그라운드 -->
 <div id="modalOverlay" style="display:none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.4); z-index: 9998;" onclick="closeTerms()"></div>
</body>
</html>
