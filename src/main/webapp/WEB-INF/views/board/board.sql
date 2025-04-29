create table board (
  idx int not null auto_increment primary key,		/* 게시글 고유 번호 */
  mid varchar(50) not null,							/* 작성자 ID */
  title varchar(200) not null,						/* 게시글 제목 */
  content text not null,							/* 게시글 내용 */
  readCount int default 0,							/* 조회수 */
  createdAt datetime default now()					/* 작성일 */
);
