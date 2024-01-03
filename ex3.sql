create database ex3;
use ex3;
CREATE TABLE Etudiant (
  numero_carte_etudiant VARCHAR(10) PRIMARY KEY,
  Nom VARCHAR(50),
  Prenom VARCHAR(50),
  Date_naissance DATE,
  Section VARCHAR(50)
);
INSERT INTO Etudiant VALUES 
('01234567', 'Ben Salah', 'Ahmed', '1990-09-02', 'Informatique'),
('01234568', 'Ben Mahmoud', 'Sami', 1990-09-02, 'Math'),
('01234569', 'Marzougui', 'Rami', '1988-08-12', 'Informatique');

CREATE TABLE Matiere (
  code_matiere INT PRIMARY KEY,
  nom_matiere VARCHAR(50),
  coefficient float
);
INSERT INTO Matiere VALUES
(12508, 'Base de données', 1.5),
(12518, 'Algorithme', 3);

CREATE TABLE Note (
  numero_carte_etudiant VARCHAR(10),
  code_matiere INT,
  note_examen float,
  FOREIGN KEY (numero_carte_etudiant) REFERENCES Etudiant(numero_carte_etudiant),
  FOREIGN KEY (code_matiere) REFERENCES Matiere(code_matiere)
);
INSERT INTO Note VALUES
('01234567', 12508, 15.5),
('01234567', 12518, 5.5),
('01234568', 12518, 10.5),
('01234569', 12518, 8.75);

-- Q1:
select * from Etudiant;

-- Q2:
select nom_matiere, coefficient from Matiere;

-- Q3:
select numero_carte_etudiant,sum(note_examen*coefficient)/sum(coefficient) as moyenne from note n inner join matiere m 
on n.code_matiere = m.code_matiere group by numero_carte_etudiant having moyenne between 7 and 12;

 -- Q4:
select * from Etudiant where Nom like 'Ben%';

-- Q5:
select count(*) as nombre_etudiants from Note where code_matiere = 12518;

-- Q6:
select sum(coefficient) as somme_coef from Matiere ;

-- Q7:
select e.nom from Etudiant e inner join Note n on e.numero_carte_etudiant=n.numero_carte_etudiant 
where note_examen >10;

-- Q8
select m.nom_matiere, m.coefficient from Matiere m inner join Note n on m.code_matiere = n.code_matiere
where n.numero_carte_etudiant = '01234568';
