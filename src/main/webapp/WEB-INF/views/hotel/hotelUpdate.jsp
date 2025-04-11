<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelUpdate.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>🏨 호텔 정보 수정</h2>

	<form method="post" action="${ctp}/hotelUpdate" enctype="multipart/form-data">
	  <input type="hidden" name="idx" value="${vo.idx}"/>
	  <label>호텔 이름</label>
	  <input type="text" name="name" value="${vo.name}"/>
	  
	  <label>연락처</label>
	  <input type="text" name="tel" value="${vo.tel}"/>
	
	  <label>주소</label>
	  <input type="text" name="address" value="${vo.address}"/>
	
	  <label>호텔 소개</label>
	  <textarea name="description">${vo.description}</textarea>
	
	  <label>대표 썸네일</label>
	  <input type="file" name="thumbnailFile" />
	
	  <button type="submit">수정하기</button>
	</form>
	
	<hr/>
	
	<h3>💤 등록된 객실 목록</h3>
	<c:if test="${empty roomList}">
	  <p>아직 등록된 객실이 없습니다.</p>
	</c:if>
	<c:forEach var="room" items="${roomList}">
	  <div style="border:1px solid #ddd; margin:10px; padding:10px;">
	    <strong>${room.name}</strong> (₩${room.price})
	    <br/>최대인원: ${room.maxPeople}명 / 반려견: ${room.petSizeLimit}, 최대 ${room.petCountLimit}마리
	    <br/><img src="${ctp}/roomThumbnail/${room.thumbnail}" width="100px"/>
	  </div>
	</c:forEach>
	
	<hr/>
	
	<h3>➕ 객실 등록</h3>
	<form method="post" action="${ctp}/roomInput" enctype="multipart/form-data">
	  <input type="hidden" name="hotelIdx" value="${vo.idx}"/>
	
	  <label>객실명</label>
	  <input type="text" name="name"/>
	
	  <label>가격</label>
	  <input type="number" name="price"/>
	
	  <label>최대 인원</label>
	  <input type="number" name="maxPeople"/>
	
	  <label>반려견 크기 제한</label>
	  <select name="petSizeLimit">
	    <option>소형</option>
	    <option>중형</option>
	    <option>대형</option>
	  </select>
	
	  <label>반려견 수 제한</label>
	  <input type="number" name="petCountLimit" value="1"/>
	
	  <label>썸네일 이미지</label>
	  <input type="file" name="thumbnailFile"/>
	
	  <label>객실 이미지들</label>
	  <input type="file" name="roomImages" multiple/>
	
	  <button type="submit">객실 등록</button>
	</form>
</div>
</body>
</html>