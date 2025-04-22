<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 관리자 상세보기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">FAQ 관리자 상세보기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 90%;">
    <table class="table table-bordered">
      <tr>
        <th class="bg-light" style="width: 15%;">제목</th>
        <td>${vo.title}</td>
      </tr>
      <tr>
        <th class="bg-light">내용</th>
        <td style="min-height: 200px;">${vo.content}</td>
      </tr>
      <tr>
        <th class="bg-light">조회수</th>
        <td>${vo.readNum}</td>
      </tr>
    </table>

    <div class="text-center mt-4">
      <a href="${ctp}/admin/faq/faqList" class="btn btn-info me-2">목록</a>
      <a href="${ctp}/admin/faq/faqUpdate?idx=${vo.idx}" class="btn btn-warning me-2">수정</a>
      <a href="${ctp}/admin/faq/faqDelete?idx=${vo.idx}" class="btn btn-danger"
         onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
    </div>
  </div>
</div>

<p><br/></p>
</body>
</html>
