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

INSERT INTO tourist_spot (hotelIdx, name, lat, lng, address, description) VALUES
(2, '덕수궁', '37.5655638710672', '126.974894754989', '서울 중구 세종대로 99', '조선시대 궁궐로 반려견 동반 산책이 가능합니다.'),
(2, '덕수궁돌담길', '37.564976582796', '126.975664628917', '서울 중구 정동길', '감성 가득한 산책길로 유명하며 반려견 동반이 가능합니다.'),
(2, '명동거리', '37.5620769169639', '126.984901336292', '서울 중구 명동', '쇼핑과 음식으로 유명한 거리로 반려견과 산책하기 좋습니다.');

