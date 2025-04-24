<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>roomDetail.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<style>
		h2 {
			color: green;
		}
		.room-detail {
			display: flex;
			flex-direction: row;
		}
		.room-items {
			margin-top: 0;
			margin-right:50px;
		}
		.room-info {
			font-size: 17px;
		}
	</style>
</head>
<body>
<div class="modal" id="myModal">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">객실 상세정보</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="container">
				<h2>객실 상세보기</h2>
				<p></p>
					<div class="room-detail">
							<div class="room-items">
						    <img class="room-photo" src="${ctp}/images/lake.jpg" alt="객실 사진" style="width:200px;max-height:200px"/>
					    </div>
					    <div class="room-items">
						    <div class="room-info"><span class="room-label idx">객실고유번호:</span></div>
						    <div class="room-info"><span class="room-label hotelIdx">호텔고유번호:</span></div>
						    <div class="room-info"><span class="room-label name">객실 명칭:</span></div>
						    <div class="room-info"><span class="room-label">가격:</span>₩</div>
						    <div class="room-info"><span class="room-label">최대숙박인원:</span></div>
						    <div class="room-info"><span class="room-label">반려견크기제한:</span></div>
						    <div class="room-info"><span class="room-label">최대마리수:</span></div>
						    <div class="room-info"><span class="room-label">썸네일:</span></div>
						    <div class="room-info"><span class="room-label">상태:</span></div>
						    <div class="room-info"><span class="room-label">등록날짜:</span></div>
					    </div>
					    <p></p>
					</div>
					<div>
				    <a href="/admin/roomType/edit?hotelIdx=${vo.hotelIdx}" class="btn btn-warning">수정</a>
				    <a href="/admin/roomType/delete?hotelIdx=${vo.hotelIdx}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
				    <a href="javascript:history.back();" class="btn btn-success">목록으로</a>
				 	</div>
				</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>	

<script>
</script>
</body>
</html>