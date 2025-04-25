-- 프로젝트용 (김아름) -- 


-- 고객 테이블 --
create table member (
   idx         int not null auto_increment,
   mid         varchar(20) not null,
   pwd         varchar(100) not null,
   nickName   varchar(20) not null,
   name      varchar(10) not null,
   gender      char(2) not null default '남자',
   birthday   datetime default now(),
   tel         varchar(15) not null,
   address      varchar(100),
   email      varchar(50) not null,
   userDel      char(2) default 'NO',
   level      int default 2,
   businessNo  varchar(20),
   userInfor char(3) default '공개',								/* 회원 정보 공개여부(공개/비공개) */
	 visitCnt	int default 0,											/* 총 방문수 */
	 todayCnt	int default 0,											/* 오늘 방문한 횟수 */
	 startDate datetime default now(),							/* 최초 가입일 */
	 lastDate datetime default now(),								/* 가장 나중에 방문한 날짜*/
   primary key (idx),
   unique key (mid)
);

desc member;
delete from member where mid ='lmr1234';
select * from member;
drop table member;

insert into member values (default, 'admin', '1234', '관리맨', '관리자','010-9366-7008','beorc8686@naver.com','여자','청주','1231231234',default,0,default,default,default,default,default,default);
insert into member values (default, 'atom', '1234', '아톰맨', '아톰','010-2127-9332','beorc8686@naver.com','여자','수원','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'tir8686', '1234', '티르맨', '티르', '010-5017-7008','tir8686@hanmail.net','여자','서울','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'btom', '1234', '비톰맨', '비톰','010-1234-1234','beorc8686@naver.com','남자','인천','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'ctom', '1234', '씨톰맨', '씨톰','010-1234-1234','beorc8686@naver.com','여자','제주','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'anuvis', '1234', '비누', '아누비스','010-1234-1234','tir8686@hanmail.net','여자','인천','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'genesiss', '1234', '제네', '제네시스','010-1234-1234','beorc8686@naver.com','여자','인천','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'sch1234', '1234', '춘향', '성춘향','010-1234-1234','beorc8686@naver.com','여자','부산','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'lmr1234', '1234', '몽룡', '이몽룡','010-1234-1234','beorc8686@naver.com','남자','서울','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'bangza1234', '1234', '방자맨', '방자','010-1234-1234','beorc8686@naver.com','남자','목포','1231231234',default,default,default,default,default,default,default,default);
insert into member values (default, 'hyangdan1234', '1234', '향단이', '향단','010-1234-1234','beorc8686@naver.com','여자','대전','1231231234',default,default,default,default,default,default,default,default);


select * from member where level = 2 or 2=99 or 2=999 order by idx desc;



-- option 테이블 --

create table options (
	idx int not null auto_increment,
	name varchar(50) not null,
	primary key (idx)
);






/* 신고테이블(complaint) */
create table complaint(
  idx  int not null auto_increment,			/* 신고테이블 고유번호 */
  part varchar(15) not null,						/* 신고 분류(게시판:board, 자료실:pds, 방명록:guest) */
  partIdx int not null,									/* 신고분류항목 글의 고유번호 */
  cpMid varchar(20) not null,						/* 신고자 아이디 */
  cpContent text not null,							/* 신고 사유 */
  cpDate datetime default now(),				/* 신고한 날짜 */
  progress varchar(10) default '신고접수',/* 진행상황 : '신고접수/처리완료(S)/처리완료(H)/처리완료(D)' S:문제없음(보이기), H:가리기, D:삭제하기 */
  primary key(idx),
  foreign key(cpMid) references member(mid)
);
desc complaint;



/*
 * 신고처리 테이블 : boardIdx필드와 pdsIdx필드 삭제후, partIdx필드(해당 part의 고유번호)추가, progress필드 추가
	// 신고 처리하기
	// complaintSw : H(감추기-보드테이블의 complaint필드값을 'HI' , complaint테이블의 progress필드값을 '처리완료(H)')
	// complaintSw : S(보이기-신고해제-board테이블의 complaint필드값을 'NO' , complaint테이블의 progress필드값을 '처리완료(S)')
	// complaintSw : D(삭제하기-board테이블의 해당레코드 삭제처리 , complaint테이블의 progress필드값을 '처리완료(D)')
*/


