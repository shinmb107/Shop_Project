create table product(
p_num int not null primary key auto_increment,
p_id varchar(50) not null,
p_img varchar(50) not null,
p_name varchar(50) not null,
p_pay varchar(50) not null,
p_count int not null,
p_day datetime not null,
p_category varchar(50) not null,
p_keep varchar(50) not null,
p_set varchar(50) not null,
p_organic varchar(50) not null,
p_explan text,
p_regdate varchar(50) not null,
p_buycount int DEFAULT 0
);

drop table product;

SHOW TABLES;

desc product;

show tables;

SELECT * FROM product

ALTER TABLE product
ALTER COLUMN p_img SET DATA TYPE varchar(50);

UPDATE product SET p_pay = '60000' WHERE p_num = 6;