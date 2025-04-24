<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>roomList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
  	'use strict';
  	
  	// 등급별 화면 출력처리
  	function statusItemCheck() {
  		let level = $("#statusItem").val();
  		location.href = "hotelList?status=" + status;
  	
  	}
/*    	// 호텔 상태 변경처리
  	function statusChange(e) {
//  		alert(" value : " + myform.level.value);
//  		alert(" value : " + e.value);
//  		console.log("e",e);
			let ans = confirm("선택한 호텔의 상태를 변경하시겠습니까?");
			if(!ans) {
				location.reload();
				return false;
			}
			
			let items = e.value.split("/");
			let query = {
					level :items[0],
					idx : items[1]
			}
			
			$.ajax({
				url : "${ctp}/admin/hotelStatusChange",
				type : "post",
				data : query,
				success:function(res) {
					if(res != "0") {
						alert("상태 수정 완료!");
						location.reload();
					}
					else alert("상태 수정 실패");
				},
				error:function() { alert("전송오류!"); }
			});
  	} */ 
		
    // 클릭시 모달을 통해서 객실 상세정보 보여주기
    function roomDetail(idx, hotelIdx, name, price, maxPeople, petSizeLimit, petCountLimit, thumbnail, status, regDate) {
    	$("#myModal .modal-body .idx").html(idx);
    	$("#myModal .modal-body .hotelIdx").html(hotelIdx);
    	$("#myModal .modal-body .name").html(name);
    	$("#myModal .modal-body .price").html(price);
    	$("#myModal .modal-body .maxPeople").html(maxPeople);
    	$("#myModal .modal-body .petSizeLimit").html(petSizeLimit);
    	$("#myModal .modal-body .petCountLimit").html(petCountLimit);
    	$("#myModal .modal-body .thumbnail").html(thumbnail);
    	$("#myModal .modal-body .status").html(status);
    	$("#myModal .modal-body .regDate").html(regDate);
    } 
  	
    // 전체선택
    function allCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = true;
      }
    }

    // 전체취소
    function allReset() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = false;
      }
    }

    // 선택반전
    function reverseCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = !myform.idxFlag[i].checked;
      }
    }
    
     // 여러개의 객실 선택항목 등급변경처리
    function roomStatusSelectCheck() {
    	let idx = document.getElementById("idx");
    	let select = document.getElementById("statusSelect");
    	let statusSelect = select.options[select.selectedIndex].value;
    	let idxSelectArray = '';
    	
      for(let i=0; i<myform.idxFlag.length; i++) {
        if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value + "/";
      }
    	if(idxSelectArray == '') {
    		alert("상태를 변경할 항목을 1개 이상 선택하세요");
    		return false;
    	}
    	
    	let ans = confirm("선택한 항목의 상태를 "+statusSelect+"상태로 변경하시겠습니까?");
    	if(!ans) return false;
    	
      idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
      
      let query = {
    		  idxSelectArray : idxSelectArray,
    		  statusSelect : statusSelect
      }
      
      $.ajax({
    	  url  : "${ctp}/admin/room/roomStatusSelectCheck",
    	  type : "post",
    	  data : query,
    	  success:function(res) {
    		  if(res != "0") alert("선택한 항목(들)이 "+statusSelect+"(으)로 변경되었습니다.");
    		  else alert("상태변경 실패~");
  			  location.reload();
    	  },
    	  error : function() {
    		  alert("전송 실패~~");
    	  }
      });
    } 
  </script>
  <style>
  	body {
  		background-color: #F6F5F2;
  	}
    a {text-decoration: none}
    a:hover {
      text-decoration: underline;
      color: orange;
    }
    
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
<p><br/></p>
<div class="container">
  <h2>객실 리스트</h2>
  <div class="row mb-1">
    <div class="col-7">
	    <div class="input-group">
	      <input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm"/>
	      <input type="button" value="전체취소" onclick="allReset()" class="btn btn-primary btn-sm"/>
	      <input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm me-2"/>
	      <select name="statusSelect" id="statusSelect" class="form-select form-select-sm">  
	        <option>정상</option>
	        <option>예약</option>
	        <option>투숙</option>
	      </select>
	      <input type="button" value="선택항목등급변경" onclick="roomStatusSelectCheck()" class="btn btn-warning btn-sm" />
	    </div>
    </div>
    
  </div>
  
  <form name="myform">
  	<table class="table table-hover text-center border-secondary">
  		<tr class="table-secondary room-headLow">
  			<th>번호</th>
  			<th>호텔번호</th>
  			<th>방이름</th>
  			<th>가격</th>
  			<th>최대숙박인원</th>
  			<th>반려견크기제한</th>
  			<th>최대수용마리수</th>
  			<th>썸네일</th>
  			<th>상태</th>
  		</tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
        <tr class="room-low">
          <td><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/>
          	${vo.idx}
          </td>
          <td>${vo.hotelIdx}</td>
          <td><a href="#" onclick="roomDetail('${vo.idx}','${vo.hotelIdx}','${vo.name}','${vo.price}','${vo.maxPeople}','${vo.petSizeLimit}','${vo.petCountLimit}','${vo.thumbnail}','${vo.status}','${fn:substring(vo.regDate, 0, 10)}')" data-bs-toggle="modal" data-bs-target="#myModal" title="객실정보 상세보기">${vo.name}</a></td>
          <td>${vo.price}</td>
          <td>${vo.maxPeople}</td>
          <td>${vo.petSizeLimit}</td>
          <td>${vo.petCountLimit}</td>
          <td>${vo.thumbnail}</td>
          <td>
            <select name="status" id="status">
              <option value="1/${vo.idx}"   ${vo.status == '정상' ? 'selected' : ''}>정상</option>
              <option value="2/${vo.idx}"   ${vo.status == '예약' ? 'selected' : ''}>예약</option>
              <option value="3/${vo.idx}"   ${vo.status == '투숙' ? 'selected' : ''}>투숙</option>
            </select>
          </td>
        </tr>
      </c:forEach>
    </table>
  </form>
</div>


<!-- 모달처리 -->    
<div class="modal" id="myModal">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">객실 상세정보</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="container">
				<p></p>
					<div class="room-detail">
							<div class="room-items">
						    <img class="room-photo" src="${ctp}/images/lake.jpg" alt="객실 사진" style="width:200px;max-height:200px"/>
					    </div>
					    <div class="room-items">
						    <div class="room-info"><span class="room-label">객실고유번호:</span><span class="idx"></span></div>
						    <div class="room-info"><span class="room-label">호텔고유번호:</span><span class="hotelIdx"></span></div>
						    <div class="room-info"><span class="room-label">객실 명칭:</span><span class="name"></span></div>
						    <div class="room-info"><span class="room-label">가격:</span><span class="price"></span>₩</div>
						    <div class="room-info"><span class="room-label">최대숙박인원:</span><span class="maxPeople"></span></div>
						    <div class="room-info"><span class="room-label">반려견크기제한:</span><span class="petSizeLimit"></span></div>
						    <div class="room-info"><span class="room-label">최대마리수:</span><span class="petCountLimit"></span></div>
						    <div class="room-info"><span class="room-label">썸네일:</span><span class="thumbnail"></span></div>
						    <div class="room-info"><span class="room-label">상태:</span><span class="status"></span></div>
						    <div class="room-info"><span class="room-label">등록날짜:</span><span class="regDate"></span></div>
					    </div>
					    <p></p>
					</div>
					<div>
				  <!-- <a href="#" class="btn btn-success">목록으로</a>  --> 
				 	</div>
				</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>	


<p><br/></p>
</body>
</html>