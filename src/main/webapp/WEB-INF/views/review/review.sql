/* 리뷰 달기 */
create table review (
  idx			  int not null auto_increment,	/* 댓글 고유번호 */
  hotelIdx  int not null,						/* 원본글 호텔의 고유번호 - 외래키로 지정 */
  roomIdx		int not null, 					/* 원본글 호텔-객실의 고유번호*/
  mid			  varchar(20) not null,		    /* 댓글 올린이 아이디 */
  nickName  varchar(20) not null,				/* 댓글 올린이 닉네임 */
  roomName	varchar(50) not null,				/* room테이블의 name 참조. 객실명*/
  purpose		varchar(20) not null,			/* 숙박인원의 단위/목적(예:가족과여행/연인과여행/친구와여행/회사/행사) */
  star      int(1) not null default 5,
  content   text not null,						/* 댓글 내용 */
  hostIp		varchar(50) not null,			/* 댓글 올린 PC의 고유 IP */
  reviewDate	datetime default now(),			/* 댓글 올린 날짜/시간 */
  primary key(idx),
  foreign key(hotelIdx) references hotel(idx),
  foreign key(roomIdx) references room(idx)
  on update cascade
  on delete cascade
);

select * from review;

insert into review(hotelIdx, roomIdx, mid, nickName, roomName, purpose, star, content, hostIp) values 
(1066, 1, 'test1', '테스터1', '디럭스룸', '기념일 여행', 5, '반려견이 너무 좋아했어요!', '127.0.0.1'),
(1067, 2, 'test2', '테스터2', '스탠다드룸', '휴식이 필요해서', 4, '조용하고 깨끗했어요.', '127.0.0.1'),
(1068, 3, 'test3', '테스터3', '펫스위트', '일상 탈출', 5, '강아지 용품이 잘 갖춰져 있었어요.', '127.0.0.1');
