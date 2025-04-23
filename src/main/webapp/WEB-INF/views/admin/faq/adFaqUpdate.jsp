<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 수정하기</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
  	'use strict';
  	
  	function fCheck() {
  	  let title = myform.title.value;
  	  let category = $("#category").val();
  	  if (privacyRegit(privacy_editor)) return false;

  	  if (title.trim() == "") {
  	    alert("제목을 입력해주세요.");
  	    myform.title.focus();
  	    return false;
  	  }
  	  if (category == "선택해주세요.") {
  	    alert("분류를 선택해주세요.");
  	    return false;
  	  }

  	  myform.submit();
  	}

    function privacyRegit(privacy_editor){ 
			if (privacy_editor.getData().trim() == ''){ 
				alert("내용을 입력해주세요."); 
				return true; 
			} 
		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">FAQ 수정하기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 80%;">
    <form name="myform" method="post">
      <input type="hidden" name="idx" value="${vo.idx}" />
      <table class="table table-bordered">
        <tr>
          <th class="bg-light">분류</th>
          <td>
            <select name="category" id="category" class="form-select">
              <option ${vo.category == '선택해주세요.' ? 'selected' : ''}>선택해주세요.</option>
              <option ${vo.category == '예약' ? 'selected' : ''}>예약</option>
              <option ${vo.category == '결제/환불' ? 'selected' : ''}>결제/환불</option>
              <option ${vo.category == '회원정보' ? 'selected' : ''}>회원정보</option>
              <option ${vo.category == '기타' ? 'selected' : ''}>기타</option>
            </select>
          </td>
        </tr>
        <tr>
          <th class="bg-light">제목</th>
          <td><input type="text" name="title" value="${vo.title}" required class="form-control"/></td>
        </tr>
        <tr>
          <th class="bg-light">내용</th>
          <td>
            <textarea name="content" id="CKEDITOR" rows="6" class="form-control">${vo.content}</textarea>
            <script>
	           var privacy_editor = CKEDITOR.replace("content", {
	            	height:460,
	            	filebrowserUploadUrl:"${ctp}/imageUpload",
	            	uploadUrl : "${ctp}/imageUpload"
	            });
            </script>
          </td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="button" value="수정하기" onclick="fCheck()" class="btn btn-success me-2"/>
            <input type="reset" value="다시쓰기" class="btn btn-warning me-2"/>
            <input type="button" value="돌아가기" onclick="location.href='${ctp}/faq/adFaqList';" class="btn btn-info"/>
          </td>
        </tr>
      </table>
    </form>
  </div>
</div>

<p><br/></p>
</body>
</html>
