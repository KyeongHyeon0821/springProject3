<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>roomUpdate.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script>
		'use strict';
		
		// 객실 수정 처리
		function fCheck() {
			// 유효성 체크
			let name = $("#name").val().trim();
			let price = $("#price").val().trim();
			let petSizeLimit = $("#petSizeLimit").val().trim();
			
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
			return true;
		}
	</script>
	<style>
	  body {
	    background-color: #f9fefb;
	  }
	
	  .form-container {
	    max-width: 800px;
	    margin: 50px auto;
	    padding: 30px;
	    background-color: #fff;
	    border: 1px solid #cde6da;
	    border-radius: 15px;
	    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
	  }
	
	  .form-container h2 {
	    text-align: center;
	    color: #2e7d32;
	    margin-bottom: 25px;
	    font-weight: bold;
	  }
	
	  .form-group {
	    margin-bottom: 20px;
	  }
	
	  .form-group label {
	    display: block;
	    font-weight: bold;
	    color: #2e7d32;
	    margin-bottom: 5px;
	  }
	
	  .form-group input[type="text"],
	  .form-group input[type="tel"],
	  .form-group input[type="file"],
	  .form-group input[type="number"],
	  .form-group select,
	  .form-group textarea {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #cde6da;
	    border-radius: 6px;
	    box-sizing: border-box;
	  }
	
	  .form-group textarea {
	    resize: vertical;
	  }
	
	  .form-group.text-center {
	    text-align: center;
	  }
	
	  .form-group.text-center input[type="submit"],
	  .form-group.text-center input[type="reset"],
	  .form-group.text-center input[type="button"] {
	    margin: 0 10px;
	    padding: 10px 20px;
	    font-weight: bold;
	    border-radius: 6px;
	    border: none;
	    cursor: pointer;
	  }
	
	  .form-group.text-center input[type="submit"] {
	    background-color: #6ac47e;
	    color: #fff;
	  }
	
	  .form-group.text-center input[type="reset"] {
	    background-color: #ffc107;
	    color: #fff;
	  }
	
	  .form-group.text-center input[type="button"] {
	    background-color: #17a2b8;
	    color: #fff;
	  }
	
	  .form-group.text-center input[type="submit"]:hover {
	    background-color: #519d63;
	  }
	
	  .form-group.text-center input[type="reset"]:hover {
	    background-color: #e0a800;
	  }
	
	  .form-group.text-center input[type="button"]:hover {
	    background-color: #138496;
	  }
	
	  /* 옵션 나열 스타일 */
	  .option-list {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 10px 20px;
	  }
	
	  .option-item {
	    display: flex;
	    align-items: center;
	    min-width: 150px;
	  }
	
	  .option-item input[type="checkbox"] {
	    margin-right: 5px;
	  }
	  .btn-link {
		  display: inline-block;
		  padding: 10px 20px;
		  margin-left: 10px;
		  background-color: #17a2b8;
		  color: #fff;
		  text-decoration: none !important;
		  font-weight: bold;
		  border-radius: 6px;
		  transition: background-color 0.2s ease;
		}
		
		.btn-link:hover {
		  background-color: #138496;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="form-container">
  <h2>객실 정보 수정</h2>
  <form name="roomForm" method="post" onsubmit="return fCheck();">
    <input type="hidden" name="idx" value="${vo.idx}" />

    <div class="form-group">
      <label for="hotelName">호텔명</label>
      <input type="text" value="${hotelVo.name}" name="hotelName" id="hotelName" class="form-control" readonly />
    </div>

    <div class="form-group">
      <label for="name">객실명</label>
      <input type="text" name="name" id="name" value="${vo.name}" class="form-control" required />
    </div>

    <div class="form-group">
      <label for="roomNumber">객실 번호</label>
      <input type="text" name="roomNumber" id="roomNumber" value="${vo.roomNumber}" class="form-control" required />
    </div>

    <div class="form-group">
      <label for="price">1박 요금</label>
      <input type="number" name="price" id="price" value="${vo.price}" class="form-control" required />
    </div>

    <div class="form-group">
      <label for="maxPeople">최대 인원 수</label>
      <select name="maxPeople" id="maxPeople" class="form-select" required>
        <option value="1" ${vo.maxPeople == 1 ? 'selected' : ''}>1</option>
        <option value="2" ${vo.maxPeople == 2 ? 'selected' : ''}>2</option>
        <option value="3" ${vo.maxPeople == 3 ? 'selected' : ''}>3</option>
        <option value="4" ${vo.maxPeople == 4 ? 'selected' : ''}>4</option>
        <option value="5" ${vo.maxPeople == 5 ? 'selected' : ''}>5</option>
      </select>
    </div>

    <div class="form-group">
      <label for="petSizeLimit">반려견 크기 제한</label>
      <select name="petSizeLimit" id="petSizeLimit" class="form-select" required>
        <option value="">선택 안 함</option>
        <option value="소형" ${vo.petSizeLimit == '소형' ? 'selected' : ''}>소형견만 가능</option>
        <option value="중형" ${vo.petSizeLimit == '중형' ? 'selected' : ''}>중형견까지 가능</option>
        <option value="대형" ${vo.petSizeLimit == '대형' ? 'selected' : ''}>대형견까지 가능 (모두 가능)</option>
      </select>
    </div>

    <div class="form-group">
      <label for="petCountLimit">최대 반려견 수</label>
      <select name="petCountLimit" id="petCountLimit" class="form-select" required>
        <option value="1" ${vo.petCountLimit == 1 ? 'selected' : ''}>1</option>
        <option value="2" ${vo.petCountLimit == 2 ? 'selected' : ''}>2</option>
        <option value="3" ${vo.petCountLimit == 3 ? 'selected' : ''}>3</option>
        <option value="4" ${vo.petCountLimit == 4 ? 'selected' : ''}>4</option>
        <option value="5" ${vo.petCountLimit == 5 ? 'selected' : ''}>5</option>
      </select>
    </div>

    <div class="form-group">
      <label class="form-label">객실 옵션</label>
      <div class="option-list">
        <c:forEach var="option" items="${optionList}">
          <c:set var="isChecked" value="false" />
          <c:forEach var="roomOption" items="${roomOptionList}">
            <c:if test="${option.idx == roomOption.idx}">
              <c:set var="isChecked" value="true" />
            </c:if>
          </c:forEach>
          <div class="option-item">
            <input type="checkbox" name="options" value="${option.idx}" id="option${option.idx}"
                   <c:if test="${isChecked}">checked</c:if> />
            <label for="option${option.idx}">${option.name}</label>
          </div>
        </c:forEach>
      </div>
    </div>

    <div class="form-group text-center">
		  <input type="submit" value="수정하기" />
		  <a href="${ctp}/room/roomDetail?roomIdx=${vo.idx}" class="btn-link">돌아가기</a>
		</div>
  </form>
</div>

</body>
</html>