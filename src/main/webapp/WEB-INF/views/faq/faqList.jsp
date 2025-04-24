<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 리스트</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script>
		'use strict';
		
		function pageSizeCheck() {
			let pageSize = document.getElementById("pageSize").value;
			location.href = "faqList?pag=1&pageSize="+pageSize;
		}
		
		function categoryCheck(){
			let category = $('#category').val();
			if(category != '') location.href = 'faqList?category='+category;
		}
		
		function searchCheck() {
			let category = $('#category').val();
			let searchString = $('#searchString').val();
			if(searchString == '') {
				alert("검색어를 입력하세요");
				return false();
			}
			else location.href = 'faqList?searchString='+searchString+'&category='+category;
		}

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">FAQ 리스트</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 90%;">
    <div  class="row m-0">
		  <div class="col-3">
		  	<select name="category" id="category" onchange="categoryCheck()" class="form-select form-select me-3 mb-2" >
		  	  <option value="전체" ${category == "전체" ? "selected" : "" }>전체</option>
		  	  <option ${pageVo.part == "예약" ? "selected" : "" }>예약</option>
		  	  <option ${pageVo.part == "결제/환불" ? "selected" : "" }>결제/환불</option>
		  	  <option ${pageVo.part == "회원정보" ? "selected" : "" }>회원정보</option>
		  	  <option ${pageVo.part == "기타" ? "selected" : "" }>기타</option>
	  		</select>
	  	</div>
		  <div class="col-3"></div>
		  <div class="col -6">
			  <div class="input-group">
			  	<input type="text" name="searchString" id="searchString" value="${pageVo.searchString}" placeholder="제목 검색가능" class="form-control mb-2"/>
			  	<input type="button" value="검색" onclick="searchCheck()" class="btn btn-secondary btn-sm me-3" />
	      </div>
      </div>
    </div>
		
		<form name="myform">
	    <table class="table table-hover text-center">
	      <tr>
					<th>번호</th>
	        <th>제목</th>
	        <th>조회수</th>
	      </tr>
	      <c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
	      <c:forEach var="vo" items="${vos}">
	        <tr>
	     	    <td>${curScrStartNo}</td>
      			<td class="text-start">
	            <a href="${ctp}/faq/faqDetail?idx=${vo.idx}" class="text-decoration-none text-dark">
	              <b>[${vo.category}]</b> ${vo.title}
	            </a>
	          </td>
	          <td>${vo.readNum}</td>
	        </tr>
	        <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
	      </c:forEach>
	      <c:if test="${empty vos}">
	        <tr>
	          <td colspan="5">등록된 FAQ가 없습니다.</td>
	        </tr>
	      </c:if>
	    </table>
    </form>
  </div>
</div>
 <!-- 블록페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="faqList?pag=1&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">첫페이지</a></li></c:if>
    <c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="faqList?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">이전블록</a></li></c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="faqList?pag=${i}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">${i}</a></li></c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link text-secondary" href="faqList?pag=${i}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">${i}</a></li></c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="faqList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">다음블록</a></li></c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="faqList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->

<p><br/></p>
</body>
</html>
