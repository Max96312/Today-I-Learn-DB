-- ## 일대일(1:1) 관계 - 주 테이블에 FK

DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS member_detail;

-- 보조 테이블 (먼저 생성)
CREATE TABLE member_detail (
    member_detail_id BIGINT NOT NULL AUTO_INCREMENT,
    bio TEXT NULL,
    mbti VARCHAR(10) NULL,
    PRIMARY KEY (member_detail_id)
);

-- 주 테이블
CREATE TABLE member (
    member_id        BIGINT NOT NULL AUTO_INCREMENT,
    member_detail_id BIGINT NOT NULL, -- NOT NULL 제약조건이 핵심
    name             VARCHAR(50) NOT NULL,
    PRIMARY KEY (member_id),
    UNIQUE KEY uq_member_detail_id (member_detail_id),
    CONSTRAINT fk_member_detail FOREIGN KEY (member_detail_id)
        REFERENCES member_detail (member_detail_id)
);

-- INSERT INTO member (member_detail_id, name) VALUES (NULL, '네이트');

-- 존재하지 않는 member_detail_id(100)를 사용
-- INSERT INTO member (member_detail_id, name) VALUES (100, '네이트');

-- 1. '네이트'의 상세 정보 추가
INSERT INTO member_detail (bio, mbti) VALUES ('안녕하세요. 백엔드 개발자입니다.', 'INFJ');

-- 2. '네이트'의 회원 정보 추가 (방금 생성된 member_detail_id는 1)
INSERT INTO member (member_detail_id, name) VALUES (1, '네이트');

-- 3. '션'의 상세 정보 추가
INSERT INTO member_detail (bio, mbti) VALUES ('풀스택 개발자를 꿈꿉니다.', 'ENFP');

-- 4. '션'의 회원 정보 추가 (방금 생성된 member_detail_id는 2)
INSERT INTO member (member_detail_id, name) VALUES (2, '션');

SELECT
    m.member_id,
    m.name,
    md.bio,
    md.mbti
FROM
    member m
JOIN
    member_detail md ON m.member_detail_id = md.member_detail_id;