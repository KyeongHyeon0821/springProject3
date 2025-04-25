<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberReviewInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<style>
		.table {
			border: #eee;
		}
		.btn-1 {
			background-color: #328E6E;
		}
		.room-detail {
		}
		.room-items {
		}
		.room-info {
		}
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
	  <table class="table table-bordered">
	  	<tr class="">
        <th class="">
        	<h4 class="title ms-3">내가 묵은 객실정보</h4>
       	</th>
       	<th></th>
      </tr>
      <c:forEach var="roomVo" items="${roomVos}" varstatus="st">
	      <tr class="room-detail">
					<td class="room-items">
				    <img class="room-photo" src="${ctp}/images/lake.jpg" alt="객실 사진" style="width:200px;max-height:200px"/>
					  <a href="#" class="btn btn-info ms-3" data-bs-toggle="modal" data-bs-target="myModal">리뷰작성</a>
					</td>
			    <td class="room-items">
				    <div class="room-info"><span class="room-label">호텔 이름:</span></div>
				    <div class="room-info"><span class="room-label">객실 명칭: ${roomVo.name}</span></div>
				    <div class="room-info"><span class="room-label">가격: ${roomVo.price}</span>₩</div>
				    <div class="room-info"><span class="room-label">최대숙박인원: ${roomVo.maxPeople}</span></div>
				    <div class="room-info"><span class="room-label">반려견크기제한: ${roomVo.petSizeLimit}</span></div>
				    <div class="room-info"><span class="room-label">최대마리수: ${roomVo.petCountLimit}</span></div>
			    </td>
	      </tr>
      </c:forEach>
	  </table>
</div>
<p><br/></p>
</body>
</html>