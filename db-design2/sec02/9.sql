ALTER TABLE common_code_detail
ADD COLUMN attr1 VARCHAR(100),
ADD COLUMN attr2 VARCHAR(100),
ADD COLUMN attr3 VARCHAR(100);

-- 회원 등급별 할인율 설정
UPDATE common_code_detail SET attr1 = '0' WHERE group_code = 'MEMBER_GRADE' AND code = 'NORMAL';
UPDATE common_code_detail SET attr1 = '5' WHERE group_code = 'MEMBER_GRADE' AND code = 'VIP';
UPDATE common_code_detail SET attr1 = '10' WHERE group_code = 'MEMBER_GRADE' AND code = 'VVIP';

-- 결제 수단별 수수료율 설정
UPDATE common_code_detail SET attr1 = '2.5' WHERE group_code = 'PAYMENT_METHOD' AND code = 'CARD';
UPDATE common_code_detail SET attr1 = '0' WHERE group_code = 'PAYMENT_METHOD' AND code = 'BANK';
UPDATE common_code_detail SET attr1 = '0' WHERE group_code = 'PAYMENT_METHOD' AND code = 'VIRTUAL';
UPDATE common_code_detail SET attr1 = '3.0' WHERE group_code = 'PAYMENT_METHOD' AND code = 'MOBILE';

SELECT group_code, code, name, attr1
FROM common_code_detail
WHERE group_code IN ('MEMBER_GRADE', 'PAYMENT_METHOD')
ORDER BY group_code, sort_order;

ALTER TABLE common_code_group
ADD COLUMN attr1_name VARCHAR(50),
ADD COLUMN attr2_name VARCHAR(50),
ADD COLUMN attr3_name VARCHAR(50);

UPDATE common_code_group SET attr1_name = '할인율(%)' WHERE group_code = 'MEMBER_GRADE';
UPDATE common_code_group SET attr1_name = '수수료율(%)' WHERE group_code = 'PAYMENT_METHOD';

SELECT group_code, group_name, attr1_name
FROM common_code_group
WHERE group_code IN ('MEMBER_GRADE', 'PAYMENT_METHOD');