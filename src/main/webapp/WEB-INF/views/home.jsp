<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home</title>
</head>
<body>
<!-- search -->
<jsp:include page="/WEB-INF/views/include/homeMain.jsp" />
<jsp:include page="/WEB-INF/views/include/mainModal.jsp" />
</body>
</html>