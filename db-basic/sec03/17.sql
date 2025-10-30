select
	s.size,
    c.color
from sizes s
cross join colors c;

select
    concat('기본티셔츠-', c.color, '-', s.size) as product_name,
	s.size,
    c.color
from sizes s
cross join colors c;

CREATE TABLE product_options (
	option_id BIGINT AUTO_INCREMENT,
	product_name VARCHAR(255) NOT NULL,
	size VARCHAR(10) NOT NULL,
	color VARCHAR(20) NOT NULL,
	PRIMARY KEY (option_id)
);

select * from product_options;

insert into product_options (product_name, size, color)
select
    concat('기본티셔츠-', c.color, '-', s.size) as product_name,
	s.size,
    c.color
from sizes s
cross join colors c;

select * from product_options;