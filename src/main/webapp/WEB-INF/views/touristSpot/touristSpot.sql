create table tourist_spot (
  idx int auto_increment primary key,	-- 관광지 고유번호
  name varchar(50),						-- 관광지 이름
  lat varchar(30),         				-- 위도
  lng varchar(30),         				-- 경도
  address varchar(100),					-- 관광지 주소
  description text,   					-- 관광지 설명
  feature text         					-- 특징 (ex: 역사적, 가족추천, 사진명소 등)
);

show tables;