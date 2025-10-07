-- ## 일대다(1:N) 다대일(N:1) 관계 - 외래 키 위치1

DROP TABLE IF EXISTS team_bad1;
CREATE TABLE team_bad1 (
    team_id BIGINT NOT NULL,
    name VARCHAR(50) NOT NULL,
    member_id BIGINT NULL,
    PRIMARY KEY (team_id)
);

-- 데이터 삽입
INSERT INTO team_bad1(team_id, name, member_id) VALUES (1, '개발팀', 1); -- 김개발(ID:1)

-- 오류 발생
INSERT INTO team_bad1(team_id, name, member_id) VALUES (1, '개발팀', 2); -- 박개발(ID:2)

DROP TABLE IF EXISTS team_bad2;
CREATE TABLE team_bad2 (
    team_id BIGINT NOT NULL,
    name VARCHAR(50) NOT NULL,
    member_ids VARCHAR(255) NULL, -- 쉼표로 구분된 회원 ID 목록
    PRIMARY KEY (team_id)
);

-- 데이터 삽입
INSERT INTO team_bad2(team_id, name, member_ids) VALUES (1, '개발팀', '1,2');

select * from team_bad2;

DROP TABLE IF EXISTS team_bad3;
CREATE TABLE team_bad3 (
    team_id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    member_id_1 BIGINT NULL, -- 첫 번째 팀원
    member_id_2 BIGINT NULL, -- 두 번째 팀원
    member_id_3 BIGINT NULL, -- 세 번째 팀원 ... 언제까지 추가할 것인가?
    PRIMARY KEY (team_id)
);

-- 데이터 삽입
INSERT INTO team_bad3(name, member_id_1, member_id_2)
VALUES ('개발팀', 1, 2); -- 김개발(ID:1), 박개발(ID:2);

select * from team_bad3;

SELECT name FROM team_bad3
WHERE member_id_1 = 2 OR member_id_2 = 2 OR member_id_3 = 2;

DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS team;

CREATE TABLE team (
    team_id   BIGINT       NOT NULL AUTO_INCREMENT,
    name      VARCHAR(50)  NOT NULL,
    PRIMARY KEY (team_id),
    UNIQUE KEY uq_name (name)
);


DROP TABLE IF EXISTS member;

CREATE TABLE member (
    member_id   BIGINT       NOT NULL AUTO_INCREMENT,
    team_id     BIGINT       NULL, -- 팀에 소속되지 않은 회원이 있을 수 있다면 NULL 허용
    name        VARCHAR(50)  NOT NULL,
    PRIMARY KEY (member_id),
    CONSTRAINT fk_member_team FOREIGN KEY (team_id)
        REFERENCES team (team_id)
);


-- 팀 데이터 삽입
INSERT INTO team(name) VALUES ('개발팀'), ('디자인팀');

-- 김개발, 박개발 -> 개발팀 (team_id=1)
INSERT INTO member(team_id, name)
VALUES (1, '김개발'),
       (1, '박개발');

-- 최디자인 -> 디자인팀 (team_id=2)
INSERT INTO member(team_id, name)
VALUES (2, '최디자인');

-- 이기획 -> 팀 없음 (team_id=NULL)
INSERT INTO member(team_id, name)
VALUES (NULL, '이기획');


SELECT * FROM team;
SELECT * FROM member;