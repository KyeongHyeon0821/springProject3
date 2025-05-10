show tables;

create table qna(
	idx int not null, /* qna의 고유번호 */
	qnaIdx int not null, /* 답변글의 고유번호 */
	mid varchar(20) not null, /* 원본글(문의글)의 작성자 아이디 */
	nickName varchar(20) not null, /* qna 작성자의 닉네임 */
	title varchar(100) not null, /* qna의 글 제목 */
	email varchar(50) not null, /* 이메일 */
	content text not null, /* qna의 글제목 */
	ansLevel int not null, /* 질문글이든 답변글이든 작성자의 등급번호를 저장한다. (리스트 출력시에 질문글을 먼저 출력하고, 답변글을 ansLevel 오름차순으로 출력시켜준다.) */
	openSw char(2) not null default 'OK', /* 공개글,비밀글 체크용도 (공개:OK, 비공개:NO) */
	qnaSw varchar(2) not null default 'q', /* question(q) 인지 answer(a)인지 표시처리 */
	wDate datetime default now(), /* 작성 날짜*/
	delCheck char(2) default 'NO', /* 답변글이 있는데 '질문글'을 삭제하고자할때 'OK'로 저장시켜준다.(나중에 '답변글'을 모두 지웠을때 '질문글'의 delCheck가 'OK'라면 원본글(질문글)도 삭제한다.) */
	primary key(idx),
	foreign key(mid) references member(mid)
);

select ifnull(max(idx), 0) from qna;

/* 질문들에 대한 관리자의 답변여부를 기억시켜주기 위한 테이블 작성 */
create table qnaAdmin(
	idx int not null auto_increment primary key, /* 답변여부 테이블의 고유번호 */
	qnaIdx int not null, /* 원본글중에서 질문글의 고유번호 */
	qnaAnswer char(4) default '답변대기', /* 질문글에 대한 답변여부(답변대기/답변완료) */
	foreign key(qnaIdx) references qna(idx) /* 원본 질문글의 qnaIdx를 외래키지정. 원본글 고유번호와 매치 */
);

/* 
	처리조건 : 
			1. qna 등록시 qnaIdx를 결정해야한다. qnaIdx는 질문글(q)일경우는 자신글(질문글)의 고유번호인 idx를 갖고, 답변글(a)일 경우는 원본글의 idx값을 갖는다.
			따라서 idx를 auto_increment로 설정하지않는다.
			2. openSw는 '공개여부'의 용도로 사용한다. 공개:OK, 비공개:NO
			3. qnaSw는 질문글은 'q'로, 답변글은 'a'로 등록한다.
			4. ansLevel은 질문글이든 답변글이든, 글쓴이의 등급번호 (세션레벨(sLevel))를 저장한다.
			5. mid, nickName은 member테이블의 값을 그대로 저장하고, email은 member테이블의 값을 보여주되, 새로 입력받을수있도록 처리한다.
			6. 답변글 등록시 qna테이블의 title필드는 원본글(질문글)의 title필드를 그대로 사용하되, 앞에 '(Re)'를 붙여서 저장한다.
				단, '관리자'가 달은 '답변글'은 '빨간색'으로 저장처리한다.
			7. 답변글 등록시, qnaAdmin테이블에 대한 추가 저장처리를 한다.
				7-1. qnaIdx는 원본글인 '질문글'의 고유번호를 저장
				7-2. qnaAnswer필드는 질문글에 대한 답변여부(답변대기/답변완료)로 저장(초기값은 '답변대기')
						qnaAnswer필드는 일반사용자가 '답변글'을 달면  '답변대기'그대로 유지되지만, 관리자가 '답변글'을 달게되면 '답변완료'로 변경해줘야한다.
			8. 답변글은 누구나 등록할 수 있도록 처리한다. 단, 관리자가 답변글을 달았을때는 '답변완료'로 처리되기에 더이상 답변글을 달수없게한다.
				('답변완료'시에는 '답변'버튼 안보이게처리)
			9. qna는 리스트 출력시 아래와 같은 조건을 따른다.(페이징처리 할 것)
				9-1. 첫번째 정렬키 : qna테이블의 qnaIdx 내림차순으로 출력
				9-2. 두번째 정렬키 : qna테이블의 qnaSw 내림차순으로 출력 
				9-3. 세번째 정렬키 : qna테이블의 ansLevel 오름차순으로 출력
			10. '답변글'이 있는 '질문글'의 삭제시는, title필드와 content필드에 '현재 삭제된 글입니다.'라고 저장시켜둔다.
				 나중에 답변글을 삭제할시에 삭제된 원본글(질문글)도 같이 삭제처리한다.

select *,(select qnaAnswer from qnaAdmin where qnaIdx=1) as qnaAnswer from qna q order by qnaIdx desc, qnaSw desc, ansLevel;

select *,(select qnaAnswer from qnaAdmin where qnaIdx=q.idx) as qnaAnswer from qna q where (select qnaAnswer from qnaAdmin where qnaIdx=q.idx) = '답변대기' order by qnaIdx desc, qnaSw desc, ansLevel limit 0,20;
*/


