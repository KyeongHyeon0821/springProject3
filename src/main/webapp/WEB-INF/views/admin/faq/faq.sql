show tables;

create table faq (
  idx		int not null auto_increment,	/* 게시글의 고유번호 */
  category varchar(10) not null,					/* 카테고리(예약,결제/환불,회원정보,기타) */
  title varchar(100) not null,				/* 글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  primary key (idx)
);

drop tables faq;