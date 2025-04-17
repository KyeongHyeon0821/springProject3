<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelUpdate.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<link rel="stylesheet" href="${ctp}/css/kakaoMap.css" />
	<script>
		'use strict';
		
		// 호텔 정보 수정 처리
		function fCheck() {
			
			// 유효성 체크
			let name = $("#name").val().trim();
			let address = $("#address").val().trim();
			let tel = $("#tel").val().trim();
			let thumbnailFile = $("#thumbnailFile").val();
			let regTel = /^\d{2,4}-\d{3,4}-\d{4}$/; // 연락처 정규식 (2~4)-(3~4)-(4)
			
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
			
			// 썸네일 파일 변경시 파일 용량 체크, 확장자 체크
			let file = document.getElementById("thumbnailFile").files[0];
			
			if(file) {
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
			}
			
			// 모든 조건 통과 시
			return true;
		}
		
		
		// 썸네일 이미지 미리보기
		function thumbnailCheck(e) {
	    if(e.files && e.files[0]) {
	      let reader = new FileReader();
	      reader.onload = function(e) {
	        document.getElementById("thumbnailPreview").src = e.target.result;
	      }
	      reader.readAsDataURL(e.files[0]);
	    }
	    $("#beforeThumbnailPreview").hide();
	  }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>🏨 호텔 정보 수정</h2>
	<hr class="border-secondary">
	
	<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div id="menu_wrap" class="bg_white">
      <div class="option">
        <div>
          <form onsubmit="searchPlaces(); return false;">
            키워드 : <input type="text" value="${vo.address}" id="keyword" size="15"> 
            <button type="submit">검색하기</button> 
          </form>
        </div>
      </div>
      <hr>
      <ul id="placesList"></ul>
      <div id="pagination"></div>
    </div>
	</div>

	<form name="hotelForm" method="post" onsubmit="return fCheck();" enctype="multipart/form-data">
		<input type="hidden" name="idx" value="${vo.idx}" />
		<input type="hidden" name="oThumbnail" value="${vo.thumbnail}" />
    <table class="table table-bordered">
      <tr>
        <th>호텔 이름</th>
        <td><input type="text" name="name" id="name" value="${vo.name}" required autofocus class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 주소</th>
        <td><input type="text" name="address" id="address" value="${vo.address}" required class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 연락처</th>
        <td><input type="tel" name="tel" id="tel" value="${vo.tel}" class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 소개</th>
        <td><textarea rows="6" name="description" id="description" class="form-control">${vo.description}</textarea></td>
      </tr>
      <tr>
        <th>대표 사진(썸네일)</th>
        <td><input type="file" name="thumbnailFile" id="thumbnailFile" class="form-control" onchange="thumbnailCheck(this)" accept=".jpg,.gif,.png,.jpeg,.webp"/></td>
      </tr>
      <tr>
      	<th>썸네일 미리보기</th>
      	<td>
      		<img id="beforeThumbnailPreview" src="${ctp}/hotelThumbnail/${vo.thumbnail}" width="150px" />
      		<img id="thumbnailPreview" width="150px">
      	</td>
      </tr>
      <tr>
        <th>사진 등록</th>
        <td>
        	<div class="text-muted" style="margin-bottom:5px;">
			      ※ 사진만 등록 가능합니다. 여러 장의 이미지는 마우스로 드래그하여 추가할 수 있습니다.
			    </div>
        	<textarea rows="6" name="images" id="CKEDITOR" class="form-control">${vo.images}</textarea>
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
          <input type="submit" value="호텔정보수정" class="btn btn-success me-2"/>
          <input type="button" onclick="location.reload()" value="다시입력" class="btn btn-warning me-2"/>
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/hotel/hotelDetail?idx=${vo.idx}';" class="btn btn-info"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="admin"/>
  </form>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f5f016ee8ec4b87750154cd5e9d07dfb&libraries=services"></script>
<script type="text/javascript" src="${ctp}/js/kakaoMap.js"></script>
</body>
</html>