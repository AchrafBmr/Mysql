use gestion_stock;
select * from produit;
-- Q1:
delimiter //
create procedure valeur()
begin
select reference,intitule,PU*quantiteStock as valeur_en_stock from produit;
end //
call valeur();

-- Q2:
select * from lignecommande
delimiter //
create procedure listpro(in num int)
begin
select * from produit where reference in (select reference from lignecommande where numBon=num);
end //
call listpro(10);

-- Q3:
select * from commande
delimiter //
create procedure nb_commande(out nb int)
begin
select count(*) into nb from commande;
end //
call nb_commande(@n);
select @n as nombreCom;

