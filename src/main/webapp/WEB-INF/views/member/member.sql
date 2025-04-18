-- 프로젝트용 -- 



create table member (
   idx         int not null auto_increment,
   mid         varchar(20) not null,
   pwd         varchar(100) not null,
   nickName   varchar(20) not null,
   name      varchar(10) not null,
   tel         varchar(15) not null,
   email      varchar(50) not null,
   gender      char(2)      not null default '남자',
   address      varchar(100),
   businessNo  varchar(20),
   birthday   datetime default now(),
   level      int default 2,
   userDel      char(2) default 'NO',
   userInfor char(3) default '공개',								/* 회원 정보 공개여부(공배/비공개) */
	 visitCnt	int default 0,											/* 총 방문수 */
	 todayCnt	int default 0,											/* 오늘 방문한 횟수 */
	 startDate datetime default now(),							/* 최초 가입일 */
	 lastDate datetime default now(),	
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
	// complaintSw : H(감추기-board테이블의 complaint필드값을 'HI' , complaint테이블의 progress필드값을 '처리완료(H)')
	// complaintSw : S(보이기-신고해제-board테이블의 complaint필드값을 'NO' , complaint테이블의 progress필드값을 '처리완료(S)')
	// complaintSw : D(삭제하기-board테이블의 해당레코드 삭제처리 , complaint테이블의 progress필드값을 '처리완료(D)')
*/




create table board (
  idx		int not null auto_increment,	/* 게시글의 고유번호 */
  mid		varchar(20) not null,					/* 게시글 올린이의 아이디 */
  nickName varchar(20) not null,			/* 게시글 올린이의 닉네임 */
  title varchar(100) not null,				/* 글 제목 */
  content text not null,							/* 글 내용 */
  hostIp  varchar(40) not null,				/* 글 올린이 IP */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  score		int default 5,							/* 서비스점수(1부터5까지,최대5점.기본 5점*/
  complaint char(2) default 'NO',			/* 신고글 유무(신고당한글:OK, 정상글:NO, 감춘글:HI(hidden)) */
  primary key (idx),
  foreign key (mid) references member(mid)
);
desc board;


/* 댓글 달기 */
create table boardReply (
  idx			  int not null auto_increment,	/* 댓글 고유번호 */
  boardIdx  int not null,						/* 원본글의 고유번호 - 외래키로 지정 */
  mid			  varchar(20) not null,		/* 댓글 올린이 아이디 */
  nickName  varchar(20) not null,		/* 댓글 올린이 닉네임 */
  content   text not null,					/* 댓글 내용 */
  hostIp		varchar(50) not null,		/* 댓글 올린 PC의 고유 IP */
  wDate			datetime default now(),	/* 댓글 올린 날짜/시간 */
  primary key(idx),
  foreign key(boardIdx) references board(idx)
  on update cascade
  on delete cascade
);
desc boardReply;
