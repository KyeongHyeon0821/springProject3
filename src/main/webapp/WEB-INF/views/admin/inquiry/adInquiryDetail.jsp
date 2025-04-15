<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 상세보기 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
 		'use strict';
 		
 		function inquiryReplyInput() {
 			let idx = ${vo.idx};
 			let reContent = $("#reContent").val();
 			if(reContent == "") {
 				alert("답변을 입력하세요.");
 				replyForm.reContent.focus();
 				return false;
 			}
 			let query = {
 					idx : idx,
 					reContent : reContent
 			}
 			$.ajax({
 				url : "${ctp}/admin/inquiry/adInquiryDetail",
 				type : "post",
 				data : query,
 				success:function(res) {
 					if(res != "0") {
 						alert("답변이 등록되었습니다.");
 						location.reload();
 					}
 					else alert("답변 등록 실패");
 				},
 			error:function() { alert("전송오류"); }
 			});
 		}
 		
 		function inquiryReplyUpdateReady() {
 			$("#btnReplyUpdate").hide();
 			$("#btnReplyUpdateOk").show();
 			$("#reContent").attr("readonly", false);
 		}
 		
 		function inquiryReplyUpdateOk() {
 			let reContent = $("#reContent").val();
 			
 			if(reContent.trim() == "") {
 				alert("수정할 답변을 입력하세요.");
 				return false;
 			}
 			let query = {
 					reIdx : ${vo.reIdx},
 					reContent : reContent
 			}
 			$.ajax({
 				url : "${ctp}/admin/inquiry/adInquiryDetailUpdate",
 				type : "post",
 				data : query,
 				success:function(res) {
 					if(res != "0"){
 						alert("답변이 수정되었습니다.");
 						location.reload();
 					}
 					else ("답변 수정 실패");
 				},
 				error : function() { alert("전송오류"); }
 			});
 		}
 		
 		function inquiryHoldCheck() {
 			$.ajax({
 				url : "${ctp}/admin/inquiry/adInquiryDetailHold",
 				type : "post",
 				data : {idx : ${vo.idx}},
 				success:function(res) {
 					if(res != "0"){
 						alert("답변이 보류되었습니다.");
 						location.reload();
 					}
 					else ("답변 보류 실패");
 				},
 				error : function() { alert("전송오류"); }
 			});
 		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">1:1 문의 상세보기 관리</h3>

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
      <c:if test="${vo.reply != '답변보류'}">
    		<input type="button" value="보류하기" onclick="inquiryHoldCheck()" class="btn btn-warning m-1">
    	</c:if>
      <button class="btn btn-secondary" onclick="location.href='${ctp}/admin/inquiry/adInquiryList';">목록으로</button>
    </div>
    <div class="container mt-5">
		  <form name="replyForm" method="post" action="${ctp}/admin/inquiry/adInquiryDetail?idx=${vo.idx}">
		    <div class="mb-3">
		      <label for="reContent" class="form-label fw-bold">답변글 작성</label>
		      <textarea name="reContent" id="reContent" class="form-control" rows="6" placeholder="답변글을 작성해주세요." ${not empty vo.reContent ? 'readonly' : ''}>${vo.reContent}</textarea>
		    </div>
		    <div class="text-end">
		      <c:if test="${empty vo.reContent}">
			      <input type="button" value="답변등록" id="btnReplyInput" onclick="inquiryReplyInput()" class="btn btn-primary">
		      </c:if>
		      <c:if test="${!empty vo.reContent}">
			      <input type="button" value="답변수정" id="btnReplyUpdate" onclick="inquiryReplyUpdateReady()" class="btn btn-warning">
		      </c:if>
		      <input type="button" value="수정완료" id="btnReplyUpdateOk" onclick="inquiryReplyUpdateOk()" class="btn btn-info" style="display:none">
		    </div>
		  </form>
		</div>
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