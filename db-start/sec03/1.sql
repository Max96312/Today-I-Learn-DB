
CREATE DATABASE my_shop;

USE my_shop;

CREATE TABLE sample (
	product_id INT PRIMARY KEY,
	name VARCHAR(100),
	price INT,
	stock_quantity INT,
	release_date DATE
);

DESC sample; -- 또는 DESCRIBE sample;

SHOW DATABASES;

SHOW TABLES;

DROP TABLE sample;

DROP TABLE sample;

DROP DATABASE my_shop;

-- 데이터베이스 생성
CREATE DATABASE my_shop;-- 데이터베이스 선택
USE my_shop;
-- 테이블 생성
CREATE TABLE sample (
product_id INT PRIMARY KEY,
name VARCHAR(100),
price INT,
stock_quantity INT,
release_date DATE
);