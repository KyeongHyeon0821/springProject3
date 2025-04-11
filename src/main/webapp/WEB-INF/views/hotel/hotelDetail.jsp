<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelDetail.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>${vo.name}</h2>
	<h5>🏨 ${vo.address}</h5>
	<div><img src="${ctp}/hotelThumbnail/${vo.thumbnail}" title="${vo.name}" alt="대표이미지" width="400px"/></div>
	
	<c:if test="${!empty vo.images}">
		<c:set var="images" value="${fn:split(vo.images, '/')}" />
		<div>
			<c:forEach var="image" items="${images}">
				<img src="${ctp}/hotelImages/${image}" width="150px"/>
			</c:forEach>
		</div>
	</c:if>
	
	<p>위치 : ${vo.address}</p>
	<p>연락처 : ${vo.tel}</p>
	<div>호텔 소개</div>
	<div>${vo.description}</div>
	
	<div class="mt-3">
		<a href="#" class="btn btn-outline-primary">객실 보기</a>
		<a href="#" class="btn btn-outline-success">리뷰 보기</a>
		<a href="hotelUpdate?idx=${vo.idx}" class="btn btn-outline-warning">호텔 정보 수정</a>
		<a href="#" class="btn btn-outline-danger">호텔 삭제</a>
	</div>
	
</div>
</body>
</html>