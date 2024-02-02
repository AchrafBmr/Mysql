CREATE DATABASE control_revision;
USE control_revision;

DROP TABLE IF EXISTS Client; 
CREATE TABLE Client (
    id_c INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    adresse VARCHAR(100),
    tel VARCHAR(20),
    nbre_comptes INT
);
DROP TABLE IF EXISTS Compte;
CREATE TABLE Compte (
    Ncompte INT PRIMARY KEY ,
    solde DECIMAL(10, 2),
    id_c INT,
    seuil DECIMAL(10, 2),
    typeC INT,
    FOREIGN KEY (id_c) REFERENCES Client(id_c),
    FOREIGN KEY (typeC) REFERENCES TypeCompte(TypeC)
);
DROP TABLE IF EXISTS Mouvement; 
CREATE TABLE Mouvement (
    NMouvement INT PRIMARY KEY,
    Ncompte INT,
    montant DECIMAL(10, 2),
    type VARCHAR(1) CHECK (type='R' or type='D'),
    dateM date,
    FOREIGN KEY (Ncompte) REFERENCES Compte(Ncompte)
);

SHOW TABLES;

CREATE TABLE TypeCompte (
    TypeC INT PRIMARY KEY,
    Type VARCHAR(50)
);
--------------------------------------------------------------
INSERT INTO Client (id_c, nom, prenom, adresse, tel, nbre_comptes)
VALUES 
    (1, 'Othman', 'SALAHI', '123 Main St', '1234567890', null)
    (2, 'Ahmad', 'ALI', '456 Elm St', '9876543210', null),
    (3, 'Youssef', 'HASSAN', '789 Oak St', '5555555555', null),
    (4, 'Ali', 'MOHAMMED', '987 Pine St', '9999999999', null);
SELECT * FROM `Client`;


-------------------------------------------------
INSERT INTO Compte (Ncompte, solde, id_c, seuil, typeC)
VALUES 
    (1, 1000.00, 1, 50000.00, 1),
    (2, 1000.00, 1, 50000.00, 3),
    (3, 2000.00, 2, 100000.00, 2),
    (4, 2000.00, 2, 100000.00, 2),
    (5, 3000.00, 3, 150000.00, 1),
    (6, 3000.00, 3, 15000.00, 3),
    (7, 4000.00, 4, 20000.00, 2),
    (8, 4000.00, 4, 20000.00, 1);

delete from Compte ;
SELECT * FROM `Compte`;
SELECT * FROM `Client`;

UPDATE Compte SET solde = 5000.00 WHERE Ncompte = 1;
-------------------------------------------
INSERT INTO TypeCompte (TypeC, Type)
VALUES 
    (1, 'épargne'),
    (2, 'âge d’or'),
    (3, 'éducation');


-- ===================== QUESTION 1 =====================

DELIMITER //
DROP PROCEDURE IF EXISTS retier;
CREATE PROCEDURE retier(in NumCompte INT, in montant DECIMAL(10, 2))
BEGIN
    DECLARE cpt INT ;
    DECLARE argent DECIMAL(10,2);
    SELECT solde INTO argent FROM Compte WHERE `Ncompte` = NumCompte;
    SELECT COUNT(*) INTO cpt FROM Mouvement ;
    -- transaction start --
    START TRANSACTION;
        INSERT INTO Mouvement 
            VALUES (cpt+1,NumCompte, montant, 'R', NOW());
        update Compte SET solde = solde - montant WHERE `Ncompte` = NumCompte;
    if NumCompte not in (SELECT NCompte FROM Compte) THEN
        SELECT 'Compte inexistant' ;
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END//

CALL retier(2, 40.00);


DELIMITER //
DROP PROCEDURE IF EXISTS depot;
CREATE PROCEDURE depot(in NumCompte INT, in montant DECIMAL(10, 2))
BEGIN
    DECLARE cpt INT ;
    DECLARE argent DECIMAL(10,2);
    SELECT solde INTO argent FROM Compte WHERE `Ncompte` = NumCompte;
    SELECT COUNT(*) INTO cpt FROM Mouvement ;
    -- transaction start --
    START TRANSACTION;
        INSERT INTO Mouvement 
            VALUES (cpt+1,NumCompte, montant, 'D', NOW());
        update Compte SET solde = solde + montant WHERE `Ncompte` = NumCompte;
    if NumCompte not in (SELECT NCompte FROM Compte) THEN
        SELECT 'Compte inexistant' ;
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END//

SELECT * FROM Compte;
CALL depot(1,1000);
SELECT * FROM Mouvement;

