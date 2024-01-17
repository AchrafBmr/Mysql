<<<<<<< HEAD
-- Active: 1698057065951@@127.0.0.1@3306
=======
>>>>>>> 23a232df680670b0c6409a00c2866ff3466fabba
CREATE DATABASE Revision;
USE Revision;
CREATE TABLE Etudiant(
    codeEt VARCHAR(50) NOT NULL PRIMARY KEY ,
    nom VARCHAR(50),
    age INT ,
    moyenne DECIMAL(10,2)
);


INSERT INTO Etudiant VALUES
("E1","rami",16,19.5),
("E2","alaoui",11,15.25),
("E3","ait sasi",15,9)


/*Q1) requete pour afficher tous les etudiants */
select * from Etudiant
/*Q2) requete pour afficher le nom et l'age de tous les etudiants */
select nom,age from Etudiant
/*Q3) requete  pour afficher l'etudiant 
select * from Etudiant where codeEt='E3'
/*Q4) requete qui permet d'afficher ts 
les informations sur les etudiants dont age > 10  */
select * from Etudiant where age > 15
/*Q5) requete qui permet d'afficher ts 
les informations sur les etudiants dont age compris entre 11 et 16  */
select * from Etudiant where age >11 and age<16
select * from Etudiant where age between 11 and 16 ;
/*Q6 les etudiants dont leur nom commence par la lettre a  */

select * from Etudiant where like 'a%';
select * from Etudiant;
/*---Mise A jour les Enregistrement---*/
/*Q7 modifier l'age  de Etudiant E3 par 16  */
update Etudiant set age=16 where codeET='E3';
/*Q8 modifier l'age et le nom  de Etudiant E2  */
UPDATE Etudiant set age=18 , nom='raji' , moyenne=8 where codeEt='E2';
/*Q9 supprimer l'Etudiant E3 */
delete from Etudiant where codeEt='E3';
/*Q10 Ajouter le champs genre de type char à la table Etudiant */
Alter table Etudiant 
ADD genre char;
/*Q11 Modifier le type de column moyenne par float */
Alter table Etudiant
MODIFY COLUMN moyenne FLOAT;
/*Q12 supprimer la column genre*/
Alter table Etudiant
drop COLUMN genre;
/*Q13 Ajouter la column date naissance de type date et la column ville varchar(50)*/
Alter table Etudiant
ADD  date_naissance date,
ADD  ville VARCHAR(50) after nom; 
/*Q14 modifier la column ville par adresse*/
ALTER Table Etudiant
CHANGE COLUMN ville adress VARCHAR(100);
/*Q15 modifier le nom de la table Etudiant par Stagiaire*/
ALTER TABLE Etudiant
RENAME To Stagiaires;
alter table Stagiaires
drop COLUMN date_naissance;
select * from Stagiaires;
update Stagiaires SET adress='dakhla' where codeEt='E1';
update Stagiaires SET adress='agadir' where codeEt='E2';

insert into Stagiaires values
('E3','jalaoui','dakhla',20,14),
('E4','alaloui','casa',19,10),
('E5','benani','dakhla',18,8);







/*Q16 afficher les adress sans duplicate*/
SELECT DISTINCT adress from Stagiaires;
SELECT adress from Stagiaires GROUP BY adress;

/*Q17 trouver combient de stagiaires de chaque adress*/
SELECT adress,COUNT(*)as 'Nombre stg' from Stagiaires GROUP BY adress;
/*Q18 afficher les adresses dans le nombre de stags superieur à 2*/
SELECT adress,COUNT(*)as 'Nombre stg' from Stagiaires 
GROUP BY adress HAVING COUNT(*)>2;
/*Q19 classer par order croissant l'ages des stagaires*/
SELECT * from Stagiaires ORDER BY age ASC;
/*Q20 classer par order decroissant la moyenne des stagaires*/
SELECT * from Stagiaires ORDER BY moyenne DESC LIMIT 3;
/*Q21 caculer la moyenne des stagiaires*/
SELECT AVG(moyenne)as 'Moyenne de classe' from Stagiaires;
/*Q22 caculer la somme des moyenne des stagiaires*/
SELECT SUM(moyenne)as 'somme des moyenne' from Stagiaires;
/*Q23 afficher le nombre des stagiaires*/
SELECT COUNT(*) from Stagiaires;
/*Q24 afficher le nombre des stagiaires ayant la moyenne*/
SELECT COUNT(*) from Stagiaires WHERE moyenne>=10;
/*Q25 afficher la moyenne maximum*/
SELECT MAX(moyenne)as 'maximum' from Stagiaires;
/*Q26 afficher la moyenne minimum*/
SELECT MIN(moyenne)as 'minimum' from Stagiaires;
/*Q27 afficher les information de stagiaires de moyenne maximum*/
UPDATE Stagiaires set moyenne=15 where codeEt='E5';
SELECT * from Stagiaires where moyenne 
in (SELECT MAX(moyenne) from Stagiaires);
SELECT * from Stagiaires;