INSERT INTO qna (idx, qnaIdx, mid, nickName, title, email, content, ansLevel, openSw, qnaSw) VALUES
(3, 3, 'coco78', '코코랑놀자', '체크인 시간 변경 가능한가요?', 'coco78@example.com', '도착 시간이 늦어질 것 같은데 체크인 시간 연장 가능한지 궁금합니다.', 2, 'OK', 'q'),
(4, 4, 'choco33', '초코사랑', '반려견 수영장 이용 시 주의사항 문의', 'choco33@example.com', '수영장 이용 시 반려견 방수 기저귀 착용이 필수인지 확인하고 싶습니다.', 2, 'NO', 'q'),
(5, 5, 'teddy07', '테디짱', '호텔 내 반려견 돌봄 서비스 제공 여부', 'teddy07@example.com', '호텔 이용 중 외출할 경우 반려견을 맡길 수 있는 서비스가 있는지 문의합니다.', 1, 'OK', 'q'),
(7, 7, 'maxx12', '맥스형', '반려견과 조식 레스토랑 이용 가능한가요?', 'maxx12@example.com', '조식 이용 시 반려견 동반이 가능한지, 별도 구역이 있는지 궁금합니다.', 1, 'NO', 'q'),
(9, 9, 'ruby14', '루비짱짱', '반려견 추가요금 기준이 궁금합니다.', 'ruby14@example.com', '2마리 반려견과 함께 이용하려고 하는데 요금 추가 여부 알고 싶습니다.', 2, 'NO', 'q'),
(10, 10, 'lemon88', '레몬큐트', '애견동반 객실 흡연 가능 여부', 'lemon88@example.com', '흡연 가능한 객실에서도 반려견과 동반 투숙이 가능한지 궁금합니다.', 1, 'OK', 'q'),
(11, 11, 'bobby65', '바비와함께', '객실 청소 요청은 어떻게 하나요?', 'bobby65@example.com', '연박 시 객실 청소 요청이 가능한지, 사전 예약이 필요한지 알고 싶습니다.', 1, 'NO', 'q'),
(13, 13, 'happy09', '해피맘', '반려견 보험 가입 여부 문의', 'happy09@example.com', '호텔 이용 중 사고 발생 시 보장 가능한 보험이 있는지 궁금합니다.', 1, 'OK', 'q'),
(15, 15, 'buddy71', '버디짱', '객실 내부 구조 문의', 'buddy71@example.com', '반려견이 머무를 수 있는 별도 공간이 객실에 있는지 알고 싶습니다.', 1, 'NO', 'q'),
(16, 16, 'candy24', '캔디러버', '애견 동반 시 입장 제한 구역 문의', 'candy24@example.com', '호텔 내 반려견 입장 제한 구역이 어디인지 궁금합니다.', 2, 'OK', 'q'),
(17, 17, 'milo05', '밀로네', '애견동반 이벤트 일정 문의', 'milo05@example.com', '호텔에서 진행하는 반려견 이벤트가 있는지, 일정은 어떻게 되는지 궁금합니다.', 1, 'NO', 'q'),
(19, 19, 'duke29', '듀크맘', '호텔 반려견 훈련 프로그램 여부', 'duke29@example.com', '호텔에서 간단한 반려견 훈련 프로그램을 제공하는지 문의드립니다.', 1, 'OK', 'q'),
(20, 20, 'olive57', '올리브조아', '예약 변경 수수료 안내', 'olive57@example.com', '예약 변경 시 별도의 수수료가 부과되는지 궁금합니다.', 2, 'NO', 'q'),
(21, 21, 'toby16', '토비짱짱', '반려견 동반 객실 이용 규칙 문의', 'toby16@example.com', '객실 내 반려견 이용 규칙(배변, 소음 등)에 대해 알고 싶습니다.', 2, 'OK', 'q'),
(22, 22, 'cookie36', '쿠키사랑', '반려견 입장 가능한 수영장 유무', 'cookie36@example.com', '반려견이 이용 가능한 야외 수영장이 있는지 문의드립니다.', 1, 'NO', 'q'),
(23, 23, 'jacky84', '재키댕댕', '호텔 주변 애견 카페 위치', 'jacky84@example.com', '호텔 인근 반려견 입장이 가능한 카페가 있으면 추천 부탁드립니다.', 1, 'NO', 'q'),
(24, 24, 'skyler03', '스카이짱', '애견동반 객실 조식 포함 여부', 'skyler03@example.com', '애견동반 객실 예약 시 조식이 포함되어 있는지 알고 싶습니다.', 2, 'OK', 'q'),
(25, 25, 'lulu28', '루루러버', '호텔 숙박권 이용 방법', 'lulu28@example.com', '숙박권을 사용해 예약하고 싶은데 절차가 궁금합니다.', 1, 'OK', 'q'),
(26, 26, 'honey13', '허니달콤', '추가 반려견 요금 문의', 'honey13@example.com', '반려견이 2마리 이상인 경우 요금 추가가 어떻게 되는지 궁금합니다.', 2, 'NO', 'q'),
(27, 27, 'brownie77', '브라우니짱', '호텔 예약 시 주의사항', 'brownie77@example.com', '애견 동반 시 예약할 때 특별히 주의할 사항이 있는지 문의합니다.', 1, 'OK', 'q'),
(28, 28, 'zoey41', '조이맘', '애견 동반 호텔 주차장 문의', 'zoey41@example.com', '반려견 동반 시 주차장 이용에 제한이 있는지 궁금합니다.', 2, 'NO', 'q'),
(29, 29, 'lucky77', '럭키두번', '호텔 예약 취소 정책 안내', 'lucky77@example.com', '예약 취소 시 수수료 및 환불 절차에 대해 문의드립니다.', 1, 'OK', 'q'),
