<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>couponForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <script>
    'use strict';
    
    function fCheck() {
    	let coupon = $("#coupon").val();
    	let email = $("#email").val();
    	if(coupon == "") {
    		alert("발행할 쿠폰을 선택하세요");
    		return false;
    	}
    	else {
    		$("#demo").show();
    		
    		let idx = coupon.split("/")[0];
    		let couponCode = coupon.split("/")[1];
    		
    		let str = '<div class="spinner-border"></div> 쿠폰 발행중입니다. <div class="spinner-border"></div>';
    		$("#demo").html(str);
    		let ans = confirm("회원님의 아래 메일주소로 쿠폰을 발행합니다.\n메일주소 : "+email+"\n쿠폰발행을 원하십니까?");
    		if(!ans) {
	    		$("#demo").html("");
    			return false;
    		}
    		
    		$.ajax({
    			url  : "couponIssue",
    			type : "post",
    			data : {
    				idx : idx,
    				couponCode : couponCode,
    				mid : '${sMid}',
    				email : '${email}'
    			},
    			success:function(res) {
    				if(res != "0") {
    					alert("쿠폰이 발송되었습니다. 메일을 확인하세요");
    					$("#demo").html("쿠폰이 발송된 메일주소 : ${email}");
    				}
    				else {
    					alert("쿠폰 발송 실패~");
    					$("#demo").hide();
    				}
    			}
    		});
    	}
    }
    
    // QR코드 모달로 보기
    function qrCodeView(couponQrcode) {
			$(".modal-body #imgSrc").attr("src","${ctp}/resources/data/couponQrcode/"+couponQrcode);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>쿠폰 관련 연습</h2>
  <hr class="border-secondary">
  <h4>쿠폰 발급받기</h4>
  <form name="couponForm" method="post">
    <div>
      <div class="input-group mb-3">
        <div class="input-group-text bg-secondary-subtle">쿠폰 발급받을 메일주소</div>
        <input type="text" name="email" id="email" value="${email}" class="form-control"/>
      </div>
      <div class="input-group">
        <div class="input-group-text bg-secondary-subtle">현재 발급중인 쿠폰</div>
        <select name="coupon" id="coupon" class="form-control">
          <option value="">쿠폰을 선택하세요</option>
          <c:forEach var="vo" items="${couponVos}" varStatus="st">
          	<option value="${vo.idx}/${vo.couponCode}">${vo.couponName}</option>
          </c:forEach>
        </select>
        <input type="button" value="쿠폰발행" onclick="fCheck()" class="btn btn-success"/>
      </div>
      <hr class="border-secondary">
      <div id="demo" style="display:none"></div>
    </div>
  </form>
  <hr class="border-secondary">
  <c:if test="${fn:length(uVos) != 0}">
	  <div>
	    <h4>현재 보유하고 있는 쿠폰정보</h4>
	    <table class="table table-hover text-center">
        <tr class="table-secondary">
          <th>번호</th>
          <th>쿠폰번호</th>
          <th>발급 메일주소</th>
          <th>쿠폰 발급일자</th>
          <th>쿠폰사용여부</th>
          <th>쿠폰사용날짜</th>
          <th>QR코드</th>
        </tr>
        <c:forEach var="vo" items="${uVos}" varStatus="st">
          <tr>
            <td>${st.count}</td>
            <td><a href="couponContent/${vo.idx}">${vo.userCouponCode}</a></td>
            <td>${vo.email}</td>
            <td>${fn:substring(vo.userIssueDate,0,16)}</td>
            <td>
              <c:if test="${vo.isUse == '사용중'}"><span class="badge bg-success">${vo.isUse}</span></c:if>
              <c:if test="${vo.isUse != '사용중'}"><span class="badge bg-warning">${vo.isUse}</span></c:if>
            </td>
            <td>
              <c:if test="${vo.isUse == '사용중'}"><span class="badge bg-info">미사용</span></c:if>
              <c:if test="${vo.isUse != '사용중'}">${fn:substring(vo.usedDate,0,16)}</c:if>
            </td>
            <td>
              <a href="#" onclick="qrCodeView('${vo.couponQrcode}')" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#myCouponModal">상세보기</a>
            </td>
          </tr>
        </c:forEach>
      </table>
	  </div>
  </c:if>
</div>
<p><br/></p>

<!-- The Modal -->
<div class="modal fade" id="myCouponModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-sm">
      <!-- Modal Header -->
      <div class="modal-header">
        <h5><span id="title"></span>발행된 쿠폰 이미지</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <img id="imgSrc"/><br/>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>