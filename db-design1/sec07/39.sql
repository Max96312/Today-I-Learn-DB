-- ## 일대일(1:1) 관계 - 시작

DROP TABLE IF EXISTS member_detail;
DROP TABLE IF EXISTS member;

CREATE TABLE member (
    member_id  BIGINT       NOT NULL AUTO_INCREMENT,
    name       VARCHAR(50)  NOT NULL,
    PRIMARY KEY (member_id)
);

CREATE TABLE member_detail (
    member_detail_id  BIGINT       NOT NULL AUTO_INCREMENT, -- 회원 상세 ID (PK)
    member_id         BIGINT       NOT NULL,                 -- 회원 ID (FK)
    bio               TEXT         NULL,                     -- 자기소개
    website_url       VARCHAR(255) NULL,                     -- 개인 홈페이지
    mbti              VARCHAR(10)  NULL,                     -- MBTI
    PRIMARY KEY (member_detail_id),
    CONSTRAINT fk_detail_member FOREIGN KEY (member_id)
        REFERENCES member (member_id)
);

-- 테스트 회원 추가
INSERT INTO member (name) VALUES ('김개발');

-- '김개발' 회원의 상세 정보 추가 (member_id = 1)
INSERT INTO member_detail (member_id, bio, mbti)
VALUES (1, '안녕하세요, 최고의 개발자가 되고 싶습니다.', 'INTJ');

select * from member;
select * from member_detail;

SELECT m.member_id, m.name, d.bio, d.mbti
FROM member m
JOIN member_detail d ON m.member_id = d.member_id;

-- '김개발' 회원의 상세 정보 또 추가
INSERT INTO member_detail (member_id, bio, mbti)
VALUES (1, '취미는 코딩입니다.', 'ENTP');

SELECT * FROM member_detail WHERE member_id = 1;

-- 기존 테이블 삭제
DROP TABLE IF EXISTS member_detail;

-- UNIQUE 제약조건을 추가하여 재생성
CREATE TABLE member_detail (
    member_detail_id  BIGINT       NOT NULL AUTO_INCREMENT, -- 회원 상세 ID (PK)
    member_id         BIGINT       NOT NULL,                 -- 회원 ID (FK, UNIQUE)
    bio               TEXT         NULL,                     -- 자기소개
    website_url       VARCHAR(255) NULL,                     -- 개인 홈페이지
    mbti              VARCHAR(10)  NULL,                     -- MBTI
    PRIMARY KEY (member_detail_id),
    UNIQUE KEY uq_member_id (member_id), -- 이 부분이 핵심!
    CONSTRAINT fk_detail_member FOREIGN KEY (member_id)
        REFERENCES member (member_id)
);


-- '김개발' 회원의 첫 번째 상세 정보 추가 (성공)
INSERT INTO member_detail (member_id, bio, mbti)
VALUES (1, '안녕하세요, 최고의 개발자가 되고 싶습니다.', 'INTJ');

-- '김개발' 회원의 두 번째 상세 정보 추가 (실패)
INSERT INTO member_detail (member_id, bio, mbti)
VALUES (1, '취미는 코딩입니다.', 'ENTP');


-- 상세 정보가 필요할 때만 JOIN
SELECT m.name, d.bio, d.mbti
FROM member m
JOIN member_detail d ON m.member_id = d.member_id
WHERE m.member_id = 1;