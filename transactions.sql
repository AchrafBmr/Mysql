create database transactions;
use transactions;
create table compte(
numcompte int primary key,
solde float
);
insert into compte values 
(1,10000),(2,0);
select * from compte;

delimiter //
create procedure tr11()
begin
start transaction;
update compte set solde=solde-200 where numcompte=1;
update compte set solde=solde+200 where numcompte=2;
set @s1=(select solde from compte where numcompte=1);
if @s1>=0 then commit;
else rollback;
end if;
end //
call tr11;



-- ----------------------------------------------------------------




CREATE TABLE client(
    codec int PRIMARY KEY,
    nom VARCHAR(50)
);
insert into client values
(1,'rami'),(2,'alaoui');

DELIMITER //
CREATE Procedure supp(code int)
BEGIN
start TRANSACTION;
if code in (SELECT codec from client) THEN
BEGIN
delete from client where codec=code;
select * from client;
COMMIT;
end;
ELSE
BEGIN
ROLLBACK;
SELECT 'client exist pas ' as message;
end;
end if;
end //
call supp(1);