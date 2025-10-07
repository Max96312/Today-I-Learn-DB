-- ## 자연 키 vs 대리 키1 - 자연 키

-- 데이터베이스가 존재하지 않으면 생성
CREATE DATABASE IF NOT EXISTS my_shop3;
USE my_shop3;


DROP TABLE IF EXISTS orders_n;
DROP TABLE IF EXISTS member_n;

-- 잘못된 설계의 시작
CREATE TABLE member_n (
    email       VARCHAR(50)  NOT NULL, -- PK (자연 키)
    password    VARCHAR(255) NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    PRIMARY KEY (email)
);

-- member 테이블을 참조하는 orders 테이블
CREATE TABLE orders_n (
    order_id      BIGINT       NOT NULL AUTO_INCREMENT,
    member_email  VARCHAR(50)  NOT NULL, -- FK
    ordered_at    DATETIME     NOT NULL,
    PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_member_n FOREIGN KEY (member_email)
        REFERENCES member_n (email)
);

-- 기존 이메일로 회원 가입
INSERT INTO member_n (email, password, name)
VALUES ('member1@old.com', 'hashed_password', '네이트');

-- 해당 회원이 상품 주문
INSERT INTO orders_n (member_email, ordered_at)
VALUES ('member1@old.com', NOW());

select * from member_n;
select * from orders_n;

UPDATE member_n SET email = 'member1@new.com' WHERE email = 'member1@old.com';