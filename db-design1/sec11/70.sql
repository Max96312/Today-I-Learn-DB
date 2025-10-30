-- ## 데이터 타입2 - 날짜와 시간 타입

DROP TABLE IF EXISTS board_sample;

CREATE TABLE board_sample (
    board_id    BIGINT          NOT NULL AUTO_INCREMENT,
    title       VARCHAR(255)    NOT NULL,
    content     TEXT            NULL,
    created_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (board_id)
);

INSERT INTO board_sample (title, content) VALUES ('첫 번째 게시글', '게시글 내용입니다.');

SELECT board_id, title, created_at, updated_at FROM board_sample;

UPDATE board_sample
SET content = '게시글 내용이 수정되었습니다.'
WHERE board_id = 1;

SELECT board_id, title, created_at, updated_at FROM board_sample;