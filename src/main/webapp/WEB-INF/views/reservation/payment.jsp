<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>payment.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	
	<script>
		IMP.init("imp76101506");
	
		IMP.request_pay(
		  {
			  pg : "html5_inicis.INIpayTest",
		    pay_method: "card",
		    name: "${hotelVo.name}",
		    amount: "${vo.totalPrice}",
		    buyer_email: "${vo.email}",
		    buyer_name: "${vo.name}",
		    buyer_tel: "${vo.tel}",
		  },
		  function (res) {
			  if(res.success) {
				  alert("결제가 완료되었습니다.");
				  location.href="${ctp}/reservation/paymentOk";
			  }
			  else {
				  alert("결제가 취소되었습니다.\n마이페이지에서 다시 결제를 진행해 주세요.");
				  location.href="${ctp}/member/memberMyPage";
			  }
		  },
		);
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<p class="text-center">
		<img src="${ctp}/images/payment.gif" />
	</p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>