create database ex_aftan;
use ex_aftan;
create table Styliste (
  NumStyliste int primary key,
  NomStyliste varchar(50),
  AdrStyliste varchar(50)
);
insert into Styliste values
(1, 'Styliste 1', 'Adresse 1'),
(2, 'Styliste 2', 'Adresse 2'),
(3, 'Styliste 3', 'Adresse 3');
create table Caftan (
  NumCaftan int primary key,
  DesignationCaftan varchar(50),
  NumStyliste int,
  foreign key (NumStyliste) references Styliste(NumStyliste)
);
insert into Caftan values
(11, 'Caftan 1', 1),
(22, 'Caftan 2', 2),
(33, 'Caftan 3', 3);
create table MembreJury (
  NumMembreJury int primary key,
  Nom varchar(50),
  Fonction varchar(50)
);
insert into MembreJury values
(10, 'Membre 1', 'Fonction 1'),
(20, 'Membre 2', 'Fonction 2'),
(30, 'Membre 3', 'Fonction 3');
create table NotesJury (
  NumCaftan int,
  NumMembre int,
  Note float,
  foreign key (NumCaftan) references Caftan(NumCaftan),
  foreign key (NumMembre) references MembreJury(NumMembreJury),
  primary key (NumCaftan)
);
insert into NotesJury values
(11, 10, 8.5),
(22, 30, 8.5),
(33, 20, 6);


create table Fonction (
  Fonction varchar(50) primary key
);
insert into Fonction values
('Fonction 1'),
('Fonction 2'),
('Fonction 3');

-- Q1:
delimiter //
create procedure DisplayCaftanList()
begin
    select c.NumCaftan, c.DesignationCaftan, s.NomStyliste, s.AdrStyliste
    from Caftan c
    inner join Styliste s on c.NumStyliste = s.NumStyliste;
end //
call DisplayCaftanList();


-- Q2:
delimiter //
create procedure nubCafs(in cNumber int)
begin
    select c.DesignationCaftan, s.NomStyliste, s.AdrStyliste from Caftan c
    inner join Styliste s on c.NumStyliste = s.NumStyliste
    where c.NumCaftan = cNumber;
end //
call nubCafs(11);


-- Q3:
delimiter //
create procedure nub2Cafs(in cNumber int)
begin
    select nj.NumMembre, mj.Nom, mj.Fonction, nj.Note from NotesJury nj
    inner join MembreJury mj on nj.NumMembre = mj.NumMembreJury
    where nj.NumCaftan = cNumber;
end //
call nub2Cafs(11);


-- Q4:
DELIMITER //
create function GetTCaftans()
returns int
begin
    declare totalCaftans int; 
    select count(*) into totalCaftans from Caftan;
    return totalCaftans;
end //
select GetTCaftans();


-- Q5:
DELIMITER //
create procedure GetNCaftanMember1(in caftanNumber int, in memberNumber int, out note float)
begin
    select Note into note from NotesJury 
    where NumCaftan = caftanNumber and NumMembre = memberNumber;
end //
call GetNCaftanMember1(22,10,@n);
select @n;


-- Q6:
DELIMITER //
create function GetNCaftan(cN int)
returns float
begin
    declare avgNote float;
    select avg(Note) into avgNote from NotesJury where NumCaftan = cN;
    return avgNote;
end //
select GetNCaftan(11);