show tables;
drop table room;
drop table hotellike;
drop table hotel;
desc hotel;
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
	status varchar(20) default '정상',		/* 호텔 상태 (정상/등록취소요청/비활성화/등록취소완료) */
	x double,														/* 경도 */
	y double,														/* 위도 */
	primary key(idx),
	foreign key(mid) references member(mid)
);
alter table hotel add column status varchar(20) default '정상';
select * from hotel;
insert into hotel values(default, 'admin', '롯데시티호텔 명동', '서울 중구 삼일대로 362', '02-6112-1000', '롯데시티호텔명동은 서울 시내 비즈니스와 쇼핑의 중심지인 명동과 서울의 오아시스인 청계천 사이에 위치하고 있으며, 27층 규모의 탁 트인 전망과 430의 객실과 멀티 스타일리시 뷔페 레스토랑, 미팅룸, 피트니스 등을 갖춘 프리미엄 비즈니스호텔입니다. 성공적인 비즈니스와 만족스런 여행을 위한 최고의 실용성과 차별화된 서비스, 합리적인 가격으로 비즈니스 고객과 레저여행객 모두에게 잊지 못할 추억을 선사합니다.', '롯데시티호텔명동.jpg',null, default,default,null,null);
insert into hotel values(default, 'admin', '소테츠호텔즈 더 스프라지르 서울 명동', '서울 중구 남대문로5길 15', '02-772-0900', '서울 비즈니스 구역 중심에 위치한 ''소테츠 호텔즈 더 스프라지르 서울 명동''은 ''지하철 4호선 회현역 7번출구''와 ''지하철 1, 2호선 시청역 7번출구''에서 도보 7분 내에 위치하고 있어 서울의 주요 관광지와 명소에 편리하게 이동할 수 있으며, 공항 리무진 버스를 타고 70분 안에 인천국제공항에 도착할 수 있습니다.', '소테츠호텔.jpg', null, default,default,null,null);
insert into hotel values(default, 'admin', '휘닉스 리조트 평창','강원도 평창군 봉평면', '033-330-0000', '스키 인/아웃이 가능한 호텔, 휘닉스파크 스키 리조트에서 가까우며 워터파크 이용 가능', '003.jpg', null, default,default,null,null);
insert into hotel values(default, 'admin', '휘닉스 아일랜드', '제주특별자치도 서귀포시 성산읍', '064-710-0000', '해변에 자리한 고급형 리조트, 섭지코지 해변에서 가까우며 스파 이용 가능', '004.jpg', null, default,default,null,null);
insert into hotel values(default, 'admin', '더블트리 바이', '성남시 분당구 정자동 3-2', '031-729-0000', '성남의 산에 있는 호텔, 실내 수영장 및 레스토랑 이용 가능', '005.jpg', null, default,default,null,null);







drop table room;
drop table reservation;
select * from room 
insert into room values (default, 1, '스튜디오,킹사이즈 침대 1개', '10', '2', '소형', '1', '1-1.jpg', null,'정상',default);
insert into room values (default, 1, '디럭스,킹사이즈 침대 1개', '10', '3', '중형', default, '1-2.jpg', null,'정상',default);
insert into room values (default, 1, '스위트,킹사이즈 침대 1개', '10', '3', '대형', default, '1-3.jpg', null,'정상',default);


