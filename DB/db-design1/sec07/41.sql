-- ## 일대일(1:1) 관계 - [실습] 관계 확장의 유연성

DROP TABLE IF EXISTS upload_file;
DROP TABLE IF EXISTS board;

-- 게시글 테이블
CREATE TABLE board (
    board_id BIGINT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NULL,
    PRIMARY KEY (board_id)
);

CREATE TABLE upload_file (
    upload_file_id   BIGINT        NOT NULL AUTO_INCREMENT,
    board_id  BIGINT        NOT NULL,
    upload_file_name VARCHAR(255)  NOT NULL,
    PRIMARY KEY (upload_file_id),
    UNIQUE KEY uq_board_id (board_id), -- 이 제약조건으로 1:1 관계를 보장
    CONSTRAINT fk_upload_file_board FOREIGN KEY (board_id) REFERENCES board(board_id)
);

desc upload_file;

INSERT INTO board(title, content) VALUES ('1:1 관계 테스트', '하나의 파일만 첨부됩니다.');

select * from board;

INSERT INTO upload_file(board_id, upload_file_name) VALUES (1, 'document.pdf');

select * from upload_file;

-- INSERT INTO upload_file(board_id, upload_file_name) VALUES (1, 'image.jpg');

SELECT
    b.board_id,
    b.title,
    f.upload_file_id,
    f.upload_file_name
FROM board b
JOIN upload_file f ON b.board_id = f.board_id
ORDER BY f.upload_file_id;

-- 1단계: 외래 키(Foreign Key) 제약조건 삭제 (MySQL에서는 인덱스 변경 전 FK를 먼저 삭제해야 한다)
ALTER TABLE upload_file DROP FOREIGN KEY fk_upload_file_board;

-- 2단계: 기존 UNIQUE 인덱스 삭제
ALTER TABLE upload_file DROP INDEX uq_board_id;

-- 3단계: 외래 키 제약조건 다시 추가 (유니크 인덱스 -> 일반 인덱스)
ALTER TABLE upload_file ADD CONSTRAINT fk_upload_file_board FOREIGN KEY (board_id)
REFERENCES board (board_id);

desc upload_file;

INSERT INTO upload_file(board_id, upload_file_name) VALUES (1, 'image.jpg');
INSERT INTO upload_file(board_id, upload_file_name) VALUES (1, 'data.csv');

SELECT
    b.board_id,
    b.title,
    f.upload_file_id,
    f.upload_file_name
FROM board b
JOIN upload_file f ON b.board_id = f.board_id
ORDER BY f.upload_file_id;