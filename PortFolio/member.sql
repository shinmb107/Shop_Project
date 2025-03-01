show databases;

create table member(
	id varchar(50) not null primary key,
	pass varchar(50) not null,
	name varchar(50) not null,
	address varchar(50) not null,
	tel varchar(50) not null,
	email varchar(50) not null,
	seller varchar(50),
	date datetime
);

desc member;

show tables;

drop table member;

select*from member;

ALTER TABLE member
ADD tel varchar(50) not null;

ALTER TABLE member
DROP COLUMN seller;

UPDATE member
SET seller = '222-22-22222'
WHERE id = 'pa';

insert into member(id, pass, name, address, tel, email, seller, date)
values('manager','0000','매니저','충청남도 천안시','010-0000-0000','manager@email.com','000-00-00000','2024-08-30 19:58:00.0');

DELETE FROM member
WHERE id = 'manager';

select id, pass
from member
where pass=1111;