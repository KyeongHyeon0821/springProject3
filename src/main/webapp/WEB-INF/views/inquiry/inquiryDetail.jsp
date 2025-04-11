<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 상세보기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
 		'use strict';
 		
 		function inquiryUpdateCheck(){
 			let ans = confirm("해당 문의글을 수정하시겠습니까?");
 			if(!ans) return false;
 			else locaiton.href="${ctp}/inquiry/inquiriyDetailCheck?idx=${vo.idx}";
 		}
 		
 		function inquiryDeleteCheck(){
 			let ans = confirm("해당 문의글을 삭제하시겠습니까?");
 			if(!ans) return false;
 			else location.href="${ctp}/inquiry/inquiryDetailCheck?idx=${vo.idx}";
 		}
 		
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">1:1 문의 상세보기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 80%;">
    <table class="table table-bordered">
      <tr>
        <th class="bg-light">작성자</th>
        <td>${vo.mid}</td>
      </tr>
      <tr>
        <th class="bg-light">제목</th>
        <td>${vo.title}</td>
      </tr>
      <tr>
        <th class="bg-light">분류</th>
        <td>${vo.part}</td>
      </tr>
      <tr>
        <th class="bg-light">예약번호</th>
        <td>
          <c:choose>
            <c:when test="${empty vo.reservation}">-</c:when>
            <c:otherwise>${vo.reservation}</c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr>
        <th class="bg-light">작성일시</th>
        <td><c:out value="${vo.WDate.substring(0,16)}" /></td>
      </tr>
      <tr>
        <th class="bg-light">문의내용</th>
        <td style="white-space:pre-line">${vo.content}</td>
      </tr>
      <tr>
        <th class="bg-light">첨부파일</th>
        <td>
          <c:if test="${not empty vo.FSName}">
            <img src="${ctp}/inquiry/${vo.FSName}" width="200px" />
          </c:if>
          <c:if test="${empty vo.FSName}">
            없음
          </c:if>
        </td>
      </tr>
			<tr>
			  <th class="bg-light">답변 상태</th>
			  <td>
			    <c:choose>
			      <c:when test="${vo.reply == '답변 대기중'}">
			        <span class="badge bg-secondary">${vo.reply}</span>
			      </c:when>
			      <c:when test="${vo.reply == '답변 완료'}">
			        <span class="badge bg-success">${vo.reply}</span>
			      </c:when>
			      <c:when test="${vo.reply == '답변 보류'}">
			        <span class="badge bg-warning text-dark">${vo.reply}</span>
			      </c:when>
			      <c:otherwise>
			        <span class="badge bg-info">${vo.reply}</span>
			      </c:otherwise>
			    </c:choose>
			  </td>
			</tr>

    </table>

    <div class="text-center mt-4">
    	<input type="button" value="수정하기" onclick="inquiryUpdateCheck()" class="btn btn-warning m-1">
    	<input type="button" value="삭제하기" onclick="inquiryDeleteCheck()" class="btn btn-danger m-1">
      <button class="btn btn-secondary" onclick="location.href='/inquiry/inquiryList';">목록으로</button>
    </div>
  </div>
</div>

<p><br/></p>
</body>
</html>
