<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelDetail.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f5f016ee8ec4b87750154cd5e9d07dfb&libraries=services"></script>
	<style>
		.hotel-container {
		  max-width: 1000px;
		  margin: 0 auto;
		  padding: 20px;
		  font-family: sans-serif;
		}
		
		.hotel-header {
		  text-align: center;
		  margin-bottom: 20px;
		}
		
		.hotel-title {
		  font-size: 28px;
		  display: inline-flex;
		  align-items: center;
		  gap: 8px;
		}
		
		.heart-icon img {
		  width: 28px;
		  vertical-align: middle;
		}
		
		.hotel-thumbnail {
		  text-align: center;
		  margin-bottom: 16px;
		}
		
		.hotel-thumbnail img {
		  width: 100%;
		  max-width: 700px;
		  border-radius: 12px;
		}
		
		.hotel-images img {
		  width: 200px !important;
		  height: auto !important;
		  margin: 5px 5px 0 0;
		  border-radius: 8px;
		}
		
		.roomList {
		  margin: 40px 0;
		}
		
		.roomList h3 {
		  margin-bottom: 16px;
		  font-size: 22px;
		  color: #444;
		}
		
		.roomContainer {
		  display: flex;
		  background-color: #f7f7f9;
		  border-radius: 10px;
		  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
		  margin-bottom: 16px;
		  overflow: hidden;
		}
		
		.roomThumbnailContainer {
		  width: 160px;
		  height: 120px;
		  flex-shrink: 0;
		}
		
		.roomThumbnailContainer img {
		  width: 100%;
		  height: 100%;
		  object-fit: cover;
		}
		
		.roomDetailContainer {
		  padding: 16px;
		  display: flex;
		  flex-direction: column;
		  justify-content: center;
		  gap: 6px;
		  flex: 1;
		}
		
		.roomDetailContainer div:nth-child(1) a {
		  font-size: 14px;
		  color: #0077cc;
		  text-decoration: none;
		}
		
		.roomDetailContainer div:nth-child(2) {
		  font-size: 16px;
		  font-weight: bold;
		  color: #333;
		}
		
		.roomDetailContainer div:nth-child(3) {
		  font-size: 15px;
		  color: #444;
		}
		
		.hotel-info {
		  margin-top: 20px;
		  font-size: 16px;
		  color: #333;
		}
		
		.hotel-description {
		  margin-top: 24px;
		  padding: 16px;
		  background: #f9f9f9;
		  border-radius: 10px;
		}
		
		.hotel-description h4 {
		  margin-bottom: 8px;
		  font-size: 18px;
		  color: #444;
		}
		
		.button-group {
		  margin-top: 30px;
		  display: flex;
		  flex-wrap: wrap;
		  gap: 10px;
		}
		
		.custom-btn {
		  padding: 10px 18px;
		  font-size: 15px;
		  border: none;
		  border-radius: 8px;
		  text-decoration: none;
		  color: white;
		  transition: background-color 0.3s ease;
		}
		
		.back-btn {
		  background-color: #6c757d;
		}
		
		.blue-btn {
		  background-color: #007bff;
		}
		
		.yellow-btn {
		  background-color: #ffc107;
		  color: black;
		}
		
		.red-btn {
		  background-color: #dc3545;
		}
		
		.reservation-search {
		  background-color: #f2f4f7;
		  border-radius: 10px;
		  padding: 24px 20px;
		  margin: 30px 0;
		  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
		}
		
		.reservation-search form {
		  display: flex;
		  flex-wrap: wrap;
		  align-items: flex-end;
		  gap: 16px;
		}
		
		.reservation-search label {
		  display: flex;
		  flex-direction: column;
		  font-size: 14px;
		  color: #333;
		  flex: 1 1 200px;
		}
		
		.reservation-search label.small-input {
		  flex: 0 0 100px;
		}
		
		.reservation-search input {
		  padding: 8px 10px;
		  border: 1px solid #ccc;
		  border-radius: 6px;
		  font-size: 14px;
		  margin-top: 4px;
		  width: 100%;
		}
		
		.reservation-search button {
		  padding: 10px 18px;
		  background-color: #28a745;
		  color: white;
		  border: none;
		  border-radius: 8px;
		  font-size: 15px;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		  flex-shrink: 0;
		  height: 40px;
		}
		
		.reservation-search button:hover {
		  background-color: #218838;
		}
	</style>

	<script>
		'use strict';
		
		// 호텔 서비스 중지 요청
		function hotelDeleteCheck() {
			let ans = confirm("해당 호텔 서비스 중지를 요청하시겠습니까?");
			if(!ans) return false;
			else location.href="hotelDeleteCheck?idx=${vo.idx}";
		}
		
		// 호텔 찜 추가하기
		function hotelLikeOk() {
			let mid = '${sMid}';
			let hotelIdx = ${vo.idx};
			
			if(mid == "") {
				alert("로그인 후 이용해주세요.");
				return false;
			}
			
			$.ajax({
				url : "hotelLikeOk",
				type : "post",
				data : {
					mid : mid,
					hotelIdx, hotelIdx
				},
				success : function(res) {
					if(res == "1") {
						$("#likeImg").attr("src", "${ctp}/images/heartRed.png");
						$("#likeFn").attr("href", "javascript:hotelLikeNo()");
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
		
		// 호텔 찜 취소하기
		function hotelLikeNo() {
			let mid = '${sMid}';
			let hotelIdx = ${vo.idx};
			
			if(mid == "") {
				alert("로그인 후 이용해주세요.");
				return false;
			}
			
			$.ajax({
				url : "hotelLikeNo",
				type : "post",
				data : {
					mid : mid,
					hotelIdx, hotelIdx
				},
				success : function(res) {
					if(res == "1") {
						$("#likeImg").attr("src", "${ctp}/images/heartBlack.png");
						$("#likeFn").attr("href", "javascript:hotelLikeOk()");
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
		
		// 체크인 체크아웃 날짜 처리
		window.addEventListener('DOMContentLoaded', function () {
		  const checkinInput = document.getElementById('checkinDate');
		  const checkoutInput = document.getElementById('checkoutDate');
		
		  // 오늘 날짜로 체크인 최소 설정
		  const today = new Date().toISOString().split('T')[0];
		  checkinInput.min = today;
		
		  // 체크인 값이 이미 있는 경우 초기 처리
		  if (checkinInput.value) {
		    checkoutInput.disabled = false;
		    checkoutInput.min = checkinInput.value;
		
		    // 체크아웃 날짜가 체크인보다 빠른 경우 초기화
		    if (checkoutInput.value && checkoutInput.value < checkinInput.value) {
		      checkoutInput.value = '';
		    }
		  } else {
		    checkoutInput.disabled = true;
		  }

		  // 체크인 날짜가 변경되면
		  checkinInput.addEventListener('change', function () {
		    if (checkinInput.value) {
		      checkoutInput.disabled = false;
		      checkoutInput.min = checkinInput.value;
		      checkoutInput.value = '';
		    } else {
		      checkoutInput.disabled = true;
		      checkoutInput.value = '';
		    }
		  });
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="hotel-container">
  <div class="hotel-header">
    <h2 class="hotel-title">
      ${vo.name} 
      <span class="heart-icon">
        <c:if test="${hotelLike == 'Ok'}">
          <a id="likeFn" href="javascript:hotelLikeNo()"><img id="likeImg" src="${ctp}/images/heartRed.png" /></a>
        </c:if>
        <c:if test="${hotelLike == 'No'}">
          <a id="likeFn" href="javascript:hotelLikeOk()"><img id="likeImg" src="${ctp}/images/heartBlack.png" /></a>
        </c:if>
      </span>
    </h2>
  </div>

  <div class="hotel-thumbnail">
    <img src="${ctp}/hotelThumbnail/${vo.thumbnail}" title="${vo.name}" alt="대표이미지" />
  </div>

  <div class="hotel-images">
    ${vo.images}
  </div>
  
  <div class="reservation-search" style="margin: 30px 0;">
	  <form method="get" action="hotelDetail?idx=${vo.idx}">
		  <input type="hidden" name="idx" value="${vo.idx}" />
		  
		  <label>체크인
		    <input type="date" id="checkinDate" name="checkinDate" value="${checkinDate}" required />
		  </label>
		  
		  <label>체크아웃
		    <input type="date" id="checkoutDate" name="checkoutDate" value="${checkoutDate}" required />
		  </label>
		  
		  <label class="small-input">인원
		    <input type="number" name="guestCount" min="1" max="5" value="${guestCount}" required />
		  </label>
		  
		  <label class="small-input">반려견
		    <input type="number" name="petCount" min="0" max="5" value="${petCount}" required />
		  </label>
		
		  <button type="submit">예약 가능 객실 검색</button>
		</form>
	</div>

  
	<div class="roomList">
  <!-- 예약 가능 객실 리스트 (검색 결과) -->
  <h3>예약 가능 객실</h3>
  <!-- 이전 객실 타입 저장 변수 -->
  <c:set var="previousRoomType" value="" />
  
	  <c:forEach items="${roomVos}" var="roomVo">
	    <!-- 객실 타입이 변경될 때마다 새로운 섹션 시작 -->
	    <c:if test="${roomVo.name != previousRoomType}">
	      <h4>${roomVo.name}</h4> <!-- 객실 타입 제목 출력 -->
	      <c:set var="previousRoomType" value="${roomVo.name}" />
	    </c:if>
	    
	    <div class="roomContainer">
	      <div class="roomThumbnailContainer">
	        <img src="${ctp}/roomThumbnail/s_${roomVo.thumbnail}" alt="Room Thumbnail"/>
	      </div>
	      <div class="roomDetailContainer">
	        <div>
	          <a href="${ctp}/room/roomDetail?roomIdx=${roomVo.idx}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&guestCount=${guestCount}&petCount=${petCount}">
	            상세보기
	          </a>
	        </div>
	        <div>${roomVo.roomNumber}</div> <!-- 호실 번호 -->
	        <div>${roomVo.price}원</div>
	      </div>
	    </div>
	  </c:forEach>
	</div>
    
    
    

  <div class="hotel-info">
    <p>📞 ${vo.tel}</p>
    <p>📍 ${vo.address}</p>
  </div>

  <div id="mapContainer" style="cursor:pointer;">
    <div id="map" style="width:100%;height:350px;"></div>
  </div>

  <div class="hotel-description">
    <h4>🏨 호텔 소개</h4>
    <p>${vo.description}</p>
  </div>

  <div class="button-group">
    <a href="${ctp}/hotel/hotelList" class="custom-btn back-btn">← 목록으로</a>

    <c:if test="${vo.mid == sMid}">
      <a href="${ctp}/room/roomInput?hotelIdx=${vo.idx}" class="custom-btn blue-btn">객실 등록</a>
      <a href="hotelUpdate?idx=${vo.idx}" class="custom-btn yellow-btn">호텔 정보 수정</a>
      <c:if test="${vo.status != '서비스중지요청'}">
        <a href="javascript:hotelDeleteCheck()" class="custom-btn red-btn">서비스 중지 요청</a>
      </c:if>
    </c:if>
  </div>
</div>
<!-- 모달 형태로 지도 띄우기 -->
<div id="modalMapContainer" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(128, 128, 128, 0.9); z-index: 9999;">
    <!-- 지도 모달 박스 -->
    <div id="modalMap" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 50%; height: 95%; background-color: white; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);">
       <button onclick="closeModalMap()" style="position: absolute; top: 10px; right: 10px; background-color: transparent; border: none; font-size: 30px; z-index: 10000;">&times;</button>
    </div>
</div>

	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		
		map.setDraggable(false); // 지도 드래그 막기
		map.setZoomable(false); // 지도 확대,축소 막기
		// 더블 클릭 확대 막기
		kakao.maps.event.addListener(map, 'dblclick', function(event) {
		    event.preventDefault(); // 더블 클릭으로 인한 확대 막기
		});
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${vo.address}', function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">${vo.name}</div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    
	
	 	// 지도 클릭 시 전체 화면을 열기 위한 스크립트
    // 기존 지도 클릭 시 모달로 지도를 띄우기
    document.getElementById('map').addEventListener('click', function() {
        // 모달 지도 표시
        document.getElementById('modalMapContainer').style.display = 'block';

        // 모달 지도 설정
        var mapContainer = document.getElementById('modalMap');
        var modalMap = new kakao.maps.Map(mapContainer, {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 임시 좌표
            level: 3 // 기본 레벨 설정
        });

        // 주소 검색 후 위치 표시
        var geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch('${vo.address}', function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                var marker = new kakao.maps.Marker({
                    map: modalMap,
                    position: coords
                });

                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">${vo.name}</div>'
                });
                infowindow.open(modalMap, marker);

                // 모달 지도 중심을 해당 위치로 이동
                modalMap.setCenter(coords);
            }
        });
    });

    // 모달 지도 닫기
    function closeModalMap() {
        document.getElementById('modalMapContainer').style.display = 'none';
    }
    
    
    // 지도 위에 마우스 올렸을 때 커서 변경
    document.addEventListener("DOMContentLoaded", function () {
  	  setTimeout(() => {
  	    const mapArea = document.querySelector('#map > div');
  	    if (mapArea) {
  	      mapArea.style.cursor = 'grab';
  	    } else {
  	      console.warn('지도 내부 요소를 찾을 수 없습니다.');
  	    }
  	  }, 500); // 지도가 렌더링될 시간 기다려줌
  	});
	</script>
</body>
</html>