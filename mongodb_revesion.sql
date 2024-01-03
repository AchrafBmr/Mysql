CREATE DATABASE IF NOT EXISTS DKM ;
use DKM;
CREATE Table servicee (
    codeser INT PRIMARY key ,
    nomser VARCHAR(50)
);

INSERT INTO servicee VALUES 
(1, 'Service A'),
(2, 'Service B');

CREATE Table salarie(
    codesal INT PRIMARY key ,
    nomsal VARCHAR(50),
    prenomsal VARCHAR(50),
    dateEmbauche DATE,
    dateNaissance DATE,
    fonction VARCHAR(50),
    codeser int ,
    Foreign Key (codeser) REFERENCES servicee(codeser)
);

INSERT INTO salarie VALUES
(1, 'John Doe', 'John', '2020-01-01', '1990-05-10', 'Manager', 1),
(2, 'Jane Smith', 'Jane', '2019-03-15', '1988-09-20', 'Employee', 2);

CREATE Table voiture(
    matricule INT PRIMARY key ,
    marque VARCHAR(50),
    couleur VARCHAR(50),
    dateMiseEnCirulation DATE
);

INSERT INTO voiture VALUES 
(1, 'Toyota', 'Red', '2020-02-01'),
(2, 'Honda', 'Blue', '2019-05-15');

CREATE Table utilisation(
    matricule INT,
    codesal INT,
    dateDebututilisation DATE,
    dateFinUtilisation DATE,
    PRIMARY KEY(matricule , codesal),
    Foreign Key (matricule) REFERENCES voiture(matricule),
    Foreign Key (codesal) REFERENCES salarie(codesal)
);

INSERT INTO utilisation VALUES
(1, 1, '2021-01-01', '2021-01-10'),
(2, 2, '2021-02-01', '2021-02-05');

CREATE TABLE garagiste(
    codegar INT PRIMARY KEY,
    nomgar VARCHAR(50),
    adresse VARCHAR(50)
);

INSERT INTO garagiste VALUES 
(1, 'Garage A', '123 Main Street'),
(2, 'Garage B', '456 Elm Street');

CREATE TABLE demandeReparation(
    codeDem INT PRIMARY KEY,
    dateDem DATE,
    codesal INT,
    descriptionDem VARCHAR(50),
    codegar INT,
    syntheseReparation VARCHAR(50),
    dateFinReparation DATE,
    Foreign Key (codegar) REFERENCES garagiste(codegar),
    Foreign Key (codesal) REFERENCES salarie(codesal)
)

INSERT INTO demandeReparation VALUES 
(1, '2021-01-15', 1, 'Issue with engine', 1, 'Repaired engine', '2021-01-20'),
(2, '2021-02-10', 2, 'Brake problem', 2, 'Replaced brake pads', '2021-02-15');

-- Qeustion 1 :
DELIMITER //
CREATE PROCEDURE EmployeesService3()
BEGIN
    SELECT sr.nomser, COUNT(sl.codesal) FROM servicee sr INNER JOIN salarie sl ON sl.codeser = sr.codeser GROUP BY sr.codeser;
END //
CALL EmployeesService3()

-- Question 2 :

DELIMITER //
CREATE FUNCTION Getcar(matriculeParam INT, dateParam DATE) RETURNS INT
BEGIN
    DECLARE employeeCode INT;
    
    SELECT codesal INTO employeeCode FROM utilisation u WHERE u.matricule = matriculeParam
    AND dateParam BETWEEN u.dateDebututilisation AND u.dateFinUtilisation;
    
    RETURN employeeCode;
END //


