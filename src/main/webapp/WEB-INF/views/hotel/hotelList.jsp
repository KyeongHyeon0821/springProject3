<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hotelList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script>
		'use strict';
		
		// 호텔 찜 추가하기
		function hotelLikeOk(hotelIdx) {
			let mid = '${sMid}';
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
						$("#likeImg" + hotelIdx).attr("src", "${ctp}/images/heartRed.png");
						$("#likeFn" + hotelIdx).attr("href", "javascript:hotelLikeNo(" + hotelIdx + ")");
						location.reload();
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
		
		// 호텔 찜 취소하기
		function hotelLikeNo(hotelIdx) {
			let mid = '${sMid}';
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
						$("#likeImg" + hotelIdx).attr("src", "${ctp}/images/heartBlack.png");
						$("#likeFn" + hotelIdx).attr("href", "javascript:hotelLikeNo(" + hotelIdx + ")");
						location.reload();
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
	</script>
	<style>
		/* 컨테이너: 카드 그리드 레이아웃 */
		.hotel-list-container {
		  display: grid;
		  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
		  gap: 24px;
		  padding: 20px;
		  max-width: 1000px;
		  margin: 0 auto;
		}
		
		/* 호텔 카드 전체 */
		.hotel-card {
		  background-color: #f9f9fc; /* 연한 회색 */
		  border-radius: 12px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		  overflow: hidden;
		  transition: transform 0.2s ease, box-shadow 0.2s ease;
		  display: flex;
		  flex-direction: column;
		  height: 100%;
		}
		
		/* 이미지 영역 */
		.hotel-image img {
		  width: 100%;
		  height: 200px;
		  object-fit: cover;
		}
		
		/* 카드 본문 */
		.hotel-details {
		  padding: 16px;
		  flex: 1;
		  position: relative;
		}
		
		/* 호텔 이름 + 하트 정렬 */
		.hotel-header {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  margin-bottom: 10px;
		  position: relative;
  		margin-bottom: 10px;
		}
		
		/* 호텔 이름 */
		.hotel-name {
			padding-right: 28px;
		  flex: 1;
		}
		
		.hotel-name a {
		  font-size: 18px;
		  font-weight: 700;
		  color: #333;
		  text-decoration: none;
		  line-height: 1.4;
		  display: -webkit-box;
		  -webkit-line-clamp: 2; /* 최대 2줄로 표시 */
		  -webkit-box-orient: vertical;
		  overflow: hidden;
		  text-overflow: ellipsis;
		  word-break: break-word;
		}
		
		.hotel-name a:hover {
		  color: #0077cc;
		}
		
		/* 하트 아이콘 */
		.heart-icon {
		  width: 20px;
		  height: 20px;
		  margin-left: 8px;
		  flex-shrink: 0;
		}
		
		/* 주소/연락처 */
		.hotel-review,
		.hotel-address,
		.hotel-tel {
		  font-size: 14px;
		  color: #555;
		  margin-top: 8px;
		}
		
		.heart-icon {
		  position: absolute;
		  top: 0;
		  right: 0;
		  width: 20px;
		  height: 20px;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="hotel-list-container">
  <c:forEach var="vo" items="${vos}">
    <div class="hotel-card">
      <div class="hotel-image">
        <img src="${ctp}/hotelThumbnail/s_${vo.thumbnail}" alt="${vo.name}">
      </div>
      <div class="hotel-details">
        <div class="hotel-header">
          <h3 class="hotel-name">
            <a href="${ctp}/hotel/hotelDetail?idx=${vo.idx}">${vo.name}</a>
          </h3>
          <!-- 찜 아이콘 -->
          <c:set var="isLiked" value="false" />
          <c:forEach var="likedIdx" items="${likedHotelListIdx}">
            <c:if test="${likedIdx == vo.idx}">
              <c:set var="isLiked" value="true" />
            </c:if>
          </c:forEach>
          <c:choose>
            <c:when test="${isLiked}">
              <a id="likeFn${vo.idx}" href="javascript:hotelLikeNo(${vo.idx})">
                <img id="likeImg${vo.idx}" src="${ctp}/images/heartRed.png" class="heart-icon" />
              </a>
            </c:when>
            <c:otherwise>
              <a id="likeFn${vo.idx}" href="javascript:hotelLikeOk(${vo.idx})">
                <img id="likeImg${vo.idx}" src="${ctp}/images/heartBlack.png" class="heart-icon" />
              </a>
            </c:otherwise>
          </c:choose>
        </div>
        <span class="hotel-review"><input class="btn btn-success btn-sm" value="4.5" style="width:40px"><font class="ms-2" color="blue">${vo.reviewTotal}</font><font class="ms-2">개의 후기</font></span>
        <p class="hotel-address">${vo.address}</p>
        <p class="hotel-tel">${vo.tel}</p>
      </div>
    </div>
  </c:forEach>
</div>
</body>
</html>