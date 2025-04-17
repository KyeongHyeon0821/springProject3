<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mainModal.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script>
		'use strict';
		$()
		
		function myInputReset() {
			$("#myInput").val("");
			$("#myInput").focus();
		} 
	</script>
	<style>
		.modal-backdrop {
			background-color: transparent;
			opacity: 0;
		}
		.custom-modal-position {
			position: absolute;
			top: var(--modal-top, 0);
			left: var(--modal-left, 0);
			margin: 0;
			transform: none;
		}
		
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>메인 모달</h2>
  <div class="row">
  	<div class="col">
	  	<button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#myModal1">
  			어디로 가세요?
			</button>
		</div>
	</div>
</div>
<hr/>



<!-- modal1 -->
<div class="modal" id="myModal1">
	<div class="modal-dialog modal-dialog-scrollable custom-modal-position">
		<div class="modal-content">
			
			<!-- modal header -->
			<div class="modal-header">
				<input type="text" id="myInput" class="input-group" placeholder="어디로 가세요?">
				<button type="button" id="myBtn" class="btn" onclick="myInputReset()">X</button>
			</div>
			
			<!-- modal body -->
			<div class="modal-body">
        <h3>Some text to enable scrolling..</h3>
        <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>

        <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p> 
      </div>
			
			<!-- modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">close</button>
			</div>	
		</div>
	</div>
</div>







<p><br/></p>
<script>
	'use strict';
	  var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
	  var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
	    return new bootstrap.Popover(popoverTriggerEl)
	  })
</script>
</body>
</html>