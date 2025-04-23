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
		.container {
			margin-top: 50px;
		}
	</style>
</head>
<body>
<c:if test="!${sLevel} == 0">
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
</c:if>
<div class="container">
	<h2>호 텔 리 스 트</h2>
	<hr class="border-secondary">
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<c:set var="hotelIdx" value="${vo.idx}" />
		<table class="table table-bordered mb-5">
			<tr>
				<th style="width:15%">대표사진</th><td><img src="${ctp}/hotelThumbnail/s_${vo.thumbnail}"/></td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<a href="${ctp}/hotel/hotelDetail?idx=${vo.idx}">${vo.name}</a>
					<!-- 찜 여부 체크용 변수-->
					<c:set var="isLiked" value="false" />
					<!-- 각 호텔의 아이디가 찜 목록에 있는 호텔 아이디에 포함되어 있는지 확인 -->
					<c:forEach var="likedIdx" items="${likedHotelListIdx}">
						<c:if test="${likedIdx == vo.idx}">
							<c:set var="isLiked" value="true" />
						</c:if>
					</c:forEach>
					<!-- 찜 여부에 따른 하트 이미지 -->
					<c:choose>
						<c:when test="${isLiked}">
							<a id="likeFn${vo.idx}" href="javascript:hotelLikeNo(${vo.idx})"><img id="likeImg${vo.idx}" src="${ctp}/images/heartRed.png" width="16px" /></a>
						</c:when>
						<c:otherwise>
							<a id="likeFn${vo.idx}" href="javascript:hotelLikeOk(${vo.idx})"><img id="likeImg${vo.idx}" src="${ctp}/images/heartBlack.png" width="16px" /></a>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>주소</th><td>${vo.address}</td>
			</tr>
			<tr>
				<th>연락처</th><td>${vo.tel}</td>
			</tr>
			<tr>
				<th>호텔소개</th>
				<td colspan="2">${vo.description}</td>
			</tr>
		</table>
	</c:forEach>
	<div>
		<input type="button" value="돌아가기" onclick="location.href='${ctp}/'" class="btn btn-warning"/>
	</div>
</div>
</body>
</html>