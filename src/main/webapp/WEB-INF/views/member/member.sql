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