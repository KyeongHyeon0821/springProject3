<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberJoin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  
  <!-- 커스텀 CSS -->
  <style>
    /* 메인 컨테이너 스타일 */
    .join-container {
      max-width: 500px;
      margin: 30px auto;
      border: 1px solid #e3e3e3;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      background-color: #fff;
    }
    .join-container h3 {
      font-weight: bold;
      margin-bottom: 20px;
      text-align: center;
    }
    /* 테이블 레이아웃 커스터마이징 */
    .join-table {
      border: none;
      width: 100%;
    }
    .join-table th,
    .join-table td {
      vertical-align: middle !important;
      border-top: none !important;
      border-bottom: 1px solid #f0f0f0;
      padding: 0.75rem;
    }
    .join-table th {
      width: 100px;
	  text-align: center;      
      font-weight: bold;
      font-color: #black;
      background-color: #fafafa;
      color: #000;
    }
    .join-table input[type="text"],
    .join-table input[type="password"],
    .join-table select {
      border: 1px solid #d4d4d4;
      border-radius: 4px;
    }
    /* 버튼 스타일 */
    .btn-sm {
      padding: 6px 12px !important;
      font-size: 0.875rem !important;
    }
    .btn-info {
      background-color: #03c75a;
      border: none;
    }
    .btn-info:hover {
      background-color: #02b757;
    }
    .btn-success {
      background-color: #02b757;
      border: none;
    }
    .btn-success:hover {
      background-color: #009345;
    }
    .btn-secondary {
      background-color: #ebebeb;
      color: #333;
      border: 1px solid #ccc;
    }
    .btn-secondary:hover {
      background-color: #ddd;
    }
    /* 기타 스타일 */
    #demo {
      margin-bottom: 1rem;
    }
    .text-start {
      text-align: left !important;
    }
  </style>
  
  <script>
    'use strict';
    
    let idCheckSw = 0;
    let nickCheckSw = 0;
    
    // 정규식 정의
    let regMid = /^[a-zA-Z0-9_-]{4,20}$/;
    let regPwd = /^[a-zA-Z0-9!@#$%^&*]{4,16}$/;
    let regNickName = /^[가-힣a-zA-Z0-9_]{2,}$/;
    let regName = /^[가-힣a-zA-Z]+$/;
    let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    let regTel = /^\d{3}-\d{3,4}-\d{4}$/;
    
    // 회원가입에 필요한 정보 체크 (정규식)
    function fCheck() {
      // 필수 항목 체크
      let mid = myform.mid.value.trim();
      let pwd = myform.pwd.value.trim();
      let nickName = myform.nickName.value.trim();
      let name = myform.name.value.trim();
      
      let email1 = myform.email1.value.trim();
      let email2 = myform.email2.value.trim();
      let email = email1 + "@" + email2;
      
      let tel1 = myform.tel1.value.trim();
      let tel2 = myform.tel2.value.trim();
      let tel3 = myform.tel3.value.trim();
      let tel = tel1 + "-" + tel2 + "-" + tel3;
      
      let postcode = myform.postcode.value + " ";
      let roadAddress = myform.roadAddress.value + " ";
      let detailAddress = myform.detailAddress.value + " ";
      let extraAddress = myform.extraAddress.value + " ";
      let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
      
      let submitFlag = 0;
      
      if(!regMid.test(mid)) {
        alert("아이디는 4~20자의 영문 소문자, 숫자, 특수기호(_),(-)만 사용 가능합니다.");
        myform.mid.focus();
        return false;
      }
      else if (!regPwd.test(pwd)) {
    	  alert("비밀번호는 4~16자 사이이며, 영문, 숫자, 특수문자(!@#$%^&*)를 사용해주세요.");
    	  myform.pwd.focus();
    	  return false;
      }
      else if(!regNickName.test(nickName)) {
        alert("닉네임은 2자 이상만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일이 형식에 맞지 않습니다.");
        myform.email1.focus();
        return false;
      }
      else {
        submitFlag = 1;
      }
      
      // 전화번호 옵션 체크
      if(tel2 !== "" && tel3 !== "") {
        if(!regTel.test(tel)) {
          alert("전화번호 형식을 확인하세요. (예: 010-1234-5678)");
          myform.tel2.focus();
          return false;
        }
        else {
          submitFlag = 1;
        }
      }
      else {
        tel2 = " ";
        tel3 = " ";
        tel = tel1 + "-" + tel2 + "-" + tel3;
        submitFlag = 1;
      }
      
      // 중복체크 버튼 눌렀는지 확인
      if(submitFlag == 1) {
        if(idCheckSw == 0){
          alert("아이디 중복체크 버튼을 눌러주세요");
          document.getElementById("midBtn").focus();
          return false;
        }
        else if(nickCheckSw == 0) {
          alert("닉네임 중복체크 버튼을 눌러주세요");
          document.getElementById("nickNameBtn").focus();
          return false;
        }
        else {
          myform.email.value = email;
          myform.tel.value = tel;
          myform.address.value = address;
          myform.submit();
        }
      }
      else {
        alert("전송 실패하였습니다. 회원폼의 내용을 확인하세요");
      }
    }
    
    // 아이디 중복검사
    function idCheck() {
      let mid = myform.mid.value;
      
      if(mid.trim() === "") {
        alert("아이디를 입력하세요");
        myform.mid.focus();
      }
      else {
        $.ajax({
          url: "${ctp}/member/memberIdCheck",
          type: "get",
          data: { mid: mid },
          success: function(res) {
            if(res !== '0') {
              alert("이미 사용중인 아이디입니다. 다시 입력하세요");
              myform.mid.focus();
            } else {
              alert("사용 가능한 아이디입니다.");
              idCheckSw = 1;
              myform.mid.readOnly = true;
            }
          },
          error: function() { alert("전송 실패하였습니다."); }
        });
      }
    }
    
    // 닉네임 중복검사
    function nickCheck() {
      let nickName = myform.nickName.value;
      
      if(nickName.trim() === "") {
        alert("닉네임을 입력하세요");
        myform.nickName.focus();
      }
      else {
        $.ajax({
          url: "${ctp}/member/memberNickCheck",
          type: "get",
          data: { nickName: nickName },
          success: function(res) {
            if(res !== '0') {
              alert("이미 사용중인 닉네임입니다. 다시 입력하세요");
              myform.nickName.focus();
            } else {
              alert("사용 가능한 닉네임입니다.");
              nickCheckSw = 1;
              myform.nickName.readOnly = true;
            }
          },
          error: function() { alert("전송 실패하였습니다."); }
        });
      }
    }
    
 // 이메일 인증번호 받기
    function emailCertification() {
      let mid = myform.mid.value.trim();
      let pwd = myform.pwd.value.trim();
      let nickName = myform.nickName.value;
      let name = myform.name.value;
      let email1 = myform.email1.value.trim();
      let email2 = myform.email2.value.trim();
      let email = email1 + "@" + email2;
      
      // 아이디 중복 체크가 완료되지 않은 경우에만 정규식 검사를 진행
      if(idCheckSw === 0) {
        if(!regMid.test(mid)) {
          alert("아이디는 5~20자의 영문 소문자, 숫자, 특수기호(_),(-)만 사용 가능합니다.");
          myform.mid.focus();
          return false;
        }
      }
      
      if(pwd.trim() === "") {
        alert("비밀번호를 입력해 주세요.");
        myform.pwd.focus();
        return false;
      }
      if(!regNickName.test(nickName)) {
        alert("닉네임을 입력해주세요.");
        myform.nickName.focus();
        return false;
      }
      if(!regName.test(name)) {
        alert("성명을 입력해주세요.");
        myform.name.focus();
        return false;
      }
      if(!regEmail.test(email)) {
        alert("이메일을 입력해주세요.");
        myform.email1.focus();
        return false;
      }
      
      let spinner = `
    	  <div class="text-center" style="margin-top: 20px;">
    	    <div class="d-flex justify-content-center align-items-center" style="gap: 10px;">
    	      <div class="spinner-border text-dark" role="status">
    	        <span class="visually-hidden">Loading...</span>
    	      </div>
    	      <span class="fs-6 text-dark" style="font-weight: bold;">메일 발송중입니다. 잠시만 기다려주세요.</span>
    	    </div>
    	  </div>
    	`;
    	$("#demo").html(spinner);

      $.ajax({
        url: "${ctp}/member/memberEmailCheck",
        type: "post",
        data: { email: email },
        success: function(res) {
          if(res !== '0') {
            alert("인증번호가 발송되었습니다.\n메일 확인 후 인증번호를 입력해 주세요.");
            let str = '<div class="input-group">';
            str += '<input type="text" name="checkKey" id="checkKey" class="form-control"/>';
            str += '<button type="button" onclick="emailCeritificationOk()" class="btn btn-primary btn-sm">인증번호확인</button>';
            str += '</div>';
            $("#demo").html(str);
          } else {
            alert("인증확인 버튼을 다시 눌러주세요.");
          }
        },
        error: function() { alert("전송 실패하였습니다."); }
      });
    }

    // 메일 인증번호 확인
    function emailCeritificationOk() {
      let checkKey = $("#checkKey").val();
      if(checkKey.trim() === "") {
        alert("메일 인증키를 입력해주세요.");
        $("#checkKey").focus();
        return false;
      }
      
      $.ajax({
        url: "${ctp}/member/memberEmailCheckOk",
        type: "post",
        data: { checkKey: checkKey },
        success: function(res) {
          if(res !== "0") {
            $("#demo").hide();
            $("#certificationBtn").hide();
            $("#addContent").show();
            $("#addBtn").show();
            $("#viewCheckBtn").show();
          } else {
            alert("인증번호 오류입니다. 메일을 확인하세요.");
          }
        },
        error: function() { alert("전송 실패하였습니다."); }
      });
    }
    
    // 추가 선택항목 보이기/가리기
    $(function(){
      $("#viewBtn").change(function(){
        if($("#viewBtn").is(":checked")) {
          $("#addContent").show();
        } else {
          $("#addContent").hide();
        }
      });
    });
  </script>
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/nav.jsp" />
  <jsp:include page="/WEB-INF/views/include/slide2.jsp" />
  <p><br/></p>
  <div class="join-container">
    <form name="myform" method="post" enctype="multipart/form-data">
      <table class="join-table">
        <tr>
          <th class="bg-secondary-subtle">아이디</th>
          <td>
            <div class="input-group">
              <input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" autofocus required class="form-control" />
              <button type="button" id="midBtn" onclick="idCheck()" class="btn btn-secondary btn-sm ms-2">아이디중복체크</button>
            </div>
          </td>
        </tr>
        <tr>
          <th class="bg-secondary-subtle">비밀번호</th>
          <td>
            <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" required class="form-control" />
          </td>
        </tr>
        <tr>
          <th class="bg-secondary-subtle">닉네임</th>
          <td>
            <div class="input-group">
              <input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" required class="form-control" />
              <button type="button" id="nickNameBtn" onclick="nickCheck()" class="btn btn-secondary btn-sm ms-2">닉네임중복체크</button>
            </div>
          </td>
        </tr>
        <tr>
          <th class="bg-secondary-subtle">성명</th>
          <td>
            <input type="text" name="name" id="name" placeholder="성명을 입력하세요" required class="form-control" />
          </td>
        </tr>
        <tr>
          <th class="bg-secondary-subtle">성별</th>
          <td>
            <input type="radio" name="gender" id="gender1" value="남자" checked> 남자 &nbsp;
            <input type="radio" name="gender" id="gender2" value="여자"> 여자
          </td>
        </tr>
        <tr>
          <th class="bg-secondary-subtle">이메일</th>
          <td>
            <div class="input-group">
              <input type="text" name="email1" id="email1" class="form-control" required placeholder="이메일"/>
              <span class="input-group-text">@</span>
              <select name="email2" id="email2" class="form-select">
                <option>naver.com</option>
                <option>hanmail.net</option>
                <option>gmail.com</option>
                <option>daum.net</option>
                <option>yahoo.com</option>
                <option>hotmail.com</option>
                <option>nate.com</option>
              </select>
            </div>
          </td>
        </tr>
      </table>
      <div class="text-center mt-3">
        <button type="button" onclick="emailCertification()" id="certificationBtn" class="btn btn-info btn-sm">인증번호받기</button>
      </div>
      <div class="text-center">
        <div id="demo"></div>
      </div>
      
      <!-- 선택입력사항 -->
      <div class="form-check mb-2" id="viewCheckBtn" style="display:none" onclick="viewBtnCheck()">
        <input type="checkbox" name="viewBtn" id="viewBtn" checked class="form-check-input" />
        <label for="viewBtn" class="form-check-label ms-1">선택입력항목 보이기/가리기</label>
      </div>
      <div id="addContent" style="display:none">
        <table class="join-table">
          <tr>
            <th class="bg-secondary-subtle">생일</th>
            <td>
              <input type="date" name="birthday" id="birthday" value="<%=java.time.LocalDate.now()%>" class="form-control">
            </td>
          </tr>
          <tr>
            <th class="bg-secondary-subtle">전화번호</th>
            <td>
              <div class="input-group">
                <select name="tel1" class="form-select">
                  <option value="010" selected>010</option>
		            <option value="02">서울</option>
		            <option value="031">경기</option>
		            <option value="032">인천</option>
		            <option value="041">충남</option>
		            <option value="042">대전</option>
		            <option value="043">충북</option>
		            <option value="051">부산</option>
		            <option value="052">울산</option>
		            <option value="051">부산</option>
		            <option value="054">경북</option>
		            <option value="055">경남</option>
		            <option value="061">전남</option>
		            <option value="062">광주</option>
		            <option value="063">전북</option>
		            <option value="064">제주</option>
                </select>
                <span class="input-group-text">-</span>
                <input type="text" name="tel2" id="tel2" class="form-control">
                <span class="input-group-text">-</span>
                <input type="text" name="tel3" id="tel3" class="form-control">
              </div>
            </td>
          </tr>
          <tr>
            <th class="bg-secondary-subtle">주소</th>
            <td>
              <div class="input-group mb-2">
                <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
                <button type="button" onclick="sample6_execDaumPostcode()" class="btn btn-info btn-sm ms-2">우편번호 찾기</button>
              </div>
              <input type="text" name="roadAddress" id="sample6_address" placeholder="주소" class="form-control mb-2">
              <div class="input-group">
                <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control">
                <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
              </div>
            </td>
          </tr>
          <tr>
            <th class="bg-secondary-subtle">정보공개</th>
            <td class="text-start">
              <input type="radio" name="userInfor" id="userinfor1" value="공개" checked> 공개 &nbsp;
              <input type="radio" name="userInfor" id="userinfor2" value="비공개"> 비공개
            </td>
          </tr>
        </table>
      </div>
      <div class="text-center mt-4" id="addBtn" style="display:none">
        <button type="button" onclick="fCheck()" class="btn btn-success me-2">회원가입</button>
        <button type="reset" class="btn btn-warning me-2">다시입력</button>
        <button type="button" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-primary">돌아가기</button>
      </div>
      <!-- 숨김 필드 -->
      <input type="hidden" name="email">
      <input type="hidden" name="tel">
      <input type="hidden" name="address">
    </form>
  </div>
  <p><br/></p>
  <jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
