show databases;
show tables;

create table member (
	idx			int not null auto_increment,
	mid			varchar(20) not null,
	pwd			varchar(100) not null,
	nickName	varchar(20) not null,
	name		varchar(10) not null,
	gender		char(2)		not null default '³²ÀÚ',
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
insert into member values (
	'atom', '0000', '¾ÆÅè', '±è¾ÆÅè', default, '1992-06-02',
	'010-6216-2673', 'Ã»ÁÖ½Ã ¼­¿ø±¸', 'cktjfl@naver.com', default, default
);

select * from member;