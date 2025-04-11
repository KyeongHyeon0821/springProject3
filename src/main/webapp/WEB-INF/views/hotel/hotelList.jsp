<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>호 텔 리 스 트</h2>
	<hr class="border-secondary">
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<table class="table table-bordered mb-5">
			<tr>
				<th style="width:15%">대표사진</th><td><img src="${ctp}/hotelThumbnail/${vo.thumbnail}" width="200px" /></td>
			</tr>
			<tr>
				<th>이름</th><td><a href="${ctp}/hotel/hotelDetail?idx=${vo.idx}">${vo.name}</a></td>
			</tr>
			<tr>
				<th>주소</th><td>${vo.address}</td>
			</tr>
			<tr>
				<th>연락처</th><td>${vo.tel}</td>
			</tr>
			<tr>
				<th>호텔소개</th>
				<td colspan="2">${vo.description}</td>
			</tr>
		</table>
	</c:forEach>
	<div>
		<input type="button" value="돌아가기" onclick="location.href='${ctp}/'" class="btn btn-warning"/>
	</div>
</div>
</body>
</html>