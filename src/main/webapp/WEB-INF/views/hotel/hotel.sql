show tables;
create table member (
   idx         int not null auto_increment,         /* 회원 고유번호 */
   mid         varchar(20) not null,               /* 아이디(중복불허/수정가능) */
   pwd         varchar(100) not null,               /* 비밀번호(BCryptPasswordEncoder) */
   nickName   varchar(20) not null,               /* 닉네임(중복불허/수정가능) */
   name      varchar(10) not null,               /* 성명(수정불가능) */
   gender      char(2)      not null default '남자',      /* 성별(수정불가능) */
   birthday   datetime default now(),               /* 생일 */
   tel         varchar(15),                     /* 전화번호 */
   address      varchar(100),                     /* 주소(다음 우편번호 API 사용) */
   email      varchar(50) not null,               /* 이메일(회원가입시 인증 또는 '아이디/비밀번호'분실시 사용 - 정규식 필수 체크 */
   userDel      char(2) default 'NO',               /* 회원 탈퇴신청여부(NO:현재 활동중, OK:탈퇴신청중) */
   level      int default 2,                     /* 회원등급(0:관리자, 1:사업자회원, 2:일반회원) */
   businessNo  varchar(20),                     /* 사업자등록번호(수정불가능) */
   userInfor    varchar(10) default '공개',            /* 정보 공개여부(공개/비공개) */
   primary key (idx),
   unique key (mid)
);
alter table member add businessNo varchar(20);

alter table member add userInfor varchar(10) default '공개';

insert into member values(default, 'admin', '1234', '관리자', '관리맨', '남자', '1996-08-21', '010-1111-1234', '청주', 'yd12321@naver.com', default, 0);
select * from member;

--------------------------------------------------------


/* 호텔 테이블 */
create table hotel(
	idx int auto_increment,							/* 호텔 번호 */
	mid varchar(20) not null,						/* 호텔 등록자 아이디 */
	name varchar(100) not null,				  /* 호텔 이름 */
	address varchar(200) not null,			/* 호텔 주소 */
	tel varchar(20),										/* 호텔 연락처 */
	description text,										/* 호텔 소개글 */
	thumbnail varchar(100) not null,		/* 호텔 썸네일 이미지 */
	images text,												/* 호텔 이미지 */
	regDate datetime default now(), 		/* 등록 날짜 */
	status varchar(20) default '정상',		/* 호텔 상태 (정상/등록취소요청/비활성화/등록취소완료) */
	primary key(idx),
	foreign key(mid) references member(mid)
);
alter table hotel add column status varchar(20) default '정상';
select * from hotel;
insert into hotel values(default, 'admin', '롯데시티호텔 명동', '서울 중구 삼일대로 362', '02-6112-1000', '롯데시티호텔명동은 서울 시내 비즈니스와 쇼핑의 중심지인 명동과 서울의 오아시스인 청계천 사이에 위치하고 있으며, 27층 규모의 탁 트인 전망과 430의 객실과 멀티 스타일리시 뷔페 레스토랑, 미팅룸, 피트니스 등을 갖춘 프리미엄 비즈니스호텔입니다. 성공적인 비즈니스와 만족스런 여행을 위한 최고의 실용성과 차별화된 서비스, 합리적인 가격으로 비즈니스 고객과 레저여행객 모두에게 잊지 못할 추억을 선사합니다.', '롯데시티호텔명동.jpg',null, default);
insert into hotel values(default, 'admin', '소테츠호텔즈 더 스프라지르 서울 명동', '서울 중구 남대문로5길 15', '02-772-0900', '서울 비즈니스 구역 중심에 위치한 ''소테츠 호텔즈 더 스프라지르 서울 명동''은 ''지하철 4호선 회현역 7번출구''와 ''지하철 1, 2호선 시청역 7번출구''에서 도보 7분 내에 위치하고 있어 서울의 주요 관광지와 명소에 편리하게 이동할 수 있으며, 공항 리무진 버스를 타고 70분 안에 인천국제공항에 도착할 수 있습니다.', '소테츠호텔.jpg', null, default);




/* 호텔 객실 테이블 */
create table room(
	idx int auto_increment,						/* 객실 번호 */
	hotelIdx int not null,						/* 연결된 호텔 아이디 */
	name varchar(50) not null,				/* 객실명 */
	price int not null,								/* 객실 1박 요금 */
	maxPeople int not null,						/* 최대 인원 수 */
	petSizeLimit varchar(10),					/* 반려견 크기 제한 (소형/중형/대형) */
	petCountLimit int default 1,			/* 최대 반려견 수 */
	thumbnail varchar(100) not null,	/* 객실 썸네일 이미지 */
	images text,											/* 객실 이미지 */
	status varchar(20) default '정상', /* 객실 상태 (정상/비활성화/삭제) */
	regDate datetime default now(),		/* 등록 날짜 */
	primary key(idx),
	foreign key(hotelIdx) references hotel(idx) on delete cascade
);


/* 옵션 테이블 */
create table option (
  idx int auto_increment,         /* 옵션 번호 */
  name varchar(50) not null,      /* 옵션 이름 */
  primary key (id)
);



/* 객실-옵션 연결 테이블 */
create table room_option (
  roomIdx int not null,							/* 객실 번호 */
  optionIdx int not null,						/* 옵션 번호 */
  primary key (roomIdx, optionIdx),
  foreign key (roomIdx) references room(idx) on delete cascade,
  foreign key (optionIdx) references option(idx) on delete cascade
);





/* 예약 테이블 */
create table reservation (
  idx           int auto_increment primary key,         /* 예약 번호	*/
  mid      		  varchar(20) not null,                		/* 예약한 회원 아이디 */
  roomIdx       int not null,                           /* 예약한 객실 번호 */
  checkinDate  date not null,                           /* 체크인 날짜 */
  checkoutDate date not null,                           /* 체크아웃 날짜 */
  status        varchar(20) default '대기중',     		    /* 예약 상태 (대기중, 예약완료, 예약취소) */
  regDate       datetime default now(), 						    /* 예약 등록일 */
  foreign key (mid) references member(mid) on delete cascade,
  foreign key (roomIdx) references room(idx) on delete cascade
);


/* 찜 테이블 */
create table hotelLike (
	idx int auto_increment primary key,				/* 찜 번호 */
	mid varchar(20) not null,									/* 찜한 회원 아이디 */
	hotelIdx int not null,										/* 찜한 호텔 아이디 */
	likedDate datetime default now(),					/* 찜한 날짜 */
	UNIQUE KEY (mid, hotelIdx),
	foreign key (mid) references member(mid) on delete cascade,
  foreign key (hotelIdx) references hotel(idx) on delete cascade
);

insert into hotelLike values(default, 'admin', 29, default);
select * from hotellike;

select idx from hotelLike where mid = 'admin';
