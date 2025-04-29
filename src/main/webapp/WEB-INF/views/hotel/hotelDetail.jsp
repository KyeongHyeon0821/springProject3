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
  .hotel-images img{
    width:200px !important;
    height:auto !important;
    margin:5px 5px 0 0;
  }
  .map_wrap {
    position:relative;
  }
  #category {
    position:absolute;
    top:10px;
    left:0px;
    margin-left:-7px;
    z-index:10;
  }
  #category li {
    display:inline-block;
    background-color:#2e7d32;
    color:white;
    font-weight:bold;
    padding:8px 14px;
    border-radius:6px;
    cursor:pointer;
    box-shadow:0 2px 4px rgba(0,0,0,0.2);
    transition:background-color 0.2s ease;
  }
  #category li:hover {
    background-color:#1b5e20;
  }
</style>
<script>
  'use strict';

	// 호텔 등록 취소 요청
	function hotelDeleteCheck() {
	  let ans = confirm("해당 호텔 등록 취소를 요청하시겠습니까?");
	  if(!ans) return false;
	  else location.href="hotelDeleteCheck?idx=${hotelVo.idx}";
	}
	
	// 호텔 찜 추가하기
	function hotelLikeOk() {
	  let mid = '${sMid}';
	  let hotelIdx = '${hotelVo.idx}';
	
	  if(mid == "") {
	    alert("로그인 후 이용해주세요.");
	    return false;
	  }
	
	  $.ajax({
	    url : "hotelLikeOk",
	    type : "post",
	    data : { mid : mid, hotelIdx : hotelIdx },
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
	  let hotelIdx = '${vo.idx}';
	
	  if(mid == "") {
	    alert("로그인 후 이용해주세요.");
	    return false;
	  }
	
	  $.ajax({
	    url : "hotelLikeNo",
	    type : "post",
	    data : { mid : mid, hotelIdx : hotelIdx },
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
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2>${hotelVo.name}</h2>

  <c:if test="${hotelLike == 'Ok'}">
    <a id="likeFn" href="javascript:hotelLikeNo()"><img id="likeImg" src="${ctp}/images/heartRed.png"/></a>
  </c:if>
  <c:if test="${hotelLike == 'No'}">
    <a id="likeFn" href="javascript:hotelLikeOk()"><img id="likeImg" src="${ctp}/images/heartBlack.png"/></a>
  </c:if>

  <h5>🏨 ${hotelVo.address}</h5>
  <div><img src="${ctp}/hotelThumbnail/${hotelVo.thumbnail}" title="${hotelVo.name}" alt="대표이미지" width="400px"/></div>

  <div class="hotel-images">${hotelVo.images}</div>

  <p>연락처 : ${hotelVo.tel}</p>
  <div>호텔 소개</div>
  <div>${hotelVo.description}</div>
  <p>위치 : ${hotelVo.address}</p>

  <div id="mapContainer" style="position:relative;cursor:pointer;">
    <div id="map" style="width:100%;height:350px;"></div>
    <ul id="category">
      <li id="TOUR" data-order="99"><span class="category_bg tour"></span>관광지</li>
    </ul>
  </div>
  
  <!-- 관광지 정보 출력 -->
  <div id="touristInfo" style="margin-top:30px; padding:20px; background:#ffffff; border:1px solid #ddd; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.08); display:none;">
	  <div style="display:flex; align-items:center; margin-bottom:15px;">
	    <img src="${ctp}/images/paw_marker.png" alt="관광지" style="width:35px; height:35px; margin-right:8px;">
	    <h4 id="touristName" style="margin:0; color:#2e7d32; font-weight:bold;"></h4>
	  </div>
	  <div style="font-size:14px; color:#555; margin-bottom:10px; padding-left:30px;">
	    <i class="bi bi-geo-alt-fill" style="color:#dc3545; margin-right:5px;"></i><span id="touristAddress"></span>
	  </div>
	  <div style="font-size:15px; color:#333; line-height:1.6; margin-top:20px; padding-left:30px; padding-right:30px; word-break:keep-all;">
	    <p id="touristDescription" style="margin:0;"></p>
	  </div>
	  <c:if test="${hotelVo.mid == sMid}">
	    <div style="text-align:right; margin-top:15px;">
	      <small style="color:#dc3545;">(수정/삭제는 관리자에게 문의하세요)</small>
	    </div>
	  </c:if>
   </div>
  <div class="mt-3">
    <a href="${ctp}/hotel/hotelList" class="btn btn-secondary">돌아가기</a>

    <c:if test="${hotelVo.mid == sMid || sLevel == 0}">
      <a href="${ctp}/room/roomInput?hotelIdx=${hotelVo.idx}" class="btn btn-primary">객실 등록</a>
      <a href="${ctp}/touristSpotInput?hotelIdx=${hotelVo.idx}" class="btn btn-success">주변 관광지 등록</a>
      <a href="hotelUpdate?idx=${hotelVo.idx}" class="btn btn-warning">호텔 정보 수정</a>
      <a href="javascript:hotelDeleteCheck()" class="btn btn-danger">호텔 등록 취소 요청</a>
    </c:if>
  </div>
</div>
<!-- 모달 형태로 지도 띄우기 -->
<div id="modalMapContainer" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(128, 128, 128, 0.9); z-index: 9999;">
  <div id="modalMap" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 50%; height: 95%; background-color: white; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); position: relative;">
    <!-- 닫기 버튼 -->
    <button onclick="closeModalMap()" style="position: absolute; top: 10px; right: 10px; background-color: transparent; border: none; font-size: 30px; z-index: 10000;">&times;</button>
     <!-- 관광지 버튼: 지도 위에 고정되게 배치 -->
	  <ul id="modalCategory" style="position: absolute; top: 15px; left: 15px; z-index: 10000;">
	    <li id="MODAL_TOUR" style="display:inline-block; background:#2e7d32; color:white; font-weight:bold; padding:8px 14px; border-radius:6px; cursor:pointer;">
	      관광지
	    </li>
	  </ul>
  </div>
</div>
<script>
'use strict';
	var touristMarkers = [];
	var tourVisible = false;
	var modalTourMarkers = [];
	var modalTourVisible = false;
	var touristListData = [];
	var modalMap;
	
	var mapContainer = document.getElementById('map');  // 지도롤 표시할 div
	var mapOption = {
	  center: new kakao.maps.LatLng(33.450701, 126.570667),
	  level: 3  // 지도의 확대 레벨
	};
	
	// 지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	map.setDraggable(false);
	map.setZoomable(true);
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${hotelVo.address}', function(result, status) {
	  
	  // 정상적으로 검색이 완료됐으면
	  if (status === kakao.maps.services.Status.OK) {
		  
	    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    
	    // 결과값으로 받은 위치를 마커로 표시합니다
	    var marker = new kakao.maps.Marker({ map: map, position: coords });
	    
	    // 인포윈도우로 장소에 대한 설명을 표시합니다
	    var infowindow = new kakao.maps.InfoWindow({ content: '<div style="width:150px;text-align:center;padding:6px 0;">${hotelVo.name}</div>' });
	    infowindow.open(map, marker);
	    
	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map.setCenter(coords);
	  }
	});
	
	// 기존 지도 클릭 시 모달 열기
	mapContainer.addEventListener('click', function(e) {
	  // 마커를 클릭한 경우에는 모달 열지 않게 막기
	  if (e.target.tagName === 'IMG') return; 
	  openHotelModalMap();
	});
	
	// 모달 열기
	function openHotelModalMap() {
	  document.getElementById('modalMapContainer').style.display = 'block';
	
	  setTimeout(function() {
	    modalTourMarkers.length = 0;
	
	    var modalMapContainer = document.getElementById('modalMap');
	    modalMap = new kakao.maps.Map(modalMapContainer, {
	      center: new kakao.maps.LatLng(33.450701, 126.570667), // 임시 좌표
	      level: 3 // 기본 레벨 설정
	    });
		
	    // 주소 검색 후 위치 표시
	    var geocoder = new kakao.maps.services.Geocoder();
	    geocoder.addressSearch('${hotelVo.address}', function(result, status) {
	      if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        var marker = new kakao.maps.Marker({ map: modalMap, position: coords });
	        var infowindow = new kakao.maps.InfoWindow({ content: '<div style="width:150px;text-align:center;padding:6px 0;">${hotelVo.name}</div>' });
	        infowindow.open(modalMap, marker);
	        
	        // 모달 지도 중심을 해당 위치로 이동
	        modalMap.setCenter(coords);
	      }
	    });
	  }, 300);
	}
	
	// 모달 지도 닫기
	function closeModalMap() {
	  document.getElementById('modalMapContainer').style.display = 'none';
	}
	
	// 관광지 버튼 처리
	function setupTouristButton(mapObj, buttonId, markerList, visibleFlagName) {
	  const btn = document.getElementById(buttonId);
	  let openInfoWindow = null;
	  
	  if (btn) {
	      btn.addEventListener('click', function() {
	    	let targetMap = mapObj;
	        if (buttonId === 'MODAL_TOUR') {
	          targetMap = modalMap; // 모달은 modalMap으로 강제 세팅
	      }
	      if (!window[visibleFlagName]) {
          
	        touristListData.forEach(spot => {
	          const coords = new kakao.maps.LatLng(Number(spot.lat), Number(spot.lng));
	          const markerImage = new kakao.maps.MarkerImage('${ctp}/images/paw_marker.png', new kakao.maps.Size(40, 40));
	          const marker = new kakao.maps.Marker({ map: targetMap, position: coords, title: spot.name, image: markerImage });
	          
	          let spotDescription = '';
	          if('${spotDescription}' != '') spotDescription = '${spotDescription}';
	          
	          var tempName = '';
	          var tempAddress = '';
	          <c:forEach var="vo" items="${vos}" varStatus="st">
	            if('${vo.spotName}' == spot.name) {
	            	tempName = '${vo.spotName}';
	            	tempAddress = '${vo.spotAddress}';
	            }
	          </c:forEach>

	          const content = '<div style="padding:10px; font-size:13px; line-height:1.6; word-break:break-word; width:200px;">'
	            + '<div style="font-weight:bold; color:#2e7d32; margin-bottom:5px;">'+tempName+'</div>'
	            + '<div style="font-size:12px; color:gray;">주소: '+tempAddress+'</div>'
	            + '</div>';
	          const infoWindow = new kakao.maps.InfoWindow({ content: content });
	          
	          kakao.maps.event.addListener(marker, 'click', function() {
	        	if (openInfoWindow) {
	              openInfoWindow.close(); // 이전 열린 창 닫기
	            }
	            infoWindow.open(targetMap, marker); // 새 창 열기
	            openInfoWindow = infoWindow; // 현재 열린 창 기록
	            
	            // 관광지 정보 텍스트 영역에 내용 채우기
	            document.getElementById('touristInfo').style.display = 'block';
	            document.getElementById('touristName').innerText = spot.name;
	            document.getElementById('touristAddress').innerText = spot.address;
	            document.getElementById('touristDescription').innerText = spot.description;
	            
	          });
	          
	          markerList.push({ marker: marker, infoWindow: infoWindow });
	        });
	        window[visibleFlagName] = true;
	      } else {
	    	  markerList.forEach(obj => {
	              if (obj.infoWindow) obj.infoWindow.close();
	              if (obj.marker) obj.marker.setMap(null);
	            });
	            markerList.length = 0;
	            window[visibleFlagName] = false;
	      }
	    });
	  }
	}

	// 관광지 데이터 저장
	<c:forEach var="spot" items="${touristList}">
		touristListData.push({
		  lat: "${spot.lat}",
		  lng: "${spot.lng}",
		  name: "${spot.name}",
		  address: "${spot.address}",
		  description: "${spot.description}"
		});
	</c:forEach>

	console.log("touristListData = ", touristListData);
	
	// 초기 관광지 버튼 설정
	window.addEventListener('DOMContentLoaded', function() {
	  setupTouristButton(map, 'TOUR', touristMarkers, 'tourVisible'); // 메인 지도용
	  setupTouristButton(null, 'MODAL_TOUR', modalTourMarkers, 'modalTourVisible'); // 모달 지도용
	});
</script>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
