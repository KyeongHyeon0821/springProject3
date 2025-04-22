<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 수정하기</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
  	'use strict';
  	
  	function fCheck() {
  		let title = myform.title.value;
  		
  		if(privacyRegit(privacy_editor)) return false;
  		else if(title == "") {
  			alert("제목을 입력해주세요.");
  			myform.title.focus();
  			return false;
  		}
  		else myform.submit();
  	}
  	
    // ckeditor null값체크하도록 처리하기 함수
    function privacyRegit(privacy_editor){ 
			if(privacy_editor.getData().trim() == ''){ 
				alert("내용을 입력해주세요."); 
				return true; 
			} 
		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">QnA 수정하기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 80%;">
    <form name="myform" method="post">
      <table class="table table-bordered">
        <tr>
          <th class="bg-light">작성자</th>
          <td><input type="text" name="nickName" value="${vo.nickName}" readonly class="form-control"/></td>
        </tr>
        <tr>
          <th class="bg-light">제목</th>
          <td><input type="text" name="title" value="${vo.title}" required class="form-control"/></td>
        </tr>
        <tr>
          <th class="bg-light">이메일</th>
          <td><input type="text" name="email" value="dnjsrkdus0403@naver.com" required class="form-control"/></td>
        </tr>
        <tr>
          <th class="bg-light">내용</th>
          <td><textarea name="content" id="CKEDITOR" rows="6" placeholder="내용을 입력하세요." required class="form-control">${vo.content}</textarea>
           <script>
	           var privacy_editor = CKEDITOR.replace("content",{
	            	height:460,
	            	filebrowserUploadUrl:"${ctp}/imageUpload",
	            	uploadUrl : "${ctp}/imageUpload"
	            });
	          </script>
          </td>
        </tr>
        <tr>
          <th class="bg-light">비밀글</th>
          <td>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" name="openSw" id="openSwCheck" ${vo.openSw == 'NO' ? 'checked' : ''}>
              <label class="form-check-label" for="openSwCheck">비밀글</label>
            </div>
            <div class="form-text text-muted">선택 시, 비밀글로 등록됩니다.</div>
          </td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="button" value="수정하기" onclick="fCheck()" class="btn btn-success me-2"/>
            <input type="reset" value="다시쓰기" class="btn btn-warning me-2"/>
            <input type="button" value="돌아가기" onclick="location.href='${ctp}/qna/qnaList';" class="btn btn-info"/>
          </td>
        </tr>
      </table>
      <input type="hidden" name="qnaSw" value="${qnaSw}"/>
      <input type="hidden" name="mid" value="${sMid}"/>
      <input type="hidden" name="ansLevel" value="${sLevel}"/>
      <input type="hidden" name="idx" value="${idx}"/>
    </form>
  </div>
</div>

<p><br/></p>
</body>
</html>
