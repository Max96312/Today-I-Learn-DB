-- ## 복합키 설계

DROP TABLE IF EXISTS popcorn_order_c;
DROP TABLE IF EXISTS movie_reservation_c;

CREATE TABLE movie_reservation_c (
    movie_title      VARCHAR(100) NOT NULL, -- 영화 제목
    screening_dt     DATETIME     NOT NULL, -- 상영 시작 시간
    seat_number      VARCHAR(10)  NOT NULL, -- 좌석 번호
    reserver_name    VARCHAR(50)  NOT NULL, -- 예매자 이름

    -- 복합키: movie_title + screening_dt + seat_number를 기본 키로 설정
    PRIMARY KEY (movie_title, screening_dt, seat_number)
);

CREATE TABLE popcorn_order_c (
    popcorn_order_id BIGINT       NOT NULL AUTO_INCREMENT,
    movie_title      VARCHAR(100) NOT NULL, -- FK1
    screening_dt     DATETIME     NOT NULL, -- FK2
    seat_number      VARCHAR(10)  NOT NULL, -- FK3
    popcorn_name     VARCHAR(50),
    PRIMARY KEY (popcorn_order_id),
    FOREIGN KEY (movie_title, screening_dt, seat_number)
        REFERENCES movie_reservation_c (movie_title, screening_dt, seat_number)
);

-- 샘플 데이터 삽입
INSERT INTO movie_reservation_c (movie_title, screening_dt, seat_number, reserver_name)
VALUES ('매트릭스1', '2025-08-31 19:30:00', 'F8', '네이트');

select * from movie_reservation_c;
select * from popcorn_order_c;

INSERT INTO popcorn_order_c (popcorn_order_id, movie_title, screening_dt, seat_number, popcorn_name)
VALUES (101, '매트릭스1', '2025-08-31 19:30:00', 'F8', '카라멜/치토스 팝콘');

SELECT
    mr.reserver_name,
    po.popcorn_order_id,
    po.popcorn_name
FROM
    popcorn_order_c po
JOIN
    movie_reservation_c mr
ON
    po.movie_title = mr.movie_title
    AND po.screening_dt = mr.screening_dt
    AND po.seat_number = mr.seat_number
WHERE
    po.popcorn_order_id = 101;

DROP TABLE IF EXISTS popcorn_order_s;
DROP TABLE IF EXISTS movie_reservation_s;

-- 예매 테이블 (대리 키 사용)
CREATE TABLE movie_reservation_s (
    reservation_id   BIGINT       NOT NULL AUTO_INCREMENT, -- 대리 키 PK
    movie_title      VARCHAR(100) NOT NULL,
    screening_dt     DATETIME     NOT NULL,
    seat_number      VARCHAR(10)  NOT NULL,
    reserver_name    VARCHAR(50)  NOT NULL,
    PRIMARY KEY (reservation_id),
    -- 자연 키 부분에 UNIQUE 제약으로 데이터 무결성 보장
    UNIQUE KEY uq_movie_reservation (movie_title, screening_dt, seat_number)
);

-- 팝콘 주문 테이블 (대리 키 참조)
CREATE TABLE popcorn_order_s (
    popcorn_order_id BIGINT      NOT NULL AUTO_INCREMENT,
    reservation_id   BIGINT      NOT NULL, -- 단순화된 FK
    popcorn_name     VARCHAR(50),
    PRIMARY KEY (popcorn_order_id),
    FOREIGN KEY (reservation_id) REFERENCES movie_reservation_s (reservation_id)
);

-- 샘플 데이터 삽입
INSERT INTO movie_reservation_s (movie_title, screening_dt, seat_number, reserver_name)
VALUES ('매트릭스1', '2025-08-31 19:30:00', 'F8', '네이트');

select * from movie_reservation_s;
select * from popcorn_order_s;

-- movie_reservation_s 테이블에 방금 입력된 reservation_id는 1이다.
INSERT INTO popcorn_order_s (reservation_id, popcorn_name)
VALUES (1, '카라멜/치토스 팝콘');

-- popcorn_order_id가 1인 주문 조회
SELECT
    mr.reserver_name,
    po.popcorn_order_id,
    po.popcorn_name
FROM
    popcorn_order_s po
JOIN
    movie_reservation_s mr ON po.reservation_id = mr.reservation_id
WHERE
    po.popcorn_order_id = 1;