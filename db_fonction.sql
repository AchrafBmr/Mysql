create database db_fonction;
use db_fonction;

-- Q1:
delimiter //
create function affichage()
returns varchar(50)
begin
return 'bonjour mysql';
end //
select affichage();


-- Q2:
delimiter //
create function factoriale1(x int)
returns int
begin
declare f int default 1;
declare i int default 1;
while i<=x do
set f=f*i;
set i=i+1;
end while;
return f;
end //
select factoriale1(5);