CREATE table filiere (
code_F int AUTO_INCREMENT,
libelle varchar(50),
PRIMARY KEY(code_F)
);

alter table Stagiaires 
add  Foreign Key (cd_F) REFERENCES filiere(code_F);

select * from filiere;
insert into filiere values('','DEV DIGITAL');
insert into filiere (libelle) values('GESTION');
select * from Stagiaires;

UPDATE Stagiaires set cd_F=2 where codeEt='E1';
UPDATE Stagiaires set cd_F=1 where codeEt='E2';
UPDATE Stagiaires set cd_F=1 where codeEt='E3';
UPDATE Stagiaires set cd_F=1 where codeEt='E4';
UPDATE Stagiaires set cd_F=2 where codeEt='E5';
/*Q28 Trouver la filiere de chaque stagiaire*/

INSERT into Stagiaires (codeEt,nom,adress,age,moyenne,cd_F) 
VALUES('E7','Ettor','rabat',21,09,NULL);

/*Constraint MYSQL*/
/*NOT NULL*/
SELECT * FROM Stagiaires;









select * from Stagiaires S LEFT JOIN filiere F 
ON S.cd_F=F.code_F ;
insert into Stagiaires values('E9','BBB','casa',NULL,18,2);
alter Table Stagiaires
MODIFY age int not null;
/*UNIQUE*/





CREATE TABLE Users(
id int primary key,
username varchar(50) not NULL,
passowrd VARCHAR(50),
);

alter table Users
drop INDEX cnr_usm;






drop table Users;
select * from Users;
INSERT INTO Users values(1,'user1','abc123');
INSERT INTO Users values(2,'user1','egb123');






ALTER table Users
add constraint Un_name UNIQUE(username);










/*-----CHECK-----*/
SELECT * FROM Users;
alter table Users
add age int not null;

alter table Users
add constraint ch_age check (age>=18);

alter table Users
drop constraint ch_age;

INSERT INTO Users values(2,'user2','abc123',100);
delete from Users where id=2;
/*-----Default-----*/
SELECT * FROM Users;
alter table Users
add ville varchar(50);
ALTER table Users
alter ville set DEFAULT 'dakhla';

ALTER table Users
alter  ville drop DEFAULT;
INSERT INTO Users values(1,'user1','abc123',18,null);
INSERT INTO Users values(2,'user2','abc123',18,null);
INSERT INTO Users (id,username,passowrd,age) 
values(3,'user3','ved123',20);
INSERT INTO Users values(4,'user4','abc123',30,'agadir');
INSERT INTO Users (id,username,passowrd,age) 
values(5,'user5','ved123',25);

/*View*/

SELECT * from Stagiaires;
SELECT * from Filiere;


CREATE view Stag_par_filiere as
select S.nom,F.libelle from Stagiaires S INNER JOIN filiere F 
ON S.cd_F=F.code_F ;

drop VIEW `Stag par filiere`;
SELECT * FROM Stag_par_filiere;






/*Transact SQL (Programmation Mysql)*/

/*Q1: Créer un programme mysql qui calcul la somme de deux variables 
a et b*/

/*Procedure*/
DELIMITER //
CREATE Procedure Display()
BEGIN
        SELECT * from Stagiaires;
END //

call Display();
/*Créer une procedure ps_somme qui prend comme argument a et b 
et puis caluer la somme de ces deux variable*/

DELIMITER //
CREATE Procedure Ps_somme(in a int,in b int)
BEGIN
    DECLARE somme int;
    set somme=a+b;
    SELECT somme;
end //

CALL Ps_somme(7,9);



/*Créer une procedure ps_signe qui prend comme argument x 
et puis afficher le signe de ce nombre*/

DELIMITER //
CREATE Procedure ps_signe(in x int)
BEGIN
    DECLARE signe VARCHAR(50);
    if x>0 THEN SET signe='positif';
    ELSE set signe='neagative';
    END IF;
    SELECT signe;
end //
CALL ps_signe(-8);

/*Créer une procedure ps_while sans parametre
et qui afficher les nombre de 5 à 0*/

