create table board(
num int(4) not null primary key auto_increment,
name  varchar(50) not null,
pass varchar(50) not null,
email varchar(50) not null,
title varchar(50) not null,
contents text(1000) not null,
writedate varchar(20),
readcount varchar(50)
);

show tables;

desc board;

drop table board;

select*from board;