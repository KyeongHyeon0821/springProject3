<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 관리자</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">FAQ 관리자 리스트</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 90%;">
    <div class="text-end mb-3">
      <a href="${ctp}/faq/adFaqInput" class="btn btn-outline-success btn-sm">FAQ 작성</a>
    </div>

    <table class="table table-bordered text-center align-middle">
      <thead>
        <tr>
          <th class="bg-light">번호</th>
          <th class="bg-light">제목</th>
          <th class="bg-light">작성자</th>
          <th class="bg-light">조회수</th>
          <th class="bg-light">관리</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vos" items="${faqList}">
          <tr>
            <td>${vo.idx}</td>
            <td class="text-start">
              <a href="${ctp}/faq/faqDetail?idx=${vo.idx}" class="text-decoration-none text-dark">
                ${vo.title}
              </a>
            </td>
            <td>${vo.mid}</td>
            <td>${vo.readNum}</td>
            <td>
              <a href="${ctp}/faq/faqUpdate?idx=${vo.idx}" class="btn btn-warning btn-sm">수정</a>
              <a href="${ctp}/faq/faqDelete?idx=${vo.idx}" class="btn btn-danger btn-sm"
                 onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty faqList}">
          <tr>
            <td colspan="5">등록된 FAQ가 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>

<p><br/></p>
</body>
</html>
