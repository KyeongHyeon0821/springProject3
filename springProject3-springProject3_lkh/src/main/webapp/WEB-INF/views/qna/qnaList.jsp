<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 리스트</title>
  <script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	 <script>
	  'use strict';
	  
	  function pageSizeCheck() {
	  	let pageSize = document.getElementById("pageSize").value;
	  	location.href = "qnaList?pag=1&pageSize="+pageSize;
	  }
	</script>
	<style>
	  a {text-decoration: none}
    a:hover {
      text-decoration: underline;
      color: orange;
    }
    
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

</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="qna-title text-center">QnA 리스트(${sMid}/${sLevel})</div>
  
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
	      <th>답변상태</th>
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
			          <c:if test="${sMid != vo.mid && sLevel != 0}">
			          	${vo.title}
			          </c:if>
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
	    <c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
		    <c:forEach var="vo" items="${vos}" varStatus="st">
			    <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		    </c:forEach>
	  </tbody>
	</table>

<!-- 블록페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="qnaList?pag=1&pageSize=${pageVo.pageSize}">첫페이지</a></li></c:if>
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
	<br/>
	<!-- 검색기 시작 -->
	<div class="text-center">
	  <!-- <form name="searchForm" method="post" action="boardSearhList"> -->
	  <form name="searchForm" method="get">
	  	<b>검색 : </b>
	  	<select name="search" id="search">
	  	  <option value="title">제목</option>
	  	  <option value="nickName">작성자</option>
	  	  <option value="content">글내용</option>
	  	</select>
	  	<input type="text" name="searchString" id="searchString" required />
	  	<input type="submit" value="검색" class="btn btn-secondary btn-sm" />
	  	<input type="hidden" name="pag" value="${pageVo.pag}" />
	  	<input type="hidden" name="pageSize" value="${pageVo.pageSize}" />
	  </form>
	</div>
	<!-- 검색기 끝 -->

</div>

</body>
</html>