-- ===================== QUESTION 2 =====================

DELIMITER //
DROP PROCEDURE IF EXISTS operations;
CREATE PROCEDURE operations(IN NumCompte INT,OUT ClientID INT,OUT DepotsCount INT,OUT RetraitsCount INT)
BEGIN
    
    SELECT id_c INTO ClientID FROM Compte WHERE Ncompte = NumCompte;

    SELECT COUNT(*) INTO DepotsCount FROM Mouvement 
    WHERE Ncompte = NumCompte AND type = 'D';

    SELECT COUNT(*) INTO RetraitsCount FROM Mouvement 
    WHERE Ncompte = NumCompte AND type = 'R';

END //

DELIMITER ;

SET @DepotsCount = 0;
SET @RetraitsCount = 0;
SET @ClientID = 0;

CALL operations(2, @ClientID ,@DepotsCount, @RetraitsCount);

SELECT @ClientID AS 'the client ID', @DepotsCount AS 'Nombre de dépôts', @RetraitsCount AS 'Nombre de retraits';

-- ===================== QUESTION 3 =====================

SELECT * FROM TypeCompte;
SELECT * FROM Compte;
DELIMITER //
DROP PROCEDURE IF EXISTS interet;
CREATE PROCEDURE interet()
BEGIN
    UPDATE `Compte` SET solde = solde * 1.06 WHERE `typeC` = 1; 
    UPDATE `Compte` SET solde = solde * 1.07 WHERE `typeC` = 2; 
    UPDATE `Compte` SET solde = solde * 1.08 WHERE `typeC` = 3; 
END //

CALL interet();

-- ===================== QUESTION 4 =====================
DELIMITER //
DROP FUNCTION IF EXISTS totalcompte;
CREATE FUNCTION totalcompte(clientID INT) RETURNS INT
BEGIN
    return (SELECT COUNT(*) FROM `Compte` WHERE id_c = clientID);
END //

SELECT totalcompte(2) AS 'Nombre de comptes pour le client 1';

-- ===================== QUESTION 5 =====================
DELIMITER //
DROP PROCEDURE IF EXISTS mouvementDate;
CREATE PROCEDURE mouvementDate(in NumCompte INT,in date1 DATE, in date2 DATE)
BEGIN
    SELECT * FROM Mouvement WHERE Ncompte = NumCompte AND dateM BETWEEN date1 AND date2;
END//

CALL mouvementDate(1, '2022-01-01', now());

-- ===================== QUESTION 6 =====================
DROP TRIGGER IF EXISTS CHEK_STOCK;
CREATE TRIGGER `CHEK_STOCK` 
BEFORE UPDATE ON `Compte` FOR EACH ROW
BEGIN
    IF NEW.solde < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Le solde insuffisant';
    END IF;
END //

-- ===================== QUESTION 7 =====================

DROP TRIGGER IF EXISTS ACHRAF_TRIGGER;
CREATE TRIGGER `ACHRAF_TRIGGER` AFTER INSERT ON Compte
FOR EACH ROW
BEGIN
    DECLARE counter INT;
    SELECT COUNT(*) INTO counter FROM Compte WHERE id_c = NEW.id_c;
    UPDATE Client SET nbre_comptes = counter WHERE id_c = NEW.id_c;
END;
-- -------------------------------------------------------------------------
DROP TRIGGER IF EXISTS update_nbre_comptes;
DELIMITER //
CREATE TRIGGER update_nbre_comptes AFTER INSERT ON Compte
FOR EACH ROW
BEGIN
    DECLARE new_nbre_comptes INT;
    SELECT COUNT(*) INTO new_nbre_comptes FROM Compte WHERE id_c = NEW.id_c;
    UPDATE Client SET nbre_comptes = new_nbre_comptes WHERE id_c = NEW.id_c;
END;
//
-- -------------------------------------------------------------------
drop trigger if exists delete_nbre_comptes;
CREATE TRIGGER delete_nbre_comptes AFTER DELETE ON Compte
FOR EACH ROW
BEGIN
    SET  @nbre_comptes = 0;
    SELECT COUNT(*) FROM Compte WHERE id_c = OLD.id_c;
    UPDATE Client SET nbre_comptes = @nbre_comptes WHERE id_c = OLD.id_c;
END;
//
DELIMITER ;
SELECT * FROM Client;
SELECT * FROM Compte;

SELECT COUNT(*) FROM Compte WHERE id_c = 1;
SELECT nbre_comptes FROM Client WHERE id_c = 2;
INSERT INTO Compte VALUES (101, 5000.00, 2, 100000.00, 2)
