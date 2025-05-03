<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>위드펫 - 반려견 동반 여행</title>
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
</head>
<body>
<!-- search -->
<jsp:include page="/WEB-INF/views/include/homeMain.jsp" />
<jsp:include page="/WEB-INF/views/include/mainModal.jsp" />
</body>
</html>