<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberUpdate</title>
</head>
<body>
	<ul>
	  <li>아이디 : ${mVo.mid}</li>
      <li>닉네임 : ${mVo.nickName}</li>
      <li>성명 : ${mVo.name}</li>
      <li>이메일 : ${mVo.email}</li>
      <li>전화번호 : ${mVo.tel}</li>
      <li>주소 : ${mVo.address}</li>
      <li>성별 : ${mVo.gender}</li>
      <li>생년월일 : ${mVo.birthday}</li>
    </ul>
</body>
</html>