DELIMITER //
CREATE Procedure ps_while()
BEGIN
    DECLARE n int DEFAULT 5;
    DECLARE msg VARCHAR(50) DEFAULT ' ';
    WHILE n>=0 DO
        SET msg=CONCAT(msg,n,' , ');
        SET n=n-1;
    END WHILE;
    SELECT msg;
END //

DROP PROCEDURE ps_while;
CALL  ps_while();





/*Créer une procedure ps_loop sans parametre
et qui afficher les nombre de 1 à 10*/
DELIMITER //
CREATE Procedure ps_loop()
BEGIN
    DECLARE cpt int DEFAULT 0;
    DECLARE texts VARCHAR(50) DEFAULT ' ';
    myl: LOOP
        set cpt=cpt+1;
        IF cpt>10 THEN
            LEAVE myl;
        END IF;
        if cpt%2!=0 THEN
            ITERATE myl;
        
        ELSE
            SET texts=CONCAT(texts,cpt,' - ');
        end IF;
    END LOOP myl ;
    SELECT texts;
END //
DROP Procedure ps_loop;


CALL ps_loop();

/*Créer une procedure ps_loop2 sans parametre 
qui afficher les nombre de 0 à 20 en utilisant la boucle Loop*/

DELIMITER //
CREATE Procedure ps_loop2()
BEGIN
    DECLARE x INT DEFAULT 0;
    DECLARE txt VARCHAR(255) DEFAULT  ' ';
    myloop: LOOP
        SET x=x+1;
        IF x>20 THEN
            LEAVE myloop;
        END IF; 
        IF x%2=0 THEN
            ITERATE myloop;
        ELSE
            SET txt=CONCAT(txt,x,',');
        END IF; 
    END LOOP myloop;
    SELECT txt;
END //

DROP Procedure ps_loop2;

CALL ps_loop2();


/*Créer une procedure Ps_repeat sans parametre 
qui afficher les nombre de 0 à 5 en utilisant la boucle Repéter jusqu'a*/
DELIMITER //
CREATE Procedure Ps_repeat()
BEGIN 
    DECLARE n int DEFAULT 0;
    DECLARE txt VARCHAR(255) DEFAULT ' ';
    REPEAT
        SET txt=CONCAT(txt,n,' , ');
        SET n=n+1;
    UNTIL n>5
    END REPEAT;
    SELECT txt;
END //


CALL Ps_repeat();


/*Créer une procedure Ps_repeat2 avec parametre x
qui afficher les nombre de 0 à x en utilisant la boucle Repéter jusqu'a*/


DELIMITER //
CREATE Procedure Ps_repeat2(x int)
BEGIN 
    SET @n=0;
    SET @TXT=' ';
    REPEAT
        SET @txt=CONCAT(@TXT,@n,' , ');
        SET @n=@n+1;
    UNTIL @n>x
    END REPEAT;
    SELECT @TXT;
END //

CALL Ps_repeat2(8);


/*Créer une procedure Ps_som avec deux parametres d'entres a et b 
qui afficher la somme de a et b */
DELIMITER //
CREATE Procedure Ps_som(in a int,in b int)
BEGIN 
    SET @somme=a+b;
    SELECT @somme; 
END //

CALL Ps_som(10,8);
/*Créer une procedure Ps_som2 avec deux parametres d'entres a et b 
et un parametere de sortie somme,puis afficher la valeur de la somme*/



DELIMITER //
CREATE Procedure Ps_som2(in a int,in b int,out somme int)
BEGIN
    SET somme=a+b;
    SELECT somme;
END //
set @result=0;
CALL Ps_som2(10,6,@result);








/*Créer une procedure Ps_gain qui prend en paramètre d'entrée 
le gain mensuel ,en parametre de sortie le chiffre d'affaire puis 
l'actualise (chiffre d'affaire+gain) et le retourné*/

chiffre d'aff =10000
gain=5000
chiffre d'aff=10000+5000

DELIMITER //
CREATE Procedure Ps_gain(INOUT chiffreaff FLOAT,in gain FLOAT)
BEGIN
        set chiffreaff=chiffreaff+gain;
END //

Set @ch=10000;
CALL Ps_gain(@ch,5000);
SELECT @ch;


/*----------Les fonctions-------------------*/
/*Q1-> créer un fonction f1 qui return bonjour*/
DELIMITER //
CREATE Function f1()RETURNS varchar(50)
BEGIN
    RETURN 'Bonjour';
