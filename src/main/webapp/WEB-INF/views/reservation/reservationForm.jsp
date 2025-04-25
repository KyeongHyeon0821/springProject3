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
			const agreeCheck = document.getElementById('agreeCheck');
			const reserveBtn = document.getElementById('reserveBtn');
			const autoFillCheck = document.getElementById('autoFillCheck');
			const name = document.getElementById('name');
			const tel = document.getElementById('tel');

			agreeCheck.addEventListener('change', function () {
				if (this.checked) {
					reserveBtn.disabled = false;
					reserveBtn.classList.remove('btn-disabled');
					reserveBtn.classList.add('btn-active');
				} else {
					reserveBtn.disabled = true;
					reserveBtn.classList.remove('btn-active');
					reserveBtn.classList.add('btn-disabled');
				}
			});
			
			// 내 정보 불러오기 체크박스
			autoFillCheck.addEventListener('change', function () {
				if (this.checked) {
					name.value = '${memberVo.name}';
					tel.value = '${memberVo.tel}';
				} else {
					name.value = "";
					tel.value = "";
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
			<div class="checkbox-area">
				<label>
					<input type="checkbox" id="autoFillCheck" />
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

			<!-- 이용약관 동의 -->
			<div class="checkbox-area">
				<label>
					<input type="checkbox" id="agreeCheck" required />
					이용약관 및 취소/환불 규정에 동의합니다.
				</label>
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
</body>
</html>
