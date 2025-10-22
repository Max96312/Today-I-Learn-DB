-- ## BCNF 정규형

DROP TABLE IF EXISTS special_lecture_bcnf_violating;

-- BCNF를 위반하는 테이블 생성
CREATE TABLE special_lecture_bcnf_violating (
    student_id     INT NOT NULL,
    lecture_name   VARCHAR(50) NOT NULL,
    professor_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (student_id, lecture_name)
);

-- 데이터 삽입
INSERT INTO special_lecture_bcnf_violating (student_id, lecture_name, professor_name) VALUES
(101, '데이터베이스', '김교수'),
(101, '자바', '서교수'),
(102, '데이터베이스', '박교수'),
(103, '자바', '서교수');

select * from special_lecture_bcnf_violating;

DROP TABLE IF EXISTS enrollment_bcnf;
DROP TABLE IF EXISTS professor_bcnf;

-- 1. professor 테이블 생성 (교수와 담당 특강 정보)
CREATE TABLE professor_bcnf (
    professor_name VARCHAR(50) NOT NULL,
    lecture_name   VARCHAR(50) NOT NULL,
    PRIMARY KEY (professor_name)
);

-- 2. enrollment 테이블 생성 (수강 신청 정보)
CREATE TABLE enrollment_bcnf (
    student_id     INT NOT NULL,
    professor_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (student_id, professor_name),
    FOREIGN KEY (professor_name) REFERENCES professor_bcnf (professor_name)
);


-- professor_bcnf 데이터 삽입 (교수-특강 정보는 중복 없이 저장된다)
INSERT INTO professor_bcnf (professor_name, lecture_name) VALUES
('김교수', '데이터베이스'),
('서교수', '자바'),
('박교수', '데이터베이스');

-- enrollment_bcnf 데이터 삽입
INSERT INTO enrollment_bcnf (student_id, professor_name) VALUES
(101, '김교수'),
(101, '서교수'),
(102, '박교수'),
(103, '서교수');


SELECT * FROM professor_bcnf;

SELECT * FROM enrollment_bcnf;