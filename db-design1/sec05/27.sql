-- 자연 키 vs 대리 키2 - 대리 키

DROP TABLE IF EXISTS orders_s;
DROP TABLE IF EXISTS member_s;

-- 올바른 설계
CREATE TABLE member_s (
    member_id   BIGINT       NOT NULL AUTO_INCREMENT, -- PK (대리 키)
    email       VARCHAR(50) NOT NULL,                -- 비즈니스 로직
    password    VARCHAR(255) NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    PRIMARY KEY (member_id),
    UNIQUE KEY uq_email (email) -- 고유해야 하는 자연 키는 UNIQUE로!
);

-- member_s 테이블을 안정적으로 참조하는 orders_s 테이블
CREATE TABLE orders_s (
    order_id    BIGINT       NOT NULL AUTO_INCREMENT,
    member_id   BIGINT       NOT NULL,                 -- FK
    ordered_at  DATETIME     NOT NULL,
    PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_member_s FOREIGN KEY (member_id) REFERENCES member_s (member_id)
);

-- 기존 이메일로 회원 가입
INSERT INTO member_s (email, password, name)
VALUES ('member1@old.com', 'hashed_password', '네이트');

-- 앞서 저장한 회원 ID 임시 저장
SET @last_member_id = LAST_INSERT_ID();

-- 해당 회원이 상품 주문
INSERT INTO orders_s (member_id, ordered_at)
VALUES (@last_member_id, NOW());

select * from member_s;
select * from orders_s;

UPDATE member_s
SET email = 'member1@new.com'
WHERE member_id = 1;

select * from member_s;
select * from orders_s;