<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>호텔 관리 페이지</h2>
  <table class="table">
  	<tr>
  		<td>호텔 번호</td>
  		<td>호텔 등록자 ID</td>
  		<td>호텔 이름</td>
  		<td>호텔 주소</td>
  		<td>호텔 연락처</td>
  		<td>호텔 이미지</td>
  		<td>호텔 상태</td>
  	</tr>
  	<c:forEach var="vo" items="${vos}" varStatus="st">
  	<tr>
  		<td>${vo.idx}</td>
  		<td><a href="${vo.mid}"></a></td>
  		<td><a href="${vo.name}"></a></td>
  		<td><a href="${vo.address}"></a></td>
  		<td><a href="${vo.tel}"></a></td>
  		<td><a href="${vo.images}"></a></td>
  		<td><a href="${vo.regDate}"></a></td>
  	</tr>
  	</c:forEach>
  </table>
</div>
<p><br/></p>
</body>
</html>