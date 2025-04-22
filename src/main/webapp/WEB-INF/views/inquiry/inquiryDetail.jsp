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
 			else location.href="${ctp}/inquiry/inquiryUpdateCheck?idx=${vo.idx}";
 		}
 		
 		function inquiryDeleteCheck(){
 			let ans = confirm("해당 문의글을 삭제하시겠습니까?");
 			if(!ans) return false;
 			else location.href="${ctp}/inquiry/inquiryDeleteCheck?idx=${vo.idx}";
 		}
 		
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">1:1 문의 상세보기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 80%;">
<table class="table table-bordered text-center">
  <tr>
    <th class="bg-light" style="width:15%;">작성자</th>
    <td style="width:35%;">${vo.mid}</td>
    <th class="bg-light" style="width:15%;">작성일시</th>
    <td style="width:35%;"><c:out value="${vo.WDate.substring(0,16)}" /></td>
  </tr>
  <tr>
    <th class="bg-light">제목</th>
    <td>${vo.title}</td>
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
    <th class="bg-light">답변 상태</th>
    <td>
      <c:choose>
        <c:when test="${vo.reply == '답변대기중'}">
          <span class="badge bg-secondary">${vo.reply}</span>
        </c:when>
        <c:when test="${vo.reply == '답변완료'}">
          <span class="badge bg-success">${vo.reply}</span>
        </c:when>
        <c:when test="${vo.reply == '답변보류'}">
          <span class="badge bg-warning text-dark">${vo.reply}</span>
        </c:when>
        <c:otherwise>
          <span class="badge bg-info">${vo.reply}</span>
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
  <tr>
    <th class="bg-light">문의내용</th>
    <td colspan="3" class="text-start" style="white-space:pre-line">${vo.content}</td>
  </tr>
  <tr>
    <th class="bg-light">첨부파일</th>
    <td colspan="3">
      <c:if test="${not empty vo.FSName}">
        <img src="${ctp}/inquiry/${vo.FSName}" width="200px" class="img-thumbnail"
     			style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#imageModal" />
      </c:if>
      <c:if test="${empty vo.FSName}">
        없음
      </c:if>
    </td>
  </tr>
</table>
    <div class="text-center mt-4">
      <c:if test="${vo.reply != '답변완료' && vo.reply != '답변보류'}">
	    	<input type="button" value="수정하기" onclick="inquiryUpdateCheck()" class="btn btn-warning m-1">
	    	<input type="button" value="삭제하기" onclick="inquiryDeleteCheck()" class="btn btn-danger m-1">
    	</c:if>
      <button class="btn btn-secondary" onclick="location.href='${ctp}/inquiry/inquiryList';">목록으로</button>
    </div>
		<c:if test="${vo.reply == '답변완료'}">
		  <hr class="border-secondary">
		  <div class="border rounded p-3 bg-light">
		    <br/>
		    <p class="mt-2" style="white-space: pre-line;">${vo.reContent}</p>
		  </div>
		</c:if>
  </div>
</div>

<p><br/></p>

<!-- 이미지 모달 -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">

      <!-- 모달 헤더 (닫기 X 버튼 포함) -->
      <div class="modal-header">
        <h5 class="modal-title" id="imageModalLabel">첨부파일 이미지</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- 모달 바디 -->
      <div class="modal-body text-center">
        <c:if test="${!empty vo.FSName}">
	        <img src="${ctp}/inquiry/${vo.FSName}" class="img-fluid"/>
        </c:if>
      </div>

      <!-- 모달 푸터 (닫기 버튼) -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>


</body>
</html>
