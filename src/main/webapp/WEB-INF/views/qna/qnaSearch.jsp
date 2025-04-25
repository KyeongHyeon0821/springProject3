<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 검색결과</title>
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
	
	  .section-box {
	    background: #fff;
	    border-radius: 12px;
	    padding: 60px;
	    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
	    border: 1px solid #e0e0e0;
	  }
	
	  .qna-title {
	    text-align: center;
	    font-weight: bold;
	    font-size: 2rem;
	    margin-bottom: 30px;
	    color: #2e7d32;
	  }
	
	  table {
	    width: 100%;
	    border-collapse: separate;
	    border-spacing: 0 10px;
	  }
	
	  th {
	    padding: 14px 12px;
	    text-align: center;
	    color: #444;
	    border-top: 1px solid #d0e0d5;
	    border-bottom: 1px solid #d0e0d5;
	  }
	
	  thead th {
	    background-color: #e0f5e9 !important;
	  }
	
	  td {
	    background-color: #fff;
	    padding: 14px 12px;
	    text-align: center;
	    border-bottom: 1px solid #e5e5e5;
	  }
	
	  .pagination .page-link {
	    color: #2e7d32;
	    border-color: #2e7d32;
	  }
	
	  .pagination .active .page-link {
	    background-color: #2e7d32;
	    border-color: #2e7d32;
	  }
	
	  .badge {
	    display: inline-block;
	    padding: 4px 10px;
	    font-size: 0.9rem;
	    font-weight: 500;
	    border-radius: 10px;
	    color: white;
	  }
	
	  .bg-success {
	    background-color: #388e3c !important;
	  }
	
	  .bg-warning {
	    background-color: #f9a825 !important;
	  }
	</style>
  <script>
    'use strict';
    function pageSizeCheck() {
      let pageSize = document.getElementById("pageSize").value;
      location.href = "qnaList?pag=1&pageSize=" + pageSize;
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
<h3 class="text-center mb-0">
<img src="${ctp}/images/logo.png" width="150px"/></h3>
  <div class="qna-title">QnA 검색결과</div>

  <div class="section-box mt-4">
  <div class="text-center">(${pageVo.searchStr}(으)로 ${pageVo.searchString}을(를) 검색한 결과 ${fn:length(vos)}건이 검색되었습니다.)</div>
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div>
        <select name="pageSize" id="pageSize" onchange="pageSizeCheck()" class="form-select form-select-sm w-auto d-inline">
          <option ${pageVo.pageSize==5 ? 'selected' : ''}>5</option>
          <option ${pageVo.pageSize==10 ? 'selected' : ''}>10</option>
          <option ${pageVo.pageSize==15 ? 'selected' : ''}>15</option>
          <option ${pageVo.pageSize==20 ? 'selected' : ''}>20</option>
        </select>
      </div>
      <div>
        <button class="btn btn-outline-success btn-sm" onclick="location.href='${ctp}/qna/qnaInput';">글올리기</button>
      </div>
    </div>

    <table class="table">
      <thead>
        <tr>
          <th class="text-center">번호</th>
          <th class="text-center">답변상태</th>
          <th class="text-center">제목</th>
          <th class="text-center">작성자</th>
          <th class="text-center">작성날짜</th>
        </tr>
      </thead>
      <tbody>
        <c:if test="${empty vos}">
          <tr>
            <td colspan="5" class="text-center">등록된 글이 없습니다.</td>
          </tr>
        </c:if>
        <c:forEach var="vo" items="${vos}">
          <tr>
            <td>${vo.idx}</td>
            <td>
              <c:if test="${vo.qnaAnswer == '답변대기'}">
                <span class="badge bg-warning">${vo.qnaAnswer}</span>
              </c:if>
              <c:if test="${vo.qnaAnswer == '답변완료'}">
                <span class="badge bg-success">${vo.qnaAnswer}</span>
              </c:if>
            </td>
            <td class="text-start">
              <c:if test="${vo.qnaSw == 'a'}">ㄴ</c:if>
              <c:if test="${vo.delCheck != 'OK'}">
                <c:if test="${vo.openSw != 'OK'}"><i class="fa-solid fa-lock"></i>
                  <c:if test="${sMid == vo.mid || sLevel == 0}">
                    <a href="${ctp}/qna/qnaDetail?idx=${vo.idx}" class="text-dark">${vo.title}</a>
                  </c:if>
                  <c:if test="${sMid != vo.mid && sLevel != 0}">${vo.title}</c:if>
                </c:if>
                <c:if test="${vo.openSw == 'OK'}">
                  <a href="${ctp}/qna/qnaDetail?idx=${vo.idx}" class="text-dark">${vo.title}</a>
                </c:if>
              </c:if>
              <c:if test="${vo.delCheck == 'OK'}">
                <font color="#ddd">삭제된 자료입니다.</font>
              </c:if>
            </td>
            <td>${vo.nickName}</td>
            <td>${vo.WDate.substring(0, 10)}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- 블록페이지 -->
    <div class="text-center mt-4">
      <ul class="pagination justify-content-center">
        <c:if test="${pageVo.pag > 1}">
          <li class="page-item"><a class="page-link" href="qnaList?pag=1&pageSize=${pageVo.pageSize}">첫페이지</a></li>
        </c:if>
        <c:if test="${pageVo.curBlock > 0}">
          <li class="page-item"><a class="page-link" href="qnaList?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li>
        </c:if>
        <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}">
          <c:if test="${i <= pageVo.totPage}">
            <li class="page-item ${i == pageVo.pag ? 'active' : ''}">
              <a class="page-link" href="qnaList?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a>
            </li>
          </c:if>
        </c:forEach>
        <c:if test="${pageVo.curBlock < pageVo.lastBlock}">
          <li class="page-item"><a class="page-link" href="qnaList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li>
        </c:if>
        <c:if test="${pageVo.pag < pageVo.totPage}">
          <li class="page-item"><a class="page-link" href="qnaList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li>
        </c:if>
      </ul>
    </div>
  <!-- 검색기 -->
  <div class="text-center mt-4">
    <form name="searchForm" method="post" action="qnaSearch">
      <b>검색 : </b>
      <select name="search" id="search">
        <option value="title">제목</option>
        <option value="nickName">작성자</option>
        <option value="content">글내용</option>
      </select>
      <input type="text" name="searchString" id="searchString" required />
      <input type="submit" value="검색" class="btn btn-outline-secondary btn-sm" />
      <input type="hidden" name="pag" value="${pageVo.pag}" />
      <input type="hidden" name="pageSize" value="${pageVo.pageSize}" />
    </form>
  </div>
  </div>

</div>
</body>
</html>