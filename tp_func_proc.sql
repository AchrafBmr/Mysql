CREATE DATABASE IF NOT EXISTS gestionEmployes;
use gestionEmployes;
CREATE TABLE Employe(
    nuempl INT PRIMARY KEY ,
    nomemp VARCHAR(50),
    hebdo INT,
    salaire FLOAT,
    affect INT,
    Foreign Key (affect) REFERENCES Service(nuser)
);

INSERT INTO Employe VALUES
(1, 'rami', 40, 3500.00, 1),
(2, 'alaoui', 35, 1900.00, 2),
(3, 'jalaoui', 35, 1600.00, 2),
(4, 'amrani', 35, 2100.00, 3)

CREATE TABLE Service(
    nuser INT PRIMARY KEY ,
    nomser VARCHAR(50)
);

INSERT INTO Service VALUES 
(1,"achat"),
(2,"vante"),
(3,"marketing")

CREATE TABLE Projet (
    nuproj INT PRIMARY KEY,
    nomproj VARCHAR(50),
    resp INT,
    Foreign Key (resp) REFERENCES Employe(nuempl)
);

INSERT INTO Projet VALUES
(11,"web",1),
(22,"web",1),
(33,"web",1)


CREATE TABLE Travail (
    nuempl INT,
    nuproj INT,
    duree INT,
    PRIMARY KEY (nuempl, nuproj),
    FOREIGN KEY (nuempl) REFERENCES Employe(nuempl),
    FOREIGN KEY (nuproj) REFERENCES Projet(nuproj)
);


INSERT INTO Travail VALUES
(2,11,15),
(2,22,20),
(3,11,10),
(3,33,30)

SELECT * FROM Travail;


-- Q1 :

DELIMITER //
CREATE PROCEDURE identit(id INT, newsal FLOAT)
BEGIN
    UPDATE Employe SET salaire = salaire + newsal WHERE nuempl = id;
END //

CALL identit(1,500.00);
SELECT * FROM Employe;


-- Q2 :
DELIMITER //
CREATE FUNCTION nbEmpl(proj INT) RETURNS INT
BEGIN
    DECLARE nb INT;
    SELECT COUNT(*) INTO nb FROM Travail WHERE nuproj = proj;
    RETURN nb;
END//
DELIMITER ;
SELECT nbEmpl(11)


-- Q3 :

DELIMITER //
CREATE FUNCTION nbProj(serv INT) RETURNS INT
BEGIN
    DECLARE nb INT;
    SELECT COUNT(*) INTO nb FROM Employe WHERE affect = serv;
    RETURN nb;
END//
DELIMITER ;
SELECT nbProj(2)

-- methode 2 de Q3 :

DELIMITER //
CREATE FUNCTION nbResp(serv VARCHAR(50)) RETURNS INT

BEGIN
    DECLARE NB VARCHAR(50);
    SELECT COUNT(*) INTO NB FROM Projet WHERE resp IN (
        SELECT e.nuempl FROM Employe e INNER JOIN Service s ON e.affect = s.nuser WHERE s.nomser = serv
    );
    RETURN NB;
END //
DELIMITER ;



-- Q4 :

DELIMITER //
CREATE FUNCTION nbPR1(Emp INT) RETURNS INT
BEGIN
    DECLARE nb INT;
    SELECT COUNT(*) INTO nb FROM Travail WHERE nuempl = Emp;
    RETURN nb;
END//
DELIMITER ;

SELECT nbPR1(1)

-- Q5 :
DELIMITER//
CREATE FUNCTION salEmp(sal INT) RETURNS VARCHAR
BEGIN
    DECLARE empl INT
    SELECT salaire INTO empl FROM Employe WHERE nuempl = sal;
    IF sal<2000 THEN
        return 'Salaire faible';
    ELSE
        return 'Bon salaire';
    END IF
END//


-- Q6:
DELIMITER //
CREATE FUNCTION nomservice(serviceId INT) RETURNS VARCHAR(50)
BEGIN
    DECLARE serviceName VARCHAR(50);
    SELECT nomser INTO serviceName FROM Service WHERE nuser = serviceId;
    RETURN serviceName;
END //
DELIMITER ;

SELECT nomservice(3)

