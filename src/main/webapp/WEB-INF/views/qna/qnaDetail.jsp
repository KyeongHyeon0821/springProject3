<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 상세보기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
  	'use strict';
  	
  	function deleteCheck(idx){
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "qnaDelete?idx=${vo.idx}";
  	}
  	
    // 답변글 달기 폼...
    function answerCheck() {
    	let tempStr = '<br/>';
    	tempStr += '<h3 class="text-center">답 변 글 달 기</h3>';
    	tempStr += '<div class="container d-flex justify-content-center">';
    	tempStr += '	<div style="width: 80%;">';
    	tempStr += '		<table class="table table-bordered">';
    	tempStr += '<tr>';
  		tempStr += '  <th class="bg-light" style="width:15%;">작성자</th>';
			tempStr += '  <td style="width:35%;"><input type="text" name="nickName" value="${sNickName}" disabled class="form-control"/></td>';
			tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '  <th class="bg-light">답변글제목</th>';
    	/* tempStr += '  <td><input type="text" name="title" value="(Re) 13134" size="60" required class="form-control"/></td>'; */
    	tempStr += '  <td colspan="3" class="text-start" style="white-space:pre-line">(Re) ${vo.title}</td>';
    	tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '<th class="bg-light">이메일</th>';
    	tempStr += '  <td colspan="3" class="text-start" style="white-space:pre-line"><input type="text" name="email" value="${vo.email}" size="60" class="form-control" required/></td>';
    	tempStr += '  </tr>';
    	tempStr += '<tr>';
    	tempStr += '  <th class="bg-light">글내용</th>';
    	tempStr += '  <td colspan="3" class="text-start" style="white-space:pre-line"><textarea rows="6" name="content" required class="form-control"></textarea></td>';
    	tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '  <td colspan="2" style="text-align:center">';
    	tempStr += '    <input type="button" value="답글올리기" onclick="fCheck()" class="btn btn-primary"/> &nbsp;';
    	tempStr += '    <input type="button" value="취소" onclick="location.reload();" class="btn btn-secondary"/> &nbsp;';
    	tempStr += '  </td>';
    	tempStr += '</tr>';
    	tempStr += '		</table>';
    	tempStr += '	</div>';
    	tempStr += '</div>';
    	tempStr += '<input type="hidden" name="qnaSw" value="a"/>';
    	tempStr += '<input type="hidden" name="qnaIdx" value="${vo.qnaIdx}"/>';
    	tempStr += '<input type="hidden" name="title" value="(Re) ${vo.title}"/>';
    	tempStr += '<input type="hidden" name="openSw" value="${vo.openSw}"/>';
			$("#reply").html(tempStr);
    }
    
    function fCheck() {
    	var title = myform.title.value;
    	var content = myform.content.value;
    	
    	if(title=="") {
    		alert("글제목을 입력하세요");
    		myform.title.focus();
    		return false;
    	}
    	else if(content=="") {
    		alert("글내용을 입력하세요");
    		myform.content.focus();
    		return false;
    	}
    	else myform.submit();
    }
    
    function delCheck() {
    	let ans = confirm("현재 글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	location.href = "/springProject3/qna/qnaDelete?idx="+${vo.idx};
    }
    
    function qnaIdxDeleteCheck() {
    	let ans = confirm("QnA 답변글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	location.href="/springProject3/qna/qnaDelete?idx="+${vo.idx};
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">QnA 상세보기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 80%;">
    <table class="table table-bordered">
		  <tr>
		    <th class="bg-light" style="width:15%;">작성자</th>
		    <td style="width:35%;">${vo.nickName}</td>
		    <th class="bg-light" style="width:15%;">작성일시</th>
		    <td style="width:35%;"><c:out value="${vo.WDate.substring(0,16)}" /></td>
		  </tr>
      <tr>
        <th class="bg-light">이메일</th>
        <td colspan="3" class="text-start" style="white-space:pre-line">${vo.email}</td>
      </tr>
		  <tr>
		    <th class="bg-light">제목</th>
		    <td colspan="3" class="text-start" style="white-space:pre-line">${vo.title}</td>
		  </tr>
		  <tr>
		    <th class="bg-light">문의내용</th>
		    <td colspan="3" class="text-start" style="white-space:pre-line;height:150px;">${vo.content}</td>
		  </tr>
		  <tr>
		    <th class="bg-light">공개여부</th>
		    <td colspan="3" class="text-start" style="white-space:pre-line">${vo.openSw == 'OK' ? '공개' : '비공개'}</td>
		  </tr>
    </table>
    <div colspan="2" class="text-center">
        <c:if test="${vo.qnaAnswer == '답변대기'}">
       	 	<input type="button" value="답변등록" onclick="answerCheck()" class="btn btn-outline-success"/> &nbsp;
        </c:if>
        <input type="button" value="목록으로" onclick="location.href='${ctp}/qna/qnaList';" class="btn btn-info me-2"/>
      <c:if test="${sMid eq vo.mid}">
      	<c:if test="${vo.qnaAnswer == '답변대기' || sLevel == 0}">
      	  <c:if test="${sLevel != 0}">
        		<input type="button" value="수정하기" onclick="location.href='${ctp}/qna/qnaUpdate?idx=${vo.idx}';" class="btn btn-warning me-2"/>
        	</c:if>
        	<input type="button" value="삭제하기" onclick="deleteCheck(${vo.idx})" class="btn btn-danger"/>
        </c:if>
      </c:if>
      <%-- 
      <c:if test="${(sMid eq vo.mid) || (sLevel == 0)}">
      	<input type="button" value="삭제하기" onclick="deleteCheck(${vo.idx})" class="btn btn-danger"/>
      </c:if>
       --%>
      <c:if test="${(vo.qnaSw == 'a') && (sMid eq vo.mid)}">
      	<input type="button" value="삭제하기" onclick="qnaIdxDeleteCheck(${vo.idx})" class="btn btn-danger"/>
      </c:if>
    </div>
  <form name="myform" method="post" action="qnaInput">
  	<div id="reply"></div>
  		<input type="hidden" name="pag" value="1"/>
  		<input type="hidden" name="pageSize" value=""/>
  		<input type="hidden" name="idx" value="${vo.idx}"/>
  		<input type="hidden" name="mid" value="${sMid}"/>
  		<input type="hidden" name="level" value="${sLevel}"/>
  		<input type="hidden" name="nickName" value="${sNickName}"/>
  </form>
  </div>
</div>

<p><br/></p>
</body>
</html>
