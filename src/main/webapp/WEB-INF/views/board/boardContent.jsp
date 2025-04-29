<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    html, body {
      height: 100%;
    }
    body {
      display: flex;
      flex-direction: column;
    }
    .container {
      flex: 1;
    }
    footer {
      margin-top: auto;
    }
    th {
      background-color: #f2f2f2;
      width: 120px;
      text-align: center;
    }
    td {
      background-color: #fff;
    }
    .content-box {
      padding: 15px;
      background-color: #f9f9f9;
      border: 1px solid #dee2e6;
      border-radius: 5px;
      min-height: 200px;
      white-space: pre-wrap;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container mt-4" style="max-width: 900px;">
  <h3 class="mb-4 fw-bold border-bottom pb-2">${vo.title}</h3>

  <table class="table table-bordered">
    <tr>
      <th>작성자</th>
      <td>${vo.nickName} (${vo.mid})</td>
      <th>조회수</th>
      <td>${vo.readCount}</td>
    </tr>
    <tr>
      <th>작성일</th>
      <td colspan="3">${vo.createdAt}</td>
    </tr>
    <tr>
      <th>내용</th>
      <td colspan="3">
        <div class="content-box">
         <pre style="margin:0; background:transparent; border:0; padding:0;">${vo.content}</pre>
        </div>
      </td>
    </tr>
  </table>

  <div class="text-end mt-4">
    <c:if test="${sMid eq vo.mid}">
      <a href="${ctp}/board/update?idx=${vo.idx}" class="btn btn-warning">수정</a>
      <a href="${ctp}/board/delete?idx=${vo.idx}" class="btn btn-danger">삭제</a>
    </c:if>
    <c:if test="${sMid ne vo.mid and sLevel == 0}">
      <a href="${ctp}/board/delete?idx=${vo.idx}" class="btn btn-danger">관리자 삭제</a>
    </c:if>
    <a href="${ctp}/board/list" class="btn btn-secondary">목록</a>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
