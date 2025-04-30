/* 호텔 객실 테이블 */
create table room(
	idx int auto_increment,									/* 객실 아이디 */
	hotelIdx int not null,									/* 연결된 호텔 아이디 */
	name varchar(50) not null,							/* 객실명 */
	roomNumber varchar(10) not null,				/* 객실 번호 */
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


/* 객실 옵션 테이블 */
create table options (
  idx int auto_increment,         /* 옵션 아이디 */
  name varchar(50) not null,      /* 옵션 이름 */
  primary key (idx)
);

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

select rs.*, r.* from reservation rs, room r where rs.roomIdx=r.idx order by checkoutDate desc;

select r.name as roomName, r.roomNumber, r.price, r.maxPeople, r.petSizeLimit, r.petCountLimit, r.thumbnail as roomThumbnail, r.idx as roomIdx,
					 h.name as hotelName, h.thumbnail as hotelThumbnail, h.idx as hotelIdx,
					 rs.idx as reservationIdx,
					 rs.checkinDate,
					 rs.checkoutDate,
					 rs.guestCount,
					 rs.petCount,
					 rs.totalPrice from reservation rs
					 join room r on rs.roomIdx = r.idx
					 join hotel h on r.hotelIdx = h.idx
					 where rs.mid = 'atom' and (rs.status ='이용완료' or rs.status ='리뷰작성') order by rs.checkinDate desc;
					 