<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>footer.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkMain.css"/>
	<style>
		
		footer {
		  background-color: #3F7D58;
		  color: white;
		  padding: 60px 0 30px;
		}
		
		.footer-logo {
		  font-size: 24px;
		  font-weight: bold;
		  color: black;
		  margin-bottom: 20px;
		  display: block;
		}
		
		.footer-links h3 {
		  margin-bottom: 20px;
		  font-size: 1.2rem;
		  color: black;
		}
		
		.footer-grid {
		  display: grid;
		  grid-template-columns: 2fr 1fr 1fr 1fr;
		  gap: 50px;
		  margin-bottom: 40px;
		}
		
		
		.footer-about p {
		  margin-bottom: 20px;
		  opacity: 0.8;
		}
		
		.social-icons {
		  display: flex;
		  gap: 15px;
		}
		
		.social-icon {
		  width: 40px;
		  height: 40px;
		  background-color: rgba(255, 255, 255, 0.1);
		  border-radius: 50%;
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  transition: background-color 0.3s;
		}
		
		.social-icon:hover {
		  background-color: #EF9651;
		}
		
		.footer-links h3 {
		  margin-bottom: 20px;
		  font-size: 1.2rem;
		  color: black;
		}
		
		.footer-links ul {
		  list-style: none;
		}
		
		.footer-links li {
		  margin-bottom: 10px;
		}
		
		.footer-links a {
		  color: white;
		  opacity: 0.8;
		  text-decoration: none;
		  transition: opacity 0.3s;
		}
		
		.footer-links a:hover {
		  opacity: 1;
		}
		
		.footer-bottom {
		  text-align: center;
		  padding-top: 30px;
		  border-top: 1px solid rgba(255, 255, 255, 0.1);
		  opacity: 0.7;
		  font-size: 0.9rem;
		}
		
		@media (max-width: 1024px) {
		  .benefits-grid {
		    grid-template-columns: repeat(2, 1fr);
		  }
		
		  .collections-grid {
		    grid-template-rows: repeat(3, 200px);
		  }
		
		  .collection-item:nth-child(1) {
		    grid-column: span 12;
		    grid-row: span 1;
		  }
		
		  .collection-item:nth-child(2) {
		    grid-column: span 6;
		    grid-row: span 1;
		  }
		
		  .collection-item:nth-child(3) {
		    grid-column: span 6;
		    grid-row: span 1;
		  }
		
		  .reviews-grid {
		    grid-template-columns: repeat(2, 1fr);
		  }
		}
		
		@media (max-width: 768px) {
		  .nav-container {
		    grid-template-columns: 1fr auto;
		  }
		
		  .nav-links {
		    display: none;
		  }
		
		  .hero-content,
		  .newsletter-container {
		    grid-template-columns: 1fr;
		    gap: 30px;
		  }
		
		  .footer-grid {
		    grid-template-columns: 1fr 1fr;
		  }
		
		  .reviews-grid {
		    grid-template-columns: 1fr;
		  }
		}
		
		@media (max-width: 576px) {
		  .footer-grid {
		    grid-template-columns: 1fr;
		  }
		
		  .collection-item:nth-child(2),
		  .collection-item:nth-child(3) {
		    grid-column: span 12;
		  }
		
		  .newsletter-form {
		    grid-template-columns: 1fr;
		  }
		
		  .benefits-grid {
		    grid-template-columns: 1fr;
		  }
		}
		
		@keyframes fadeIn {
		  from { opacity: 0; transform: translateY(20px); }
		  to { opacity: 1; transform: translateY(0); }
		}
		
		.animated {
		  animation: fadeIn 0.5s ease forwards;
		}
	</style>
</head>
<body>

<!-- Footer -->
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