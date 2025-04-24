<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 상세보기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
  	'use strict';
  	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">FAQ 상세보기</h3>

<!-- <div class="container d-flex justify-content-center"> -->
<div class="container ">
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
      <a href="${ctp}/faq/faqList" class="btn btn-info me-2">목록으로</a>
    </div>
  </div>
	<hr class="border-secondary">
	<!-- 이전글/다음글 -->
	<div class="row">
		<div class="col">
		  <c:if test="${not empty nextVo.title}">
				👉 <a href="faqDetail?idx=${nextVo.idx}">다음글 : ${nextVo.title}</a><br/>
			</c:if>
		  <c:if test="${not empty preVo.title}">
				👈 <a href="faqDetail?idx=${preVo.idx}">이전글 : ${preVo.title}</a><br/>
			</c:if>
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>
