<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 관리자 상세보기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
  	'use strict';
  	
  	function deleteCheck(idx) {
  		let ans = confirm("현재 게시글을 삭제하시겠습니까?");
  		if(ans) location.href = "adFaqDelete?idx=${vo.idx}";
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">FAQ 관리자 상세보기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 90%;">
  	<div><b>분류 : ${vo.category}</b></div>
    <table class="table table-bordered">
      <tr>
        <th class="bg-light" style="width:10%;">제목</th>
        <td>${vo.title}</td>
        <th class="bg-light" style="width:10%;">조회수</th>
        <td>${vo.readNum}</td>
      </tr>
      <tr>
        <th class="bg-light" style="height:300px">내용</th>
        <td colspan="3">${vo.content}</td>
      </tr>
    </table>

    <div class="text-center mt-4">
      <a href="${ctp}/faq/adFaqList" class="btn btn-info me-2">목록으로</a>
      <input type="button" value="수정하기" onclick="location.href='${ctp}/faq/adFaqUpdate?idx=${vo.idx}';" class="btn btn-warning me-2"/>
      <input type="button" value="삭제하기" onclick="deleteCheck(${vo.idx})" class="btn btn-danger"/>
    </div>
  </div>
</div>
	  <hr/>
	  <!-- 이전글/다음글 -->
	  <div class="row">
	  	<div class="col">
	  	  <c:if test="${!empty nextVo.title}">
	  			👉 <a href="adFaqDetail?idx=${nextVo.idx}">다음글 : ${nextVo.title}</a><br/>
	  		</c:if>
	  	  <c:if test="${!empty preVo.title}">
	  			👈 <a href="adFaqDetail?idx=${preVo.idx}">이전글 : ${preVo.title}</a><br/>
	  		</c:if>
	  	</div>
	  </div>
<p><br/></p>
</body>
</html>
