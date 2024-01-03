create database gestion_stock;
use gestion_stock;
CREATE TABLE Client (
  numCl INT PRIMARY KEY,
  nomCl VARCHAR(50),
  prCl VARCHAR(50),
  telCI int
);
insert into Client values 
("1","khalid","kamal",0666666666),
("2","brahim","dawd",0677777777),
("3","rami","alaoui",0688888888);
CREATE TABLE Commande (
  numBon INT PRIMARY KEY,
  dateCmd DATE,
  numCl INT,
  FOREIGN KEY (numCl) REFERENCES Client(numCl)
);
insert into Commande values 
(10,2023-05-01,"1"),
(20,2023-06-02,"2"),
(30,2023-01-09,"3");

CREATE TABLE Produit (
  reference INT PRIMARY KEY,
  intitule VARCHAR(50),
  PU DECIMAL(10,2),
  quantiteStock INT
);
insert into Produit values 
(5,"intitule1",4000,100),
(15,"intitule2",800,120),
(25,"intitule3",5000,125);

CREATE TABLE LigneCommande (
  numBon INT,
  reference INT,
  quantiteCommandee INT,
  FOREIGN KEY (numBon) REFERENCES Commande(numBon),
  FOREIGN KEY (reference) REFERENCES Produit(reference),
  primary key (numBon , reference)
);
insert into LigneCommande values 
(10,5,10),
(20,15,12),
(30,25,7);


select * from Client;
select * from Commande;
select * from Produit;
select * from LigneCommande;


-- Q1: afficher la liste de produit (refe intitulé) classe de mois chere to plus chere:
SELECT reference, intitule FROM Produit ORDER BY PU ASC;

-- Q2: la liste de tous les produits qui sont present:
select reference,count(*) from LigneCommande group by reference having count(*)>1;

-- Q3: enger le prx totale a linteriere de chaque ligne de commande en fonction 
alter table LigneCommande add column prix_total decimal(10,2);
update LigneCommande set prix_total=null where numBon=10;

create view tableteste as
select L.*,P.PU from LigneCommande L inner join Produit P on L.reference = P.reference;
update tableteste set prix_total=(quantiteCommandee*PU) where numBon=10;

-- Q4: calculer la somme de prix total des commandes associer le produit 1 
select sum(prix_total) from LigneCommande where reference=5;


