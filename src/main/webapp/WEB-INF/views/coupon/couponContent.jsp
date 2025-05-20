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
        </td>
      </tr>
    </table>
    <div class="text-center">
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/coupon/couponForm';" class="btn btn-primary"/>
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