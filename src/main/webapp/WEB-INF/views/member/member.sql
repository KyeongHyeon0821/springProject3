show databases;
show tables;

create table member (
	idx			int not null auto_increment,			/* 회원 고유번호 */
	mid			varchar(20) not null,					/* 아이디(중복불허/수정가능) */
	pwd			varchar(100) not null,					/* 비밀번호(BCryptPasswordEncoder) */
	nickName	varchar(20) not null,					/* 닉네임(중복불허/수정가능) */
	name		varchar(10) not null,					/* 성명(수정불가능) */
	gender		char(2)		not null default '남자',		/* 성별(수정불가능) */
	birthday	datetime default now(),					/* 생일 */
	tel			varchar(15),							/* 전화번호 */
	address		varchar(100),							/* 주소(다음 우편번호 API 사용) */
	email		varchar(50) not null,					/* 이메일(회원가입시 인증 또는 '아이디/비밀번호'분실시 사용 - 정규식 필수 체크 */
	userDel		char(2) default 'NO',					/* 회원 탈퇴신청여부(NO:현재 활동중, OK:탈퇴신청중) */
	level		int default 2,							/* 회원등급(0:관리자, 1:사업자회원, 2:일반회원) */
	businessNo  varchar(20),							/* 사업자등록번호(수정불가능) */
	userInfor 	varchar(10) default '공개',				/* 정보 공개여부(공개/비공개) */
	primary key (idx),
	unique key (mid)
);

desc member;

select * from member;

drop table if exists member;


INSERT INTO member (mid, pwd, nickName, name, email, level) VALUES
('bella21', '1234', '벨라엄마', '김벨라', 'bella21@example.com', 2),
('lucky55', '1234', '럭키댕댕', '박럭키', 'lucky55@example.com', 1),
('coco78', '1234', '코코랑놀자', '최코코', 'coco78@example.com', 2),
('choco33', '1234', '초코사랑', '정초코', 'choco33@example.com', 2),
('teddy07', '1234', '테디짱', '이테디', 'teddy07@example.com', 1),
('minty92', '1234', '민티조아', '윤민티', 'minty92@example.com', 2),
('maxx12', '1234', '맥스형', '김맥스', 'maxx12@example.com', 2),
('snowy45', '1234', '스노우펫', '송스노우', 'snowy45@example.com', 1),
('ruby14', '1234', '루비짱짱', '장루비', 'ruby14@example.com', 2),
('lemon88', '1234', '레몬큐트', '오레몬', 'lemon88@example.com', 2),
('bobby65', '1234', '바비와함께', '조바비', 'bobby65@example.com', 1),
('momo82', '1234', '모모댕댕', '홍모모', 'momo82@example.com', 2),
('happy09', '1234', '해피맘', '임해피', 'happy09@example.com', 1),
('daisy31', '1234', '데이지사랑', '서데이지', 'daisy31@example.com', 2),
('buddy71', '1234', '버디짱', '구버디', 'buddy71@example.com', 2),
('candy24', '1234', '캔디러버', '백캔디', 'candy24@example.com', 1),
('milo05', '1234', '밀로네', '심밀로', 'milo05@example.com', 2),
('pearl93', '1234', '펄사랑해', '황펄', 'pearl93@example.com', 1),
('duke29', '1234', '듀크맘', '하듀크', 'duke29@example.com', 2),
('olive57', '1234', '올리브조아', '윤올리브', 'olive57@example.com', 2),
('toby16', '1234', '토비짱짱', '문토비', 'toby16@example.com', 1),
('cookie36', '1234', '쿠키사랑', '한쿠키', 'cookie36@example.com', 2),
('jacky84', '1234', '재키댕댕', '남재키', 'jacky84@example.com', 1),
('skyler03', '1234', '스카이짱', '정스카이', 'skyler03@example.com', 2),
('lulu28', '1234', '루루러버', '이루루', 'lulu28@example.com', 2),
('honey13', '1234', '허니달콤', '김허니', 'honey13@example.com', 1),
('brownie77', '1234', '브라우니짱', '최브라우니', 'brownie77@example.com', 2),
('zoey41', '1234', '조이맘', '조조이', 'zoey41@example.com', 2),
('lucky77', '1234', '럭키두번', '박럭키2', 'lucky77@example.com', 1),
('juno06', '1234', '주노네', '홍주노', 'juno06@example.com', 2);

