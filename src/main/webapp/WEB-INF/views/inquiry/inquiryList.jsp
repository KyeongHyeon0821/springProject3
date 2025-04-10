<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 리스트</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    table {
      width: 80%;
      margin: 0 auto;
      border-collapse: collapse;
    }
    th, td {
      padding: 10px;
      border-bottom: 1px solid #ddd;
      text-align: center;
    }
    th {
      background-color: #f5f5f5;
    }
    h3 {
      text-align: center;
    }
    a {
      color: #333;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<h3 class="text-center m-5">1:1 문의 리스트</h3>

<table>
  <tr>
    <th>번호</th>
    <th>제목</th>
    <th>분류</th>
    <th>작성일</th>
    <th>상태</th>
  </tr>

  <c:forEach var="vo" items="${vos}">
    <tr>
      <td>${vo.idx}</td>
      <td>
        <a href="/inquiry/detail?idx=${vo.idx}">
          ${vo.title}
        </a>
      </td>
      <td>${vo.part}</td>
      <td>${vo.wDate}</td>
      <td>${vo.reply}</td>
    </tr>
  </c:forEach>

  <c:if test="${empty vos}">
    <tr>
      <td colspan="5">등록된 문의가 없습니다.</td>
    </tr>
  </c:if>

</table>

</body>
</html>
