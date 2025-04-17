<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    .container { max-width: 500px; margin: 50px auto; }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h3 class="text-center mb-4">
    <img src="${ctp}/images/logo.png" width="150px"/><br/>
    <span style="color: #2e7d32; font-weight: bold;">아이디찾기</span>
  </h3>

  <form method="post" action="${ctp}/member/memberFindId" onsubmit="return validateForm()">
    <div class="mb-3">
      <label for="name" class="form-label">이름</label>
      <input type="text" name="name" id="name" class="form-control">
    </div>

    <div class="mb-3">
      <label for="email1" class="form-label">이메일</label>
      <div class="input-group">
        <input type="text" name="email1" id="email1" class="form-control" placeholder="이메일 아이디">
        <span class="input-group-text">@</span>
        <select name="email2" id="email2" class="form-select">
          <option value="naver.com">naver.com</option>
          <option value="hanmail.net">hanmail.net</option>
          <option value="gmail.com">gmail.com</option>
          <option value="daum.net">daum.net</option>
          <option value="yahoo.com">yahoo.com</option>
          <option value="hotmail.com">hotmail.com</option>
          <option value="nate.com">nate.com</option>
        </select>
      </div>
    </div>
    <button type="submit" class="btn btn-success w-100">아이디 찾기</button>
    
    <c:if test="${not empty foundId}">
	    <div class="alert alert-success mt-4 text-center">
	      회원님의 아이디는 <strong>${foundId}</strong> 입니다.
	    </div>
	</c:if>
  	<c:if test="${notFound}">
	    <div class="alert alert-danger mt-4 text-center">
	      일치하는 회원 정보가 없습니다.
	    </div>
	</c:if>
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
	function validateForm() {
	  const name = document.getElementById("name").value.trim();
	  const email1 = document.getElementById("email1").value.trim();
	  const email2 = document.getElementById("email2").value;
	
	  const namePattern = /^[가-힣a-zA-Z]+$/;
	  
	  if (!name) {
	    alert("이름을 입력해주세요.");
	    document.getElementById("name").focus();
	    return false;
	  }
	  if (!namePattern.test(name)) {
		    alert("이름은 한글 또는 영문만 입력 가능합니다.");
		    document.getElementById("name").focus();
		    return false;
	  }
	  if (!email1) {
	    alert("이메일을 입력해주세요.");
	    document.getElementById("email1").focus();
	    return false;
	  }
	
	  const email = email1 + "@" + email2;
	  const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	  if (!emailPattern.test(email)) {
	    alert("이메일 형식이 올바르지 않습니다.");
	    document.getElementById("email1").focus();
	    return false;
	  }
	  return true;
	}
</script>
</body>
</html>
