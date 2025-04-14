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
			let name = $("#name").val().trim();
			let address = $("#address").val().trim();
			let tel = $("#tel").val().trim();
			let thumbnailFile = $("#thumbnailFile").val(); // 썸네일 파일 이름
			let regTel = /^\d{3,4}-\d{3,4}-\d{4}$/; // 연락처 정규식 (3~4)-(3~4)-(4)
			
			if(name == "") {
				alert("호텔 이름을 입력해주세요.");
				return false;
			}
			else if (name.length > 100) {
	      alert("호텔 이름은 100자 이내로 입력해주세요.");
	      $("#name").focus();
	      return false;
	    }
			
			if (address == "") {
	      alert("호텔 주소를 입력해주세요.");
	      $("#address").focus();
	      return false;
	    } 
			else if (address.length > 200) {
	      alert("호텔 주소는 200자 이내로 입력해주세요.");
	      $("#address").focus();
	      return false;
	    }
			
			if(thumbnailFile == "") {
				alert("업로드할 파일을 선택하세요");
				$("#thumbnailFile").focus();
				return false;
			}
			
			if(tel != "" && !regTel.test(tel)) {
				alert("전화번호 형식이 올바르지 않습니다.\n예: 02-123-4567, 010-1234-5678, 0505-123-4567");
			  $("#tel").focus();
			  return false;
			}
			else if (tel.length > 20) {
	      alert("호텔 연락처는 20자 이내로 입력해주세요.");
	      $("#tel").focus();
	      return false;
	    }
			
			// 파일 등록 처리
			let ext = thumbnailFile.substring(thumbnailFile.lastIndexOf(".")+1).toLowerCase();
			let maxSize = 1024 * 1024 * 20; // 한번에 업로드할 파일의 최대용랑을 20mb로 한정
			
			let fileSize = document.getElementById("thumbnailFile").files[0].size;
			if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 20mb 입니다.");
				$("#thumbnailFile").focus();
				return false;
			}
			else if(ext !="jpg" && ext !="gif" && ext !="png" && ext !="jpeg" && ext !="webp") {
				alert("업로드 가능 파일은 'jpg/gif/png/jpeg/webp' 입니다.");
				$("#thumbnailFile").focus();
				return false;
			}
			
			// 모든 조건 통과시
			return true;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>호 텔 등 록</h2>
	<hr class="border-secondary">
	<form name="hotelForm" method="post" onsubmit="return fCheck();" enctype="multipart/form-data">
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
        <td><input type="file" name="thumbnailFile" id="thumbnailFile" required class="form-control" accept=".jpg,.gif,.png,.jpeg,.webp"/></td>
      </tr>
      <tr>
        <th>사진 등록</th>
        <td>
        	<div class="text-muted" style="margin-bottom:5px;">
			      ※ 사진만 등록 가능합니다. 여러 장의 이미지는 마우스로 드래그하여 추가할 수 있습니다.
			    </div>
        	<textarea rows="6" name="images" id="CKEDITOR" class="form-control"></textarea>
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