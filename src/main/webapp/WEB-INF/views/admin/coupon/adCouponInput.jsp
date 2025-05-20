<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adCouponInput.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
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
			else {
				alert("안내사진을 선택하세요");
				return false;
			}
			
			couponForm.submit();
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-2">쿠폰 등록하기</h2>
  <form name="couponForm" method="post" enctype="multipart/form-data">
    <table class="table table-bordered p-3">
      <tr>
        <th>쿠폰타입</th>
        <td>
          <select name="couponType" id="couponType" class="form-select">
	          <option value="R" selected>예약쿠폰</option>
	          <option value="E" selected>이벤트쿠폰</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>발행쿠폰이름</th>
        <td><input type="text" name="couponName" id="couponName" placeholder="쿠폰 이름을 등록하세요" class="form-control"/></td>
      </tr>
      <tr>
        <th>할인형태</th>
        <td>
          <input type="radio" name="discountType" id="discountTypeP" value="P" checked onclick="discountTypeCheck('P')"> <label for="discountTypeP">%(퍼센트) &nbsp;</label>
          <input type="radio" name="discountType" id="discountTypeA" value="A" onclick="discountTypeCheck('A')"> <label for="discountTypeA">원(현금)</label>
        </td>
      </tr>
      <tr id="discountValueP">
        <th>할인율</th>
        <td>
          <div class="input-group">
          	<input type="number" name="discountValue" id="discountValueP" value="10" class="form-control"/>
          	<div class="input-group-text">%(퍼센트)</div>
          </div>
        </td>
      </tr>
      <tr id="discountValueA" style="display:none">
        <th>할인액</th>
        <td>
          <div class="input-group">
            <input type="number" name="discountValue" id="discountValueA" value="5000" class="form-control"/>
            <div class="input-group-text">원(금액)</div>
          </div>
        </td>
      </tr>
      <tr>
        <th>쿠폰발행일</th>
        <td><input type="date" name="issueDate" id="issueDate" value="<%=LocalDate.now()%>" class="form-control"/></td>
      </tr>
      <tr>
        <th>쿠폰만료일</th>
        <td><input type="date" name="expiryDate" id="expiryDate" value="<%=LocalDate.now()%>" class="form-control"/></td>
      </tr>
      <tr>
        <th>쿠폰활성화</th>
        <td>
          <input type="radio" name="isActive" id="isActive0" value="0" checked> 비활성화 &nbsp;
          <input type="radio" name="isActive" id="isActive1" value="1" /> 활성화
        </td>
      </tr>
      <tr>
        <th>안내사진</th>
        <td>
          <input type="file" name="fName" id="fName" class="form-control"/>
        </td>
      </tr>
    </table>
    <div class="text-center">
      <input type="button" value="쿠폰발행" onclick="fCheck()" class="btn btn-success me-2"/>
      <input type="reset" value="다시작성" class="btn btn-warning me-2"/>
      <input type="button" value="돌아가기" onclick="location.href='adCouponList';" class="btn btn-info"/>
    </div>
  </form>
</div>
<p><br/></p>
</body>
</html>