show tables;
create table member (
   idx         int not null auto_increment,
   mid         varchar(20) not null,
   pwd         varchar(100) not null,
   nickName   varchar(20) not null,
   name      varchar(10) not null,
   gender      char(2)      not null default '남자',
   birthday   datetime default now(),
   tel         varchar(15) not null,
   address      varchar(100),
   email      varchar(50) not null,
   userDel      char(2) default 'NO',
   level      int default 2,
   primary key (idx),
   unique key (mid)
);
insert into member values(default, 'admin', '1234', '관리자', '관리맨', '남자', '1996-08-21', '010-1111-1234', '청주', 'yd12321@naver.com', default, 0);
select * from member;

--------------------------------------------------------


/* 호텔 테이블 */
create table hotel(
	idx int auto_increment,							/* 호텔 아이디 */
	mid varchar(20) not null,						/* 호텔 등록자 아이디 */
	name varchar(100) not null,				  /* 호텔 이름 */
	address varchar(200) not null,			/* 호텔 주소 */
	tel varchar(20),										/* 호텔 연락처 */
	description text,										/* 호텔 소개글 */
	thumbnail varchar(100) not null,		/* 호텔 썸네일 이미지 */
	images text,												/* 호텔 이미지 */
	regDate datetime default now(), 		/* 등록 날짜 */
	primary key(idx),
	foreign key(mid) references member(mid)
);
select * from hotel;
insert into hotel values(default, 'admin', '롯데시티호텔 명동', '서울 중구 삼일대로 362', '02-6112-1000', '롯데시티호텔명동은 서울 시내 비즈니스와 쇼핑의 중심지인 명동과 서울의 오아시스인 청계천 사이에 위치하고 있으며, 27층 규모의 탁 트인 전망과 430의 객실과 멀티 스타일리시 뷔페 레스토랑, 미팅룸, 피트니스 등을 갖춘 프리미엄 비즈니스호텔입니다. 성공적인 비즈니스와 만족스런 여행을 위한 최고의 실용성과 차별화된 서비스, 합리적인 가격으로 비즈니스 고객과 레저여행객 모두에게 잊지 못할 추억을 선사합니다.', '롯데시티호텔명동.jpg',null, default);
insert into hotel values(default, 'admin', '소테츠호텔즈 더 스프라지르 서울 명동', '서울 중구 남대문로5길 15', '02-772-0900', '서울 비즈니스 구역 중심에 위치한 ''소테츠 호텔즈 더 스프라지르 서울 명동''은 ''지하철 4호선 회현역 7번출구''와 ''지하철 1, 2호선 시청역 7번출구''에서 도보 7분 내에 위치하고 있어 서울의 주요 관광지와 명소에 편리하게 이동할 수 있으며, 공항 리무진 버스를 타고 70분 안에 인천국제공항에 도착할 수 있습니다.', '소테츠호텔.jpg', null, default);

/* 호텔 이미지 테이블 */
create table hotelImage(
	idx int auto_increment,								/* 이미지 아이디 */
	hotelIdx int not null,								/* 연결된 호텔 아이디 */
	imageName varchar(100) not null,			/* 이미지 이름 */
	isThumbnail char(1) default 'N',			/* 썸네일 여부 ('Y', 'N') */
	primary key(idx),
	foreign key(hotelIdx) references hotel(idx) on delete cascade
);
drop table hotelImage;
select * from hotelImage;
insert into hotelImage values(default, 1, '롯데시티호텔명동.jpg', 'Y');
insert into hotelImage values(default, 2, '소테츠호텔.jpg', 'Y');

/* 호텔 객실 테이블 */
create table room(
	idx int auto_increment,						/* 객실 아이디 */
	hotelIdx int not null,						/* 연결된 호텔 아이디 */
	name varchar(50) not null,				/* 객실명 */
	price int not null,								/* 객실 1박 요금 */
	maxPeople int not null,						/* 최대 인원 수 */
	petSizeLimit varchar(10),					/* 반려견 크기 제한 (소형/중형/대형) */
	petCountLimit int default 1,			/* 최대 반려견 수 */
	image text,												/* 객식 이미지 */
	regDate datetime default now(),		/* 등록 날짜 */
	primary key(idx),
	foreign key(hotelIdx) references hotel(idx)
);


/* 객실 이미지 테이블 */
create table roomImage (
  idx       int auto_increment,   						  /* 이미지 아이디 */
  roomIdx   int not null,                    		/* 객실 아이디 */
  imageName varchar(200) not null,            	/* 이미지 이름 */
  regDate   datetime default now(),
  primary key(idx),
  foreign key(roomIdx) references room(idx) on delete cascade
);




/* 예약 테이블 */
CREATE TABLE reservation (
  id            INT AUTO_INCREMENT PRIMARY KEY,         /* 예약 고유 ID */
  user_id       VARCHAR(20) NOT NULL,                   /* 예약한 회원 ID */
  room_id       INT NOT NULL,                           /* 예약한 객실 ID */
  checkin_date  DATE NOT NULL,                          /* 체크인 날짜 */
  checkout_date DATE NOT NULL,                          /* 체크아웃 날짜 */
  status        VARCHAR(20) DEFAULT '예약완료',       		  /* 예약 상태 (예약완료, 취소됨 등) */
  regDate       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    /* 예약 등록일 */
  FOREIGN KEY (user_id) REFERENCES user(userid) ON DELETE CASCADE,
  FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE CASCADE
);