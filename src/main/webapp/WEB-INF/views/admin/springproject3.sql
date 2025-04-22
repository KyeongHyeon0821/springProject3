-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.1.0 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- springproject3 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `springproject3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `springproject3`;

-- 테이블 springproject3.hotel 구조 내보내기
CREATE TABLE IF NOT EXISTS `hotel` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `mid` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `description` text,
  `thumbnail` varchar(100) NOT NULL,
  `images` text,
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT '정상',
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `mid` (`mid`),
  CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `member` (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=1056 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 springproject3.hotel:~5 rows (대략적) 내보내기
DELETE FROM `hotel`;
INSERT INTO `hotel` (`idx`, `mid`, `name`, `address`, `tel`, `description`, `thumbnail`, `images`, `regDate`, `status`, `x`, `y`) VALUES
	(1, 'admin', '롯데시티호텔 명동', '서울 중구 삼일대로 362', '02-6112-1000', '롯데시티호텔명동은 서울 시내 비즈니스와 쇼핑의 중심지인 명동과 서울의 오아시스인 청계천 사이에 위치하고 있으며, 27층 규모의 탁 트인 전망과 430의 객실과 멀티 스타일리시 뷔페 레스토랑, 미팅룸, 피트니스 등을 갖춘 프리미엄 비즈니스호텔입니다. 성공적인 비즈니스와 만족스런 여행을 위한 최고의 실용성과 차별화된 서비스, 합리적인 가격으로 비즈니스 고객과 레저여행객 모두에게 잊지 못할 추억을 선사합니다.', 'admin_250415105624_롯데시티호텔명동.jpg', '', '2025-04-10 16:32:44', '정상', NULL, NULL),
	(2, 'admin', '소테츠호텔즈 더 스프라지르 서울 명동', '서울 중구 남대문로5길 15', '02-772-0900', '서울 비즈니스 구역 중심에 위치한 \'소테츠 호텔즈 더 스프라지르 서울 명동\'은 \'지하철 4호선 회현역 7번출구\'와 \'지하철 1, 2호선 시청역 7번출구\'에서 도보 7분 내에 위치하고 있어 서울의 주요 관광지와 명소에 편리하게 이동할 수 있으며, 공항 리무진 버스를 타고 70분 안에 인천국제공항에 도착할 수 있습니다.', 'admin_250415105602_소테츠호텔.jpg', '', '2025-04-10 16:32:45', '정상', NULL, NULL),
	(16, 'admin', 'MANHATTAN HOTEL', '충북 청주시 흥덕구 풍년로193번길 6', '043-236-7676', '없음', 'admin_250415105727_멘하탄호텔.jpg', '<p><img src="/springProject3/data/hotelImages/admin_250414161901_멘하탄호텔4.jpg" style="height:683px; width:1024px" /><img src="/springProject3/data/hotelImages/admin_250414161901_멘하탄호텔2.jpg" style="height:800px; width:1280px" /><img src="/springProject3/data/hotelImages/admin_250414161901_멘하탄호텔3.jpg" style="height:683px; width:1024px" /></p>\r\n', '2025-04-14 16:19:07', '정상', NULL, NULL),
	(29, 'admin', '켄싱턴리조트 충주', '충북 충주시 앙성면 산전장수1길 103 켄싱턴리조트 충주', '043-1234-1234', '1', 'admin_250417174721_켄싱턴리조트.jpg', '<p><img src="/springProject3/data/hotelImages/admin_250415103318_켄싱턴리조트2.png" style="height:1242px; width:1242px" /></p>\r\n', '2025-04-15 10:32:53', '정상', NULL, NULL);

-- 테이블 springproject3.hotellike 구조 내보내기
CREATE TABLE IF NOT EXISTS `hotellike` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `mid` varchar(20) NOT NULL,
  `hotelIdx` int NOT NULL,
  `likedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idx`),
  UNIQUE KEY `mid` (`mid`,`hotelIdx`),
  KEY `hotelIdx` (`hotelIdx`),
  CONSTRAINT `hotellike_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `member` (`mid`) ON DELETE CASCADE,
  CONSTRAINT `hotellike_ibfk_2` FOREIGN KEY (`hotelIdx`) REFERENCES `hotel` (`idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1071 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 springproject3.hotellike:~0 rows (대략적) 내보내기
DELETE FROM `hotellike`;
INSERT INTO `hotellike` (`idx`, `mid`, `hotelIdx`, `likedDate`) VALUES
	(67, 'admin', 1, '2025-04-21 09:45:20'),
	(69, 'admin', 29, '2025-04-21 09:45:31');

-- 테이블 springproject3.inquiry 구조 내보내기
CREATE TABLE IF NOT EXISTS `inquiry` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `mid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `part` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `wDate` datetime NOT NULL DEFAULT (now()),
  `reservation` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fSName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `reply` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '답변 대기중',
  PRIMARY KEY (`idx`) USING BTREE,
  KEY `mid` (`mid`) USING BTREE,
  CONSTRAINT `inquiry_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `member` (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 springproject3.inquiry:~11 rows (대략적) 내보내기
DELETE FROM `inquiry`;
INSERT INTO `inquiry` (`idx`, `mid`, `title`, `part`, `wDate`, `reservation`, `content`, `fSName`, `reply`) VALUES
	(2, 'kms1234', '문의합니다', '결제/환불문의', '2025-04-10 18:26:16', '', '결제가 안된거같습니다.', '', '답변완료'),
	(7, 'hkd1234', '123', '회원정보', '2025-04-11 14:20:33', '546', '123', '250411142033_후추2.jpg', '답변대기중'),
	(10, 'hkd1234', '1133', '회원정보', '2025-04-14 09:35:43', '5555', '779955', '250414093543_egg.png', '답변완료'),
	(14, 'hkd1234', '3333', '결제/환불', '2025-04-14 09:44:11', '33', '333', '250414135029_랑이2.jpg', '답변보류'),
	(18, 'hkd1234', '123123', '기타', '2025-04-14 10:15:40', '123123', '123123', '', '답변완료'),
	(19, 'hkd1234', '4144', '결제/환불', '2025-04-14 10:27:02', '1116', '141414 수정수정 \r\n레전드수정\r\n수정하면 20번으로가나\r\n\r\n수정을했는데 19번수정이 되려나!!!!!!!!!!!', '', '답변대기중'),
	(21, 'hkd1234', '1234', '회원정보', '2025-04-14 14:23:44', '1234', '1234', '', '답변대기중'),
	(22, 'hkd1234', '44343', '예약', '2025-04-14 15:20:06', '3434', '3434', '', '답변완료'),
	(23, 'hkd1234', 'afaf', '예약', '2025-04-14 16:57:38', '3414', 'afafd', NULL, '답변완료'),
	(30, 'hkd1234', '1313', '회원정보', '2025-04-14 17:13:05', '', '2323', '250414173302_랑이.jpg', '답변보류'),
	(31, 'hkd1234', '0033', '회원정보', '2025-04-16 10:11:03', '', '8855', NULL, '답변 대기중');

-- 테이블 springproject3.inquiryreply 구조 내보내기
CREATE TABLE IF NOT EXISTS `inquiryreply` (
  `reIdx` int NOT NULL AUTO_INCREMENT,
  `inquiryIdx` int NOT NULL,
  `reWDate` datetime NOT NULL DEFAULT (now()),
  `reContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`reIdx`) USING BTREE,
  KEY `inquiryIdx` (`inquiryIdx`) USING BTREE,
  CONSTRAINT `inquiryreply_ibfk_1` FOREIGN KEY (`inquiryIdx`) REFERENCES `inquiry` (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 springproject3.inquiryreply:~6 rows (대략적) 내보내기
DELETE FROM `inquiryreply`;
INSERT INTO `inquiryreply` (`reIdx`, `inquiryIdx`, `reWDate`, `reContent`) VALUES
	(1, 7, '2025-04-15 13:10:23', 'ㅇㅇ'),
	(2, 2, '2025-04-15 14:49:32', '00..'),
	(3, 10, '2025-04-15 15:19:45', '0022\n수정했을껄\n진짜 수정할껄'),
	(4, 18, '2025-04-15 15:44:10', '야호'),
	(5, 23, '2025-04-15 18:08:55', 'vfgfg'),
	(6, 14, '2025-04-15 18:49:30', '025505');

-- 테이블 springproject3.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `mid` varchar(20) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  `nickName` varchar(20) NOT NULL,
  `name` varchar(10) NOT NULL,
  `gender` char(2) NOT NULL DEFAULT '남자',
  `birthday` datetime DEFAULT CURRENT_TIMESTAMP,
  `tel` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `userDel` char(2) DEFAULT 'NO',
  `level` int DEFAULT '2',
  `businessNo` varchar(20) DEFAULT NULL,
  `userInfor` varchar(10) DEFAULT '공개',
  PRIMARY KEY (`idx`),
  UNIQUE KEY `mid` (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 springproject3.member:~1 rows (대략적) 내보내기
DELETE FROM `member`;
INSERT INTO `member` (`idx`, `mid`, `pwd`, `nickName`, `name`, `gender`, `birthday`, `tel`, `address`, `email`, `userDel`, `level`, `businessNo`, `userInfor`) VALUES
	(1, 'admin', '$2a$10$1crj8z.McCbLH3XvSFsA7eYkP8eBM2xUlkpLvDfYfXprsj1V5QiPG', '관리자', '관리맨', '남자', '1996-08-21 00:00:00', '010-1111-1234', '청주', 'yd12321@naver.com', 'NO', 0, NULL, '공개'),
	(2, 'hkd1234', '1234', '홍장군', '홍길동', '남자', '2025-04-11 14:18:44', '010-1111-2222', '서울', 'dnjsrkdus0403@naver.com', 'NO', 1, NULL, '공개'),
	(3, 'kms1234', '1234', '김장미', '김말숙', '여자', '2025-04-15 19:05:43', '010-2222-3333', '광주', 'dnjsrkdus0403@naver.com', 'NO', 2, NULL, '공개');

-- 테이블 springproject3.options 구조 내보내기
CREATE TABLE IF NOT EXISTS `options` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=1012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 springproject3.options:~11 rows (대략적) 내보내기
DELETE FROM `options`;
INSERT INTO `options` (`idx`, `name`) VALUES
	(1, 'TV'),
	(2, '욕조'),
	(3, '에어컨'),
	(4, '냉장고'),
	(5, '드라이기'),
	(6, '전자레인지'),
	(7, '전기포트'),
	(8, '와이파이'),
	(9, '반려견 침대'),
	(10, '반려견 배변패드'),
	(11, '반려견 샴푸');

-- 테이블 springproject3.pet 구조 내보내기
CREATE TABLE IF NOT EXISTS `pet` (
  `petIdx` int NOT NULL AUTO_INCREMENT,
  `memberMid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `petName` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `breed` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `petGender` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `petAge` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `weight` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `memo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`petIdx`) USING BTREE,
  KEY `memberMid` (`memberMid`) USING BTREE,
  CONSTRAINT `pet_ibfk_1` FOREIGN KEY (`memberMid`) REFERENCES `member` (`mid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 springproject3.pet:~0 rows (대략적) 내보내기
DELETE FROM `pet`;

-- 테이블 springproject3.qna 구조 내보내기
CREATE TABLE IF NOT EXISTS `qna` (
  `idx` int NOT NULL,
  `qnaIdx` int NOT NULL,
  `mid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ansLevel` int NOT NULL,
  `openSw` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'OK',
  `qnaSw` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'q',
  `wDate` datetime DEFAULT (now()),
  `delCheck` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'NO',
  PRIMARY KEY (`idx`) USING BTREE,
  KEY `mid` (`mid`) USING BTREE,
  CONSTRAINT `qna_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `member` (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 springproject3.qna:~7 rows (대략적) 내보내기
DELETE FROM `qna`;
INSERT INTO `qna` (`idx`, `qnaIdx`, `mid`, `nickName`, `title`, `email`, `content`, `ansLevel`, `openSw`, `qnaSw`, `wDate`, `delCheck`) VALUES
	(1, 1, 'hkd1234', '홍장군', '진짜 테스트', 'dnjsrkdus0403@naver.com', '<p>테스트임</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img alt="" src="/springProject3/data/qna/250421112110_egg.png" style="height:212px; width:300px" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>테스트테스트</p>\r\n', 1, 'OK', 'q', '2025-04-21 11:21:22', 'NO'),
	(2, 2, 'kms1234', '김장미', '564', 'dnjsrkdus0403@naver.com', '<p>564</p>\r\n', 2, 'OK', 'q', '2025-04-21 18:18:42', 'OK'),
	(3, 2, 'hkd1234', '홍장군', '(Re) 564', 'dnjsrkdus0403@naver.com', '789', 1, 'OK', 'a', '2025-04-21 18:18:49', 'NO'),
	(4, 4, 'hkd1234', '홍장군', 'ㄴㄹㅇㅎ', 'dnjsrkdus0403@naver.com', '<p>ㄴㄹㅇㅎ</p>\r\n', 1, 'OK', 'q', '2025-04-21 18:25:22', 'NO'),
	(5, 5, 'hkd1234', '홍장군', 'ㄴㄹㅇㅎ', 'dnjsrkdus0403@naver.com', '<p>ㄴㄹㅇㅎ</p>\r\n', 1, 'OK', 'q', '2025-04-21 18:25:25', 'NO'),
	(6, 6, 'hkd1234', '홍장군', 'ㄱㄷㅅㄱㄷ', 'dnjsrkdus0403@naver.com', '<p>ㅅㄱㄷㅅ</p>\r\n', 1, 'OK', 'q', '2025-04-21 18:25:28', 'NO'),
	(7, 7, 'hkd1234', '홍장군', '4653', 'dnjsrkdus0403@naver.com', '<p>6435</p>\r\n', 1, 'OK', 'q', '2025-04-21 18:25:33', 'NO');

-- 테이블 springproject3.qnaadmin 구조 내보내기
CREATE TABLE IF NOT EXISTS `qnaadmin` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `qnaIdx` int NOT NULL,
  `qnaAnswer` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '답변대기',
  PRIMARY KEY (`idx`) USING BTREE,
  KEY `qnaIdx` (`qnaIdx`) USING BTREE,
  CONSTRAINT `qnaadmin_ibfk_1` FOREIGN KEY (`qnaIdx`) REFERENCES `qna` (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 springproject3.qnaadmin:~6 rows (대략적) 내보내기
DELETE FROM `qnaadmin`;
INSERT INTO `qnaadmin` (`idx`, `qnaIdx`, `qnaAnswer`) VALUES
	(1, 1, '답변완료'),
	(31, 2, '답변대기'),
	(32, 4, '답변대기'),
	(33, 5, '답변대기'),
	(34, 6, '답변대기'),
	(35, 7, '답변대기');

-- 테이블 springproject3.room 구조 내보내기
CREATE TABLE IF NOT EXISTS `room` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `hotelIdx` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` int NOT NULL,
  `maxPeople` int NOT NULL,
  `petSizeLimit` varchar(10) NOT NULL,
  `petCountLimit` int NOT NULL DEFAULT '1',
  `thumbnail` varchar(100) NOT NULL,
  `images` text,
  `status` varchar(20) DEFAULT '정상',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idx`),
  KEY `hotelIdx` (`hotelIdx`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`hotelIdx`) REFERENCES `hotel` (`idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 springproject3.room:~0 rows (대략적) 내보내기
DELETE FROM `room`;
INSERT INTO `room` (`idx`, `hotelIdx`, `name`, `price`, `maxPeople`, `petSizeLimit`, `petCountLimit`, `thumbnail`, `images`, `status`, `regDate`) VALUES
	(5, 29, '스위트룸', 90000, 3, '대형', 1, '29_250421110154_켄싱리조트room1.jpg', '29_250421110154_켄싱리조트room2.jpg/29_250421110154_켄싱리조트room3.jpg', '정상', '2025-04-21 11:01:54');

-- 테이블 springproject3.roomoptions 구조 내보내기
CREATE TABLE IF NOT EXISTS `roomoptions` (
  `roomIdx` int NOT NULL,
  `optionIdx` int NOT NULL,
  PRIMARY KEY (`roomIdx`,`optionIdx`),
  KEY `optionIdx` (`optionIdx`),
  CONSTRAINT `roomoptions_ibfk_1` FOREIGN KEY (`roomIdx`) REFERENCES `room` (`idx`) ON DELETE CASCADE,
  CONSTRAINT `roomoptions_ibfk_2` FOREIGN KEY (`optionIdx`) REFERENCES `options` (`idx`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 springproject3.roomoptions:~0 rows (대략적) 내보내기
DELETE FROM `roomoptions`;

-- 테이블 springproject3.tourist_spot 구조 내보내기
CREATE TABLE IF NOT EXISTS `tourist_spot` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lng` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `feature` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 springproject3.tourist_spot:~0 rows (대략적) 내보내기
DELETE FROM `tourist_spot`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
