<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>messageMenu.jsp</title>
</head>
<body>
<p><br/></p>
<div class="container">
		<h3 class="text-center">✉ 문의관리 ✉</h3>
		<div>(현재 접속자:<font color="red">${sMid}</font>)</div>
		<div id="leftWindow">
				<p><a href="webMessage?mSw=0">새 문의</a></p>
				<p><a href="webMessage?mSw=1">받은 문의</a></p>
				<p><a href="webMessage?mSw=2">답변 작성</a></p>
		</div>
		<div id="rightWindow">
				<p>
						<c:if test="${mSw == 0}">
								<h3>새 문의</h3>
								<%-- <jsp:include page="wmList.jsp" /> --%>
						</c:if>
						<c:if test="${mSw == 1}">
								<h3>받은 문의</h3>
								<%-- <jsp:include page="wmList.jsp" /> --%>
						</c:if>
						<c:if test="${mSw == 2}">
								<h3>답변 작성</h3>
								<jsp:include page="wmInput.jsp" />
						</c:if>
				</p>
		</div>
</div>
<p><br/></p>
</body>
</html>