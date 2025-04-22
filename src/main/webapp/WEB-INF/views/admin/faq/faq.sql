show tables;

create table faq (
  idx		int not null auto_increment,	/* 게시글의 고유번호 */
  title varchar(100) not null,				/* 글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  primary key (idx)
);

drop tables faq;