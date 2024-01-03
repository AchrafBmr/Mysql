-- EXERCICE 1 : --
create table CLIENT 
(
codeclt int primary key, 
nomclt varchar(50), 
prenomclt varchar(50), 
adresse varchar(50), 
cp int, 
ville varchar(50)
);


create table PRODUIT 
(
référence int primary key, 
désignation varchar(50), 
prix float
);


create table TECHNICIEN 
(
codetec int primary key, 
nomtec varchar(50), 
prenomtec varchar(50), 
tauxhoraire float
);


create table INTERVENTION 
(
numero int primary key, 
date datetime, 
raison varchar(50), 
codeclt int,
référence int,
codetec int,
foreign key (codeclt) references CLIENT (codeclt),
foreign key (référence) references PRODUIT (référence),
foreign key (codetec) references TECHNICIEN (codetec)
);

insert into CLIENT values
(1,'rami','ahmed','rue 15','12345','agadir'),
(2,'alaoui','khalid','avenue med5','67890','dakhla');
insert into CLIENT values
(3,'ait sasi','imane','lot 20','654321','boujdour');

insert into PRODUIT values
(10,'pc portable',1500),
(20,'impriment',999),
(30,'ecran',2000);
insert into PRODUIT values
(40,'pc bureu',1300),
(50,'clavier',300);


insert into TECHNICIEN values
(100,'jalaoui','jamal',20),
(200,'ait sasi','imane',18);

insert into INTERVENTION values
(1000,'2021-03-29','panne',1,20,100),
(2000,'2022-01-18','maintenance',2,10,200),
(3000,'2022-10-05','instalation',1,30,200);
insert into INTERVENTION values
(4000,'2023-12-20','en panne',2,50,100),
(5000,'2023-03-10','prob maj',1,10,100);

-- Q2:
delimiter //
create function Q2(v varchar(50))
returns int
begin
    declare nb int;
    select count(*) into nb from CLIENT where ville=v;
    return nb;
end //
select Q2('dakhla');

-- Q3:
delimiter //
create function Q33(n varchar(50))
returns int
begin
    declare nb int;
    select count(*) into nb  from INTERVENTION i inner join TECHNICIEN t on t.codetec=i.codetec where t.nomtec=n ;
    return nb;
end //
select Q33('ait sasi');


-- Q4:
delimiter //
create function Q4(nm varchar(50),d1 date,d2 date)
returns float
begin
declare somme float;
select sum(p.prix) into somme from INTERVENTION i inner join PRODUIT p inner join CLIENT c on i.référence=p.référence and i.codeclt=c.codeclt
and c.nomclt=nm and i.date between d1 and d2;
return somme;
end //
select Q4('rami','2021-12-12','2023-12-22') as result;


-- Q5:
delimiter //
create function Q55(d varchar(50))
returns int
begin
declare nb int;
select count(*) into nb from INTERVENTION i inner join PRODUIT p on i.référence=p.référence where p.désignation=d;
return nb;
end //
select Q55('pc portable');


-- Q6:
delimiter //
create function Q6666(code int)
returns varchar(50)
begin
    declare NPNI varchar(50);
    select CONCAT(c.nomclt, ' ', c.prenomclt, ' le nombre d’intervention est : ', count(*)) into NPNI from CLIENT c inner join INTERVENTION i on c.codeclt=i.codeclt group by c.codeclt having c.codeclt=code;
    return NPNI;
end //
select Q6666(1);


