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
	</style>
	<script>
		'use strict';
		
		function hotelDeleteCheck() {
			let ans = confirm("해당 호텔 삭제 신청을 진행하시겠습니까?");
			if(!ans) return false;
			else location.href="hotelDeleteCheck?idx=${vo.idx}";
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>${vo.name}</h2>
	<h5>🏨 ${vo.address}</h5>
	<div><img src="${ctp}/hotelThumbnail/${vo.thumbnail}" title="${vo.name}" alt="대표이미지" width="400px"/></div>
	
	<div class="hotel-images">${vo.images}</div>
	
	<p>연락처 : ${vo.tel}</p>
	<div>호텔 소개</div>
	<div>${vo.description}</div>
	<p>위치 : ${vo.address}</p>
	<div id="map" style="width:100%;height:350px;"></div>
	
	<div class="mt-3">
		<a href="#" class="btn btn-outline-primary">객실 보기</a>
		<a href="#" class="btn btn-outline-success">리뷰 보기</a>
		<a href="${ctp}/hotel/hotelList" class="btn btn-info">돌아가기</a>
	</div>
	<%-- <c:if test="${vo.mid == sMid}"> --%>
		<a href="hotelUpdate?idx=${vo.idx}" class="btn btn-outline-warning">호텔 정보 수정</a>
		<a href="javascript:hotelDeleteCheck()" class="btn btn-outline-danger">호텔 등록 취소 요청</a>
<%-- 	</c:if> --%>

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
		
		console.log(document.getElementById('map')); // 지도 요소 확인
		
		//map.setDraggable(true); // 지도 드래그 막기
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
	</script>
	
	<!-- 지도 클릭 시 전체 화면을 열기 위한 스크립트 -->
	<script>
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
</script>
</body>
</html>