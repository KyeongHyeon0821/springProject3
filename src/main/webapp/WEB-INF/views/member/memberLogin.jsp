<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberLogin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script>
    'use strict';
    window.Kakao.init("158c673636c9a17a27b67c95f2c6be5c");
    function kakaoLogin() {
      window.Kakao.Auth.login({
        scope: 'profile_nickname, account_email',
        success:function(autoObj) {
          window.Kakao.API.request({
            url : '/v2/user/me',
            success:function(res) {
              const kakao_account = res.kakao_account;
              location.href = "${ctp}/member/kakaoLogin?nickName=" + kakao_account.profile.nickname + "&email=" + kakao_account.email + "&accessToken=" + Kakao.Auth.getAccessToken();
            }
          });
        }
      });
    }
    
    function loginCheck() {
    	  const mid = document.getElementById("mid").value.trim();
    	  const pwd = document.getElementById("pwd").value.trim();

    	  if (mid === "") {
    	    alert("아이디를 입력하세요.");
    	    document.getElementById("mid").focus();
    	    return false;
    	  }

    	  if (pwd === "") {
    	    alert("비밀번호를 입력하세요.");
    	    document.getElementById("pwd").focus();
    	    return false;
    	  }

    	  return true;
    	}

  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container" style="max-width: 500px;">
  <form name="myform" method="post" onsubmit="return loginCheck()">
    <h3 class="text-center mb-4">
    <img src="${ctp}/images/logo.png" width="150px"/></h3>
    <div class="mb-3">
      <label for="mid" class="form-label">아이디</label>
      <input type="text" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요" autofocus class="form-control" />
    </div>
    <div class="mb-3">
      <label for="pwd" class="form-label">비밀번호</label>
      <input type="password" name="pwd" id="pwd" value="0000" placeholder="비밀번호를 입력하세요." class="form-control" />
    </div>

    <div class="d-flex justify-content-center gap-2 mb-3 align-items-center">
      <button type="submit" class="btn btn-success d-flex justify-content-center align-items-center" style="min-width: 70px; height: 38px; padding: 0;">로그인</button>
      <a href="javascript:kakaoLogin()" class="btn p-0" style="background-color: transparent; border: none;">
        <img src="${ctp}/images/kakao_login_medium.png" width="75px"/>
      </a>
      <a href="${ctp}/member/memberJoin" class="btn btn-primary d-flex justify-content-center align-items-center" style="min-width: 90px; height: 38px; padding: 0;">회원가입</a>
    </div>

    <div class="d-flex justify-content-center align-items-center gap-3">
      <div class="form-check mb-0">
        <input type="checkbox" class="form-check-input" id="idSave" name="idSave" checked>
        <label class="form-check-label" for="idSave">아이디 저장</label>
      </div>
      <a href="${ctp}/member/memberFindId" class="text-decoration-none">아이디 찾기</a>
      <span>/</span>
      <a href="${ctp}/member/memberFindPwd" class="text-decoration-none">비밀번호 찾기</a>
    </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>