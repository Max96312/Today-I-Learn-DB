DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS team;

CREATE TABLE team (
    team_id   BIGINT       NOT NULL AUTO_INCREMENT,
    name      VARCHAR(50)  NOT NULL,
    PRIMARY KEY (team_id)
);

CREATE TABLE member (
    member_id   BIGINT       NOT NULL AUTO_INCREMENT,
    team_id     BIGINT       NULL, -- NULL 허용으로 선택적 참여 구현
    name        VARCHAR(50)  NOT NULL,
    PRIMARY KEY (member_id),
    CONSTRAINT fk_member_team FOREIGN KEY (team_id)
        REFERENCES team (team_id)
);

INSERT INTO member(name, team_id) VALUES ('이기획', NULL);

SELECT * FROM member;

DROP TABLE IF EXISTS member;

CREATE TABLE member (
    member_id   BIGINT       NOT NULL AUTO_INCREMENT,
    team_id     BIGINT       NOT NULL, -- NOT NULL로 필수적 참여 구현
    name        VARCHAR(50)  NOT NULL,
    PRIMARY KEY (member_id),
    CONSTRAINT fk_member_team FOREIGN KEY (team_id)
        REFERENCES team (team_id)
);

INSERT INTO member(name, team_id) VALUES ('이기획', NULL);