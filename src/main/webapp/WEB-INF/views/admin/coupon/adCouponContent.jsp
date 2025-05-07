<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adCouponContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <style>
    th {
      text-align: center;
      vertical-align: middle;
      background-color: #eee !important;
    }
  </style>
  <script>
    'use strict';
    
    function discountTypeCheck(discountType) {
    	if(discountType == 'P') {
    		$("#discountValueP").show();
    		$("#discountValueA").hide();
    	}
    	else {
    		$("#discountValueP").hide();
    		$("#discountValueA").show();
    	}
    }
    
    function fCheck() {
    	let couponType = $("#couponType").val();
    	let couponName = $("#couponName").val();
    	let discountType = couponForm.discountType.value;
    	let discountValue = '';
    	if(discountType == 'P') $("#discountValueP").val();
    	else $("#discountValueA").val();
    	let issueDate = $("#issueDate").val();
    	let expiryDate = $("#expiryDate").val();
    	let isActive = $("#isActive").val();
    	
    	if(couponName.trim() == "") {
    		alert("쿠폰 이름을 적어주세요");
    		$("#couponName").focus();
    		return false;
    	}
    	
			// 전송전에 파일에 관련된 사항들을 체크해준다.
			let fName = document.getElementById("fName").value;
			if(fName.trim() != "") {
				let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				let maxSize = 1024 * 1024 * 5;
				let fileSize = document.getElementById("fName").files[0].size;
				
				if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
					alert("그림파일만 업로드 가능합니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 5MByte입니다.");
					return false;
				}
			}
			
			couponForm.submit();
    }
    
    // QR코드 모달로 보기
    function qrCodeView(photo) {
			$(".modal-body #imgSrc").attr("src","${ctp}/resources/data/coupon/"+photo);
    }
    
    // 쿠폰 사용처리
    function couponCheck(userCouponCode) {
    	let ans = confirm("현재 쿠폰사용자를 사용완료처리 하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "${ctp}/coupon/adUserCouponCodeUsed",
    		type : "post",
    		data : {userCouponCode : userCouponCode},
    		success:function(res) {
    			if(res != "0") {
    				alert("쿠폰이 정상적으로 사용처리 되었습니다.");
    				location.reload();
    			}
    			else alert("쿠폰 사용 처리 불가~");
    		},
    		error : function() { alert("전송오류!"); }
    	});
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">쿠폰 정보 상세보기</h2>
  <form name="couponForm" method="post" enctype="multipart/form-data">
    <table class="table table-bordered p-3">
      <tr>
        <th>쿠폰타입</th>
        <td>
          <select name="couponType" id="couponType" class="form-select">
	          <option value="R" ${vo.couponType == 'R' ? 'selected' : ''}>예약쿠폰</option>
	          <option value="E" ${vo.couponType == 'E' ? 'selected' : ''}>이벤트쿠폰</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>발행쿠폰이름</th>
        <td><input type="text" name="couponName" id="couponName" value="${vo.couponName}" class="form-control"/></td>
      </tr>
      <tr>
        <th>할인형태</th>
        <td>
          <input type="radio" name="discountType" id="discountTypeP" value="P" ${vo.discountType=='P' ? 'checked' : ''} onclick="discountTypeCheck('P')"> <label for="discountTypeP">%(퍼센트) &nbsp;</label>
          <input type="radio" name="discountType" id="discountTypeA" value="A" ${vo.discountType=='A' ? 'checked' : ''} onclick="discountTypeCheck('A')"> <label for="discountTypeA">원(현금)</label>
        </td>
      </tr>
      <c:if test="${vo.discountType=='P'}">
	      <tr id="discountValueP">
	        <th>할인율</th>
	        <td>
	          <div class="input-group">
	          	<input type="number" name="discountValue" id="discountValueP" value="${vo.discountValue}" class="form-control"/>
	          	<div class="input-group-text">%(퍼센트)</div>
	          </div>
	        </td>
	      </tr>
      </c:if>
      <c:if test="${vo.discountType=='A'}">
	      <tr id="discountValueA">
	        <th>할인액</th>
	        <td>
	          <div class="input-group">
	            <input type="number" name="discountValue" id="discountValueA" value="${vo.discountValue}" class="form-control"/>
	            <div class="input-group-text">원(금액)</div>
	          </div>
	        </td>
	      </tr>
      </c:if>
      <tr>
        <th>쿠폰발행일</th>
        <td><input type="date" name="issueDate" id="issueDate" value="${fn:substring(vo.issueDate,0,10)}" class="form-control"/></td>
      </tr>
      <tr>
        <th>쿠폰만료일</th>
        <td><input type="date" name="expiryDate" id="expiryDate" value="${fn:substring(vo.expiryDate,0,10)}" class="form-control"/></td>
      </tr>
      <tr>
        <th>쿠폰활성화</th>
        <td>
          <input type="radio" name="isActive" id="isActive0" value="0" ${vo.isActive=='0' ? 'checked' : ''}> 비활성화 &nbsp;
          <input type="radio" name="isActive" id="isActive1" value="1" ${vo.isActive=='1' ? 'checked' : ''} /> 활성화
        </td>
      </tr>
      <tr>
        <th>안내사진</th>
        <td>
          <div><img src="${ctp}/coupon/${vo.photo}" width="120px"/></div>
          <input type="file" name="fName" id="fName" class="form-control"/>
        </td>
      </tr>
    </table>
    <hr class="board-secondary">
    <div>
      <h4>쿠폰 발급 내역</h4>
      <table class="table table-hover text-center">
        <tr class="table-secondary">
          <th>번호</th>
          <th>쿠폰번호</th>
          <th>발급자 아이디</th>
          <th>발급 메일주소</th>
          <th>쿠폰 발급일자</th>
          <th>쿠폰사용여부</th>
          <th>쿠폰사용날짜</th>
          <th>QR코드</th>
          <th>비고</th>
        </tr>
        <c:forEach var="cvo" items="${vos}" varStatus="st">
          <tr>
            <td>${st.count}</td>
            <td>${cvo.userCouponCode}</td>
            <td>${cvo.mid}</td>
            <td>${cvo.email}</td>
            <td>${fn:substring(cvo.userIssueDate,0,16)}</td>
            <td>
              <c:if test="${cvo.isUse == '사용중'}"><span class="badge bg-success">${cvo.isUse}</span></c:if>
              <c:if test="${cvo.isUse != '사용중'}"><span class="badge bg-warning">${cvo.isUse}</span></c:if>
            </td>
            <td>
              <c:if test="${cvo.isUse == '사용중'}">미사용</c:if>
              <c:if test="${cvo.isUse != '사용중'}">${fn:substring(cvo.usedDate,0,16)}</c:if>
            </td>
            <td>
              <a href="#" onclick="qrCodeView('${cvo.photo}')" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#myCouponModal">상세보기</a>
            </td>
            <td><input type="button" value="사용처리" onclick="couponCheck('${cvo.userCouponCode}')" class="btn btn-primary btn-sm"/>
          </tr>
        </c:forEach>
      </table>
    </div>
    <div class="text-center">
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/coupon/adCouponList';" class="btn btn-info"/>
    </div>
  </form>
</div>

<!-- The Modal -->
<div class="modal fade" id="myCouponModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-sm">
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 id="title"><span>발행된 쿠폰 이미지</span></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <img id="imgSrc" width="470px" /><br/>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<p><br/></p>
</body>
</html>