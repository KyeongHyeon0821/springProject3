<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
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

<div class="text-end" style="width: 80%; margin: 0 auto;">
	<a href="inquiryInput" class="btn btn-info btn-sm text-decoration-none mb-3">1:1문의쓰기</a>
</div>

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
        <a href="${ctp}/inquiry/inquiryDetail?idx=${vo.idx}">
          ${vo.title}
        </a>
      </td>
      <td>${vo.part}</td>
      <td>${vo.WDate}</td>
      <td>${vo.reply}</td>
    </tr>
  </c:forEach>

  <c:if test="${empty vos}">
    <tr>
      <td colspan="5">등록된 문의가 없습니다.</td>
    </tr>
  </c:if>

</table>
<br/>

<!-- 블록페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="inquiryList?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="inquiryList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->

</body>
</html>
