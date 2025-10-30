-- ## 식별 관계 vs 비식별 관계 - 일대다(1:N)

DROP TABLE IF EXISTS comment_non_identifying;
DROP TABLE IF EXISTS board_non_identifying;

CREATE TABLE board_non_identifying (
    board_id BIGINT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    PRIMARY KEY (board_id)
);

CREATE TABLE comment_non_identifying (
    comment_id BIGINT NOT NULL AUTO_INCREMENT, -- 독립적인 PK
    board_id BIGINT NOT NULL, -- 일반 컬럼 + FK
    content TEXT NOT NULL,
    PRIMARY KEY (comment_id),
    CONSTRAINT fk_comment_board_non FOREIGN KEY (board_id)
        REFERENCES board_non_identifying (board_id)
);

-- 데이터 입력
INSERT INTO board_non_identifying (title) VALUES ('첫 번째 게시글'); -- board_id: 1
INSERT INTO board_non_identifying (title) VALUES ('두 번째 게시글'); -- board_id: 2

INSERT INTO comment_non_identifying (board_id, content) VALUES (1, '1번 글의 첫 댓글입니다.');  -- comment_id: 1
INSERT INTO comment_non_identifying (board_id, content) VALUES (1, '1번 글의 두 번째 댓글입니다.'); -- comment_id: 2
INSERT INTO comment_non_identifying (board_id, content) VALUES (2, '2번 글의 첫 댓글입니다.');  -- comment_id: 3

select * from board_non_identifying;
select * from comment_non_identifying;

DROP TABLE IF EXISTS comment_identifying;
DROP TABLE IF EXISTS board_identifying;

CREATE TABLE board_identifying (
    board_id BIGINT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    PRIMARY KEY (board_id)
);

CREATE TABLE comment_identifying (
    board_id BIGINT NOT NULL, -- PK의 일부 + FK
    comment_no BIGINT NOT NULL, -- PK의 일부, 해당 board_id 내에서 순차 증가
    content TEXT NOT NULL,
    PRIMARY KEY (board_id, comment_no), -- 복합 기본 키 (Composite PK)
    CONSTRAINT fk_comment_board_iden FOREIGN KEY (board_id)
        REFERENCES board_identifying (board_id)
);


-- 데이터 입력
INSERT INTO board_identifying (title) VALUES ('첫 번째 게시글'); -- board_id: 1
INSERT INTO board_identifying (title) VALUES ('두 번째 게시글'); -- board_id: 2

-- 애플리케이션 레벨에서 comment_no를 계산해서 넣어주어야 한다.
INSERT INTO comment_identifying (board_id, comment_no, content) VALUES (1, 1, '1번 글의 첫 댓글입니다.');
INSERT INTO comment_identifying (board_id, comment_no, content) VALUES (1, 2, '1번 글의 두 번째 댓글입니다.');
INSERT INTO comment_identifying (board_id, comment_no, content) VALUES (2, 1, '2번 글의 첫 댓글입니다.');

select * from board_identifying;
select * from comment_identifying;

-- 채번
select max(comment_no) + 1 as next_comment_no
from comment_identifying
where board_id = 1;