/* 객실 테이블 */
create table room(
	idx int auto_increment,									/* 객실 아이디 */
	mid varchar(20) not null,								/* 호텔 등록자 아이디 */
	hotelIdx int not null,									/* 연결된 호텔 아이디 */
	name varchar(50) not null,							/* 객실명 */
	roomNumber varchar(10) not null,				/* 객실 번호 */
	price int not null,											/* 객실 1박 요금 */
	maxPeople int not null,									/* 최대 인원 수 */
	petSizeLimit varchar(10) not null,			/* 반려견 크기 제한 (소형/중형/대형) */
	petCountLimit int not null default 1,		/* 최대 반려견 수 */
	thumbnail varchar(100) not null,				/* 객실 썸네일 이미지 */
	images text,														/* 객실 이미지 */
	status varchar(20) default '정상', 				/* 객실 상태 (정상/서비스중지요청/서비스중지) */
	regDate datetime default now(),					/* 등록 날짜 */
	primary key(idx),
	foreign key(hotelIdx) references hotel(idx) on delete cascade,
	foreign key(mid) references member(mid)
);
select images from room where idx =6;


/* 객실 옵션 테이블 */
create table options (
  idx int auto_increment,         /* 옵션 아이디 */
  name varchar(50) not null,      /* 옵션 이름 */
  primary key (idx)
);
drop table options;

insert into options(name) values('TV');
insert into options(name) values('욕조');
insert into options(name) values('에어컨');
insert into options(name) values('냉장고');
insert into options(name) values('드라이기');
insert into options(name) values('전자레인지');
insert into options(name) values('전기포트');
insert into options(name) values('와이파이');
insert into options(name) values('반려견 침대');
insert into options(name) values('반려견 배변패드');
insert into options(name) values('반려견 샴푸');


/* 객실-옵션 연결 테이블 */
create table roomOptions (
  roomIdx int not null,											/* 객실 아이디 */
  optionIdx int not null,										/* 옵션 아이디 */
  primary key (roomIdx, optionIdx),
  foreign key (roomIdx) references room(idx) on delete cascade,
  foreign key (optionIdx) references options(idx) on delete cascade
);























/* 예약 테이블 */
create table reservation (
  idx           int auto_increment primary key,         /* 예약 번호	*/
  mid      		  varchar(20) not null,                		/* 예약한 회원 아이디 */
  name					varchar(10) not null,										/* 예약자 이름 */
  tel						varchar(15) not null,										/* 예약자 연락처 */
  roomIdx       int not null,                           /* 예약한 객실 번호 */
  checkinDate  date not null,                           /* 체크인 날짜 */
  checkoutDate date not null,                           /* 체크아웃 날짜 */
  guestCount    int not null,                           /* 인원 수 */
  petCount      int not null,                           /* 반려견 수 */
  totalPrice    int not null,                           /* 총 결제 금액 */
  status        varchar(20) not null default '대기중',    /* 예약 상태 (대기중, 예약완료, 예약취소, 이용완료) */
  regDate       datetime default now(), 						    /* 예약 등록일 */
  memo					varchar(300),														/* 예약자 메모 */
  foreign key (mid) references member(mid) on delete cascade,
  foreign key (roomIdx) references room(idx) on delete cascade
);

drop table reservation;




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



/* 1:1 문의 */
create table inquiry (
		idx int not null auto_increment,              /* 고유번호 */
		mid varchar(20) not null,                      /* 아이디 */
		title varchar(100) not null,                   /* 1:1문의 제목 */
		part varchar(20) not null,                    /* 분류 (카테고리) */
		wDate datetime not null default now(), /* 문의 작성 날짜*/
		reservation varchar(50),                      /* 예약 번호 */
		content text not null,                           /* 문의 내역 */
		fSName varchar(200),                          /* 문의시에 올린 서버에 저장되는 이름*/
		reply varchar(10) default '답변대기중',      /* 답변 여부(답변대기중/답변완료/답변보류) */
		primary key (idx),
		foreign key (mid) references member(mid) 
);

insert into inquiry values (default, 'admin', '문의합니다', '결제/환불문의', default, '', '결제가 안된거같습니다.', '', default);
select count(*) from inquiry;
select * from inquiry;

desc inquiry;

/* 1:1 문의 답변글 */
create table inquiryReply(
		reIdx int not null auto_increment,            /* 답변 고유번호*/
		inquiryIdx int not null,                            /* 문의글 고유번호*/
		reWDate datetime not null default now(), /* 답변 작성 날짜*/
		reContent text not null,                          /* 답변 내용 */
		primary key (reIdx),
		foreign key (inquiryIdx) references inquiry (idx)
);



