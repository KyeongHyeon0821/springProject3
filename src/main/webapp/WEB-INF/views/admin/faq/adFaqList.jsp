<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 관리자</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script>
		'use strict';
		
		function pageSizeCheck() {
			let pageSize = document.getElementById("pageSize").value;
			location.href = "adFaqList?pag=1&pageSize="+pageSize;
		}
		
		function categoryCheck(){
			let category = $('#category').val();
			if(category != '') location.href = 'adFaqList?category='+category;
		}
		
		function searchCheck() {
			let category = $('#category').val();
			let searchString = $('#searchString').val();
			if(searchString == '') {
				alert("검색어를 입력하세요");
				return false();
			}
			else location.href = 'adFaqList?searchString='+searchString+'&category='+category;
		}
	
    // 전체선택
    function allCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = true;
      }
      $("#allCheckBtn").hide();
      $("#allResetBtn").show();
    }

    // 전체취소
    function allReset() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = false;
      }
      $("#allCheckBtn").show();
      $("#allResetBtn").hide();
    }
    
    // 여러개 선택항목 삭제처리
    function delCheck() {
    	let idxSelect = '';
    	
      for(let i=0; i<myform.idxFlag.length; i++) {
        if(myform.idxFlag[i].checked) idxSelect += myform.idxFlag[i].value + "/";
      }
    	if(idxSelect.indexOf("/") == -1) {
    		alert("1개이상 선택되어야 삭제가 가능합니다.");
    		return false;
    	}
    	else {
    		let ans = confirm("선택하신 FAQ를 삭제하시겠습니까?");
    		if(!ans) return false;
    	}
    	idxSelect = idxSelect.substring(0,idxSelect.lastIndexOf("/"));
      
      let query = {
    		  idxSelect : idxSelect
      }
      
      $.ajax({
    	  url  : "${ctp}/faq/adFaqDelete",
    	  type : "post",
    	  data : query,
    	  success:function(res) {
    		  if(res != "0") alert("선택하신 FAQ가 삭제되었습니다.");
    		  else alert("FAQ 삭제 실패");
  			  location.reload();
    	  },
    	  error : function() {
    		  alert("전송 실패~~");
    	  }
      });
    }
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h3 class="text-center m-5">FAQ 관리자 리스트</h3>

<div class="container d-flex justify-content-center">
  <div style="width: 90%;">
    <div  class="row m-0">
		  <div class="text-start m-1 col">
		    <div class="input-group">
			  	<!-- <input type="checkbox" id="selectAll" name="selectAll" class="form-check me-2" /> -->
		  		<button type="button" onclick="allCheck()" id="allCheckBtn" class="btn btn-primary me-1">전체선택</button>
		  		<button type="button" onclick="allReset()" id="allResetBtn" class="btn btn-warning me-1" style="display:none">전체취소</button>
			  	<input type="button" value="선택삭제" onclick="delCheck()" class="btn btn-danger btn-sm me-2" />
			    <input type="button" value="전체검색" onclick="location.href='adFaqList';" class="btn btn-success"/>
		  	</div>
		  </div>
			<div class="text-end m-1 col">
			  <div class="input-group">
			  	<select name="category" id="category" onchange="categoryCheck()" class="form-select form-select-sm me-3">
			  	  <option value="전체" ${category == "전체" ? "selected" : "" }>전체</option>
			  	  <option ${pageVo.part == "예약" ? "selected" : "" }>예약</option>
			  	  <option ${pageVo.part == "결제/환불" ? "selected" : "" }>결제/환불</option>
			  	  <option ${pageVo.part == "회원정보" ? "selected" : "" }>회원정보</option>
			  	  <option ${pageVo.part == "기타" ? "selected" : "" }>기타</option>
		  		</select>
			  <!-- <form name="searchForm" method="post" action="boardSearhList"> -->
				  	<input type="text" name="searchString" id="searchString" value="${pageVo.searchString}" placeholder="제목 검색가능" class="form-control"/>
				  	<input type="button" value="검색" onclick="searchCheck()" class="btn btn-secondary btn-sm me-3" />
		      <a href="${ctp}/faq/adFaqInput" class="btn btn-outline-success btn-sm">FAQ 작성</a>
	      </div>
	    </div>
    </div>
		
		<form name="myform">
	    <table class="table table-hover text-center">
	      <tr class="table-info">
					<th>번호</th>
	        <th>제목</th>
	        <th>조회수</th>
	      </tr>
	      <c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
	      <c:forEach var="vo" items="${vos}">
	        <tr class="table-warning">
	     	    <td>${curScrStartNo}</td>
      			<td class="text-start">
	      			<input type="checkbox" id="idxFlag${vo.idx}" name="idxFlag" value="${vo.idx}" class="text-start me-2"/>
	            <a href="${ctp}/faq/adFaqDetail?idx=${vo.idx}" class="text-decoration-none text-dark">
	              <b>[${vo.category}]</b> ${vo.title}
	            </a>
	          </td>
	          <td>${vo.readNum}</td>
	        </tr>
	        <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
	      </c:forEach>
	      <c:if test="${empty vos}">
	        <tr>
	          <td colspan="5">등록된 FAQ가 없습니다.</td>
	        </tr>
	      </c:if>
	    </table>
    </form>
  </div>
</div>
 <!-- 블록페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="adFaqList?pag=1&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">첫페이지</a></li></c:if>
    <c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="adFaqList?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">이전블록</a></li></c:if>
    <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
      <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adFaqList?pag=${i}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">${i}</a></li></c:if>
      <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link text-secondary" href="adFaqList?pag=${i}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">${i}</a></li></c:if>
    </c:forEach>
    <c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="adFaqList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">다음블록</a></li></c:if>
    <c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="adFaqList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}&searchString=${pageVo.searchString}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->

<p><br/></p>
</body>
</html>
