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

select cd,nom,moyenne from Etudiants;
delimiter //
create procedure Cur_Et()
begin
declare res text default '';
declare finish int default 0;
declare cdEt int;
declare nomEt varchar(50);
declare moyEt decimal(10,2);
declare ligne varchar(500);
declare curEtudiant cursor for select cd,nom,moyenne from Etudiants 
where moyenne>=10;
declare continue handler for not found set  finish=1;
open curEtudiant;
	lp: loop
		fetch curEtudiant into cdEt,nomEt,moyEt;
        if finish=1 then
			leave lp;
        end if;
        set ligne=concat(cdEt," ",nomEt," ",moyEt);
        set res=concat(res,'/',ligne);
	end loop lp;
    select res as 'Liste Etudiant';
close curEtudiant;
end //

call Cur_Et();










DROP PROCEDURE Cur_Et







Declare Nom_curseur cursor for instruction select
open Nom_curseur;
fetch Nom_curseur into liste_variables;
close Nom_curseur;






/*TP CURSOR*/
create table t1(
id int primary key,
nom varchar(50),
moy decimal(10,2)
)
create table t2(
cd int primary key,
mess1 varchar(50),
mess2 varchar(50)
)
create table t3(
ref int primary key auto_increment,
nom varchar(50),
mention varchar(50)
)
insert into t1 values(1,'rami',19),(2,'alaoui',8),(3,'enouri',16);
insert into t2 values(11,'admis','non admis');
select * from t3;
delimiter //
create procedure CurTP()
begin
	declare finish int default 0;
    declare n varchar(50);
    declare m decimal(12,2);
    declare cur1 cursor for select nom,moy from t1;
    declare continue handler for not found set finish=1;
    open cur1;
	lp: loop
		    fetch cur1 into n,m;
            if finish=1 then
				leave lp;
            end if;
            if m>=10 then
				insert into t3  values('',n,'admis');
            else
				insert into t3 values('',n,'non admis');
            end if;
	end loop lp;
    close cur1;
end //



drop procedure CurTP
call CurTP();

select * from t3



create table table1(
id int primary key,
note1 decimal(10,2)
);
create table table2(
id int primary key,
note2 decimal(10,2)
);
create table table3(
id int primary key,
somme decimal(10,2)
);






insert into table1 values(1,15),(2,18);
insert into table2 values(1,5),(2,11);




delimiter //
create procedure Cur_somme()
begin
declare finish int default 0;
declare n1 decimal(12,2);
declare n2 decimal(12,2);
declare idd int;
declare c1 cursor for select id,note1 from table1;
declare c2 cursor for select note2 from table2;
declare continue handler for not found set finish=1;
open c1;
open c2;
lp: loop
	fetch c1 into idd,n1;
    fetch c2 into n2;
    if finish=1 then
		leave lp;
    end if;
    insert into table3 values(idd,n1+n2);
end loop lp;
close c1;
close c2;
end //




call Cur_somme();
select * from table3;















/*LES DECLENCHEURS (trigger)*/

/*
Syntaxe:
CREATE TRIGGER [nom_declencheur] [before|afler]
{insert|update|delete}
ON [nom_table]
[for each row]
[corps_declencheur]



*/
/*TP declencheur*/
select * from Compte;
select * from Client;
delete from Compte where NumCompte=5
create table Compte(
NumCompte int primary key,
solde decimal(12,2),
TypeCompte varchar(50) check (TypeCompte='CC' or TypeCompte='CE'),
NumCl  varchar(50),
foreign key(NumCl) references Client(CIN)
)
create table Client(
CIN varchar(50) primary key,
nom varchar(50),
prenom varchar(50),
adr varchar(50),
tel varchar(50)
)
create table Operation(
NumOp int primary key auto_increment,
TypeOp varchar(50),
MontantOp decimal(12,2),
NumCpt int,
DateOp date default now(),
foreign key(NumCpt) references Compte(NumCompte)
)
insert into Client values
('BBBB','BB','BB','CASA','0666666666'),
insert into Client values
('AB2222','AAA','BBB','FES','0666666666'),

('DE1487','Alaoui','khalid','Agadir','0668798548'),
('AR1234','Jalaoui','fatima','Rabat','0587255487');

insert into Compte values(1,10000,'CC','JE2656')
insert into Compte values(2,8000,'CC','DE1487')
insert into Compte values(3,11000,'CC','AR1234')
insert into Compte values(4,20000,'CE','JE2656')
insert into Compte values(5,9800,'CC','JE2656')



delimiter //
create procedure Test2(in numc int,in solde decimal(10,2),in Ty varchar(50),in cinCl varchar(50))
begin
start transaction;
set @nb=0;
select count(*) into @nb from Compte where NumCl=cinCl and TypeCompte='CC';
insert into Compte values(numc,solde,Ty,cinCl);
if @nb<1 or Ty='CE' then 
	commit;
else
	rollback;
end if;
end //

drop procedure TestCC;

select * from Compte;
call Test2(8,55555,'CE','DE1487');

insert into Compte values(9,100000,'CC','DE1487');


delete from Compte where NumCompte=5