create table coupons (
		CouponIdx (INT, Primary Key, Auto-increment)
		couponCode (VARCHAR(50), Unique) : 쿠폰 코드
		couponName (VARCHAR(50)) : 쿠폰 이름
		discountType (ENUM('percentage', 'amount')) : 할인 유형 (정률, 정액)
		discountValue (DECIMAL) : 할인 값 (예: 10%, 10000원)
		--maxDiscountAmount (DECIMAL, NULLABLE) : 최대 할인 금액 (정률 할인 시)
		issueStartDate (DATETIME) : 발급 시작일
		--issueEndDate (DATETIME) : 발급 종료일
		expiryDate (DATETIME) : 사용 만료일
		--minOrder_amount (DECIMAL) : 최소 주문 금액 조건
		--usageLimit (INT) : 총 사용 가능 횟수
		--usageCount (INT, Default 0) : 사용 횟수
		isActive (BOOLEAN, Default TRUE) : 활성화 여부
		--targetType (ENUM('all', 'hotel', 'room_type')) : 쿠폰 적용 대상 (전체, 특정 호텔, 특정 객실 타입)
		photo (varchar())
);


create table userCoupons (
		idx (INT, Primary Key, Auto-increment)
		mid (INT) : 사용자 ID (Users 테이블 참조)
		couponCode (varchar) : 쿠폰 ID (Coupons 테이블 참조)
		issue_date (DATETIME) : 쿠폰 발급일
		is_used (BOOLEAN, Default FALSE) : 사용 여부
		used_date (DATETIME, NULLABLE) : 사용일
		order_id (INT, NULLABLE) : 사용된 주문 ID (Orders 테이블 참조)
		qrcodeName  (varchar(100)))  : 쿠폰정보를 담은 qrcode
);


/* 리뷰 달기 */
create table Review (
  idx			  int not null auto_increment,	/* 댓글 고유번호 */
  hotelIdx  int not null,						/* 원본글 호텔의 고유번호 - 외래키로 지정 */
  roomIdx		int not null, 					/* 원본글 호텔-객실의 고유번호*/
  reviewTotCnt int not null,
  reviewCnt	int not null default 0,
  mid			  varchar(20) not null,		/* 댓글 올린이 아이디 */
  nickName  varchar(20) not null,		/* 댓글 올린이 닉네임 */
  roomName	varchar(50) not null,		/* room테이블의 name 참조. 객실명*/
  purpose		varchar(20) not null,		/* 숙박인원의 단위/목적(예:친구와여행/가족) */
  content   text not null,					/* 댓글 내용 */
  hostIp		varchar(50) not null,		/* 댓글 올린 PC의 고유 IP */
  reviewDate	datetime default now(),	/* 댓글 올린 날짜/시간 */
  primary key(idx),
  foreign key(hotelIdx) references hotel(idx),
  foreign key(roomIdx) references room(idx)
  on update cascade
  on delete cascade
);
desc Review;

drop table Review;



/* 예약 테이블 */
create table reservation (
  idx           int auto_increment primary key,         /* 예약 번호	*/
  mid      		  varchar(20) not null,                		/* 예약한 회원 아이디 */
  name					varchar(10) not null,										/* 예약자 이름 */
  tel						varchar(15) not null,										/* 예약자 연락처 */
  roomIdx       int not null,                           /* 예약한 객실 번호 */
  checkinDate  date not null,                           /* 체크인 날짜 */
  checkoutDate date not null,                           /* 체크아웃 날짜 */
  guestCount    int not null,                           /* 인원 수 */
  petCount      int not null,                           /* 반려견 수 */
  totalPrice    int not null,                           /* 총 결제 금액 */
  status        varchar(20) not null default '대기중',    /* 예약 상태 (대기중, 예약완료, 예약취소, 이용완료) */
  regDate       datetime default now(), 						    /* 예약 등록일 */
  memo					varchar(300),														/* 예약자 메모 */
  foreign key (mid) references member(mid) on delete cascade,
  foreign key (roomIdx) references room(idx) on delete cascade
);