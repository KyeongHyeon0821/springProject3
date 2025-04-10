<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<script>
		'use strict';
		
		// 호텔 등록 처리
		function fCheck() {
			
			// 유효성 체크
			let name = $("#name").val();
			let address = $("#address").val();
			let tel = $("#tel").val();
			let description = $("#description").val();
			let thumbnailFile = $("#thumbnailFile").val(); // 썸네일 파일 이름
			let images = $("#CKEDITOR").val();
			
			if(thumbnailFile.trim() == "") {
				alert("업로드할 파일을 선택하세요");
				return false;
			}
			
			// 파일 등록 처리
			let ext = thumbnailFile.substring(thumbnailFile.lastIndexOf(".")+1).toLowerCase();
			let maxSize = 1024 * 1024 * 20; // 한번에 업로드할 파일의 최대용랑을 20mb로 한정
			
			let fileSize = document.getElementById("thumbnailFile").files[0].size;
			if(fileSize > maxSize) alert("업로드할 파일의 최대용량은 20mb 입니다.");
			else if(ext !="jpg" && ext !="gif" && ext !="png" && ext !="jpeg" && ext !="webp") {
				alert("업로드 가능 파일은 'jpg/gif/png/jpeg/webp' 입니다.");
				
			}
			else return true;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>호 텔 등 록</h2>
	<hr class="border-secondary">
	<form name="myform" method="post" onsubmit="return fCheck();" enctype="multipart/form-data">
    <table class="table table-bordered">
      <tr>
        <th>호텔 이름</th>
        <td><input type="text" name="name" id="name" placeholder="호텔 이름" required autofocus class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 주소</th>
        <td><input type="text" name="address" id="address" placeholder="호텔 주소" required class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 연락처</th>
        <td><input type="tel" name="tel" id="tel" placeholder="호텔 연락처" class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 소개</th>
        <td><textarea rows="6" name="description" id="description" class="form-control" placeholder="호텔 소개"></textarea></td>
      </tr>
      <tr>
        <th>대표 사진(썸네일)</th>
        <td><input type="file" name="thumbnailFile" id="thumbnailFile" required class="form-control" /></td>
      </tr>
      <tr>
        <th>사진 등록</th>
        <td><textarea rows="6" name="images" id="CKEDITOR" class="form-control" placeholder="사진 업로드"></textarea>
          <script>
            CKEDITOR.replace("images",{
            	height:450,
            	filebrowserUploadUrl:"hotelImageUpload?mid=admin",
            	uploadUrl:"hotelImageUpload?mid=admin" 
            });
          </script>
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="호텔등록" class="btn btn-success me-2"/>
          <input type="reset" value="다시입력" class="btn btn-warning me-2"/>
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/';" class="btn btn-info"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="admin"/>
  </form>
</div>
</body>
</html>