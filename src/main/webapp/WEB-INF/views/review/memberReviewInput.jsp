<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberReviewInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<%-- <jsp:include page="/WEB-INF/views/review/reviewModalForm.jsp" /> --%>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
	<style>
		.container-review {
			background-color: white;
		}
		.room-detail {
			display: flex;
			align-items: center;
		}
		.room-items2 {
			width: 500px;		
		}
		.room-items3 {
			width: 500px;
		}
		.modal-content {
			box-sizing: border-box;
		} 
		.modal-content textarea {
			width: 100%;
			height: 100%;
			box-sizing: border-box;
			border-color: #eee;
			resize: none;
			
		}
		
		fieldset {
      direction: rtl;
    }
    #starForm input[type=radio] {
      display: none;
    }
    #starForm label {
      font-size: 1.6em;
      color: transparent;
      text-shadow: 0 0 0 #f0f0f0;
    }
    #starForm label:hover {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    #starForm label:hover ~ label {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    #starForm input[type=radio]:checked ~ label {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
	</style>
	<script>
	  'use strict';
	  
	  function modalCheck(hotelIdx,roomIdx,roomName,hostIp) {
		  $("#hotelIdx").val(hotelIdx);
		  $("#roomIdx").val(roomIdx);
		  $("#roomName").val(roomName);
		  $("#hostIp").val(hostIp);
	  }
	</script>
</head>
<body>
<p><br/></p>
<div class="container container-review">
		<p><br></p>
	  <table class="table text-center">
	  	<tr>
        <th class="table-secondary">숙소 이용 내역</th>
      </tr>
      <c:forEach var="ReservationListVo" items="${rsVos}" varStatus="st">
	      <tr class="room-detail">
					<td class="room-items1 border border-0 ">
				    <img class="room-photo" src="${ctp}/hotelThumbnail/${ReservationListVo.hotelThumbnail}" alt="객실 사진" style="width:200px;max-height:180px;border:none;"/>
					</td>
			    <td class="room-items2 ms-4 border border-0">
				    <div class="room-info"><span class="room-label"><a href="${ctp}/hotel/hotelDetail?idx=${ReservationListVo.hotelIdx}"><b style="color: blue">호텔 이름:${ReservationListVo.hotelName}</b></a></span></div>
				    <div class="room-info"><span class="room-label">객실 명칭: ${ReservationListVo.roomName}</span></div>
				    <div class="room-info"><span class="room-label">가격: ${ReservationListVo.price}</span>₩</div>
				    <div class="room-info"><span class="room-label">최대숙박인원: ${ReservationListVo.maxPeople}</span></div>
				    <div class="room-info"><span class="room-label">반려견크기제한: ${ReservationListVo.petSizeLimit}</span></div>
				    <div class="room-info"><span class="room-label">최대마리수: ${ReservationListVo.petCountLimit}</span></div>
				    <div class="room-info"><span class="room-label">체크인 날짜: ${ReservationListVo.checkinDate}</span></div>
				    <div class="room-info"><span class="room-label">체크아웃 날짜: ${ReservationListVo.checkoutDate}</span></div>
				    <div class="room-info"><span class="room-label" style="color: red">총 숙박비용: ${ReservationListVo.totalPrice}</span></div>
			    </td>
			    <td class="room-items3 border border-0">
			    	<a href="#" onclick="modalCheck('${ReservationListVo.hotelIdx}','${ReservationListVo.roomIdx}','${ReservationListVo.roomName}','${pageContext.request.remoteAddr}')" class="btn btn-info ms-3 text-end" data-bs-toggle="modal" data-bs-target="#myModal">리뷰작성</a>
			    </td>
			    <td class="room-items4 border border-0 ms-10">
			    	<a href="${ctp}/room/roomDetail?roomIdx=${ResevationListVo.roomIdx}&checkinDate=${ReservationListVo.checkinDate}&checkoutDate=${ReservationListVo.checkoutDate}&guestCount=${guestCount}&petCount=${petCount}" >내 리뷰 확인</a>
			    </td>
	      </tr>
      </c:forEach>
	  </table>
</div>
<p><br/></p>

<!-- 모달 리뷰창 띄우기 -->

	<div class="modal modal-lg" id="myModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	    	<div class="modal-header">
	      	<h4>리뷰달기 </h4><span class="btn btn-info ms-3">${sNickName} 님</span>
	    	</div>
				<form name="reviewForm" id="reviewForm" action="${ctp}/review/reviewInput" method="post">
		      <div class="modal-body text-end">
			      <fieldset style="border:0px;" class="starForm" id="starForm">
			        <div class="text-left viewPoint m-0 b-0" >
			          <input type="radio" name="star" value="1" id="star1"><label for="star1">★</label>
			          <input type="radio" name="star" value="2" id="star2"><label for="star2">★</label>
			          <input type="radio" name="star" value="3" id="star3"><label for="star3">★</label>
			          <input type="radio" name="star" value="4" id="star4"><label for="star4">★</label>
			          <input type="radio" name="star" value="5" id="star5"><label for="star5">★</label>
			          : 별점을 선택해 주세요 ■
			        </div>
			      </fieldset>
			      
			      <div class="m-0 p-0">
			      	<div class="text-end">
			          <input type="radio" name="purpose" value="1" id="purpose1"><label for="star1">가족과여행</label>
			          <input type="radio" name="purpose" value="2" id="purpose2"><label for="star2">연인과함께</label>
			          <input type="radio" name="purpose" value="3" id="purpose3"><label for="star3">친구와여행</label>
			          <input type="radio" name="purpose" value="4" id="purpose4"><label for="star4">회사단체</label>
			          <input type="radio" name="purpose" value="5" id="purpose5"><label for="star5">행사</label>
			          : 목적을 선택해 주세요 ■
			        </div>
		      		<textarea rows="6" cols="80" name="content" id="content" placeholder="리뷰를 등록해주세요." required></textarea>
		      	</div>
					</div>
					<div class="modal-footer">
		      	<button type="submit" class="btn btn-dark" >등록하기</button>
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
					</div>   
					<input type="hidden" name="roomIdx" id="roomIdx" />
					<input type="hidden" name="hotelIdx" id="hotelIdx" />
					<input type="hidden" name="roomName" id="roomName" />
					<input type="hidden" name="hostIp" id="hostIp" />  
				</form>      
			</div>
		</div>      
	</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>