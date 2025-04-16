show databases;
show tables;

create table member (
	idx			int not null auto_increment,
	mid			varchar(20) not null,
	pwd			varchar(100) not null,
	nickName	varchar(20) not null,
	name		varchar(10) not null,
	gender		char(2)		not null default '남자',
	birthday	datetime default now(),
	tel			varchar(15) not null,
	address		varchar(100),
	email		varchar(50) not null,
	userDel		char(2) default 'NO',
	level		int default 2,
	primary key (idx),
	unique key (mid)
);

desc member;

select * from member;

alter table member add businessNo varchar(20);

alter table member add userInfor varchar(10) default '공개';
