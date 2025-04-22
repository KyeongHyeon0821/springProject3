<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<style>
		#map{border-radius: 5px;}
		.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
		.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
		.map_wrap {position:relative;width:100%;height:500px;}
		#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
		.bg_white {background:#fff;}
		#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
		#menu_wrap .option{text-align: center;}
		#menu_wrap .option p {margin:10px 0;}  
		#menu_wrap .option button {margin-left:5px; cursor: pointer;}
		#placesList li {list-style: none;}
		#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
		#placesList .item span {display: block;margin-top:4px;}
		#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
		#placesList .item .info{padding:10px 0 10px 55px;}
		#placesList .info .gray {color:#8a8a8a;}
		#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
		#placesList .info .tel {color:#009900;}
		#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
		#placesList .item .marker_1 {background-position: 0 -10px;}
		#placesList .item .marker_2 {background-position: 0 -56px;}
		#placesList .item .marker_3 {background-position: 0 -102px}
		#placesList .item .marker_4 {background-position: 0 -148px;}
		#placesList .item .marker_5 {background-position: 0 -194px;}
		#placesList .item .marker_6 {background-position: 0 -240px;}
		#placesList .item .marker_7 {background-position: 0 -286px;}
		#placesList .item .marker_8 {background-position: 0 -332px;}
		#placesList .item .marker_9 {background-position: 0 -378px;}
		#placesList .item .marker_10 {background-position: 0 -423px;}
		#placesList .item .marker_11 {background-position: 0 -470px;}
		#placesList .item .marker_12 {background-position: 0 -516px;}
		#placesList .item .marker_13 {background-position: 0 -562px;}
		#placesList .item .marker_14 {background-position: 0 -608px;}
		#placesList .item .marker_15 {background-position: 0 -654px;}
		#pagination {margin:10px auto;text-align: center;}
		#pagination a {display:inline-block;margin-right:10px;}
		#pagination .on {font-weight: bold; cursor: default;color:#777;}
	</style>
	<script>
		'use strict';
		
		
		// 호텔 등록 처리
		function fCheck() {
			let x = $("#x").val();
			console.log(x);
			
			// 유효성 체크
			let name = $("#name").val().trim();
			let address = $("#address").val().trim();
			let tel = $("#tel").val().trim();
			let thumbnailFile = $("#thumbnailFile").val(); // 썸네일 파일 이름
			let regTel = /^\d{2,4}-\d{3,4}-\d{4}$/; // 연락처 정규식 (2~4)-(3~4)-(4)
			
			if(name == "") {
				alert("호텔 이름을 입력해주세요.");
				$("#name").focus();
				return false;
			}
			else if (name.length > 100) {
	      alert("호텔 이름은 100자 이내로 입력해주세요.");
	      $("#name").focus();
	      return false;
	    }
			
			if (address == "") {
	      alert("호텔 주소를 입력해주세요.");
	      $("#address").focus();
	      return false;
	    } 
			else if (address.length > 200) {
	      alert("호텔 주소는 200자 이내로 입력해주세요.");
	      $("#address").focus();
	      return false;
	    }
			
			if(thumbnailFile == "") {
				alert("업로드할 썸네일 파일을 선택하세요");
				$("#thumbnailFile").focus();
				return false;
			}
			
			if(tel != "" && !regTel.test(tel)) {
				alert("전화번호 형식이 올바르지 않습니다.\n예: 02-123-4567, 010-1234-5678, 0505-123-4567");
			  $("#tel").focus();
			  return false;
			}
			else if (tel.length > 20) {
	      alert("호텔 연락처는 20자 이내로 입력해주세요.");
	      $("#tel").focus();
	      return false;
	    }
			
			// 썸네일 파일 용량 체크, 확장자 체크
			let ext = thumbnailFile.substring(thumbnailFile.lastIndexOf(".")+1).toLowerCase();
			let maxSize = 1024 * 1024 * 20; // 한번에 업로드할 파일의 최대용랑을 20mb로 한정
			
			let fileSize = document.getElementById("thumbnailFile").files[0].size;
			if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 20mb 입니다.");
				$("#thumbnailFile").focus();
				return false;
			}
			
			if(ext !="jpg" && ext !="gif" && ext !="png" && ext !="jpeg" && ext !="webp") {
				alert("업로드 가능 파일은 'jpg/gif/png/jpeg/webp' 입니다.");
				$("#thumbnailFile").focus();
				return false;
			}
			
			// 모든 조건 통과시
			return true;
		}
		
		// 썸네일 이미지 미리보기
		function thumbnailCheck(e) {
	    if(e.files && e.files[0]) {
	      let reader = new FileReader();
	      reader.onload = function(e) {
	        document.getElementById("thumbnailPreview").src = e.target.result;
	      }
	      reader.readAsDataURL(e.files[0]);
	    }
	  }
		
	</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<h2>🏨호 텔 등 록</h2>
	<hr class="border-secondary">
	
	<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div id="menu_wrap" class="bg_white">
      <div class="option">
        <div>
          <form onsubmit="searchPlaces(); return false;">
            키워드 : <input type="text" value="반려견 동반 호텔" id="keyword" size="15"> 
            <button type="submit">검색하기</button> 
          </form>
        </div>
      </div>
      <hr>
      <ul id="placesList"></ul>
      <div id="pagination"></div>
    </div>
	</div>
	
	<form name="hotelForm" method="post" onsubmit="return fCheck();" enctype="multipart/form-data">
    <table class="table table-bordered">
      <tr>
        <th>호텔 이름</th>
        <td><input type="text" name="name" id="name" placeholder="호텔 이름" required autofocus class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 주소</th>
        <td><input type="text" name="address" id="address" placeholder="호텔 주소" required class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 연락처</th>
        <td><input type="tel" name="tel" id="tel" placeholder="호텔 연락처" class="form-control"/></td>
      </tr>
      <tr>
        <th>호텔 소개</th>
        <td><textarea rows="6" name="description" id="description" class="form-control" placeholder="호텔 소개"></textarea></td>
      </tr>
      <tr>
        <th>대표 사진(썸네일)</th>
        <td><input type="file" name="thumbnailFile" id="thumbnailFile" onchange="thumbnailCheck(this)" required class="form-control" accept=".jpg,.gif,.png,.jpeg,.webp"/></td>
      </tr>
      <tr>
        <th>썸네일 미리보기</th>
        <td><img id="thumbnailPreview" width="150px"></td>
      </tr>
      <tr>
        <th>사진 등록</th>
        <td>
        	<div class="text-muted" style="margin-bottom:5px;">
			      ※ 사진만 등록 가능합니다. 여러 장의 이미지는 마우스로 드래그하여 추가할 수 있습니다.
			    </div>
        	<textarea rows="6" name="images" id="images" class="form-control"></textarea>
          <script>
            CKEDITOR.replace("images",{
            	height:450,
            	filebrowserUploadUrl:"hotelImageUpload?mid=admin",
            	uploadUrl:"hotelImageUpload?mid=admin" 
            });
          </script>
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="등록하기" class="btn btn-success me-2"/>
          <input type="reset" value="다시입력" class="btn btn-warning me-2"/>
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/';" class="btn btn-info"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" id="x" name="x">
		<input type="hidden" id="y" name="y">
  </form>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f5f016ee8ec4b87750154cd5e9d07dfb&libraries=services"></script>
