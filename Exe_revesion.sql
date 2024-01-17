CREATE DATABASE exerc;
USE exerc;

CREATE TABLE Stagiaire (
  ids INT PRIMARY KEY,
  nom VARCHAR(255),
  prenom VARCHAR(255),
  daten DATE
);

CREATE TABLE Matiere (
  idm INT PRIMARY KEY,
  libelle VARCHAR(255),
  mh INT
);

CREATE TABLE Notation (
  idn INT PRIMARY KEY,
  ids INT,
  idm INT,
  note FLOAT,
  FOREIGN KEY (ids) REFERENCES Stagiaire(ids),
  FOREIGN KEY (idm) REFERENCES Matiere(idm)
);


INSERT INTO Stagiaire (ids, nom, prenom, daten)
VALUES
  (1, 'dawd', 'ali', '1995-07-15'),
  (2, 'kamal', 'med', '1998-02-28'),
  (3, 'alaoui', 'khalid', '1997-11-10');


INSERT INTO Matiere (idm, libelle, mh)
VALUES
  (1, 'Mathematics', 60),
  (2, 'Physics', 45),
  (3, 'Computer Science', 90);


INSERT INTO Notation (idn, ids, idm, note)
VALUES
  (1, 1, 1, 15),
  (2, 1, 2, 17),
  (3, 2, 1, 9),
  (4, 2, 3, 20),
  (5, 3, 2, 10),
  (6, 3, 3, 11);




-- Q1 :
DELIMITER //
CREATE OR REPLACE PROCEDURE Q1 (idDonne INT)
BEGIN  
  SELECT m.libelle, n.note   FROM Notation n
  INNER JOIN Matiere m ON n.idm = m.idm
  WHERE n.ids = idDonne;
END //

CALL Q1(1)

-- Q2:

DELIMITER //
CREATE OR REPLACE PROCEDURE Q2 (stag INT)
BEGIN
    SELECT m.libelle, AVG(n.note ) AS moyenne  FROM Notation n
    INNER JOIN Matiere m ON n.idm = m.idm
    WHERE n.ids = stag GROUP BY m.libelle;
END //

CALL Q2(1)


-- Q3 :

DELIMITER //
CREATE OR REPLACE FUNCTION Q3 (idStg INT) RETURNS FLOAT
BEGIN
    DECLARE nb FLOAT DEFAULT 0;
    SELECT AVG(note) INTO nb FROM Notation WHERE ids = idStg;
    RETURN nb;
END //

SELECT Q3(3)


DELIMITER //
CREATE OR REPLACE PROCEDURE Q33(IN idStg INT, OUT moyenne FLOAT)
BEGIN
    SELECT AVG(note) INTO moyenne FROM Notation WHERE ids = idStg;
END //

CALL Q33(2, @result);
SELECT @result AS moyenne;


-- Q4: 
CREATE OR REPLACE PROCEDURE display (IN idd INT)
BEGIN
    
    IF idd not in (SELECT ids FROM stagiaire) THEN
        SELECT 'pas existe';
    ELSE
        SELECT * FROM stagiaire WHERE ids = idd;
    END IF;
END;


call display(5);


-- Q5 : 
CREATE OR REPLACE PROCEDURE displaydate (IN idd INT, OUT dateD DATE)
BEGIN
    IF idd NOT IN (SELECT ids FROM stagiaire) THEN
        SELECT 'doesnt existe';
    ELSE
        SELECT daten INTO dateD FROM stagiaire WHERE ids = idd;
    END IF;
END;


CALL displaydate(1, @dateD);
SELECT @dateD AS date_naissance;


-- anther method :

CREATE OR REPLACE PROCEDURE displaydate_2 (IN idd INT)
BEGIN
    DECLARE dt DATE;
    IF idd NOT IN (SELECT ids FROM stagiaire) THEN
        SELECT 'doesnt existe';
    ELSE
        SELECT daten INTO dt FROM stagiaire WHERE ids = idd;
    END IF;

    SELECT dt;
END;


CALL displaydate_2(1);


-- Q6 :

CREATE OR REPLACE PROCEDURE Q6 (OUT cpt INT)
BEGIN
    SELECT COUNT(*) FROM Stagiaire;
END;
CALL Q6(@cpt);




-- Q7 :


CREATE OR REPLACE PROCEDURE Q7(IN id INT, IN nm VARCHAR(50), IN pr VARCHAR(50), IN dt DATE)
BEGIN
    INSERT INTO Stagiaire(ids, nom, prenom, daten) VALUES(id, nm, pr, dt);
    SELECT * FROM Stagiaire;
END;

CALL Q7(4,'achraf','dawd','2000-07-15')




-- Q8 :




CREATE OR REPLACE PROCEDURE Q8(IN id INT , IN updt DATE)
BEGIN
    IF id NOT IN (SELECT ids FROM stagiaire) THEN
        SELECT 'doesnt existe';
    ELSE
        UPDATE Stagiaire SET daten = updt WHERE ids = id;
        SELECT * FROM Stagiaire;
    END IF;
END;

CALL Q8(5 , '1900-07-15');



-- Q9 :




CREATE OR REPLACE PROCEDURE Q9(IN id INT)
BEGIN
    IF id NOT IN (SELECT ids FROM stagiaire) THEN
        SELECT 'doesnt existe';
    ELSE
        DELETE FROM Stagiaire WHERE ids = id;
        SELECT * FROM Stagiaire;
    END IF;
END;

CALL Q9(4)



--  Q10 :


CREATE OR REPLACE FUNCTION Q10() RETURNS INT
BEGIN
    DECLARE count_value INT;
    SELECT COUNT(*) INTO count_value FROM Stagiaire;
    RETURN count_value;
END;

SELECT Q10()



-- Q11 :



CREATE OR REPLACE FUNCTION Q11(id INT) RETURNS VARCHAR(50)
BEGIN
    DECLARE msg VARCHAR(50) DEFAULT '';
    DECLARE dt DATE;

    IF id NOT IN (SELECT ids FROM stagiaire) THEN
        SET msg = 'doesnt existe';
        RETURN msg;
    ELSE
        SELECT daten INTO dt FROM Stagiaire WHERE ids = id;
        RETURN dt;
    END IF;
END;

SELECT Q11(2) AS 'date naissance';



-- Q12 :



CREATE or REPLACE FUNCTION Q12(id INT) RETURNS VARCHAR(255)
BEGIN
   DECLARE msg VARCHAR(50) DEFAULT 'existe';

    IF id NOT IN (SELECT ids FROM Stagiaire) THEN
        SET msg = 'doesnt existe';
    END IF;
    RETURN msg;
END;

SELECT Q12(1) AS 'Existence';



-- les transaction:


SELECT * FROM Stagiaire;


BEGIN;
INSERT INTO Stagiaire VALUES 
(5,'jalaoui','rachid','2002-03-06');
COMMIT;  -- commit for save modifycation


BEGIN;
INSERT INTO Stagiaire VALUES 
(6,'nazi','brahim','2001-03-06');
ROLLBACK;  -- annule modification


CREATE TABLE Compte(
    
);





