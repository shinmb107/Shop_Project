create table cart(
c_num int(4) not null primary key auto_increment,
c_id varchar(50) not null,
c_img varchar(50) not null,
c_name varchar(50) not null,
c_pay varchar(50) not null,
c_day varchar(50) not null,
c_keep varchar(50) not null
);

show tables;

desc cart;

drop table cart;

select*from cart;

insert into cart(c_name, c_pay, c_set, c_organic, c_category)
values('a','1','c','d','e');




create table buy(
b_num int(4) not null primary key auto_increment,
b_id varchar(50) not null,
b_name varchar(50) not null,
b_email varchar(50) not null,
b_address varchar(50) not null,
b_img varchar(50) not null,
b_cname varchar(50) not null,
b_pay varchar(50) not null,
b_day datetime not null,
b_keep varchar(50) not null,
b_count varchar(50)
);

drop table buy;

select*from buy;