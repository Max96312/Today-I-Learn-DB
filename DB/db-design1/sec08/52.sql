-- ## 식별 관계 vs 비식별 관계 - 일대일(1:1)

DROP TABLE IF EXISTS member_detail_non_identifying;
DROP TABLE IF EXISTS member_non_identifying;

CREATE TABLE member_non_identifying (
    member_id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (member_id)
);

CREATE TABLE member_detail_non_identifying (
    member_detail_id BIGINT NOT NULL AUTO_INCREMENT, -- 독립적인 PK
    member_id BIGINT NOT NULL, -- 일반 컬럼 + FK + UNIQUE
    bio TEXT NULL,
    PRIMARY KEY (member_detail_id),
    UNIQUE KEY uq_member_id (member_id),
    CONSTRAINT fk_detail_member_non FOREIGN KEY (member_id)
        REFERENCES member_non_identifying (member_id)
);

-- 1. 회원 데이터 입력
INSERT INTO member_non_identifying (name) VALUES ('kim'); -- member_id = 1 생성
INSERT INTO member_non_identifying (name) VALUES ('park'); -- member_id = 2 생성

-- 2. 'kim' 회원의 상세 정보 입력
-- member_id = 1을 참조하여 상세 정보를 추가한다.
INSERT INTO member_detail_non_identifying (member_id, bio)
VALUES (1, '데이터베이스 전문가입니다.'); -- member_detail_id = 1 생성

select * from member_non_identifying;
select * from member_detail_non_identifying;

select
	m.member_id,
    m.name,
    md.bio
from
	member_non_identifying m
left join
	member_detail_non_identifying md on m.member_id = md.member_id;

DROP TABLE IF EXISTS member_detail_identifying;
DROP TABLE IF EXISTS member_identifying;

CREATE TABLE member_identifying (
    member_id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (member_id)
);

CREATE TABLE member_detail_identifying (
    member_id BIGINT NOT NULL, -- PK + FK
    bio TEXT NULL,
    PRIMARY KEY (member_id),
    CONSTRAINT fk_detail_member_iden FOREIGN KEY (member_id)
        REFERENCES member_identifying (member_id)
);

-- 1. 회원 데이터 입력
INSERT INTO member_identifying (name) VALUES ('kim'); -- member_id = 1 생성
INSERT INTO member_identifying (name) VALUES ('park'); -- member_id = 2 생성

-- 2. 'kim' 회원의 상세 정보 입력
-- member_id = 1을 PK이자 FK로 사용하여 상세 정보를 추가한다.
INSERT INTO member_detail_identifying (member_id, bio)
VALUES (1, '데이터베이스 전문가입니다.');

select * from member_identifying;
select * from member_detail_identifying;

select
	m.member_id,
    m.name,
    md.bio
from
	member_identifying m
left join
	member_detail_identifying md on m.member_id = md.member_id;