END //
SELECT f1();
/*Q2-> créer une fonction f2 qui prend  en paramétre 
d'entrer variable nom et qui return bonjour nom*/

DELIMITER //
CREATE Function f2(nom varchar(50))
RETURNS VARCHAR(50)
BEGIN
    DECLARE msg VARCHAR(50) DEFAULT 'Bonjour';
    SET msg=CONCAT(msg,' ',nom);
    RETURN msg;
END //
SELECT f2('Mohamed');

/*Q3-> créer une fonction f3 qui prend  deux paramétres 
 x,y et qui return la multiplication*/
DELIMITER //
CREATE Function f3(x int,y int)RETURNS INT
BEGIN
    RETURN x*y;
END //
SELECT f3(4,6) as 'Multiplication';
/*Q4-> créer une fonction f4 qui prend en paramétre 
 n et qui return le signe de ce nombre*/
DELIMITER //
CREATE Function f4(n int)RETURNS VARCHAR(50)
BEGIN
    DECLARE signe VARCHAR(50) DEFAULT ' ';
    IF n>0 THEN
        SET signe='positif';
    ELSEIF n<0 THEN
        SET signe='negatif';
    ELSE SET signe='null';
    END IF;
    RETURN signe;
END //
SELECT f4(-10) as 'Signe';

/*Q5-> créer une fonction f5 qui prend en paramétre 
 n (n>1) et qui return les nombres de n à 1 (en utilisant while)*/
DELIMITER //
CREATE Function f5(n int)RETURNS VARCHAR(50)
BEGIN
    DECLARE result VARCHAR(50) DEFAULT ' ';
    WHILE n>0 DO
            SET result=CONCAT(result,n,' , ');
            SET n=n-1;
    END WHILE;
    RETURN result;
END //
SELECT f5(10);
/*Q6-> créer une fonction f6 qui prend en paramétre 
 n  et qui return les nombres de n à 0 (en utilisant while)*/

DELIMITER //
CREATE OR REPLACE Function f6(n int)RETURNS VARCHAR(50)
BEGIN
    DECLARE result VARCHAR(50) DEFAULT ' ';
    IF n>0 THEN
        WHILE n>=0 DO
            SET result=CONCAT(result,n,' , ');
            SET n=n-1;
        END WHILE;
    ELSE
        WHILE n<=0 DO
            SET result=CONCAT(result,n,' , ');
            SET n=n+1;
        END WHILE;
    END IF;
    RETURN result;
END //
SELECT f6(0);
/*Q7-> créer une fonction f7 qui prend deux paramétres a et b
et qui return les nombres de a à b (en utilisant la Loop)*/
DELIMITER //
CREATE or REPLACE Function f7(a int,b int) RETURNS VARCHAR(255)
BEGIN 
    DECLARE res VARCHAR(255) DEFAULT ' ';
    DECLARE c INT;
    myloop: LOOP
    if a=b THEN
        SET res='Erreur !! a doit etre != b';
        LEAVE myloop;
    END if;
    IF a>b THEN
         SET c=a;
         SET a=b;
         SET b=c;
    END if;
    IF a<=b THEN
        SET res=CONCAT(res,a,' ');
        SET a=a+1;
    END if;
    IF a=b THEN
            SET res=CONCAT(res,a,' ');
            LEAVE myloop;
    END if;
    END LOOP myloop;
    RETURN res;
END //
SELECT f7(1,3);


/*Q8-> créer une fonction f8 qui prend en paramétres n
et qui return la valeur de n! (en utilisant la boucle repeat)*/
DELIMITER //
CREATE or REPLACE FUNCTION f8(n INT)RETURNS INT
BEGIN
    DECLARE f int DEFAULT 1;
    DECLARE i int DEFAULT 1;
    REPEAT
        SET f=f*i;
        SET i=i+1;
    UNTIL n<i
    END REPEAT;
    RETURN f;
END //

SELECT f8(5);


/*Q9-> créer une fonction f9 qui prend en paramétres n
et qui return la valeur de n! (en utilisant la boucle repeat)*/



DELIMITER //
CREATE or REPLACE Function f9(x int)RETURNS int
BEGIN
    RETURN x*2;
END //
SELECT f9(12);
<<<<<<< HEAD





/*
Exercice sur les fonctions et les procedure
soit le schéma relationnel suivant:

Stagiaire(ids,nom,prenom,daten)
Matiere(idm,libelle,mh)
Notaion(idn,#ids,#idm,note)
*/
CREATE DATABASE Corr_TP;








=======
>>>>>>> 23a232df680670b0c6409a00c2866ff3466fabba
