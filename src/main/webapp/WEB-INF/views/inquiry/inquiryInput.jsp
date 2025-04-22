<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1문의 작성하기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';

    function fCheck() {
      let maxSize = 1024 * 1024 * 20; // 20MB
      let fName = document.getElementById("fSName").value;
      let ext = "";
      let fileSize = 0;
      let title = $("#title").val();
      let part = $("#part").val();
      let content = $("#content").val();
      
       if(title == "") {
    	  alert("제목을 입력해주세요.");
    	  return false;
      }
      
      if(part == "선택해주세요.") {
    	  alert("문의 분류를 선택해주세요.");
    	  return false;
      }
      
      if(content == "") {
    	  alert("내용을 입력해주세요.");
    	  return false;
      } 

      if (fName.trim() != "") {
	      let fileLength = document.getElementById("fSName").files.length;
	
	      for (let i = 0; i < fileLength; i++) {
	        fName = document.getElementById("fSName").files[i].name;
	        ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
	        fileSize += document.getElementById("fSName").files[i].size;
	        if (ext != "jpg" && ext != "gif" && ext != "png" && ext != "zip" && ext != "ppt" && ext != "pptx" && ext != "hwp" && ext != "webp") {
	          alert("업로드 가능파일은 'jpg/gif/png/zip/ppt/pptx/hwp' 입니다.");
	          return false;
	        }
	      }
	
	      if (fileSize > maxSize) {
	        alert("업로드할 파일의 최대용량은 20MByte입니다.");
	        return false;
	      } else {
	        myform.submit();
	      }
      }
      else {
    	  myform.submit();
      }
      
    }
    
    // 업로드 시킬 사진 미리보기
    function imgCheck(e) {
    	if(e.files && e.files[0]) {
    		let reader = new FileReader();
    		reader.onload = function(e) {
          const img = document.getElementById("photoDemo");
          const btn = document.getElementById("removeBtn");

          img.src = e.target.result;
          img.style.display = "block";
          btn.style.display = "inline-block";
    		}
    		reader.readAsDataURL(e.files[0]);
    	}
    }
    
    function removeImage() {
			let ans = confirm("이미지를 삭제하시겠습니까?");
 			if(!ans) return false;
 			
      const img = document.getElementById("photoDemo");
      const btn = document.getElementById("removeBtn");

      img.src = "";
      img.style.display = "none";
      btn.style.display = "none";

      // 파일 input 초기화
      document.querySelector('input[type="file"]').value = "";
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">1:1 문의 작성하기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 80%;">
    <form name="myform" method="post" enctype="multipart/form-data">
      <table class="table table-bordered">
        <tr>
          <th class="bg-light">제목</th>
          <td><input type="text" name="title" id="title" placeholder="제목을 입력하세요." autofocus required class="form-control"/></td>
        </tr>
        <tr>
          <th class="bg-light">예약번호</th>
          <td><input type="text" name="reservation" id="reservation" placeholder="예약번호를 알고계시면 입력하세요." class="form-control"/></td>
        </tr>
        <tr>
          <th class="bg-light">분류</th>
          <td>
            <select name="part" id="part" onchange="partCheck()" class="form-select">
              <option selected>선택해주세요.</option>
              <option>예약</option>
              <option>결제/환불</option>
              <option>회원정보</option>
              <option>기타</option>
            </select>
          </td>
        </tr>
        <tr>
          <th class="bg-light">내용</th>
          <td><textarea rows="6" name="content" id="content" class="form-control" placeholder="내용을 입력하세요." required></textarea></td>
        </tr>
        <tr>
          <th class="bg-light">첨부파일</th>
          <td>
            <input type="file" name="mFile" id="fSName" onchange="imgCheck(this)" class="form-control mb-3"/>
            <div class="form-text text-muted">- 업로드 가능파일은 'jpg/gif/png/zip/ppt/pptx/hwp/webp' 입니다.</div>
            <!-- <div class="imgs_wrap form-text text-muted"><img id="photoDemo" width="120px"/></div> -->
					  <div>
					    <img id="photoDemo" width="200px"/>
					    <button type="button" onclick="removeImage()" style="display:none;border:0px" id="removeBtn" class="badge bg-danger">이미지 삭제</button>
					  </div>
          </td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="button" value="글올리기" onclick="fCheck()" class="btn btn-success me-2"/>
            <input type="reset" value="다시입력" class="btn btn-warning me-2"/>
            <input type="button" value="돌아가기" onclick="location.href='${ctp}/inquiry/inquiryList';" class="btn btn-info"/>
          </td>
        </tr>
      </table>
      <input type="hidden" name="mid" value="${sMid}"/>
    </form>
  </div>
</div>

<p><br/></p>
</body>
</html>
