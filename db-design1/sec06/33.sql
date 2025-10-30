-- ## 논리적 모델링 - 관계

DROP TABLE IF EXISTS member_detail; -- 다른 예제에서 발생
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS team;

-- 팀 테이블 생성
CREATE TABLE team (
    team_id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (team_id)
);

-- 회원 테이블 생성
CREATE TABLE member (
    member_id BIGINT NOT NULL AUTO_INCREMENT,
    team_id BIGINT NULL, -- 회원은 팀에 소속되지 않을 수도 있다 (NULL 허용)
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (member_id),
    CONSTRAINT fk_member_team FOREIGN KEY (team_id)
        REFERENCES team (team_id)
);

-- 샘플 데이터 추가
INSERT INTO team(name) VALUES ('개발팀'), ('기획팀');
INSERT INTO member(name, team_id) VALUES ('션', 1), ('잡스', 1), ('네이트', 2);

select * from team;
select * from member;

SELECT
    m.name AS member_name,
    t.name AS team_name
FROM member m
JOIN team t ON m.team_id = t.team_id
WHERE m.name = '잡스';

SELECT
    t.name AS team_name,
    m.name AS member_name
FROM team t
JOIN member m ON t.team_id = m.team_id
WHERE t.name = '개발팀';