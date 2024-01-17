create database Rev;
use Rev;
create table Compte(
id_compte int primary key,
name varchar(50),
solde decimal(12,2)
);
select * from Compte;
call Trans();

delimiter //
create procedure Trans()
begin
declare s1 decimal(12,2);
select solde into s1 from Compte where id_compte=1;
start transaction;
update Compte set solde=solde-1000 where id_compte=1;
update Compte set solde=solde+1000 where id_compte=2;
if s1>=1000 then
	commit;
else
	rollback;
end if;
end //




##############Les curseurs##################
create table Clients(
id int primary key,
nom varchar(50),
prenom varchar(50)
);
insert into Clients values
(1,'rami','ahmed'),(2,'alaloui','khalid'),
(3,'amrani','fatima'),(4,'jalaoui','imane')



delimiter //
create procedure Test()
begin
declare res varchar(500) default '';
select concat(id,'-',nom,'-',prenom) into res from Clients where id=1;
select res;
end //
call Test();








delimiter //
create procedure Liste_clients(inout Result varchar(6000))
begin
declare finish int default 0;
declare id_c int;
declare nom_c varchar(50);
declare prenom_c varchar(50);
declare ligne varchar(500);
declare cur_clients cursor for select id,nom,prenom from Clients;
declare continue handler for not found set finish=1;
open cur_clients;
	myloop: loop
    fetch cur_clients into id_c,nom_c,prenom_c;
    if  finish=1 then
		leave myloop;
    end  if;
    set ligne=concat(id_c,'-',nom_c,'-',prenom_c);
    set Result=concat(Result,'|',ligne);
    end loop myloop;
close cur_clients;
end //
##################Appel procedure##################################
set @r='';
call Liste_clients(@r);
select @r as 'Liste Clients';
###################################################################











create table Etudiants(
cd int primary key,
nom varchar(50),
moyenne decimal(10,2)
)
insert into Etudiants values
(1,'mohamed',19),
(2,'khalid',8),
(3,'fatima',16),
(4,'salim',11),
(5,'sara',6),
(6,'omar',12);
/*Afficher la liste des etudiant qui 
ont la moyenne en utilisant le curseur*/








