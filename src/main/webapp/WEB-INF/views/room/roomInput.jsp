<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>roomInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script>
		'use strict';
		
		// 객실 등록 처리
		function fCheck() {
			// 유효성 체크
			let name = $("#name").val().trim();
			let price = $("#price").val().trim();
			let petSizeLimit = $("#petSizeLimit").val().trim();
			let thumbnailFile = $("#thumbnailFile").val(); // 썸네일 파일 이름
			
			if(name == "") {
				alert("객실 이름을 입력해주세요.");
				$("#name").focus();
				return false;
			}
			else if (name.length > 50) {
	      alert("객실 이름은 50자 이내로 입력해주세요.");
	      $("#name").focus();
	      return false;
	    }
			
			if(price == "") {
				alert("객실 요금을 입력해주세요.");
				$("#price").focus();
				return false;
			}
			
			if(petSizeLimit == "") {
				alert("반려견 크기 제한을 선택해주세요.");
				$("#petSizeLimit").focus();
				return false;
			}
			
			if(thumbnailFile == "") {
				alert("업로드할 썸네일 파일을 선택하세요");
				$("#thumbnailFile").focus();
				return false;
			}
			
			// 썸네일 파일 용량 체크, 확장자 체크
			let ext = thumbnailFile.substring(thumbnailFile.lastIndexOf(".")+1).toLowerCase();
			let maxSize = 1024 * 1024 * 20; // 한번에 업로드할 파일의 최대용랑을 20mb로 한정
			let fileSize = document.getElementById("thumbnailFile").files[0].size;
			
			if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 20mb 입니다.");
				$("#thumbnailFile").focus();
				return false;
			}
			
			if(ext !="jpg" && ext !="gif" && ext !="png" && ext !="jpeg" && ext !="webp") {
				alert("업로드 가능 파일은 'jpg/gif/png/jpeg/webp' 입니다.");
				$("#thumbnailFile").focus();
				return false;
			}
			
			// 썸네일 외 이미지 파일 확장자 체크, 파일 누적 크기 체크
			let imageFiles = document.getElementById("imageFiles").value; // 이미지 이름
			let imageFilesLength = document.getElementById("imageFiles").files.length; // 이미지 파일 갯수
			// 썸네일 외 이미지 파일을 업로드 했을 경우에만 체크
			if(imageFilesLength > 0) {
				// 각 파일 확장자 체크, 파일 누적 크기 체크
				for(let i=0; i<imageFilesLength; i++) {
					let imageFileName = document.getElementById("imageFiles").files[i].name;
					ext = imageFileName.substring(imageFileName.lastIndexOf(".")+1).toLowerCase();
					fileSize += document.getElementById("imageFiles").files[i].size;
					
					if(ext !="jpg" && ext !="gif" && ext !="png" && ext !="jpeg" && ext !="webp") {
						alert("업로드 가능 파일은 'jpg/gif/png/jpeg/webp' 입니다.");
						return false;
					}
					
					if(fileSize > maxSize) {
						alert("업로드할 파일의 최대용량은 20mb 입니다.");
						return false;
					}
			}
			return true;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h3 class="mb-4">객실 등록</h3>
	<form name="roomForm" method="post" onsubmit="return fCheck();" enctype="multipart/form-data">
		<input type="hidden" name="hotelIdx" value="${hotelIdx}" />
		
		<div class="mb-3">
			<label for="name" class="form-label">객실명</label>
			<input type="text" name="name" id="name" class="form-control" required />
		</div>

		<div class="mb-3">
			<label for="price" class="form-label">1박 요금</label>
			<input type="number" name="price" id="price" class="form-control" required />
		</div>

		<div class="mb-3">
			<label for="maxPeople" class="form-label">최대 인원 수</label>
			<select name="maxPeople" id="maxPeople" class="form-select" required>
				<option value="1">1</option>
				<option value="2" selected>2</option>
  			<option value="3">3</option>
 				<option value="4">4</option>
 				<option value="5">5</option>
			</select>
		</div>

		<div class="mb-3">
			<label for="petSizeLimit" class="form-label" >반려견 크기 제한</label>
			<select name="petSizeLimit" id="petSizeLimit" class="form-select" required>
				<option value="">선택 안 함</option>
				<option value="소형">소형견만 가능</option>
  			<option value="중형">중형견까지 가능</option>
 				<option value="대형">대형견까지 가능 (모두 가능)</option>
			</select>
		</div>

		<div class="mb-3">
			<label for="petCountLimit" class="form-label">최대 반려견 수</label>
			<select name="petCountLimit" id="petCountLimit" class="form-select" required>
				<option value="1">1</option>
				<option value="2">2</option>
  			<option value="3">3</option>
 				<option value="4">4</option>
 				<option value="5">5</option>
			</select>
		</div>

		<div class="mb-3">
			<label for="thumbnail" class="form-label">썸네일 이미지</label>
			<input type="file" name="thumbnailFile" id="thumbnailFile" class="form-control" accept=".jpg,.gif,.png,.jpeg,.webp" required />
		</div>

		<div class="mb-3">
			<label for="images" class="form-label">객실 이미지 (여러 장 가능)</label>
			<input type="file" name="imageFiles" id="imageFiles" class="form-control" accept=".jpg,.gif,.png,.jpeg,.webp" multiple />
		</div>

		<div class="mb-3 text-center">
			<input type="submit" value="등록하기" class="btn btn-primary">
			<a href="${ctp}/hotel/hotelDetail?idx=${hotelIdx}" class="btn btn-secondary">돌아가기</a>
		</div>
	</form>
	
</div>
</body>
</html>