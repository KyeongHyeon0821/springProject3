<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 수정</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
  	'use strict';
  	
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
    
    // 미리보기 그림 삭제
    function removeImage() {
			let ans = confirm("이미지를 삭제하시겠습니까?");
			if(!ans) return false;
			
      const img = document.getElementById("photoDemo");
      const btn = document.getElementById("removeBtn");

      img.src = "";
      img.style.display = "none";
      btn.style.display = "none";

      document.querySelector('input[type="file"]').value = "";
    }
    
    function imageDelete(idx,fSName) {
    	let ans = confirm("해당 이미지를 삭제하시겠습니까?\n삭제를 선택하시면 현재 이미지는 영구히 삭제됩니다.");
			if(!ans) return false;
			
    	$.ajax({
    		url  : "imageDelete",
    		type : "post",
    		data : {
    			idx    : idx,
    			fSName : fSName
    		},
    		success:function(res) {
    			if(res != "0") {
    				alert('그림파일이 삭제되었습니다.');
    				location.reload();
    			}
    			else alert('파일 삭제 실패');
    		},
    		error : function() { alert('전송오류!'); }
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">1:1 문의 수정하기</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 80%;">
    <form name="myform" method="post" enctype="multipart/form-data">
      <table class="table table-bordered">
        <tr>
          <th class="bg-light">제목</th>
          <td><input type="text" name="title" value="${vo.title}" required class="form-control" /></td>
        </tr>
        <tr>
          <th class="bg-light">예약번호</th>
          <td><input type="text" name="reservation" value="${vo.reservation}" class="form-control" /></td>
        </tr>
        <tr>
          <th class="bg-light">분류</th>
          <td>
            <select name="part" class="form-select">
              <option ${vo.part == '예약' ? 'selected' : ''}>예약</option>
              <option ${vo.part == '결제/환불' ? 'selected' : ''}>결제/환불</option>
              <option ${vo.part == '회원정보' ? 'selected' : ''}>회원정보</option>
              <option ${vo.part == '기타' ? 'selected' : ''}>기타</option>
            </select>
          </td>
        </tr>
        <tr>
          <th class="bg-light">내용</th>
          <td><textarea name="content" rows="6" class="form-control" required>${vo.content}</textarea></td>
        </tr>
				<tr>
				  <th class="bg-light">첨부파일</th>
				  <td>
						<c:if test="${empty vo.FSName}">
						  <div>
						    <img id="photoDemo" width="150px"/>
						    <button type="button" onclick="removeImage()" style="display:none;border:0px" id="removeBtn" class="badge bg-danger">이미지 삭제</button>
						    <!-- <input type="button" value="이미지 삭제" onclick="removeImage()" style="display:none;border:0px" id="removeBtn" class="badge bg-danger" /> -->
						  </div>
						</c:if>
						<c:if test="${not empty vo.FSName}">
						  <div style="display: flex; align-items: flex-end; gap: 10px;">
						    <div style="border: 1px solid #ccc; padding: 8px; border-radius: 6px;">
						      <img src="${ctp}/inquiry/${vo.FSName}" width="200px" style="border-radius: 4px;" />
						    </div>
						    <button type="button" id="fileDeleteBtn" onclick="imageDelete('${vo.idx}','${vo.FSName}')" class="btn btn-outline-danger btn-sm">삭제</button>
						  </div>
						</c:if>
				    <input type="file" name="mFile" id="fSName" onchange="imgCheck(this)" class="form-control mt-3 mb-3" />
				    <div class="form-text text-muted">새 파일을 등록하면 기존 파일이 대체됩니다.</div>
				    <!-- <div class="imgs_wrap form-text text-muted"><img id="photoDemo" width="100px"/></div> -->
				  </td>
				</tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="submit" value="수정하기" class="btn btn-success me-2" />
            <input type="reset" value="다시입력" class="btn btn-warning me-2" />
            <input type="button" value="돌아가기" onclick="location.href='${ctp}/inquiry/inquiryList';" class="btn btn-info" />
          </td>
        </tr>
      </table>
      <input type="hidden" name="idx" value="${vo.idx}" />
      <input type="hidden" name="fSName" value="${vo.FSName}" />
    </form>
  </div>
</div>

<p><br/></p>
</body>
</html>