delimiter //
CREATE TRIGGER Q_Trig before insert
ON Compte
for each row 
begin
	declare nbc int;
	select count(*) into @nbc from Compte where NumCl=new.NumCl and TypeCompte='CC';
    if @nbc>=1 and new.TypeCompte='CC' then
		signal sqlstate '45000'
        set message_text='Impossible de creer plus du\'un compte courant au meme client';
    end if;
end //



select * from Compte;
insert into Compte values(13,100000,'CC','AB2222');

SHOW TRIGGERS
drop trigger TP_AJOUT_COMPTE
/* =============================  Q1  ============================ */

delimiter //
CREATE TRIGGER TP_AJOUT_COMPTE before insert
ON Compte
for each row 
begin
    if new.solde <= 1500 and new.TypeCompte='CC' then
		signal sqlstate '45000'
        set message_text='Impossible de creer un compte avec un sold <= 1500';
    end if;
end //
-- test question 1 de solde > 1500

SELECT * FROM Compte;
SELECT * from Client;

DELETE FROM Compte where NumCompte = 18
INSERT INTO Client VALUES("JH3321","Dani","Mohamed","Rhamna","065587414");
insert into Compte values(19,500,'CE','JH3321');
insert into Compte values(20,0,'CE','JH3321');











delimiter //
create trigger supp_compte before delete
on Compte
for each row
begin
	if old.solde>0 then
		signal sqlstate '45000'
        set message_text='Impossible de supprimer un compte avec un solde n\est 0';
	end if;
end //

select * from Compte;
select * from Operation;

DELETE FROM Operation where numOp in (10, 11); 
SHOW TRIGGERS;
DROP TRIGGER Update_compte;



insert into Operation values(10,'retait',1000,2,'');
insert into Operation (NumOp,TypeOp,MontantOp,NumCpt) values(11,'verment',2000,3);

delete from Compte where NumCompte=20



delimiter //
create trigger Update_compte before update on Compte
for each row
begin
	declare nbop int;
    select count(*) into @nbop from Operation where NumCpt=old.NumCompte;
    if @nbop>0 then
		signal sqlstate '45000'
        set message_text='Impossible de modifier un compte qui a des operations';
    end if;
end//


select * from Operation;
update Compte set TypeCompte='CE' where NumCompte=3;


















create table Employ (
NEmploye int primary key,
nom varchar(50),
pr nom varchar(50),
salaire decimal(12,2)
)
create table Journal(
message Text
)
insert into Employ  values(100,'Rami','ahmed',9000);
insert into Employ  values(101,'Alaoui','khalid',8500);
insert into Employ  values(102,'Ellali','fatima',10000);



delimiter //
create trigger insert_message after delete on Employ 
for each row
begin
	insert into Journal values(concat('L\'employe ',old.NEmploye,
    ' a  t  supprim  le ',current_timestamp));
end //


select * from Employ ;
select * from Journal;
delete from Employ  where NEmploye=101




















create table Testdate(
id int,
date1 date default now(),
date2 timestamp default current_timestamp
)
select * from Testdate;
insert into Testdate (id) value(2)




create table Etudiant (
CodeEt int primary key,
nom varchar(50),
Note decimal(10,2)
)
create table Detais(
id int primary key,
Somme_Note decimal(10,2),
Nombre_Et int
)
/*Chaque mise   jour de la table Etudiant modifier la table detais*/


insert into Detais values(1,0,0)
delimiter //
create trigger tr1 after insert on Etudiant
for each row
begin
	declare somme decimal(10,2);
    declare nombre int;
    select sum(Note) into somme from Etudiant;
    select count(*) into nombre from Etudiant;
	update Detais  set Somme_Note=somme ,Nombre_Et=nombre where id=1;
end //




delimiter //
create trigger tr2 after update on Etudiant
for each row
begin
	declare somme decimal(10,2);
    select sum(Note) into somme from Etudiant;
	update Detais  set Somme_Note=somme where id=1;
end //








select * from Detais;
select * from Etudiant;

insert into Etudiant values(2,'allaoui',15);
update Etudiant set Note=11 where CodeEt=2;







delimiter //
create trigger tr3 after delete on Etudiant
for each row
begin
	declare somme decimal(10,2);
    declare nombre int;
    select sum(Note) into somme from Etudiant;
    select count(*) into nombre from Etudiant;
	update Detais  set Somme_Note=somme ,Nombre_Et=nombre where id=1;
end //





/*
before insert
before update
before delete
--------------------------------
after insert
after update
after delete
*/

select * from Compte;
select * from Operation;

INSERT INTO Operation VALUES (2,'Vairment',500,5,now());

DELIMITER //
CREATE TRIGGER insertOp AFTER INSERT ON Operation
FOR EACH ROW
BEGIN
	IF NEW.TypeOp = 'Retrait' THEN
	UPDATE Compte SET solde = solde - NEW.montantOp WHERE NumCompte = NEW.NumCpt;
    ELSEIF NEW.TypeOp = 'Vairment' THEN
    UPDATE Compte SET solde = solde + NEW.montantOp WHERE NumCompte = NEW.NumCpt;
    END IF;
END//







