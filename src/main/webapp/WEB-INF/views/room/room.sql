/* 호텔 객실 테이블 */
create table room(
	idx int auto_increment,									/* 객실 번호 */
	hotelIdx int not null,									/* 연결된 호텔 아이디 */
	name varchar(50) not null,							/* 객실명 */
	price int not null,											/* 객실 1박 요금 */
	maxPeople int not null,									/* 최대 인원 수 */
	petSizeLimit varchar(10) not null,			/* 반려견 크기 제한 (소형/중형/대형) */
	petCountLimit int not null default 1,		/* 최대 반려견 수 */
	thumbnail varchar(100) not null,				/* 객실 썸네일 이미지 */
	images text,														/* 객실 이미지 */
	status varchar(20) default '정상', 				/* 객실 상태 (정상/비활성화/삭제) */
	regDate datetime default now(),					/* 등록 날짜 */
	primary key(idx),
	foreign key(hotelIdx) references hotel(idx) on delete cascade
);

drop table room;


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