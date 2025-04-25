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
		height: auto !important;
		margin : 5px 5px 0 0;
	}
	.map_wrap {
   		position: relative;
    }
	#category {
	    position: absolute;
	    top: 10px;
	    left: 0px;
	    margin-left: -7px;
	    z-index: 10;
	  }
	
	#category li {
	  display: inline-block;
	  background-color: #2e7d32;
	  color: white;
	  font-weight: bold;
	  padding: 8px 14px;
	  border-radius: 6px;
	  cursor: pointer;
	  box-shadow: 0 2px 4px rgba(0,0,0,0.2);
	  transition: background-color 0.2s ease;
	}
	
	#category li:hover {
	  background-color: #1b5e20;
	}
</style>
<script>
		'use strict';
		
		// 호텔 등록취소 요청
		function hotelDeleteCheck() {
			let ans = confirm("해당 호텔 등록 취소를 요청하시겠습니까?");
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
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>${vo.name}</h2>
  
	<c:if test="${hotelLike == 'Ok'}">
		<a id="likeFn" href="javascript:hotelLikeNo()"><img id="likeImg" src="${ctp}/images/heartRed.png" /></a>
	</c:if>
	<c:if test="${hotelLike == 'No'}">
		<a id="likeFn" href="javascript:hotelLikeOk()"><img id="likeImg" src="${ctp}/images/heartBlack.png" /></a>
	</c:if>
	
	
	<h5>🏨 ${vo.address}</h5>
	<div><img src="${ctp}/hotelThumbnail/${vo.thumbnail}" title="${vo.name}" alt="대표이미지" width="400px"/></div>
	
	<div class="hotel-images">${vo.images}</div>
	
	<p>연락처 : ${vo.tel}</p>
	<div>호텔 소개</div>
	<div>${vo.description}</div>
	<p>위치 : ${vo.address}</p>
	
	<div id="mapContainer" style="position:relative; cursor:pointer;">
		<div id="map" style="width:100%;height:350px;"></div>
		  <ul id="category">
		    <li id="TOUR" data-order="99"><span class="category_bg tour"></span>관광지</li>
		  </ul>
	</div>
	
	<div class="mt-3">
		<a href="${ctp}/hotel/hotelList" class="btn btn-secondary">돌아가기</a>
	
		<c:if test="${vo.mid == sMid}">
			<a href="${ctp}/room/roomInput?hotelIdx=${vo.idx}" class="btn btn-primary">객실 등록</a>
			<a href="${ctp}/touristSpotInput?hotelIdx=${vo.idx}" class="btn btn-success">주변 관광지 등록</a>
			<a href="hotelUpdate?idx=${vo.idx}" class="btn btn-warning">호텔 정보 수정</a>
			<a href="javascript:hotelDeleteCheck()" class="btn btn-danger">호텔 등록 취소 요청</a>
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
		
		map.setDraggable(false);
		map.setZoomable(true);
		
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
		        
		        // 관광지 마커 표시
		        <c:forEach var="spot" items="${touristList}">
		          var spotLatLng = new kakao.maps.LatLng(${spot.lat}, ${spot.lng});
		          var pawMarkerImage = new kakao.maps.MarkerImage(
		            "${ctp}/images/paw_marker.png", 
		            new kakao.maps.Size(40, 40)
		          );

		          var spotMarker = new kakao.maps.Marker({
		            position: spotLatLng,
		            title: '${spot.name}',
		            image: pawMarkerImage
		          });

		          var spotInfo = new kakao.maps.InfoWindow({
		            content: '<div style="padding:5px; font-size:13px; font-weight:bold;">${spot.name}</div>'
		          });

		          kakao.maps.event.addListener(spotMarker, 'click', function() {
		            spotInfo.open(map, spotMarker);
		          });
		          
		          touristMarkers.push(spotMarker);
		        </c:forEach>
		    } 
		});    
	
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
        
        // 클릭 vs 드래그 판별 로직
        let isDragging = false;
        let dragStart = null;

        const mapElement = document.getElementById('map');

        mapElement.addEventListener('mousedown', function (e) {
          isDragging = false;
          dragStart = { x: e.clientX, y: e.clientY };
        });

        mapElement.addEventListener('mouseup', function (e) {
          const dx = Math.abs(e.clientX - dragStart.x);
          const dy = Math.abs(e.clientY - dragStart.y);
          const distance = Math.sqrt(dx * dx + dy * dy);

          // 드래그로 판정할 정도로 움직이지 않았으면 클릭으로 처리
          if (distance < 5) {
            openHotelModalMap();
          }
        });

        // 모달 열기 함수로 분리
        function openHotelModalMap() {
          document.getElementById('modalMapContainer').style.display = 'block';

          var mapContainer = document.getElementById('modalMap');
          var modalMap = new kakao.maps.Map(mapContainer, {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
          });

          var geocoder = new kakao.maps.services.Geocoder();
          geocoder.addressSearch('${vo.address}', function (result, status) {
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

              modalMap.setCenter(coords);
              
              // 관광지 마커
              <c:forEach var="spot" items="${touristList}">
                var modalSpotLatLng = new kakao.maps.LatLng(${spot.lat}, ${spot.lng});
                var pawMarkerImage = new kakao.maps.MarkerImage(
                  "${ctp}/images/paw_marker.png",
                  new kakao.maps.Size(40, 40)
                );

                var modalSpotMarker = new kakao.maps.Marker({
                  map: modalMap,
                  position: modalSpotLatLng,
                  title: '${spot.name}',
                  image: pawMarkerImage
                });

                var modalSpotInfo = new kakao.maps.InfoWindow({
                  content: '<div style="padding:5px; font-size:13px; font-weight:bold;">${spot.name}</div>'
                });

                kakao.maps.event.addListener(modalSpotMarker, 'click', function() {
                  modalSpotInfo.open(modalMap, modalSpotMarker);
                });
              </c:forEach>
            }
          });
        }
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
    
    // 관광지 마커를 따로 관리할 배열
    var touristMarkers = [];
    let tourVisible = false;

    // 관광지 버튼 클릭 이벤트 설정
    document.addEventListener("DOMContentLoaded", function () {
	  const tourBtn = document.getElementById('TOUR');
	  if (tourBtn) {
	    tourBtn.addEventListener('click', function () {
	      if (!tourVisible) {
	        <c:forEach var="spot" items="${touristList}">
	          var coords = new kakao.maps.LatLng(parseFloat("${spot.lat}"), parseFloat("${spot.lng}"));
	          var markerImage = new kakao.maps.MarkerImage(
	            '${ctp}/images/paw_marker.png',
	            new kakao.maps.Size(40, 40)
	          );
	
	          var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            title: '${spot.name}',
	            image: markerImage
	          });
	
	          var info = new kakao.maps.InfoWindow({
	            content: '<div style="padding:5px; font-size:13px; font-weight:bold;">${spot.name}</div>'
	          });
	
	          kakao.maps.event.addListener(marker, 'click', function() {
	            info.open(map, marker);
	          });
	
	          touristMarkers.push(marker);
	        </c:forEach>
	        tourVisible = true;
	      } else {
	        touristMarkers.forEach(function(marker) {
	          marker.setMap(null);
	        });
	        touristMarkers = [];
	        tourVisible = false;
	      }
	    });
	  }
	});
</script>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>