-- ## 일대일(1:1) 관계 - 외래 키 위치

DROP TABLE IF EXISTS member_detail;
DROP TABLE IF EXISTS member;

-- 주 테이블
CREATE TABLE member (
    member_id  BIGINT       NOT NULL AUTO_INCREMENT,
    name       VARCHAR(50)  NOT NULL,
    PRIMARY KEY (member_id)
);

-- 보조 테이블
CREATE TABLE member_detail (
    member_detail_id  BIGINT       NOT NULL AUTO_INCREMENT, -- 고유 PK
    member_id         BIGINT       NOT NULL,              -- FK + UNIQUE
    bio               TEXT         NULL,
    mbti              VARCHAR(10)  NULL,
    PRIMARY KEY (member_detail_id),
    UNIQUE KEY uq_member_id (member_id), -- 1:1 관계의 핵심
    CONSTRAINT fk_detail_member FOREIGN KEY (member_id)
        REFERENCES member (member_id)
);


-- 1. 주 테이블에 데이터 추가
INSERT INTO member(name) VALUES ('김개발'); -- member_id = 1 가정

-- 2. 보조 테이블에 데이터 추가
INSERT INTO member_detail(member_id, bio, mbti)
VALUES (1, '항상 성장하는 개발자입니다.', 'INTJ');

select * from member;
select * from member_detail;

DROP TABLE IF EXISTS member_detail; -- member를 참조한다. 먼저 제거
DROP TABLE IF EXISTS member;

DROP TABLE IF EXISTS member; -- member_detail을 참조한다. 먼저 제거
DROP TABLE IF EXISTS member_detail;

-- 보조 테이블 (먼저 생성)
CREATE TABLE member_detail (
    member_detail_id  BIGINT       NOT NULL AUTO_INCREMENT,
    bio               TEXT         NULL,
    mbti              VARCHAR(10)  NULL,
    PRIMARY KEY (member_detail_id)
);

-- 주 테이블
CREATE TABLE member (
    member_id         BIGINT       NOT NULL AUTO_INCREMENT,
    member_detail_id  BIGINT       NULL, -- FK이자 UNIQUE, NULL 허용
    name              VARCHAR(50)  NOT NULL,
    PRIMARY KEY (member_id),
    UNIQUE KEY uq_member_detail_id (member_detail_id), -- 1:1 관계의 핵심
    CONSTRAINT fk_member_detail FOREIGN KEY (member_detail_id)
        REFERENCES member_detail (member_detail_id)
);

-- 1. 주 테이블에 데이터 추가 (보조 테이블 NULL)
INSERT INTO member(name, member_detail_id)
VALUES ('김개발', NULL);

-- 2. 보조 테이블에 먼저 데이터 추가
INSERT INTO member_detail(bio, mbti)
VALUES ('항상 성장하는 개발자입니다.', 'INTJ');

-- 3. 주 테이블에 보조 테이블 정보 등록
UPDATE member
   SET member_detail_id = 1 -- 1이라고 가정
 WHERE member_id = 1; -- 1이라고 가정
 
select * from member;
select * from member_detail;

-- 1. 보조 테이블에 먼저 데이터 추가
INSERT INTO member_detail(bio, mbti)
VALUES ('기획은 나의 길, 기획자 입니다.', 'ENTJ');

-- 2. 주 테이블에 해당 ID를 넣어서 데이터 추가
INSERT INTO member(name, member_detail_id)
VALUES ('서기획', 2); -- member_detail_id: 2라고 가정

select * from member;
select * from member_detail;