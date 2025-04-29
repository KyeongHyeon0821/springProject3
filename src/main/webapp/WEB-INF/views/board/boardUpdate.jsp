<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardUpdate.jsp</title>
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
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container mt-4" style="max-width: 800px;">
  <h2 class="mb-4">글 수정</h2>
  <form action="${ctp}/board/update" method="post">
    <input type="hidden" name="idx" value="${vo.idx}" />

    <div class="mb-3">
      <label for="title" class="form-label">제목</label>
      <input type="text" class="form-control" id="title" name="title" value="${vo.title}" required>
    </div>

    <div class="mb-3">
      <label for="content" class="form-label">내용</label>
      <textarea class="form-control" id="content" name="content" rows="10" required>${vo.content}</textarea>
    </div>

    <div class="text-end">
      <button type="submit" class="btn btn-primary">수정</button>
      <a href="${pageContext.request.contextPath}/board/content?idx=${vo.idx}" class="btn btn-secondary">취소</a>
    </div>
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
