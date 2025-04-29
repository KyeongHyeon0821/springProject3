<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 상세보기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    body {
      background-color: #f9fefb;
      font-family: 'Arial', sans-serif;
      font-size: 1.1rem;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 40px 20px;
    }

    .my-page-header {
      text-align: center;
      font-weight: bold;
      font-size: 2rem;
      margin-bottom: 30px;
      color: #2e7d32;
    }

    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 60px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e0e0e0;
      margin-top: 30px;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
    }

    table th {
      background-color: #e0f5e9 !important;
      color: #444 !important;
      padding: 14px 12px;
      text-align: center;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
      width: 150px;
    }

    table td {
      background-color: #fff;
      padding: 20px 20px;
      vertical-align: middle;
      border-bottom: 1px solid #e5e5e5;
    }

    table tr:last-child td {
      border-bottom: none !important;
    }
    
    .btn {
      font-size: 1rem;
    }
  </style>
  <script>
    'use strict';

    function deleteCheck(idx) {
      let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
      if (ans) location.href = "photogalleryDelete?idx=${vo.idx}";
    }
    
    // 좋아요
    function goodCheck() {
    	$.ajax({
    		url  : "${ctp}/photogallery/photogalleryGoodCheck",
    		type : "post",
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res != "0") location.reload();
    			else alert("이미 좋아요를 눌러주셨습니다.");
    		},
    		error : function() { alert("전송오류!"); }
    	});
    }

  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <div class="col m-3 text-center">
    <img src="${ctp}/images/logo.png" width="100px"/>
	  <span class="my-page-header">포토갤러리 상세보기</span>
	</div>
  <div class="section-box">
  	<div class="text-end">
  		<a href="javascript:goodCheck()" title="좋아요" style="text-decoration: none;"><font size="5">👍 (${vo.good})</font></a>
  	</div>
    <table class="table">
      <tr>
        <th>작성자</th>
        <td style="border-top: 1px solid #e5e5e5;">${vo.nickName}</td>
        <th>작성일시</th>
        <td style="border-top: 1px solid #e5e5e5;"><c:out value="${vo.WDate.substring(0,16)}" /></td>
      </tr>
      <tr>
        <th>제목</th>
        <td colspan="3">${vo.title}</td>
      </tr>
      <tr style="border-bottom: 1px solid #e5e5e5">
        <th>내용</th>
        <td colspan="3">
        	<div style="min-height:300px; height:auto; ">${fn:replace(vo.content, newLine, "<br/>")}</div>
        </td>
      </tr>
    </table>
    <div class="text-center mt-4">
      <input type="button" value="목록으로" onclick="location.href='${ctp}/photogallery/photogalleryList';" class="btn btn-outline-secondary me-2"/>
          <c:if test="${sMid eq vo.mid || sLevel == 0}">
          <input type="button" value="삭제하기" onclick="deleteCheck(${vo.idx})" class="btn btn-outline-danger"/>
        </c:if>
    </div>
      <input type="hidden" name="pag" value="1"/>
      <input type="hidden" name="pageSize" value=""/>
      <input type="hidden" name="idx" value="${vo.idx}"/>
      <input type="hidden" name="mid" value="${sMid}"/>
      <input type="hidden" name="level" value="${sLevel}"/>
      <input type="hidden" name="nickName" value="${sNickName}"/>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
