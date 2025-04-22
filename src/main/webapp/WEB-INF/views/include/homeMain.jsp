<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>homeMain.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkMain.css"/>
	<style>
		ul, li {
			text-decoration: none;
			list-style: none;
		}
				
		body.modal-open {
  		padding-right: 0 !important;
		}
		
		.nav-container {
		  display: grid;
		  grid-template-columns: auto 1fr auto;
		  align-items: center;
		  padding: 20px;
		  max-width: 1400px;
		  margin: 0 auto;
		}
		
		.hero {
			width: 1400px;
			background-repeat: no-repeat;
		  background-image: url("https://cdn.pixabay.com/photo/2023/09/25/10/46/krka-8274679_960_720.jpg");
		  background-size: cover;
		  background-position: center;
		  color: white;
		  padding: 100px 0;
		  margin: 45 auto 0 auto;
		  border: background;
		  border-radius: 20px;
		}

		/* Style The Dropdown Button */
		.dropbtn {
		  color: black;
		  padding: 16px;
		  font-size: 16px;
		  border: none;
		  cursor: pointer;
		}
		
		/* The container <div> - needed to position the dropdown content */
		.dropdown {
		  position: relative;
		  display: inline-block;
		}
		
		/* Dropdown Content (Hidden by Default) */
		.dropdown-content {
		  display: none;
		  position: absolute;
		  background-color: #f9f9f9;
		  min-width: 160px;
		  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		  z-index: 1;
		}
		
		/* Links inside the dropdown */
		.dropdown-content a {
		  color: black;
		  padding: 12px 16px;
		  text-decoration: none;
		  display: block;
		}
		
		/* Change color of dropdown links on hover */
		.dropdown-content a:hover {background-color: #f1f1f1}
		
		/* Show the dropdown menu on hover */
		.dropdown:hover .dropdown-content {
		  display: block;
		}
		
		/* Change the background color of the dropdown button when the dropdown content is shown */
		.dropdown:hover .dropbtn {
		  background-color: #eee;
		}
	</style>
</head>
<body>
<nav>
  <div class="nav-container">
    <a href="${ctp}/" class="logo" style="display:flex; line-height: 80px;"><img src="${ctp}/images/logo.png" width="80px"/>withPet</a>
    <ul class="nav-links">
    	<li>
      	<a href="${ctp}/hotel/hotelInput">숙박시설 등록</a>
      </li>
      <c:if test="${empty sessionScope.sLogin}">
	      <li>
	      	<a href="${ctp}/member/memberLogin">로그인</a>
	      </li>
      </c:if>
      <c:if test="${sMid == 'admin'}">
	      <li>
	      	<a href="${ctp}/admin/adminMain">관리자</a>
	      </li>
      </c:if>
      <!-- 로그인 상태일 때만 로그아웃 & 마이페이지 표시 -->
			<c:if test="${not empty sessionScope.sLogin}">
		  	<li class="nav-item">
		    	<a class="nav-link" href="${ctp}/member/memberLogout">로그아웃</a>
		  	</li>
			  <li class="nav-item">
			    <a class="nav-link" href="${ctp}/member/memberMyPage">마이페이지</a>
			  </li>
			</c:if>
	    <li class="nav-item dropdown">
        <a class="nav-link dropbtn" href="#" role="button" data-bs-toggle="modal" data-bs-target="#myModal3" id="customButton3">고객센터</a>
        <div class="dropdown-content">
			    <a class="dropdown-item" href="${ctp}/inquiry/inquiryList">1:1문의</a>
          <a class="dropdown-item" href="${ctp}/admin/inquiry/adInquiryList">1:1문의(관리자답변)</a>
          <a class="dropdown-item" href="${ctp}/faq/faqList">FAQ</a>
          <a class="dropdown-item" href="${ctp}/qna/qnaList">Q&A</a>
				</div>
      </li>
    </ul>
   </div>
</nav>

<section class="hero">
  <div class="hero-content">
    <div class="hero-text">
      <h2>다음엔 어디로 떠나세요?(호텔리스트)</h2>
      <p></p>
      <div class="row hero-row">
      	<div class="col">
      		<a href="${ctp}/hotel/hotelList" class="cta-button">어디로 가시나요?</a>
      		<button id="cta-button" class="me-3" data-bs-toggle="modal" data-bs-target="#myModal1">테스트중</button>
      	</div>
      </div>
    </div>
    <div class="hero-image">
    </div>
  </div>
</section>

<section class="featured">
  <div class="container">
    <div class="section-header">
      <h2>편하고 쾌적한 숙소</h2>
      <p>여유롭게 즐길 수 있는 시설을 찾아드려요.</p>
    </div>
    <div class="product-grid">
      <div class="product-card">
        <div class="product-image">
          <img src="${ctp}/images/hotel1.jpg" alt="" />
        </div>
        <div class="product-info">
          <span class="product-tag">9.7</span>
          <h3 class="product-title">시그니엘 부산</h3>
          <p>부산</p>
          <div class="product-price">
            <span class="price">₩369,000</span>
            <button class="add-to-cart" style="font-size: 0.8em; width: 80px; border-radius: 10%;">20%할인</button>
          </div>
        </div>
      </div>
      <div class="product-card">
        <div class="product-image">
          <img src="${ctp}/images/hotel2.jpg" alt="" />
        </div>
        <div class="product-info">
          <span class="product-tag">10.0</span>
          <h3 class="product-title">신라스테이 해운대 벡스코</h3>
          <p>부산</p>
          <div class="product-price">
            <span class="price">₩340.950</span>
            <button class="add-to-cart" style="font-size: 0.8em; width: 80px; border-radius: 10%;">회원가 제공</button>
          </div>
        </div>
      </div>
      <div class="product-card">
        <div class="product-image">
          <img src="${ctp}/images/hotel3.jpg" alt="" />
        </div>
        <div class="product-info">
          <span class="product-tag">9.0</span>
          <h3 class="product-title">ENA 스위트 호텔 남대문</h3>
          <p>서울</p>
          <div class="product-price">
            <span class="price">₩490,803</span>
            <button class="add-to-cart" style="font-size: 0.8em; width: 80px; border-radius: 10%;">31%할인</button>
          </div>
        </div>
      </div>
      <div class="product-card">
        <div class="product-image">
          <img src="${ctp}/images/hotel4.jpg" alt="" />
        </div>
        <div class="product-info">
          <span class="product-tag">8.1</span>
          <h3 class="product-title">메종 글래드 제주</h3>
          <p>제주시</p>
          <div class="product-price">
            <span class="price">₩528,338</span>
            <button class="add-to-cart" style="font-size: 0.8em; width: 80px; border-radius: 10%;">회원가 제공</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="benefits">
  <div class="container">
    <div class="section-header">
      <h2>위드펫의 혜택정보</h2>
      <p>반려동물과 꿈꾸는 숙박이 무엇이든 회원가로 할인받으세요.</p>
    </div>
    <div class="benefits-grid">
      <div class="benefit-card">
        <div class="benefit-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
          </svg>
        </div>
        <h3 class="benefit-title">럭셔리 호텔을 더 저렴하게</h3>
        <p>수준은 높게, 가격은 저렴하게 즐길 수 있는 호텔을 만나보세요.</p>
      </div>
      <div class="benefit-card">
        <div class="benefit-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
          </svg>
        </div>
        <h3 class="benefit-title">리워드 혜택</h3>
        <p>위드펫 리워드로 10박 숙박 시 리워드 1박</p>
      </div>
      <div class="benefit-card">
        <div class="benefit-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
            <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
            <line x1="12" y1="22.08" x2="12" y2="12"></line>
          </svg>
        </div>
        <h3 class="benefit-title">호텔링 체험</h3>
        <p>호텔에서 제공하는 반려동물 호텔링 서비스도 체험해보세요.</p>
      </div>
      <div class="benefit-card">
        <div class="benefit-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
            <polyline points="22 4 12 14.01 9 11.01"></polyline>
          </svg>
        </div>
        <h3 class="benefit-title">멋진 후기를 남겨보세요!</h3>
        <p>월마다 멋진 리뷰를 추첨하여 할인쿠폰을 제공합니다.</p>
      </div>
    </div>
  </div>
</section>

<section class="collections">
  <div class="container">
    <div class="section-header">
      <h2>나에게 꼭 맞는 추천 숙소리스트</h2>
      <p>현재 월 기준 평균 요금</p>
    </div>
    <div class="collections-grid">
      <div class="collection-item">
        <div class="collection-bg" style="background-image: url('${ctp}/images/hotel5.jpg')"></div>
        <div class="collection-overlay">
          <h3 class="collection-title">호텔이름1</h3>
          <p>강릉,한국</p>
          <a href="#" class="collection-link">￦65,347 →</a>
        </div>
      </div>
      <div class="collection-item">
        <div class="collection-bg" style="background-image: url('${ctp}/images/hotel6.jpg')"></div>
        <div class="collection-overlay">
          <h3 class="collection-title">호텔이름2</h3>
          <p>속초,한국</p>
          <a href="#" class="collection-link">￦44,917 →</a>
        </div>
      </div>
      <div class="collection-item">
        <div class="collection-bg" style="background-image: url('${ctp}/images/hotel7.jpg')"></div>
        <div class="collection-overlay">
          <h3 class="collection-title">호텔이름3</h3>
          <p>부산,한국</p>
          <a href="#" class="collection-link">￦69,373 →</a>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="reviews">
  <div class="container">
    <div class="section-header">
      <h2>고객 리뷰</h2>
      <p>내맘에 쏙 드는 체험</p>
    </div>
    <div class="reviews-grid">
      <div class="review-card">
        <div class="review-quote">"</div>
        <div class="stars">
          ★★★★★
        </div>
        <p class="review-text">경치좋고 풍경좋습니다.나이스.<br/>편안히 쉬다 갑니다.</p>
        <div class="review-author">
          <div class="author-avatar">
            <img src="https://assets.codepen.io/406785/avatar3.webp" alt="" />
          </div>
          <div class="author-info">
            <h4>Sarah M.</h4>
            <p>메종호텔</p>
          </div>
        </div>
      </div>
      <div class="review-card">
        <div class="review-quote">"</div>
        <div class="stars">
          ★★★★★
        </div>
        <p class="review-text">경치좋고 풍경좋습니다.나이스.<br/>편안히 쉬다 갑니다.</p>
        <div class="review-author">
          <div class="author-avatar">
            <img src="https://assets.codepen.io/406785/avatar2.jpg" alt="" />
          </div>
          <div class="author-info">
            <h4>David L.</h4>
            <p>산수유호텔</p>
          </div>
        </div>
      </div>
      <div class="review-card">
        <div class="review-quote">"</div>
        <div class="stars">
          ★★★★★
        </div>
        <p class="review-text">경치좋고 풍경좋습니다.나이스.<br/>편안히 쉬다 갑니다.</p>
        <div class="review-author">
          <div class="author-avatar">
            <img src="https://assets.codepen.io/406785/avatar1.jpg" alt="" />
          </div>
          <div class="author-info">
            <h4>Emma T.</h4>
            <p>멍동반호텔</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="newsletter">
  <div class="newsletter-container">
    <div>
      <h2>로그인</h2>
      <p>회원가입시 국내 애견동반 호텔의 모든 서비스를 10% 싼 가격으로 체험할 수 있습니다.</p>
    </div>
    <form class="newsletter-form">
      <input type="email" placeholder="Your email address">
      <button type="submit">로그인하여<br/>숙소찾기</button>
    </form>
  </div>
</section>
<footer>
  <div class="container">
    <div class="footer-grid">
      <div class="footer-about">
        <a href="#" class="footer-logo">withPet</a>
        <p>반려동물 동반 호텔 예약사이트</p>
        <div class="social-icons">
          <a href="#" class="social-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path>
            </svg>
          </a>
          <a href="#" class="social-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
              <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
              <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
            </svg>
          </a>
          <a href="#" class="social-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path>
            </svg>
          </a>
        </div>
      </div>
      <div class="footer-links">
        <h3>메뉴1</h3>
        <ul>
          <li><a href="#">All Products</a></li>
          <li><a href="#">New Arrivals</a></li>
          <li><a href="#">Best Sellers</a></li>
          <li><a href="#">Gift Sets</a></li>
        </ul>
      </div>
      <div class="footer-links">
        <h3>메뉴2(About)</h3>
        <ul>
          <li><a href="#">Our Story</a></li>
          <li><a href="#">Sustainability</a></li>
          <li><a href="#">Ingredients</a></li>
          <li><a href="#">Blog</a></li>
        </ul>
      </div>
      <div class="footer-links">
        <h3>메뉴3(Help)</h3>
        <ul>
          <li><a href="#">Contact Us</a></li>
          <li><a href="#">Shipping & Returns</a></li>
          <li><a href="#">FAQs</a></li>
          <li><a href="#">Track Order</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      <p>© 2025 withPet All rights reserved. | Designed in Korea</p>
    </div>
  </div>
</footer>
</body>
</html>