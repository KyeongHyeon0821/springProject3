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

create table tourist_spot (
  idx int auto_increment primary key,        -- 관광지 고유번호
  hotelIdx int not null,                     -- 해당 호텔과 연관 (호텔 상세페이지용)
  name varchar(30) not null,                 -- 관광지 이름
  lat varchar(30) not null,                  -- 위도
  lng varchar(30) not null,                  -- 경도
  address varchar(200),                      -- 주소
  description text,                          -- 관광지 설명
  foreign key (hotelIdx) references hotel(idx) on delete cascade
);