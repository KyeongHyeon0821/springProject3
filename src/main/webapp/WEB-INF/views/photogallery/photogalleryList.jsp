<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>포토갤러리</title>
  <script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    body {
      background-color: #f9fefb;
      font-family: 'Arial', sans-serif;
      font-size: 1.1rem;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 40px 20px;
    }

    .my-page-header {
      text-align: center;
      font-weight: bold;
      font-size: 2rem;
      margin-bottom: 30px;
      color: #2e7d32;
    }

    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
    }

    th {
      background-color: #e0f5e9;
      padding: 12px;
      text-align: center;
      color: #444;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
    }

    td {
      background-color: #fff;
      padding: 14px 12px;
      text-align: center;
      border-bottom: 1px solid #e5e5e5;
    }

    td a {
      text-decoration: none;
      font-weight: 500;
    }

    td a:hover {
      color: #4caf50;
      text-decoration: none;
    }

    .badge {
      display: inline-block;
      padding: 4px 10px;
      font-size: 0.9rem;
      font-weight: 500;
      border-radius: 10px;
      color: white;
    }

    .badge-success {
      background-color: #388e3c;
    }

    .badge-warning {
      background-color: #f9a825;
    }

    .pagination .page-link {
      color: #2e7d32;
      border-color: #2e7d32;
    }

    .pagination .active .page-link {
      background-color: #2e7d32;
      border-color: #2e7d32;
    }

    .no-data {
      text-align: center;
      padding: 30px 0;
      color: #888;
    }
  </style>
  <script>
    'use strict';
    
    
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="col m-3 text-center">
    <img src="${ctp}/images/logo.png" width="100px"/>
	  <span class="my-page-header">포토갤러리</span>
	</div>
  <div class="section-box">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div>
        <select name="pageSize" id="pageSize" onchange="pageSizeCheck()" class="form-select form-select-sm w-auto d-inline">
          <option ${pageVo.pageSize==5 ? 'selected' : ''}>5</option>
          <option ${pageVo.pageSize==10 ? 'selected' : ''}>10</option>
          <option ${pageVo.pageSize==15 ? 'selected' : ''}>15</option>
          <option ${pageVo.pageSize==20 ? 'selected' : ''}>20</option>
        </select>
        <button class="btn btn-outline-success" onclick="location.href='${ctp}/photogallery/photogalleryInput';">작성하기</button>
      </div>
      <div>
        <c:if test="${sLevel != 0}">
          <button class="btn btn-outline-success" onclick="location.href='${ctp}/photogallery/photogalleryInput';">작성하기</button>
        </c:if>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th class="text-center">번호</th>
          <th class="text-center">장소</th>
          <th class="text-center">제목</th>
          <th class="text-center">작성날짜</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${vos}">
          <tr>
          	<td>${vo.idx}</td>
            <td>${vo.part}</td>
            <td><a href="${ctp}/photogallery/photogalleryDetail?idx=${vo.idx}">${vo.title}</a></td>
            <td>${vo.WDate.substring(0,16)}</td>
          </tr>
        </c:forEach>
        <c:if test="${empty vos}">
          <tr>
            <td colspan="5" class="no-data">등록된 글이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>

<!-- 블록페이지 시작 -->
<div class="text-center mt-4">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link" href="qnaList?part=${pageVo.part}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link" href="qnaList?part=${pageVo.part}&pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link" href="qnaList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link" href="qnaList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link" href="qnaList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link" href="qnaList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->

  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