<script>
	// 마커를 담을 배열입니다
	var markers = [];
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	// 키워드로 장소를 검색합니다
	searchPlaces();
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
	
	    var keyword = document.getElementById('keyword').value;
	
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);
	
	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);
	
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	
	    } else if (status === kakao.maps.services.Status.ERROR) {
	
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	
	    }
	}
	
	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);
	
	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title, placeinfo) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	            	displayInfowindow(marker, title);
	            });
	
	            kakao.maps.event.addListener(marker, 'click', function() {
	            	document.querySelector("#name").value = placeinfo.place_name
	            	document.querySelector("#address").value =placeinfo.road_address_name
	            	document.querySelector("#tel").value = placeinfo.phone
	            	document.querySelector("#x").value = placeinfo.x
	            	document.querySelector("#y").value = placeinfo.y
                document.querySelector("#name").focus();
	            	
	            });
	            
	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	
	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };
	
	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	            itemEl.onclick = function(){
	            	document.querySelector("#name").value = placeinfo.place_name
	            	document.querySelector("#address").value =placeinfo.road_address_name
	            	document.querySelector("#tel").value = placeinfo.phone
	            	document.querySelector("#x").value = placeinfo.x
	            	document.querySelector("#y").value = placeinfo.y
                document.querySelector("#name").focus();
	            }
	        })(marker, places[i].place_name, places[i]);
	
	        fragment.appendChild(itemEl);
	    }
	
	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}
	
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	
	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';
	
	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           
	
	    el.innerHTML = itemStr;
	    el.className = 'item';
	
	    return el;
	}
	
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 
	
	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	
	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;
	
	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }
	
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}
	
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}
	
	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}
</script>
</body>
</html>