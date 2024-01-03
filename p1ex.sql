create database p1ex;
use p1ex;
create table developpeur (
numdev int primary key,
nomdev varchar(50),
adrdev varchar(50),
emaildev varchar(50),
teldev int
);
select * from developpeur;
INSERT INTO developpeur values 
(1, "khalid", "boujdour", "khalid@gamil.com", 066666666),
(2, "dawd", "boujdour", "d@gamil.com", 067777777),
(3, "brahim", "boujdour", "b@gamil.com", 068888888);
create table projet (
numproj int primary key,
titreproj varchar(50),
datedeb date,
datefin date
);
INSERT INTO projet values 
(1, "p1", "1/1/2023", "1/6/2023"),
(2, "gestion de stagaire", "1/3/2023", "1/9/2023");
UPDATE projet
SET titreproj = 'gestion de stock'
WHERE numproj = 1;
select * from projet;

create table logiciel (
codelog int primary key,
nomlog varchar(50),
prixlog float,
numproj int,
FOREIGN KEY (numproj) REFERENCES projet(numproj)
);
INSERT INTO logiciel values 
(2, "log1", 20000, 1),
(3, "log2", 25000, 2);
select * from logiciel;

CREATE TABLE realisation (
  numdev INT,
  numproj INT,
  FOREIGN KEY (numdev) REFERENCES developpeur(numdev),
  FOREIGN KEY (numproj) REFERENCES projet(numproj)
);
select * from realisation;
INSERT INTO realisation values
(1, 1),
(2, 1),
(1, 2);


-- Q1 : 
SELECT l.nomlog, l.prixlog FROM logiciel l inner JOIN projet p ON l.numproj = p.numproj 
WHERE p.titreproj = 'gestion de stock' ORDER BY l.prixLog DESC;
-- methode 2 :
select l.nomlog, l.prixlog from logiciel l,projet p where l.numproj=p.numproj and p.titreproj='gestion de stock' ORDER BY l.prixLog DESC;

-- Q2 :
SELECT titreproj, SUM(prixlog) AS TotalPrix FROM projet JOIN logiciel ON projet.numproj = logiciel.numproj
WHERE projet.numproj = 1 GROUP BY titreproj;

-- Q3 :
SELECT projet.titreproj, COUNT(realisation.numdev) AS NbDeveloppeurs FROM projet
JOIN realisation ON projet.numproj = realisation.numproj
JOIN developpeur ON realisation.numdev = developpeur.numdev GROUP BY projet.titreproj;

-- Q4:
SELECT projet.numproj, projet.titreproj FROM projet JOIN logiciel ON projet.numproj = logiciel.numproj
GROUP BY projet.numproj, projet.titreproj HAVING COUNT(logiciel.codelog) > 5;

-- Q5:
SELECT d.numdev, d.nomdev FROM developpeur d JOIN realisation r ON d.numdev = r.numdev
GROUP BY d.numdev, d.nomdev HAVING COUNT(r.numdev) >=3;


