<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 리스트</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<style>
	  th, td {
	    text-align: center;
	    border-top: none;
	    border-left: none;
	    border-right: none;
	    border-bottom: 1px solid #dee2e6;
	  }
	
	  thead th {
	    background-color: #f8f9fa;
	  }
	
	  table {
	    border-collapse: collapse;
	    width: 100%;
	  }
	
	  .qna-title {
	    font-weight: bold;
	    font-size: 22px;
	    margin: 30px 0;
	  }
	</style>

  <script>
  
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="qna-title text-center">QnA 리스트</div>
  
  <div class="d-flex justify-content-between align-items-center mb-2">
    <div>
      <select name="pageSize" id="pageSize" onchange="pageSizeCheck()" class="form-select form-select-sm w-auto d-inline">
        <option ${pageVo.pageSize==5 ? 'selected' : ''}>5</option>
        <option ${pageVo.pageSize==10 ? 'selected' : ''}>10</option>
        <option ${pageVo.pageSize==15 ? 'selected' : ''}>15</option>
        <option ${pageVo.pageSize==20 ? 'selected' : ''}>20</option>
      </select>
    </div>
    <div>
      <button class="btn btn-secondary btn-sm" onclick="location.href='${ctp}/qna/qnaInput';">글올리기</button>
    </div>
  </div>

	<table class="table">
	  <thead class="table-light">
	    <tr>
	      <th>번호</th>
	      <th>제목</th>
	      <th>작성자</th>
	      <th>작성날짜</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:if test="${empty vos}">
	      <tr>
	        <td colspan="4" class="text-center">등록된 글이 없습니다.</td>
	      </tr>
	    </c:if>
	  
	    <c:forEach var="vo" items="${vos}">
	      <tr>
	        <td>${vo.idx}</td>
	        <td class="text-start">
	          <c:if test="${vo.openSw != 'OK'}">🔒</c:if>
	          <a href="${ctp}/qna/qnaDetail?idx=${vo.idx}" class="text-dark">${vo.title}</a>
	        </td>
	        <td>${vo.nickName}</td>
	        <td>${vo.WDate.substring(0, 10)}</td>
	      </tr>
	    </c:forEach>
	  </tbody>
	</table>

<!-- 블록페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="qnaList?pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
    <c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="qnaList?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="qnaList?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link text-secondary" href="qnaList?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="qnaList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="qnaList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->

  <!-- 검색 -->
  <form method="get" action="${ctp}/qna/qnaList" class="text-center mb-5">
    <select name="searchOption">
      <option value="title">글제목</option>
      <option value="nickName">글쓴이</option>
    </select>
    <input type="text" name="searchString" />
    <input type="submit" value="검색" class="btn btn-outline-secondary btn-sm" />
  </form>
</div>

</body>
</html>
