<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>roomDetail.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h3>객실 상세</h3>
	<div><img src="${ctp}/roomThumbnail/${vo.thumbnail}" title="${vo.name}" alt="대표이미지" width="400px"/></div>
	
	<c:if test="${!empty vo.images}">
		<c:set var="roomImages" value="${fn:split(vo.images, '/')}" />
		<div class="roomImagesDiv">
			<c:forEach var="roomImage" items="${roomImages}" varStatus="st">
				<img src="${ctp}/roomImages/${roomImage}" width="200px">
			</c:forEach>
		</div>
	</c:if>
	<h3>${vo.name}</h3>
	
	
	<ul>
		<li>최대 ${vo.maxPeople}인</li>
		<li>반려견 크기제한 ${vo.petSizeLimit}</li>
		<li>반려견 최대 ${vo.petCountLimit}마리</li>
	</ul>
	
	<div>시설/서비스</div>
	<c:forEach items="${roomOptionList}" var="optionVo" varStatus="st">
		<div>${optionVo.name}</div>
	</c:forEach>
	
	
	<div>${vo.price}원</div>
	
	<a href="${ctp}/hotel/hotelDetail?idx=${vo.hotelIdx}" class="btn btn-warning">돌아가기</a>
	<input type="button" value="예약하기" onclick="" class="btn btn-success" />
	
	<c:if test="${vo.mid == sMid}">
		<div>
			<a href="roomUpdate?roomIdx=${vo.idx}" class="btn btn-info">객실 정보 수정</a>
		</div>
	</c:if>
	
</div>
</body>
</html>