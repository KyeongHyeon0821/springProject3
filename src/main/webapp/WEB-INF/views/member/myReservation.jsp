<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myReservation.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2 class="text-center">예약 내역</h2>
	
	<c:if test="${!empty vos}">
		<table class="table table-hover">
			<tr>
				<th>번호</th>
				<th>예약번호</th>
				<th>예약자이름</th>
				<th>예약자연락처</th>
				<th>이메일</th>
				<th>금액</th>
				<th>예약상태</th>
			</tr>
			<c:set var="vosSize" value="${fn:length(vos)}"/>
			<c:forEach items="${vos}" var="vo" varStatus="st">
				<tr>
					<td>${vosSize - st.index}</td>
					<td><a href="${ctp}/reservation/reservationDetail/${vo.reservationNo}">${vo.reservationNo}</a></td>
					<td>${vo.name}</td>
					<td>${vo.tel}</td>
					<td>${vo.email}</td>
					<td>${vo.totalPrice}</td>
					<td>${vo.status}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<c:if test="${empty vos}">
		<div>예약 내역이 없습니다.</div>
	</c:if>
	
</div>
</body>
</html>