/* 리뷰 달기 */
CREATE TABLE IF NOT EXISTS `review` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `hotelIdx` int NOT NULL,
  `roomIdx` int NOT NULL,
  `reservationIdx` int NOT NULL DEFAULT (0),
  `reservationNo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mid` varchar(20) NOT NULL,
  `nickName` varchar(20) NOT NULL,
  `roomName` varchar(50) NOT NULL,
  `purpose` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `star` int NOT NULL DEFAULT '5',
  `content` text NOT NULL,
  `hostIp` varchar(50) NOT NULL,
  `reviewDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idx`),
  KEY `hotelIdx` (`hotelIdx`),
  KEY `roomIdx` (`roomIdx`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`hotelIdx`) REFERENCES `hotel` (`idx`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`roomIdx`) REFERENCES `room` (`idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE reservation ADD CONSTRAINT unique_reservationNo UNIQUE (reservationNo);

select * from review;

insert into review (hotelIdx, roomIdx, reservationIdx, reservationNo, mid, nickName, roomName, purpose, star, content, hostIp, reviewDate
) values
(1066, 1, 101, '240502A1', 'test1', '테스터1', '디럭스룸', '기념일 여행', 5, '반려견이 너무 좋아했어요!', '127.0.0.1', now()),
(1067, 2, 102, '240502B2', 'test2', '테스터2', '스탠다드룸', '휴식이 필요해서', 4, '조용하고 깨끗했어요.', '127.0.0.1', now()),
(1068, 3, 103, '240502C3', 'test3', '테스터3', '펫스위트', '일상 탈출', 5, '강아지 용품이 잘 갖춰져 있었어요.', '127.0.0.1', now());

